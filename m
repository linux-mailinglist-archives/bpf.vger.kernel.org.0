Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B383645DBD
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 16:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiLGPhA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 10:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLGPg4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 10:36:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60E5E9D0
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 07:36:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670427410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCh61LjppO0ipjg7odH/HImdPvBRb5T3+ecF0/1jgdU=;
        b=xk01Cyg/qekF+R980jXdeFv1Jni8PzBNsYmiL32UcXftQwPQy1JZhMSNHMJHAEO4rgdPXV
        58encetXmFvihKyoCWgWnZKAemyLW5feEXqxSymoO1X1spCQn1vt2kKNtYgoPCwFPh11qQ
        kF5/7BeNQJwG0VLKlU0jxB3EJxK1llqpqz2FuN/NNieuIX2hwKIV586FM8hf2tYPVI3tXX
        wRJacBnuP0R3cBQVBtdthIhC4qcD6gNwfGQXy+kEPYxjdRmsc3MqVJcsffzLdTCFEaC7I9
        MbDUX3w/DmvzbOVv8l6CDhjGdVDbNCK7mvlaeMdKEkur0L15wBozRyYC89FB0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670427410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCh61LjppO0ipjg7odH/HImdPvBRb5T3+ecF0/1jgdU=;
        b=XykrjWnX4ppkALVqJeY7VOYxFLgwA12Y8nLjbMSQGBhW/VgqRS0CQDwIdexrMT3KZxDEsQ
        cvxDtQ7FXvHPtPAA==
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx>
 <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx>
 <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
Date:   Wed, 07 Dec 2022 16:36:49 +0100
Message-ID: <87v8mndy3y.ffs@tglx>
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

On Tue, Dec 06 2022 at 12:25, Song Liu wrote:
> On Fri, Dec 2, 2022 at 1:22 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Correct. Please have a close look at the 11 architecture specific
>> module_alloc() variants so you can see what kind of tweaks and magic
>> they need, which lets you better specify the needs for the
>> initialization parameter set required.
>
> Survey of the 11 architecture specific module_alloc(). They basically do
> the following magic:
>
> 1. Modify MODULES_VADDR and/or MODULES_END. There are multiple
>   reasons behind this, some arch does this for KASLR, some other archs
>   have different MODULES_[VADDR|END] for different processors (32b vs.
>   64b for example), some archs use some module address space for other
>   things (i.e. _exiprom on arm).
>
> Archs need 1: x86, arm64, arm, mips, ppc, riscv, s390, loongarch,
> sparc

All of this is pretty much a boot time init decision, right?

> 2. Use kasan_alloc_module_shadow()
>
> Archs need 2: x86, arm64, s390

There is nothing really architecture specific, so that can be part of
the core code, right?

> 3. A secondary module address space. There is a smaller preferred
>   address space for modules. Once the preferred space runs out, allocate
>   memory from a secondary address space.
>
> Archs need 3: some ppc, arm, arm64 (PLTS on arm and arm64)

Right.

> 4. User different pgprot_t (PAGE_KERNEL, PAGE_KERNEL_EXEC, etc.)
>
> 5. sparc does memset(ptr, 0, size) in module_alloc()

which is pointless if you do a GPF_ZERO allocation, but sure.

> 6. nios2 uses kmalloc() for modules. Based on the comment, this is
>   probably only because it needs different MODULES_[VADDR|END].

It's a horrible hack because they decided to have their layout:

     VMALLOC_SPACE   0x80000000
     KERNEL_SPACE    0xC0000000

and they use kmalloc because CALL26/PCREL26 cannot reach from 0x80000000
to 0xC0000000. That's true, but broken beyond repair.

Making the layout:

     VMALLOC_SPACE   0x80000000
     MODULE_SPACE    0xBE000000         == 0xC0000000 - (1 << 24) (32M)
or     
     MODULE_SPACE    0xBF000000         == 0xC0000000 - (1 << 24) (16M)
     KERNEL_SPACE    0xC0000000

would have been too obvious...

