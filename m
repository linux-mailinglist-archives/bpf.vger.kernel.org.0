Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D736B4ACBA4
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 22:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbiBGVv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 16:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbiBGVvZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 16:51:25 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AEBC061355
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 13:51:25 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r144so18721182iod.9
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 13:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bW4R90mfSdW4f8R3ft1IeaBObiDCJa07DzSRLolKjXU=;
        b=ExbXULI9+uBUhVVWVw9puJfcl+6b4c8JXmgCrbBPyYExMQR+6Ul3xmek1DXH1qSoKD
         hNXHKks2j9UCpGYdLsx58/7M2AuJxET5paq2EzufyWiVnLURfCbjegw/XqDlztPaOZ5z
         8j5qu+l3W2JW6+VFnJd+xylvaGEO01OlpNLCpvxc5ubKuT5Zu9BTrcX8eNXbGdVbTkBa
         IN8VK8g8IlmVh/ua1qgHqhr//8FzRHJfsQe4j0YR7n4c8O3D9gAF+1ZmmeqdKUBdz+iQ
         KSfdqaiOxed5GG5jshzZwl7sLc1Th4mYjF8hsKozrQrPWdari7OPtgYUiMNnpFG2ESxR
         hrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bW4R90mfSdW4f8R3ft1IeaBObiDCJa07DzSRLolKjXU=;
        b=idsOCGg7XHGVh78j9vhid3sciMK3xbRnQn0vkQMBZ8jRvvCz3JaFVs5PAlA3K7mIdZ
         QrR8Qvisoh1MHRAMq3/zyyWQS1J5xg2gKfskqLjp8a7U51Q76zRWt/1eQLF71Xw2fl9j
         Zg+EfxbFg/+scCzKieS1C1BTiLSEm7a2eC23X4Tfni156hPdY1ilhxNL35f2pQ4jeVsP
         Y3ukTAG4sNlTbQNU0SFJGySQizX+kWn2njW+6bX8YYtyuhmn+5zwZGRvE6Re/oya7Sbj
         trU9APzVlH7qGLRaTOoSDcvEgasByOIaTNrpWk+5/3VhWF7Up6Cb4pJteTmRkQCOZpbO
         LEtQ==
X-Gm-Message-State: AOAM533PXJzWzqd/MBys5QnpHmu0mPlTur5nIgemW0xQTipWx1qI5Rnk
        Hlhg5jKUhKNPZ4QEAJDMC3XNO41H4QrWDN6O0pWCbJqd
X-Google-Smtp-Source: ABdhPJx4sCt05kWuv+nbKFgGmKVvq/NmjYZzybB7Fy1KtUlPGh+LVFq/uW0X3nL1uZZKMuh/Q/DZEGATg/okip+KSJ8=
X-Received: by 2002:a05:6638:d88:: with SMTP id l8mr808976jaj.234.1644270684836;
 Mon, 07 Feb 2022 13:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
 <20220204231710.25139-3-alexei.starovoitov@gmail.com> <CAEf4BzZQs=QU2=Qz55TYiiWbhw0ne=S8iTBAV3U8Ayr7grG4Ag@mail.gmail.com>
 <20220207212742.xjx6siycudwzok62@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220207212742.xjx6siycudwzok62@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 13:51:13 -0800
Message-ID: <CAEf4BzbOM7_KH3y18QTZmJkr7QAxgm=fcavN=sFF+_PAZqJoaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: Prepare light skeleton for the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 7, 2022 at 1:27 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 07, 2022 at 12:04:14PM -0800, Andrii Nakryiko wrote:
> > >   */
> > >  struct bpf_map_desc {
> > > -       union {
> > > -               /* input for the loader prog */
> > > -               struct {
> > > -                       __aligned_u64 initial_value;
> > > -                       __u32 max_entries;
> > > -               };
> > > +       struct {
> >
> > Is this anonymous struct still needed?
>
> Right. Will remove.
>
> > > +static inline void *skel_alloc(size_t size)
> > > +{
> > > +       return kcalloc(1, size, GFP_KERNEL);
> > > +}
> > > +static inline void skel_free(const void *p)
> > > +{
> > > +       kfree(p);
> > > +}
> >
> > any reason to skim on empty lines between functions? The rest of this
> > file (and libbpf code in general) feels very different in terms of
> > spacing.
>
> Because it's more compact, but I don't mind extra lines.
>
> > > +static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> > > +{
> > > +       if (addr && addr != ~0ULL)
> > > +               vm_munmap(addr, sz);
> > > +       if (addr != ~0ULL)
> > > +               kvfree(p);
> >
> > minor nit: a small comment explaining that we set addr to ~0ULL on
> > error (but we still call skel_free_map_data) would help a bit here
>
> ok.
>
> > > +}
> > > +/* skel->bss/rodata maps are populated in three steps.
> > > + *
> > > + * For kernel use:
> > > + * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
> > > + * skel_prep_init_value() allocates a region in user space process and copies
> > > + * potentially modified initial map value into it.
> > > + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
> >
> > I'm missing something here. If a light skeleton is used from a kernel
> > module, then this initialization data is also pointing to kernel
> > module memory, no? So why the copy_from_user() then?
> >
> > Also this vm_mmap() and vm_munmap(), is it necessary for in-kernel
> > skeleton itself, or it's required so that if some user-space process
> > would fetch that BPF map by ID and tried to mmap() its content it
> > would be possible? Otherwise it's not clear, as kernel module can
> > access BPF array's value pointer directly anyways, so why the mmaping?
>
> vm_mmap step only to preserve one version of light skeleton that
> works for both user space and kernel. Otherwise bpftool would need another flag
> and test coverage would need to increase. This way light skeleton for kernel
> doesn't need a bunch of new tests.
> Another option would be to add 'is_kernel' flag to bpf_loader_ctx and generate
> loader program like:
> if (ctx->is_kernel)
>   bpf_probe_read_kernel
> else
>   bpf_copy_from_user
>
> but 'ctx' will be modified after signature check, so the user space user
> of light skel might trick it to populate maps with garbage kernel data.
> The loader prog needs cap_perfmon anyway, so there are no security concerns,
> but it's not great to have such room for error.
> vm_mmap approach is not pretty, but looks to be the lesser evil.
> I'm all ears if there are other options.

Ah, ok, I didn't get that. Please leave comments explaining this. I
have no preference regarding ctx->is_kernel vs doing in-kernel
vm_mmap(), but this needs to be spelled out, as it's very non-obvious.
