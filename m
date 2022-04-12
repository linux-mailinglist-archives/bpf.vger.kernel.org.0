Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120714FEADC
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 01:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiDLX20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 19:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiDLX0y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 19:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31801985A0;
        Tue, 12 Apr 2022 15:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA1861C9C;
        Tue, 12 Apr 2022 21:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2333CC385AF;
        Tue, 12 Apr 2022 21:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649797250;
        bh=ZpL2a5lPfBdUIedwirE+bwCeUGPgdpinbYEuBaVo93A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MCex7/V9j1yaLO/NwFvMfN5Tp5passJZr3HqGxacPnkN/uqVJgDV+rDlkf1JPJwrw
         jJB0IM3r7a2aAMtm494uCivGxhePa7QfZ+jkvq7y8qLMP/BY8+y8zWkpDjmPQa5I7L
         S7USJwm6H2O06hVGDOBS6jujqxpB4Ehdbv+IenT2YnlBLa+zjLLRgjhYnqd++AdrUS
         G1HhigEtmQyZDEFtNzHtsuQ1N1RKuyeK9ygp0C5hWpeJXX3IggUIBvCT1o6nkW7Xty
         KaPr7X08KWFfkIvdctNrlhRko2OZv2SYWUSZ86O+K8x+Vrw4K3NlwSUJA54zTdvMa/
         9JFzcxQ9NBJ0Q==
Received: by mail-yb1-f177.google.com with SMTP id x200so185500ybe.13;
        Tue, 12 Apr 2022 14:00:50 -0700 (PDT)
X-Gm-Message-State: AOAM531vS9nc+/mkPDmeNVQcGDxlyvYuGImW7eCpuDnxn5ZsV2d0RjPp
        LmR1lb/d8Ducsnbsnup/zZZWvuo32EdNcRWTez8=
X-Google-Smtp-Source: ABdhPJxjBoD724NeqcWAf+nNammAA1fL9bzwhgdCmHoOJV6kU0RCocV1LM2FswYKq8YjUh6v1F76bmQApbI2VBmEnEk=
X-Received: by 2002:a25:4055:0:b0:641:636e:18dd with SMTP id
 n82-20020a254055000000b00641636e18ddmr8364049yba.389.1649797249049; Tue, 12
 Apr 2022 14:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233549.740157-1-song@kernel.org> <20220411233549.740157-5-song@kernel.org>
 <0e8047d07def02db8ef33836ee37de616660045c.camel@intel.com>
In-Reply-To: <0e8047d07def02db8ef33836ee37de616660045c.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 12 Apr 2022 14:00:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4pde5DTMNzRUHwPoxs6vh9AQPn+ny5-9cFVO4nVnYsGw@mail.gmail.com>
Message-ID: <CAPhsuW4pde5DTMNzRUHwPoxs6vh9AQPn+ny5-9cFVO4nVnYsGw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] bpf: use vmalloc with VM_ALLOW_HUGE_VMAP for bpf_prog_pack
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 12, 2022 at 10:21 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-04-11 at 16:35 -0700, Song Liu wrote:
> > @@ -889,7 +889,6 @@ static struct bpf_prog_pack *alloc_new_pack(void)
> >         bitmap_zero(pack->bitmap, bpf_prog_pack_size /
> > BPF_PROG_CHUNK_SIZE);
> >         list_add_tail(&pack->list, &pack_list);
> >
> > -       set_vm_flush_reset_perms(pack->ptr);
> >         set_memory_ro((unsigned long)pack->ptr, bpf_prog_pack_size /
> > PAGE_SIZE);
> >         set_memory_x((unsigned long)pack->ptr, bpf_prog_pack_size /
> > PAGE_SIZE);
> >         return pack;
>
> Dropping set_vm_flush_reset_perms() is not mentioned in the commit log.
> It is kind of a fix for a different issue.
>
> Now that x86 supports vmalloc huge pages, but VM_FLUSH_RESET_PERMS does
> not work with them, we should have some comments or warnings to that
> effect somewhere. Someone may try to pass the flags in together.

Good catch! I will add it in the next version.

>
> > @@ -970,7 +969,9 @@ static void bpf_prog_pack_free(struct
> > bpf_binary_header *hdr)
> >         if (bitmap_find_next_zero_area(pack->bitmap,
> > bpf_prog_chunk_count(), 0,
> >                                        bpf_prog_chunk_count(), 0) ==
> > 0) {
> >                 list_del(&pack->list);
> > -               module_memfree(pack->ptr);
>
>
> > +               set_memory_nx((unsigned long)pack->ptr,
> > bpf_prog_pack_size / PAGE_SIZE);
> > +               set_memory_rw((unsigned long)pack->ptr,
> > bpf_prog_pack_size / PAGE_SIZE);
> > +               vfree(pack->ptr);
> >                 kfree(pack);
>
> Now that it calls module_alloc_huge() instead of vmalloc_node_range(),
> should it call module_memfree() instead of vfree()?

Right. Let me sort that out. (Also, whether we introduce module_alloc_huge()
or not).

>
>
>
> Since there are bugs, simple, immediate fixes seem like the right thing
> to do, but I had a couple long term focused comments on this new
> feature:
>
> It would be nice if bpf and the other module_alloc() callers could
> share the same large pages. Meaning, ultimately that this whole thing
> should probably live outside of bpf. BPF tracing usages might benefit
> for example, and kprobes and ftrace are not too different than bpf
> progs from a text allocation perspective.

Agreed.

>
> I agree that the module's part is non-trivial. A while back I had tried
> to do something like bpf_prog_pack() that worked for all the
> module_alloc() callers. It had some modules changes to allow different
> permissions to go to different allocations so they could be made to
> share large pages:
>
> https://lore.kernel.org/lkml/20201120202426.18009-1-rick.p.edgecombe@intel.com/
>
> I thought the existing kernel special permission allocation methods
> were just too brittle and intertwined to improve without a new
> interface. The hope was the new interface could wrap all the arch
> intricacies instead of leaving them exposed in the cross-arch callers.
>
> I wonder what you think of that general direction or if you have any
> follow up plans for this?

Since I am still learning the vmalloc/module_alloc code, I think I am
not really capable of commenting on the direction. From our use
cases, we do see performance hit due to large number of BPF
program fragmenting the page table. Kernel module, OTOH, is not
too big an issue for us, as we usually build hot modules into the
kernel. That being said, we are interested in making the huge page
interface general for BPF program and kernel module. We can
commit resources to this effort.

Thanks,
Song
