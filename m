Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78690644D30
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 21:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLFUZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 15:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLFUZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 15:25:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B40DF88
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 12:25:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 296F8B81B41
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 20:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FDFC43470
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670358321;
        bh=g+UJhIb6XTi9ELAWzGf0CWEVr1yG77sLW8EtzNC5gJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=exHuj4stldFYqPs/hDhXAOV/GpVi6b90zkRCAHhKFIompRNu+zHOXvdA884feOtix
         cqlq2vd2F2Ce+yxf1WDlnVkXWFOMVpoe5KKffUtR0rSuuiQB9e4SDwfvDn2L5OJzyD
         SEjQBTlULFdDQ+nzrF8WhFiuomUVGLVqy/BUfU80uvAwMhnMUXGPKhQ9wLQUAxzWkO
         JgcLfffOuSVXnFf/3A7uoho2YOp98h5mzviPRa+1H4NGjGlP8z6nvODn0haY9bZfq1
         20KXfG6ss8MDGHH6bGiYKqpqVi0VWzOmduXopMXyfxIZSziHKpLULu9XQYsXNJJ9Ik
         CkWBqJmEwezhw==
Received: by mail-ed1-f49.google.com with SMTP id r26so22006509edc.10
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 12:25:21 -0800 (PST)
X-Gm-Message-State: ANoB5pl8ENevI3iSsg0BlOuWjwlK5XDNg/T7FKM8EH8a7Sd0m7xhrrv9
        6MSS1+a8Zw52fDXowDKy4nhpCsYPeKhJIRzSxLY=
X-Google-Smtp-Source: AA0mqf7l+DO/d7ni2kOz06viSdNYs9u6v/0DiAEzxLIXQ92JMWDvVspjM/evP3pZMs3O798aL9AOaCN8oyAV47duUiI=
X-Received: by 2002:a50:ff08:0:b0:461:dbcc:5176 with SMTP id
 a8-20020a50ff08000000b00461dbcc5176mr67397812edu.53.1670358319856; Tue, 06
 Dec 2022 12:25:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx> <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx> <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx>
In-Reply-To: <878rjqqhxf.ffs@tglx>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Dec 2022 12:25:07 -0800
X-Gmail-Original-Message-ID: <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
Message-ID: <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Thomas,

Thanks again for your suggestions. Here is my homework so far.

On Fri, Dec 2, 2022 at 1:22 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Song!
>
> On Fri, Dec 02 2022 at 00:38, Song Liu wrote:
> > Thanks for all these suggestions!
>
> Welcome.
>
> > On Thu, Dec 1, 2022 at 5:38 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> You have to be aware, that the rodata space needs to be page granular
> >> while text and data can really aggregate below the page alignment, but
> >> again might have different alignment requirements.
> >
> > I don't quite follow why rodata space needs to be page granular. If text can
> > go below page granular, rodata should also do that, no?
>
> Of course it can, except for the case of ro_after_init_data, because
> that needs to be RW during module_init() and is then switched to RO when
> module_init() returns success. So for that you need page granular maps
> per module, right?
>
> Sure you can have a separate space for rodata and ro_after_init_data,
> but as I said to Mike:
>
>   "The point is, that rodata and ro_after_init_data is a pretty small
>    portion of modules as far as my limited analysis of a distro build
>    shows.
>
>    The bulk is in text and data. So if we preserve 2M pages for text and
>    for RW data and bite the bullet to split one 2M page for
>    ro[_after_init_]data, we get the maximum benefit for the least
>    complexity."
>
> So under the assumption that rodata is small, it's questionable whether
> the split of rodata and ro_after_init_data makes a lot of difference. It
> might, but that needs to be investigated.
>
> That's not a fundamental conceptual problem because adding a 4th type to
> the concept we outlined so far is straight forward, right?
>
> > I guess I will do my homework, and come back with as much information
> > as possible for #1 + #2 + #3. Then, we can discuss whether it makes
> > sense at all.
>
> Correct. Please have a close look at the 11 architecture specific
> module_alloc() variants so you can see what kind of tweaks and magic
> they need, which lets you better specify the needs for the
> initialization parameter set required.

Survey of the 11 architecture specific module_alloc(). They basically do
the following magic:

1. Modify MODULES_VADDR and/or MODULES_END. There are multiple
  reasons behind this, some arch does this for KASLR, some other archs
  have different MODULES_[VADDR|END] for different processors (32b vs.
  64b for example), some archs use some module address space for other
  things (i.e. _exiprom on arm).