> I think we can handle all these with a single module_alloc() and a few
> module_arch_* functions().
>
> unsigned long module_arch_vaddr(void);
> unsigned long module_arch_end(void);
> unsigned long module_arch_secondary_vaddr(void);
> unsigned long module_arch_secondary_end(void);
> pgprot_t module_arch_pgprot(alloc_type type);
> void *module_arch_initialize(void *s, size_t n);
> bool module_arch_do_kasan_shadow(void);

Why? None of these functions is required at all.

Go back to one of my previous replies:

>> +     select CONFIG_MODULE_ALLOC_NEWFANGLED
>> 
>> +     module_alloc_newfangled_init(&type_parameters);

/**
 * struct mod_alloc_type - Parameters for module allocation type
 * @mapto_type:		The type to merge this type into, if different
 *			from the actual type which is configured here.
 * @flags:		Properties
 * @granularity:	The allocation granularity (PTE/PMD)
 * @alignment:		The allocation alignment requirement
 * @start:		Array of address space range start (inclusive)
 * @end:		Array of address space range end (inclusive)
 * @pgprot:		The page protection for this type
 * @fill:		Function to fill allocated space. If NULL, use memcpy()
 * @invalidate:		Function to invalidate allocated space. If NULL, use memset()
 *
 * If @granularity > @alignment the allocation can reuse free space in
 * previously allocated pages. If they are the same, then fresh pages
 * have to be allocated.
 */
struct mod_alloc_type {
	unsigned int	mapto_type;
        unsigned int	flags;
	unsigned int	granularity;
        unsigned int    alignment;
	unsigned long	start[MOD_MAX_ADDR_SPACES];
	unsigned long	end[MOD_MAX_ADDR_SPACES];
        pgprot_t	pgprot;
        void		(*fill)(void *dst, void *src, unsigned int size);
        void		(*invalidate)(void *dst, unsigned int size);
};

struct mod_alloc_type_params {
       struct mod_alloc_type	types[MOD_MAX_TYPES];
};

or something like that.

> So module_alloc() would look like:

<SNIP>horror</SNIP>

No. It would not contain a single arch_foo() function at all. Everything
can be expressed with the type descriptors above.

> For the allocation type, there are technically 5 of them:
>
> ALLOC_TYPE_RX,   /* text */
> ALLOC_TYPE_RW,    /* rw data */
> ALLOC_TYPE_RO,    /* ro data */
> ALLOC_TYPE_RO_AFTER_INIT,
> ALLOC_TYPE_RWX,   /* legacy, existing module_alloc behavior */

You are mixing page protections and section types as seen from the
module core code. We need exactly four abstract allocation types:

   MOD_ALLOC_TYPE_TEXT
   MOD_ALLOC_TYPE_DATA
   MOD_ALLOC_TYPE_RODATA
   MOD_ALLOC_TYPE_RODATA_AFTER_INIT

These allocation types represent the section types and are mapped to
module_alloc_type->pgprot by the allocator. Those protections can be
different or identical, e.g. all RWX.

The module core does neither care about the resulting page protection
nor about the question whether the allocation can reuse free space or
needs to allocate fresh pages nor about the question whether an
allocation type maps to some other type.

> Given RO and RO_AFTER_INIT require PAGE alignment and are
> relatively small. I think we can merge them with RWX.

There is no RWX, really. See above.

> We also need to redesign module_layout. Right now, we have
> up to 3 layouts: core, init, and data. We will need 6 allocations:
>   core text,
>   core rw data,
>   core ro and ro_after_init data (one allocation)
>   init text,
>   init rw data,
>   init ro data.
>
> PS: how much do we benefit with separate core and init.
> Maybe it is time to merge the two? (keep init part around until
> the module unloads).

That needs some investigation into how much memory is really made
available.

OTOH, if you look at the above then we can just have:

   MOD_ALLOC_TYPE_INITTEXT
   MOD_ALLOC_TYPE_INITDATA
   MOD_ALLOC_TYPE_INITRODATA

