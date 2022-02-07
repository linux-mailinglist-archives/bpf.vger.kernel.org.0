Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860944ACB43
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 22:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiBGV1s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 16:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbiBGV1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 16:27:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A9C0612A4
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 13:27:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z17so2151872plb.9
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 13:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xzktq0nFKpwkfS9KVyPwcTXjLml1DCMFjIHIhtaSzl0=;
        b=lSe+3n/7iTHRWcKgoOMRytjDDmwsCy6cqjPaPbhYB5YNPH4PuLNeRaTPRGuN9WfysO
         xr4iL1RIkwUI2wBVV97RnAEdaSE54wUMjwzJy4U7ShFM9dkjpO59gQ41QyKR7qtEkIxU
         a4TBuxWXRiGgvcRJArD6dC1I25BNTuoe29N2o0t1KYo5WEVdLqS9Mkpk6aopwaV9Q1vq
         D5121lRqouSLdmPkhzGi/WGClOGxaR12xjj9zPFgxAGqUGvBijVCSYVFrxyht7094xxx
         GVDgSFkXgR0WzrtrbCgJBjtRfEOa8YxpTrl63MYBV9YAOSP1uEKm23ufZ/bI14959uDv
         OUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xzktq0nFKpwkfS9KVyPwcTXjLml1DCMFjIHIhtaSzl0=;
        b=VceV9eUxkANjrtbhNhMiFYRjakmP9yMlCsp4Pzx3H1xWqs5ilhoySJhhBudQQnQSp6
         Kymf/+eFgGifFHbD131OQ/PSG32scR3Bv8uX+mX3Ju3jsramjBZelLVCJxEa5ojSGo0w
         mOpraBigGuikcLighK3miBaz0Q8dv2gSNAT6cZhiNrEVayteKUOGme9G5BQPP7anZCDb
         3l09bmQ7d7tGCtuUm7eQQ6ZkzMcEq4+ZIRFtynXa5+wlL88DU++DQ7jOmc7dqksJkz8B
         tvt2dA3+4Yd5AIqcBJNjb3pWQt1CnAKCZD32vl7hcC5gIx17lIZzsSJ9mr9dhXsZMi5a
         MLLQ==
X-Gm-Message-State: AOAM533XAuLVgoXeFSsd2kY2Eh6MpkHSiHIYcJkyJ3oYkr4aXLybeaSd
        ir942NWQSVxXfbG3eifgnEKZxjVczRw=
X-Google-Smtp-Source: ABdhPJw3N8CoTTDrd827u8o63zLCg/ZAV1Ovm0w1Sn2ulrQpeRILtsfJzVXMj1uZBsASjeJBrxK6hw==
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr925904pjb.33.1644269265702;
        Mon, 07 Feb 2022 13:27:45 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::5f3a])
        by smtp.gmail.com with ESMTPSA id md9sm290374pjb.6.2022.02.07.13.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:27:44 -0800 (PST)
Date:   Mon, 7 Feb 2022 13:27:42 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: Prepare light skeleton for the
 kernel.
Message-ID: <20220207212742.xjx6siycudwzok62@ast-mbp.dhcp.thefacebook.com>
References: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
 <20220204231710.25139-3-alexei.starovoitov@gmail.com>
 <CAEf4BzZQs=QU2=Qz55TYiiWbhw0ne=S8iTBAV3U8Ayr7grG4Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZQs=QU2=Qz55TYiiWbhw0ne=S8iTBAV3U8Ayr7grG4Ag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 07, 2022 at 12:04:14PM -0800, Andrii Nakryiko wrote:
> >   */
> >  struct bpf_map_desc {
> > -       union {
> > -               /* input for the loader prog */
> > -               struct {
> > -                       __aligned_u64 initial_value;
> > -                       __u32 max_entries;
> > -               };
> > +       struct {
> 
> Is this anonymous struct still needed?

Right. Will remove.

> > +static inline void *skel_alloc(size_t size)
> > +{
> > +       return kcalloc(1, size, GFP_KERNEL);
> > +}
> > +static inline void skel_free(const void *p)
> > +{
> > +       kfree(p);
> > +}
> 
> any reason to skim on empty lines between functions? The rest of this
> file (and libbpf code in general) feels very different in terms of
> spacing.

Because it's more compact, but I don't mind extra lines.

> > +static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> > +{
> > +       if (addr && addr != ~0ULL)
> > +               vm_munmap(addr, sz);
> > +       if (addr != ~0ULL)
> > +               kvfree(p);
> 
> minor nit: a small comment explaining that we set addr to ~0ULL on
> error (but we still call skel_free_map_data) would help a bit here

ok.

> > +}
> > +/* skel->bss/rodata maps are populated in three steps.
> > + *
> > + * For kernel use:
> > + * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
> > + * skel_prep_init_value() allocates a region in user space process and copies
> > + * potentially modified initial map value into it.
> > + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
> 
> I'm missing something here. If a light skeleton is used from a kernel
> module, then this initialization data is also pointing to kernel
> module memory, no? So why the copy_from_user() then?
> 
> Also this vm_mmap() and vm_munmap(), is it necessary for in-kernel
> skeleton itself, or it's required so that if some user-space process
> would fetch that BPF map by ID and tried to mmap() its content it
> would be possible? Otherwise it's not clear, as kernel module can
> access BPF array's value pointer directly anyways, so why the mmaping?

vm_mmap step only to preserve one version of light skeleton that
works for both user space and kernel. Otherwise bpftool would need another flag
and test coverage would need to increase. This way light skeleton for kernel
doesn't need a bunch of new tests.
Another option would be to add 'is_kernel' flag to bpf_loader_ctx and generate
loader program like:
if (ctx->is_kernel)
  bpf_probe_read_kernel
else
  bpf_copy_from_user

but 'ctx' will be modified after signature check, so the user space user
of light skel might trick it to populate maps with garbage kernel data.
The loader prog needs cap_perfmon anyway, so there are no security concerns,
but it's not great to have such room for error.
vm_mmap approach is not pretty, but looks to be the lesser evil.
I'm all ears if there are other options.