Archs need 1: x86, arm64, arm, mips, ppc, riscv, s390, loongarch, sparc

2. Use kasan_alloc_module_shadow()

Archs need 2: x86, arm64, s390

3. A secondary module address space. There is a smaller preferred
  address space for modules. Once the preferred space runs out, allocate
  memory from a secondary address space.

Archs need 3: some ppc, arm, arm64 (PLTS on arm and arm64)

4. User different pgprot_t (PAGE_KERNEL, PAGE_KERNEL_EXEC, etc.)

5. sparc does memset(ptr, 0, size) in module_alloc()

6. nios2 uses kmalloc() for modules. Based on the comment, this is
  probably only because it needs different MODULES_[VADDR|END].

I think we can handle all these with a single module_alloc() and a few
module_arch_* functions().

unsigned long module_arch_vaddr(void);
unsigned long module_arch_end(void);
unsigned long module_arch_secondary_vaddr(void);
unsigned long module_arch_secondary_end(void);
pgprot_t module_arch_pgprot(alloc_type type);
void *module_arch_initialize(void *s, size_t n);
bool module_arch_do_kasan_shadow(void);

So module_alloc() would look like:

void *module_alloc(unsigned long size, pgprot_t prot, unsigned long align,
       unsigned long granularity, alloc_type type)
{
    unsigned long vm_flags = VM_FLUSH_RESET_PERMS |
        (module_arch_do_kasan_shadow() ? VM_DEFER_KMEMLEAK : 0);
    void *ptr;

    ptr = __vmalloc_node_range(size, align, module_arch_vaddr(),
        module_arch_end(), GFP_KERNEL, module_arch_pgprot(type), vm_flags,
        NUMA_NO_NODE, __builtin_return_address(0));

    if (!ptr && module_arch_secondary_vaddr() != module_arch_secondary_end())
        ptr = __vmalloc_node_range(size, align, module_arch_secondary_vaddr(),
        module_arch_secondary_end(), GFP_KERNEL, module_arch_pgprot(type),
        vm_flags, NUMA_NO_NODE, __builtin_return_address(0));

    if (p && module_arch_do_kasan_shadow() &&
        (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
        vfree(p);
        return NULL;
    }
    module_arch_initialize(ptr, size);
    return p;
}

This is not really pretty, but I don't have a better idea at the moment.


For the allocation type, there are technically 5 of them:

ALLOC_TYPE_RX,   /* text */
ALLOC_TYPE_RW,    /* rw data */
ALLOC_TYPE_RO,    /* ro data */
ALLOC_TYPE_RO_AFTER_INIT,
ALLOC_TYPE_RWX,   /* legacy, existing module_alloc behavior */

Given RO and RO_AFTER_INIT require PAGE alignment and are
relatively small. I think we can merge them with RWX.

For RX and RW, we can allocate huge pages, and cut subpage
chunks out for users (something similar to 1/6 of the set).

For RWX, we have 2 options:
1. Use similar logic as RX and RW, but use PAGE granularity, and
    do set_memory_ro on it.
2. Keep current module_alloc behavior.

1 is better at protecting direct map (less fragmentation); while
2 is probably a little simpler. Given module load/unload are
rare events in most systems, I personally think we can start
with option 2.


We also need to redesign module_layout. Right now, we have
up to 3 layouts: core, init, and data. We will need 6 allocations:
  core text,
  core rw data,
  core ro and ro_after_init data (one allocation)
  init text,
  init rw data,
  init ro data.

PS: how much do we benefit with separate core and init.
Maybe it is time to merge the two? (keep init part around until
the module unloads).

The above is my Problem analysis and Concepts.

For data structures, I propose we use two extra trees for RX
and RW allocation (similar to 1/6 of current version, but 2x
trees). For RWX, we keep current module_alloc() behavior,
so no new data structure is needed.

The new module_layout will be something like:

struct module_layout {
    void *ptr;
    unsigned int size;  /* text size, rw data size, ro + ro_after_init size */
    unsigned int ro_size;    /* ro_size for ro + ro_after_init allocation */
};

So that's all I have so far. Please share your comments and
suggestions on it.

One more question: shall we make module sections page
aligned without STRICT_MODULE_RWX? It appears to be
a good way to simplify the logic. But it may cause too much
memory waste for smaller processors?

Thanks,
Song
