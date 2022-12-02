Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26B963FDB8
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 02:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiLBBie (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 20:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLBBid (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 20:38:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FDA9EB2
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 17:38:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669945108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAM7Dn3W2rkQuoMWLtf+Mjvw69ftPZNLD8XMmhxb4IA=;
        b=eX47Ta8c1a19s2yMrdDuGxJ84egGk2iiUHo7cuuLiZrQklnqdHY/qdsR+0YIyU++aIzWtQ
        GSlWOww7XsMGnruL90ApMlkZ45sKEKSgPoPmnlelDcDdNRmxe7oj2tBBx0Wx+Pp4RKwbmu
        0TBZ78L6ieYBUaUtA/pKrDYjxKdiWc/RhQ+uBY6xtkFEbmJs7FDVix0FglCQYNlwalSzay
        2Z75h5aKaou+iOOE0rrrMVMvyTwItj1Wv4cKbfQsD0LXIkpHCDXUWcyNUQSA0yFU5ubWXO
        mH3DFe+OlKVP2kt4ODUA4/OJX6vqBv4tlr21rhQhfGyAjvUqwfDKm45132CQqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669945108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAM7Dn3W2rkQuoMWLtf+Mjvw69ftPZNLD8XMmhxb4IA=;
        b=W0tFParW9z09IK/dkTPx4cJhoBZoWjyZUPrERCOOvJGZsCNPtzF2jt5p9tnDB54a0axUvn
        NBoBFpbVgyH07kDA==
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
Date:   Fri, 02 Dec 2022 02:38:28 +0100
Message-ID: <87k03ar3e3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song!

On Thu, Dec 01 2022 at 11:31, Song Liu wrote:
> Thanks for these insights! They are really helpful!

I'm glad it helped and did not create more confusion :)

> On Thu, Dec 1, 2022 at 1:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> This made me look at your allocator again:
>>
>> > +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
>> > +#define EXEC_MEM_START MODULES_VADDR
>> > +#define EXEC_MEM_END MODULES_END
>> > +#else
>> > +#define EXEC_MEM_START VMALLOC_START
>> > +#define EXEC_MEM_END VMALLOC_END
>> > +#endif
>>
>> The #else part is completely broken on x86/64 and any other
>> architecture, which has PC relative restricted displacement.
>
> Yeah, the #else part is just to make it build. It is not really
> usable.

That's not an option for code which is submitted for inclusion. It can
be used and will be used. You know that already, right? So why are you
posting such broken crap?

>> Even if modules are disabled in Kconfig the only safe place to allocate
>> executable kernel text from (on these architectures) is the modules
>> address space. The ISA restrictions do not go magically away when
>> modules are disabled.
>>
>> In the early version of the SKX retbleed mitigation work I had
>>
>>   https://lore.kernel.org/all/20220716230953.442937066@linutronix.de
>>
>> exactly to handle this correctly for the !MODULE case. It went nowhere
>> as we did not need the trampolines in the final version.
>
> I remember there was some other work to use module_alloc for ftrace, etc.
> without CONFIG_MODULES. One of these versions would work here.

We don't want any of these. The new infrastructure which is set out to
replace module_alloc() has to be designed upfront to handle the
CONFIG_MODULES=n case properly.

>> Alternatively, instead of splitting the module address space, the
>> allocation mechanism can keep track of the types (text, data, rodata)
>> and manage large mapping blocks per type. There are pros and cons for
>> both approaches, so that needs some thought.
>
> AFAICT, the new allocator (let's call it module_alloc_new here)
> requires quite some different logic than the existing vmalloc logic (or
> module_alloc logic):

Obviously.

> 1. vmalloc is at least PAGE_SIZE granularity; while ftrace, bpf etc would
>     benefit from a much smaller granularity.

Even modules can benefit from that. The fact that modules have all
sections (text, data, rodata) page aligned and page granular is not due
to an requirement of modules, it's so because that's how module_alloc()
works and the module layout has been adopted to it.

text has an architecture/compile time specific alignment requirement for
function entries, data obviously has it's own alignment requirements,
but none of those are page granular.

> 2. vmalloc maintains 1-to-1 mapping between virtual address range (vmap
>     in vmap_area_root) and physical pages (vm_struct); while
>     module_alloc_new allocates physical pages in 2MB chunks, and
>     maintains multiple vmap within a single 2MB chunk.
>
> To solve this, I introduced a new tree free_text_area_root, address spaces
> in this tree is backed with ROX physical pages, but not used by any
> user.

Can you please refrain from discussing implementation details _before_
the conceptual details are sorted?

Implementation details are completely irrelevant at this point,
really. Quite the contrary, they just add confusion to the discussion.

The basic concept is:

module_alloc_type(type, size)
{
        if (!size || invalid_type(type))
        	return -ENOPONIES;

	mutex_lock(&m);
        if (!space_available(type, size))
        	alloc_new_blocks(type, size);
        
        p = alloc_space(type, size);
        mutex_unlock(&m);
        return p;
}

and the counterpart

module_free_type(p)
{
        if (!p)
        	return;

	mutex_lock(&m);
        x = lookup(p);
        type = x->type;
        free_space(x) {
        	...
                if (unused_blocks(type))
        		free_unused_blocks(type);
        }
        mutex_unlock(&m);
        return p;
}

> With this logic in place, I think we don't really need to split the module
> address space. Instead, we can have 3 trees:
>   free_module_text_area_root;
>   free_module_data_area_root;
>   free_module_ro_data_area_root;
>
> Similar to free_text_area_root, we add virtual address and physical pages
> to these trees in 2MB chunks, and hands virtual address rnage out to users in
> smaller granularity.

Whatever the actual tracking mechanism is, does not matter. This is
pretty much at the conceptual level the same what I said before:

>> Alternatively, instead of splitting the module address space, the
>> allocation mechanism can keep track of the types (text, data, rodata)
>> and manage large mapping blocks per type. There are pros and cons for
>> both approaches, so that needs some thought.

Right?

You have to be aware, that the rodata space needs to be page granular
while text and data can really aggregate below the page alignment, but
again might have different alignment requirements.

So you need a configuration mechanism which allows to specify per type:

   - Initial mapping type (RX, RWX, RW)
   - Alignment
   - Granularity
   - Address space restrictions

With those 4 parameters you can map all architecture requirements
including kaslr to each type.

>> But at the end we want an allocation mechanism which:
>>
>>   - preserves large mappings
>>   - handles a distinct address range
>>   - is mapping type aware
>>
>> That solves _all_ the issues of modules, kprobes, tracing, bpf in one
>> go. See?
>
> I think the user still needs to use module_alloc_new() differently. At
> the moment, the user does something like.

Neither me nor Peter said, that this ends up as a 1:1 replacement for
the actual module_alloc() users, but that's obvious and not the point.

The point is that the new infrastructure provides a solution which
solves _all_ issues of those users in one go.

The fact that we need to adjust the call sites is more than obvious, but
this can be done with the well known methods of code refactoring.

Step 1:

module_alloc_text(size)
{
        if (!size)
        	return -ENOPONIES;

	mutex_lock(&m);
        p = module_alloc(size);
	mutex_unlock(&m);
        if (p)
       		set_memory_ro+x(p, size);
        return p;
}

and

module_write_text(p, src, size)
{
        // Fill in the architecture specific magic depending on
        // the mapping type for text:
        if (ARCH_TEXT_MAP_TYPE == RX) {
        	text_poke();
        } else {
        	memcpy();
                set_memory_ro+x();
        }
}

Step 2:

Convert the usage sites outside of the core module code which really
only care about text allocations one by one:

-	p = module_alloc(size);
-       memcpy(p, src, size);
+	p = module_alloc_text(size);
+	module_write_text(p, src, size);

After that the only user of module_alloc() left is the module core
code.

Step 3:

Provide functions to prepare for converting the module core. You need to
have module_alloc_data() and module_alloc_rodata() where both implement
in the first step:

module_alloc_[ro]data(size)
{
        if (!size)
        	return -ENOPONIES;

	mutex_lock(&m);
        p = module_alloc(size);
	mutex_unlock(&m);
        if (p)
       		set_memory_rw-nox(p, size);
        return p;
}

Step 4:

Fixup the module code. Break up the en-bloc allocation and allocate
text, data, and rodata separately and adjust the methods to write into
them.

For text that's obviously module_write_text(), but for the [ro]data
mappings memcpy() is still fine. For the rodata mapping you need
set_memory_ro() right in the module prepare stage and for the
ro_after_init_data() you do that after the module init function returns
success, which is pretty much what the code does today.

Step 5:

Now once this is sorted, you add the new allocation magic.

Step 6:

Then you do:

module_alloc_text(size)
{
        if (!size)
        	return -ENOPONIES;

	mutex_lock(&m);
-       p = module_alloc(size);
+	if (IS_ENABLED(CONFIG_MODULE_ALLOC_NEWFANGLED))
+		p = module_alloc_type(TYPE_TEXT, size);
+	else
+		p = module_alloc(size);
	mutex_unlock(&m);
-       if (p)
+	if (!IS_ENABLED(CONFIG_MODULE_ALLOC_NEWFANGLED) && p)
      		set_memory_ro+x(p, size);
        return p;
}

and the corresponding changes to module_alloc_[ro]data()

Step 7:

Then you go and enable it per architecture:

+     select CONFIG_MODULE_ALLOC_NEWFANGLED

+     module_alloc_newfangled_init(&type_parameters);

Step 8:

Once everything is converted over you can remove
CONFIG_MODULE_ALLOC_NEWFANGLED and the associated conversion cruft.

> my_text = module_alloc(size);

<SNIP .... />

> Also, do you have suggestions on the name of the API?

Again, API and implementation details are pointless bikeshedding
material at this point.

I really have a hard time to understand why you are so focussed on
implementation details instead of establishing a common understanding of
the problem, the goals and the concepts in the first place.

Linus once said:

  "Bad programmers worry about the code. Good programmers worry about
   data structures and their relationships."

He's absolutely right. Here is my version of it:

  The order of things to worry about:

      1) Problem analysis
      2) Concepts
      3) Data structures and their relationships
      4) Code

      #1 You need to understand the problem fully to come up with
         concepts

      #2 Once you understand the problem fully you can talk about
         concepts to solve it

      #3 Maps the concept to data structures and forms relationships

      #4 Is the logical consequence of #1 + #2 + #3 and because your
         concept makes sense, the data structures and their
         relationships are understandable, the code becomes
         understandable too.

      If any of the steps finds a gap in the previous ones, then you
      have to go back and solve those first.

Any attempt to reorder the above is putting the cart before the horse
and a guarantee for failure.

Now go back and carefully read up on what I wrote above and in my
previous mail.

The previous mail was mostly about #1 to explain the problem as broad as
possible and an initial stab at #2 suggesting concepts to solve it.

This one is still covering some aspects of #1, but it is mostly about #2
and more focussed on particular aspects of the concept. If you look at
it carefully then you find some bits which map to #3 but still at the
conceptual level.

Did I talk about code or implementation details?

Not at all and I'm not going to do so before #1 and #2 are agreed
on. The above pseudo code snippets are just for illustration and I used
them because I was too lazy to write a novel, but they all are still at
the conceptual level.

Now you can rightfully argue that if you stich those snippets together
then they form a picture which outlines the implementation, but that's
the whole purpose of this exercise, right?

They still do not worry about any of the implementation details of root
trees, APIs or whatever simply because they are completely irrelevant at
this point of the discussion.

See?

Thanks,

        tglx