as extra allocation types. All it does is add some initconst memory and
a slightly larger static datastructure in the allocator itself. See
below.

> For data structures, I propose we use two extra trees for RX
> and RW allocation (similar to 1/6 of current version, but 2x
> trees).

The number of trees does not matter. You can make them part of the type
scheme and then the number of active trees depends on the number of
types and the properties of the types. Which is the right thing to do
because then you can e.g. trivially split RODATA and RODATA_AFTER_INIT.

> For RWX, we keep current module_alloc() behavior, so no new data
> structure is needed.

Seriously no. We switch the whole logic over to the new scheme for
consistency, simplicity and mental sanity reasons.

Again: Module code cares about section types, not about the resulting
page protections. The page protections are a matter of the underlying
allocator and architecture specific properties.

> The new module_layout will be something like:
>
> struct module_layout {
>     void *ptr;
>     unsigned int size;  /* text size, rw data size, ro + ro_after_init size */
>     unsigned int ro_size;    /* ro_size for ro + ro_after_init allocation */
> };

*SHUDDER*

struct module_layout {
        unsigned int	type;
        unsigned int	size;
	void 		*ptr;
};

or

struct module_layout {
        unsigned int	size;
	void 		*ptr;
};

struct module {
	...
	struct module_layout	layouts[MOD_ALLOC_TYPE_MAX];
        ...
};

> One more question: shall we make module sections page
> aligned without STRICT_MODULE_RWX? It appears to be
> a good way to simplify the logic. But it may cause too much
> memory waste for smaller processors?

Yes, we want that again for simplicity. That wastes some space on
architectures which do not support large pages, but that's not the end
of the world. Deep embedded is not really module heavy.

So lets look at some examples under the assumption that we have the init
sections separate:

Legacy default (All RWX):

struct mod_alloc_type_params {
   	[MOD_ALLOC_TYPE_TEXT ... MOD_ALLOC_TYPE_RODATA_AFTER_INIT] = {
        	.mapto_type	= MOD_ALLOC_TYPE_TEXT,
                .granularity	= PAGE_SIZE,
                .alignment	= PAGE_SIZE,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL_EXEC,
	},
   	[MOD_ALLOC_TYPE_INITTEXT ... MOD_ALLOC_TYPE_INITRODATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_INITTEXT,
                .granularity	= PAGE_SIZE,
                .alignment	= PAGE_SIZE,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL_EXEC,
	},
   };

So this is the waste space version, but we can also do:

struct mod_alloc_type_params {
   	[MOD_ALLOC_TYPE_TEXT ... MOD_ALLOC_TYPE_INITRODATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_TEXT,
                .granularity	= PAGE_SIZE,
                .alignment	= MOD_ARCH_ALIGNMENT,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL_EXEC,
	},
   };

The "use free space in existing mappings" mechanism is not required to
be PMD_SIZE based, right?

Large page size, strict separation:

struct mod_alloc_type_params {
   	[MOD_ALLOC_TYPE_TEXT] = {
        	.mapto_type	= MOD_ALLOC_TYPE_TEXT,
                .flags		= FLAG_SHARED_PMD | FLAG_SECOND_ADDRESS_SPACE,
                .granularity	= PMD_SIZE,
                .alignment	= MOD_ARCH_ALIGNMENT,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .start[1]	= MODULES_VADDR_2ND,
                .end[1]		= MODULES_END_2ND,
                .pgprot		= PAGE_KERNEL_EXEC,
                .fill		= text_poke,
                .invalidate	= text_poke_invalidate,
	},
   	[MOD_ALLOC_TYPE_DATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_DATA,
                .flags		= FLAG_SHARED_PMD,
                .granularity	= PMD_SIZE,
                .alignment	= MOD_ARCH_ALIGNMENT,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL,
	},
   	[MOD_ALLOC_TYPE_RODATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_RODATA,
                .granularity	= PAGE_SIZE,
                .alignment	= PAGE_SIZE,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL_RO,
	},
   	[MOD_ALLOC_TYPE_RODATA_AFTER_INIT] = {
        	.mapto_type	= MOD_ALLOC_TYPE_RODATA_AFTER_INIT,
		.flags		= FLAG_SET_RO_AFTER_INIT,                                                          
                .granularity	= PAGE_SIZE,
                .alignment	= PAGE_SIZE,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL,
	},
   	[MOD_ALLOC_TYPE_INITTEXT] = {
        	.mapto_type	= MOD_ALLOC_TYPE_TEXT,
        },
   	[MOD_ALLOC_TYPE_INITDATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_DATA,
        },
   	[MOD_ALLOC_TYPE_INITRODATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_RODATA,
        },
   };

