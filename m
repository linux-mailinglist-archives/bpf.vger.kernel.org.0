Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247F7614DF7
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 16:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKAPMX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 11:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiKAPMD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 11:12:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5552C1004
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 08:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D956661617
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 15:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E86C433C1
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667315191;
        bh=KsYtGllPGvynMCY3GzO/L7I7rZ7vlfjcEUfFT2fvNNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=teMTWeqxn4Tx4kbgkG+nt7Cc6KENlB6vgsryjnXOwYPyotGcg/INQoLn/xdWf9mjA
         05ucAyWnetfx25sVVfx/N0Hk8C9Eg9AtHqHc1Sj5iOEhiuxZXkpvYQ12vqVPMXEfY2
         AKA/WALFGaFnesQtIDJEm8+5Bof9gEoA203GvXYCslXGBte6I9BWcd0MYoW7qwhQH8
         n3jB1rLQXMCuM4xmF29TjZkOVv+NdE3fq+7WnCDyHmCYQr21m1t+knkB51P8+wlyqI
         v25yzdde7HTNpr122jgqiTuOCRmXnx+jnd37GwOZKpBt06K7HgTxLWKDIzWL+jmTNp
         MqbLPqclSzrNA==
Received: by mail-ej1-f53.google.com with SMTP id f27so37755818eje.1
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 08:06:31 -0700 (PDT)
X-Gm-Message-State: ACrzQf0s9Cz/XVnWnGXro1gfCtUVpCh4dVHxRtoXdMAeDj2xGdbEX3nh
        kkJDMiZNgDg2y43Q5+xYGSRpbE6EWzf/iG0y7Wo=
X-Google-Smtp-Source: AMsMyM7Mo2fRx3Fq+g7lJlwPyodqrQCksZrooLG5S/xRU2M0eRNZIaAY199jFsGhFNYi2Gwf+/TtKomI8LbDuwanK9U=
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id
 nd15-20020a170907628f00b0072f58fc3815mr18322891ejc.719.1667315189418; Tue, 01
 Nov 2022 08:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221031215834.1615596-1-song@kernel.org> <20221031215834.1615596-2-song@kernel.org>
 <Y2EJB34M3NPKBY3v@pc636>
In-Reply-To: <Y2EJB34M3NPKBY3v@pc636>
From:   Song Liu <song@kernel.org>
Date:   Tue, 1 Nov 2022 08:06:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW65B2ApXc0zpEW3OV_FNt9VzxAu2pWffcF3UthL2xty7A@mail.gmail.com>
Message-ID: <CAPhsuW65B2ApXc0zpEW3OV_FNt9VzxAu2pWffcF3UthL2xty7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, dave.hansen@intel.com,
        mcgrof@kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 4:54 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Oct 31, 2022 at 02:58:30PM -0700, Song Liu wrote:
> > vmalloc_exec is used to allocate memory to host dynamic kernel text
> > (modules, BPF programs, etc.) with huge pages. This is similar to the
> > proposal by Peter in [1].
> >
> > A new tree of vmap_area, free_text_area_* tree, is introduced in addition
> > to free_vmap_area_* and vmap_area_*. vmalloc_exec allocates pages from
> > free_text_area_*. When there isn't enough space left in free_text_area_*,
> > new PMD_SIZE page(s) is allocated from free_vmap_area_* and added to
> > free_text_area_*. To be more accurate, the vmap_area is first added to
> > vmap_area_* tree and then moved to free_text_area_*. This extra move
> > simplifies the logic of vmalloc_exec.
> >
> > vmap_area in free_text_area_* tree are backed with memory, but we need
> > subtree_max_size for tree operations. Therefore, vm_struct for these
> > vmap_area are stored in a separate list, all_text_vm.
> >
> > The new tree allows separate handling of < PAGE_SIZE allocations, as
> > current vmalloc code mostly assumes PAGE_SIZE aligned allocations. This
> > version of vmalloc_exec can handle bpf programs, which uses 64 byte
> > aligned allocations), and modules, which uses PAGE_SIZE aligned
> > allocations.
> >
> > Memory allocated by vmalloc_exec() is set to RO+X before returning to the
> > caller. Therefore, the caller cannot write directly write to the memory.
> > Instead, the caller is required to use vcopy_exec() to update the memory.
> > For the safety and security of X memory, vcopy_exec() checks the data
> > being updated always in the memory allocated by one vmalloc_exec() call.
> > vcopy_exec() uses text_poke like mechanism and requires arch support.
> > Specifically, the arch need to implement arch_vcopy_exec().
> >
> > In vfree_exec(), the memory is first erased with arch_invalidate_exec().
> > Then, the memory is added to free_text_area_*. If this free creates big
> > enough continuous free space (> PMD_SIZE), vfree_exec() will try to free
> > the backing vm_struct.
> >
> > [1] https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  include/linux/vmalloc.h |   5 +
> >  mm/nommu.c              |  12 ++
> >  mm/vmalloc.c            | 318 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 335 insertions(+)
> >
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 096d48aa3437..9b2042313c12 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -154,6 +154,11 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >  void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
> >               int node, const void *caller) __alloc_size(1);
> >  void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
> > +void *vmalloc_exec(unsigned long size, unsigned long align) __alloc_size(1);
> > +void *vcopy_exec(void *dst, void *src, size_t len);
> > +void vfree_exec(void *addr);
> > +void *arch_vcopy_exec(void *dst, void *src, size_t len);
> > +int arch_invalidate_exec(void *ptr, size_t len);
> >
> >  extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
> >  extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 214c70e1d059..8a1317247ef0 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -371,6 +371,18 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
> >  }
> >  EXPORT_SYMBOL(vm_map_pages_zero);
> >
> > +void *vmalloc_exec(unsigned long size, unsigned long align)
> > +{
> > +     return NULL;
> > +}
> > +
> > +void *vcopy_exec(void *dst, void *src, size_t len)
> > +{
> > +     return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +
> > +void vfree_exec(const void *addr) { }
> > +
> >  /*
> >   *  sys_brk() for the most part doesn't need the global kernel
> >   *  lock, except when an application is doing something nasty
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ccaa461998f3..6f4c73e67191 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -72,6 +72,9 @@ early_param("nohugevmalloc", set_nohugevmalloc);
> >  static const bool vmap_allow_huge = false;
> >  #endif       /* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
> >
> > +#define PMD_ALIGN(addr) ALIGN(addr, PMD_SIZE)
> > +#define PMD_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PMD_SIZE)
> > +
> >  bool is_vmalloc_addr(const void *x)
> >  {
> >       unsigned long addr = (unsigned long)kasan_reset_tag(x);
> > @@ -769,6 +772,38 @@ static LIST_HEAD(free_vmap_area_list);
> >   */
> >  static struct rb_root free_vmap_area_root = RB_ROOT;
> >
> > +/*
> > + * free_text_area for vmalloc_exec()
> > + */
> > +static DEFINE_SPINLOCK(free_text_area_lock);
> > +/*
> > + * This linked list is used in pair with free_text_area_root.
> > + * It gives O(1) access to prev/next to perform fast coalescing.
> > + */
> > +static LIST_HEAD(free_text_area_list);
> > +
> > +/*
> > + * This augment red-black tree represents the free text space.
> > + * All vmap_area objects in this tree are sorted by va->va_start
> > + * address. It is used for allocation and merging when a vmap
> > + * object is released.
> > + *
> > + * Each vmap_area node contains a maximum available free block
> > + * of its sub-tree, right or left. Therefore it is possible to
> > + * find a lowest match of free area.
> > + *
> > + * vmap_area in this tree are backed by RO+X memory, but they do
> > + * not have valid vm pointer (because we need subtree_max_size).
> > + * The vm for these vmap_area are stored in all_text_vm.
> > + */
> > +static struct rb_root free_text_area_root = RB_ROOT;
> > +
> > +/*
> > + * List of vm_struct for free_text_area_root. This list is rarely
> > + * accessed, so the O(N) complexity is not likely a real issue.
> > + */
> > +struct vm_struct *all_text_vm;
> > +
> >  /*
> >   * Preload a CPU with one object for "no edge" split case. The
> >   * aim is to get rid of allocations from the atomic context, thus
> > @@ -3313,6 +3348,289 @@ void *vmalloc(unsigned long size)
> >  }
> >  EXPORT_SYMBOL(vmalloc);
> >
> > +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> > +#define VMALLOC_EXEC_START MODULES_VADDR
> > +#define VMALLOC_EXEC_END MODULES_END
> > +#else
> > +#define VMALLOC_EXEC_START VMALLOC_START
> > +#define VMALLOC_EXEC_END VMALLOC_END
> > +#endif
> > +
> > +static void move_vmap_to_free_text_tree(void *addr)
> > +{
> > +     struct vmap_area *va;
> > +
> > +     /* remove from vmap_area_root */
> > +     spin_lock(&vmap_area_lock);
> > +     va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> > +     if (WARN_ON_ONCE(!va)) {
> > +             spin_unlock(&vmap_area_lock);
> > +             return;
> > +     }
> > +     unlink_va(va, &vmap_area_root);
> > +     spin_unlock(&vmap_area_lock);
> > +
> > +     /* make the memory RO+X */
> > +     memset(addr, 0, va->va_end - va->va_start);
> > +     set_memory_ro(va->va_start, (va->va_end - va->va_start) >> PAGE_SHIFT);
> > +     set_memory_x(va->va_start, (va->va_end - va->va_start) >> PAGE_SHIFT);
> > +
> > +     /* add to all_text_vm */
> > +     va->vm->next = all_text_vm;
> > +     all_text_vm = va->vm;
> > +
> > +     /* add to free_text_area_root */
> > +     spin_lock(&free_text_area_lock);
> > +     merge_or_add_vmap_area_augment(va, &free_text_area_root, &free_text_area_list);
> > +     spin_unlock(&free_text_area_lock);
> > +}
> > +
> > +/**
> > + * vmalloc_exec - allocate virtually contiguous RO+X memory
> > + * @size:    allocation size
> > + *
> > + * This is used to allocate dynamic kernel text, such as module text, BPF
> > + * programs, etc. User need to use text_poke to update the memory allocated
> > + * by vmalloc_exec.
> > + *
> > + * Return: pointer to the allocated memory or %NULL on error
> > + */
> > +void *vmalloc_exec(unsigned long size, unsigned long align)
> > +{
> > +     struct vmap_area *va, *tmp;
> > +     unsigned long addr;
> > +     enum fit_type type;
> > +     int ret;
> > +
> > +     va = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, NUMA_NO_NODE);
> > +     if (unlikely(!va))
> > +             return NULL;
> > +
> > +again:
> > +     preload_this_cpu_lock(&free_text_area_lock, GFP_KERNEL, NUMA_NO_NODE);
> > +     tmp = find_vmap_lowest_match(&free_text_area_root, size, align, 1, false);
> > +
> > +     if (!tmp) {
> > +             unsigned long alloc_size;
> > +             void *ptr;
> > +
> > +             spin_unlock(&free_text_area_lock);
> > +
> > +             /*
> > +              * Not enough continuous space in free_text_area_root, try
> > +              * allocate more memory. The memory is first added to
> > +              * vmap_area_root, and then moved to free_text_area_root.
> > +              */
> > +             alloc_size = roundup(size, PMD_SIZE * num_online_nodes());
> > +             ptr = __vmalloc_node_range(alloc_size, PMD_SIZE, VMALLOC_EXEC_START,
> > +                                        VMALLOC_EXEC_END, GFP_KERNEL, PAGE_KERNEL,
> > +                                        VM_ALLOW_HUGE_VMAP | VM_NO_GUARD,
> > +                                        NUMA_NO_NODE, __builtin_return_address(0));
> > +             if (unlikely(!ptr))
> > +                     goto err_out;
> > +
> > +             move_vmap_to_free_text_tree(ptr);
> > +             goto again;
> >
> It is yet another allocator built on top of vmalloc. So there are 4 then.
> Could you please avoid of doing it? I do not find it as something that is
> reasonable.

Could you please elaborate why this is not reasonable? Or, what would
be a more reasonable alternative?

Thanks,
Song
