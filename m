Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B163F85B
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiLATdg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 14:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiLATdU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 14:33:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2509C8D24
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 11:31:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E59B8201F
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 19:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D391C4347C
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669923117;
        bh=MHrMG4HUwne7kwNPQKHu6pg4BWKi0jqdvGpYPvhZB4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tzPPxLmncvGcY4JJt/V6T3fQSEIMFEAiBy4p/gseXkO37gY48UXF0ctHnlrJuxURT
         /fmOyOCedFYZCH//s5cvntIXZ4qBb/vtZVoLReXbZtMZ7GJ9WWv/5Dh0mBdtc13lIu
         +qhd9mjK2nCmHId0r/plvpPVdJL3MQHeLOX9YxxeDdgJamAM5LiUgi6GJfR/v1j+Bb
         S6w1FkjVLsoFc5UBQxv1i8sCC0zWeqNg0r4o5H4QOI+FwMwqGrGEuDS9ETOWwAoNKW
         GvXszzjlMR0v0vjZhF9cA/B9eXcOkxHZc1ul7IJlL/2DfpA0i2Rcp41xbFbDDMqZk/
         gzdcL95DbbCcw==
Received: by mail-ej1-f44.google.com with SMTP id gu23so6591236ejb.10
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 11:31:57 -0800 (PST)
X-Gm-Message-State: ANoB5pnkIWcOwllm5lUR+5RsWGJZJzj3gXS1aqIbi1l55L0Ctu1cEixt
        DcYU4m3V3uBQo59mbfTWmXWmWk8sR3TQWsdIPYw=
X-Google-Smtp-Source: AA0mqf67rwGPuNDsKkeGCJ2W2GUnpY9YAc/CBgcYBqfz5BnQZnCr8T5FH87MMR6mdb62Po1C8Auz3sIm8V6n72ZJhZY=
X-Received: by 2002:a17:907:2c68:b0:7c0:999d:1767 with SMTP id
 ib8-20020a1709072c6800b007c0999d1767mr8756042ejc.301.1669923115499; Thu, 01
 Dec 2022 11:31:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
In-Reply-To: <87v8mvsd8d.ffs@tglx>
From:   Song Liu <song@kernel.org>
Date:   Thu, 1 Dec 2022 11:31:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
Message-ID: <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
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

Thanks for these insights! They are really helpful!


On Thu, Dec 1, 2022 at 1:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Song!
>
> On Wed, Nov 30 2022 at 08:18, Song Liu wrote:
> > On Tue, Nov 29, 2022 at 3:56 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> You are not making anything easier. You are violating the basic
> >> engineering principle of "Fix the root cause, not the symptom".
> >>
> >
> > I am not sure what is the root cause and the symptom here.
>

[...]

>
> This made me look at your allocator again:
>
> > +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> > +#define EXEC_MEM_START MODULES_VADDR
> > +#define EXEC_MEM_END MODULES_END
> > +#else
> > +#define EXEC_MEM_START VMALLOC_START
> > +#define EXEC_MEM_END VMALLOC_END
> > +#endif
>
> The #else part is completely broken on x86/64 and any other
> architecture, which has PC relative restricted displacement.

Yeah, the #else part is just to make it build. It is not really usable.

>
> Even if modules are disabled in Kconfig the only safe place to allocate
> executable kernel text from (on these architectures) is the modules
> address space. The ISA restrictions do not go magically away when
> modules are disabled.
>
> In the early version of the SKX retbleed mitigation work I had
>
>   https://lore.kernel.org/all/20220716230953.442937066@linutronix.de
>
> exactly to handle this correctly for the !MODULE case. It went nowhere
> as we did not need the trampolines in the final version.

I remember there was some other work to use module_alloc for ftrace, etc.
without CONFIG_MODULES. One of these versions would work here.