Large page size, strict separation and RODATA uses PMD:

struct mod_alloc_type_params {
   	[MOD_ALLOC_TYPE_TEXT] = {
        	.mapto_type	= MOD_ALLOC_TYPE_TEXT,
                .flags		= FLAG_SHARED_PMD,
                .granularity	= PMD_SIZE,
                .alignment	= MOD_ARCH_ALIGNMENT,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL_EXEC,
                .fill		= text_poke,
                .invalidate	= text_poke_invalidate,
	},
   	[MOD_ALLOC_TYPE_DATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_DATA,
                .flags		= FLAG_SHARED_PMD,
                .granularity	= PMD_SIZE,
                .alignment	= MOD_ARCH_ALIGNMENT,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL,
	},
   	[MOD_ALLOC_TYPE_RODATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_RODATA,
                .flags		= FLAG_SHARED_PMD,
                .granularity	= PMD_SIZE,
                .alignment	= MOD_ARCH_ALIGNMENT,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL_RO,
                .fill		= rodata_poke,
                .invalidate	= rodata_poke_invalidate,
	},
   	[MOD_ALLOC_TYPE_RODATA_AFTER_INIT] = {
        	.mapto_type	= MOD_ALLOC_TYPE_RODATA_AFTER_INIT,
		.flags		= FLAG_SET_RO_AFTER_INIT,                                                          
                .granularity	= PAGE_SIZE,
                .alignment	= PAGE_SIZE,
                .start[0]	= MODULES_VADDR,
                .end[0]		= MODULES_END,
                .pgprot		= PAGE_KERNEL,
	},
   	[MOD_ALLOC_TYPE_INITTEXT] = {
        	.mapto_type	= MOD_ALLOC_TYPE_TEXT,
        },
   	[MOD_ALLOC_TYPE_INITDATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_DATA,
        },
   	[MOD_ALLOC_TYPE_INITRODATA] = {
        	.mapto_type	= MOD_ALLOC_TYPE_RODATA,
        },
   };

Then this data structure is handed to the module allocation init
function, which in turn sets up the resulting type magic.

struct mod_type_allocator {
	struct mutex		mutex;
	struct mod_alloc_type	params;
	struct rb_root		free_area;
        struct list_head	list;
        struct vm_struct	*vm;
};

struct mod_allocator {
	struct mod_type_allocator	base_types[MAX_TYPES];
        struct mod_type_allocator	*real_types[MAX_TYPES];
};

static struct mod_allocator mod_allocator;

So the init function does:

mod_alloc_init(struct mod_alloc_type_params *params)
{
	for (i = 0; i < MAX_TYPES; i++)
        	mod_alloc_init_type(i, &params->types[i]);
}

mod_alloc_init_type(int i, struct mod_alloc_type *params)
{
	struct mod_type_allocator = *ta;

	mutex_init(&ta->mutex);
        memcpy(&ta->params, params, sizeof(params);
        ta->free_area = RB_ROOT;
        LIST_HEAD_INIT(&ta->list);

      	mod_allocator.real_types[i] = &mod_allocator.base_types[params->mapto_type];
}

and then you have:

module_alloc_type(size, type)
{
	return __module_alloc_type(mod_allocator.real_types[type], size);
}

and everything just works and operates from the relevant allocator.

See: No question about how many trees are required, no question about
     legacy RWX, ...

Hmm?

Thanks,

        tglx
