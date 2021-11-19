Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB92457588
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhKSRip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 12:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbhKSRio (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 12:38:44 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB410C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 09:35:42 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id u60so30252816ybi.9
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33HlLVuxAZElBzzJ1+m7qIH+YTQS14kQQby19PCYy7k=;
        b=QTPGKABkmNei6Euw66nZjLL0F6sl/cmZGZDwok3JGuWT/EcNNVCyw69Oljqu90qnPF
         AkwUuPnLLRClwWoXbVgDVrer7ZWrBlrMwxM8IwklFupdmMT+HbaOpzy6IUpbt+vsaJdg
         HqRrcFHtMIiNxLOev4DHKQURDBiwtvp8mdkrjT1QIj9CTcT84kqqWSxJPYsiC8UNP40+
         5z0RH0Iq2l232T9tFShBxbtQO4GGa/8AUfeYp/vlLc+o4Gn+uISTh2HgDW0bmMNYm1Uy
         fBxy4n7gdNaj6Vjv7i9e3LYKQWQKhHx1LNEm38NQ0/8E9LH8pbKxfHjWRsZJVfbGpO+j
         i1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33HlLVuxAZElBzzJ1+m7qIH+YTQS14kQQby19PCYy7k=;
        b=PSLFLcBwE3mw++52/FKd6RC3vaxQMzv7Vu29sTpQ8E7Qu3n6ykKsEpfSdsF+VfQAMA
         86IakXvHfmBncTP0XxhOONXAIpp8ksGbYDYiACYsauEcpp5DnD8SbxpygYQZ8f07cxl+
         KlRCLPWTq4iSoi37buR4ISILqMzgux0XJH8STf+9pnxAsrxC8TrPo3ba6upq5xSLY6++
         F9b7DOFwaMcIk2AZBYVDxA9rdjaEzxM7UZHisIp7OC3l5tauIyhO84z1ez8YchOu/Srm
         +cTcOM/FPHFOERJVN6fBR7xPQmWUSlz+VJOMW83eyNv8IxUjCM898wYBsXCd7sxqlIHe
         Yz9Q==
X-Gm-Message-State: AOAM531XW0w5KkC2xtT6x8ZYa34t0M/4d7Hg5HOIeWCY0bhmclDtrPQn
        00gTFPGPWa6oDZH4WOHj6saU/sjkzvKya1IvD/gBec4RmS4=
X-Google-Smtp-Source: ABdhPJwasnxC8yUziBXfbJKcsdRhT/QoA3dqbXCDroqM2qGp+PYstY39z27wcYZY6sql/47FpREXK5X+dJgYOSYDSLs=
X-Received: by 2002:a25:ccd4:: with SMTP id l203mr16810757ybf.225.1637343342066;
 Fri, 19 Nov 2021 09:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-6-alexei.starovoitov@gmail.com> <CAEf4BzbqNxw9pDXNHrB9KAy6mbnspRxF5JtUv7kL6iisU02Efg@mail.gmail.com>
 <20211119033242.r4irsnacxtptibrc@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211119033242.r4irsnacxtptibrc@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Nov 2021 09:35:31 -0800
Message-ID: <CAEf4BzZ7yZu9rVrm8_dta8MmzSgm=qMAtq3XfzgubEBWXpC95g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/12] bpf: Pass a set of bpf_core_relo-s to
 prog_load command.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 7:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 16, 2021 at 05:17:27PM -0800, Andrii Nakryiko wrote:
> > > +
> > > +       rec_size = attr->core_relo_rec_size;
> > > +       if (rec_size != sizeof(struct bpf_core_relo))
> > > +               return -EINVAL;
> >
> > For func_info we allow trailing zeroes (in check_btf_func, we check
> > MIN_BPF_FUNCINFO_SIZE and MAX_FUNCINFO_REC_SIZE). Shouldn't we do
> > something like that here?
>
> For both func_info and line_info the verifier indeed uses 252 as max rec_size.
> I believe the logic is trying to help in the following case:
> If llvm starts to produce a larger records the libbpf will test for the
> new kernel and will sanize the newer records with zeros _in place_.
>
> In case of bpf_core_relo the implementation of this patch doesn't
> take llvm bytes as-is. The relo records saved and copied potentially
> many times with every libbpf call relocations.
> Then later they are prepared in the final form.
>
> I don't mind doing the same 252 logic here, but when I wrote above
> check it felt more natural to be strict and simple, but...
>
> > > +
> > > +       u_core_relo = make_bpfptr(attr->core_relo, uattr.is_kernel);
> > > +       expected_size = sizeof(struct bpf_core_relo);
> > > +       ncopy = min_t(u32, expected_size, rec_size);
> >
> > I'm confused, a few lines above you errored out if expected_size != rec_size...
>
> but then I kept this part and below bpf_check_uarg_tail_zero().
> Clearly I couldn't make up my mind :)
>

Heh :)

> So drop all future proofing ? or do 252 ?

I think allowing bigger record sizes than the kernel knows about
(assuming zeroes in the tail) is a bit better, because then
sanitization won't require unnecessary memory copying. I'm actually
not sure why we restrict record size, if kernel can just copy just the
right amount of first X bytes of each record (we do the copy anyways),
so it feels like kernel should just make sure that the tail is zeroed,
like we do for bpf_attr, for example.

So I guess I vote for future proofing.
