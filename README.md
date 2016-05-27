# mongobijou

This gem is mongoDB mapper that allows you to save, destroy and load any object with self-defined nested attributes. You also do not have to use any specific keywords that describes your instance attributes or even include modules on lower levels of defined object.

Attention!

At this moment, gem is made for self-use only. **No tests are provided for this code!**

At actual version the only restriction is, that objects you want to save/load, cannot have initializers with arguments-passing.

Below are few examples of using gem.

```ruby
class CoolClass
  attr_accessor :cool_attr
  include MongoBijou
  
  def initialize
    @cool_attr = NestedClass.new
  end
end

class NestedClass
  attr_accessor :nested_attr
  
  def initialize
    @nested_attr = 9
  end
end
```

Then you can

```ruby
  object = CoolClass.new
  id = object.store #=> '562f8ab72d27c231fb000003'
  object = CoolClass.find(id) #=> <CoolClass:0x000000016ad438 @cool_attr=
                              # <NestedClass:0x000000016ad439 @nested_attr = 9>,
                              # @config_attr={:cool_attr=>0}>

  CoolClass.all   #=> array of saved objects
  CoolClass.remove(id)  # remove specific document
  CoolClass.drop  # destroy collection
``` 
  

  



<p align='center' >
 <img src="http://ruby.zigzo.com/wp-content/uploads/sites/2/2013/01/spike_and_rarity__s_heart_shaped_fire_ruby_by_edwardten.png" alt="Ruby beauty" height="100" width="100"> 
</p>