>
> This is why Peter suggested to 'split' the module address range into a
> top down and bottom up part:
>
>   https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/
>
> That obviously separates text and data, but keeps everything within the
> defined working range.
>
> It immediately solves the text problem for _all_ module_alloc() users
> and still leaves the data split into 4k pages due to RO/RW sections.
>
> But after staring at it for a while I think this top down and bottom up
> dance is too much effort for not much gain. The module address space is
> sized generously, so the straight forward solution is to split that
> space into two blocks and use them to allocate text and data separately.
>
> The rest of Peter's suggestions how to migrate there still apply.
>
> The init sections of a module are obviously separate as they are freed
> after the module is initialized, but they are not really special either.
> Today they leave holes in the address range. With the new scheme these
> holes will be in the memory backed large mapping, but I don't see a real
> issue with that, especially as those holes at least in text can be
> reused for small allocations (kprobes, trace, bpf).
>
> As a logical next step we make that three blocks and allocate text,
> data and rodata separately, which will preserve the large mappings for
> text and data. rodata still needs to be split because we need a space to
> accomodate ro_after_init data.
>
> Alternatively, instead of splitting the module address space, the
> allocation mechanism can keep track of the types (text, data, rodata)
> and manage large mapping blocks per type. There are pros and cons for
> both approaches, so that needs some thought.

AFAICT, the new allocator (let's call it module_alloc_new here)
requires quite some different logic than the existing vmalloc logic (or
module_alloc logic):

1. vmalloc is at least PAGE_SIZE granularity; while ftrace, bpf etc would
    benefit from a much smaller granularity.
2. vmalloc maintains 1-to-1 mapping between virtual address range (vmap
    in vmap_area_root) and physical pages (vm_struct); while
    module_alloc_new allocates physical pages in 2MB chunks, and
    maintains multiple vmap within a single 2MB chunk.

To solve this, I introduced a new tree free_text_area_root, address spaces
in this tree is backed with ROX physical pages, but not used by any user.
I think some logic like this is always needed.

With this logic in place, I think we don't really need to split the module
address space. Instead, we can have 3 trees:
  free_module_text_area_root;
  free_module_data_area_root;
  free_module_ro_data_area_root;

Similar to free_text_area_root, we add virtual address and physical pages
to these trees in 2MB chunks, and hands virtual address rnage out to users in
smaller granularity.

What do you think about this idea?

>
> But at the end we want an allocation mechanism which:
>
>   - preserves large mappings
>   - handles a distinct address range
>   - is mapping type aware
>
> That solves _all_ the issues of modules, kprobes, tracing, bpf in one
> go. See?

I think the user still needs to use module_alloc_new() differently. At the
moment, the user does something like.

my_text = module_alloc(size);
set_vm_flush_reset_perms(my_text);
update_my_text(my_text);
set_memory_ro(my_text);
set_memory_x(my_text);
/* use my_text */

With module_alloc_new(), my_text buffer is RX right out of the
allocator, so some text_poke mechanism is needed. In some cases,
the user also needs some logic to handle relative call/jump. It is
something like:

my_text = module_alloc_new(size, MODULE_MEM_TEXT);
my_tmp_buf = vmalloc(size);
update_my_text(my_tmp_buf);
adjust_rela_calls(my_tmp_buf, my_text);
text_poke_copy(my_text, my_tmp_buf, size);
vfree(my_tmp_buf);
/* use my_text */

There are also archs that do not support text_poke, so we need some
logic, especially for modules, to handle them properly. For example,
Rick suggested something like:

For non-text_poke() architectures, the way you can make it work is have
the API look like:
execmem_alloc()  <- Does the allocation, but necessarily usable yet
execmem_write()  <- Loads the mapping, doesn't work after finish()
execmem_finish() <- Makes the mapping live (loaded, executable, ready)

So for text_poke():
execmem_alloc()  <- reserves the mapping
execmem_write()  <- text_pokes() to the mapping
execmem_finish() <- does nothing

And non-text_poke():
execmem_alloc()  <- Allocates a regular RW vmalloc allocation
execmem_write()  <- Writes normally to it
execmem_finish() <- does set_memory_ro()/set_memory_x() on it

Does this sound like the best path forward to you?

Also, do you have suggestions on the name of the API? Maybe
something like:

enum module_mem_type {
    MODULE_MEM_TEXT,
    MODULE_MEM_DATA,
    MODULE_MEM_RODATA,
};
module_alloc_type(size_t len, enum module_mem_type type);
module_free_type(ptr);   /* I guess we may or may not type here */

Thanks,
Song
