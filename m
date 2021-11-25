Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9347245DE6F
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 17:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhKYQQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 11:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhKYQOv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 11:14:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC30AC061A3F
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 07:59:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m24so4842966pls.10
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVT/h/b1JxXgPsghZbme6MV/FB5PifGmFBJ6WbiXN8U=;
        b=mBA310ouSV2pzyNALCaaR62JWArRGnIAL5pcXXyHshM6yx1Lpf0y0mbWaFTCAay2fd
         NKGvOgd18u46/e/rR9P6TCUZShhKCrW+/4UG4BCMqOubFV6vHl0ontxZ/1Rg67TECkrD
         IgMnEyRLxM/k0PnSaEslQLsLZabeFAupFkvlX92JVFeXS8+au/b9UGMsLuilFT4GuX8Q
         geM+OXizmPRk+fVgX0nMPZHY34Buw+3VgZ+SF9aXmdboVBcvSneGF9K4JXGenQ1KcLAK
         ThmB0KdzHCEE91f59JPQUZr2l8aKevpW75sMt6ud2LaDdWoX5WeKnFfQCC1IMmxidDBZ
         uYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVT/h/b1JxXgPsghZbme6MV/FB5PifGmFBJ6WbiXN8U=;
        b=my1BOxw6k8u+eN1PgtpSwIVmERnJQ67Mnf0ah/8PVAKa4L+EfYcQPB3/Bnp40hLzn9
         IzHtzMyZbvTC8+Cei0nzzlq3Sr+lOna0BtL7pq68OszWHvmpJVYZxCZCpIDcoVyYoXqi
         rajdv8qsh2RQEB8+zd1C0RWg/xcvf5jd315Ovp/y6iCqY061lZtebwaDyzqXrPDSAttS
         Mzxwdh6ZcFvRrLcAGtIYVpS/Du33yX6hIe17ZCqILe4zovAnQ8cOAMwChNoOcGzyDpQ4
         i473tECihbpKxejyNiZjHrcpEmdLHiiCl16RYVxr34cF6wBjAooqfwUsn1zH/xGrg5TS
         jp2g==
X-Gm-Message-State: AOAM532983iHBi3cD+7Z/5AEGtTgefm2KYzi9XUXd7MXuI/q7MVYDCfZ
        osztXu5C5srZZRrJIWP5pgIH0uVo2EPoMcGxvZs=
X-Google-Smtp-Source: ABdhPJzOI5UrU+4xlknefr2amNHx+hymVWs98IjoAUyQ3buD1ZmrzUhLA2BNeP7CTsdNj4hQXTC79ApGINK3CsXxdnA=
X-Received: by 2002:a17:902:b588:b0:143:b732:834 with SMTP id
 a8-20020a170902b58800b00143b7320834mr30907940pls.22.1637855957399; Thu, 25
 Nov 2021 07:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20211120165528.197359-1-kuba@kernel.org> <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
 <d4c52f8f-7efb-3d2a-8f2e-c983cd0c8cce@arm.com> <CAPhsuW6CMBymKpOMdL-bianESBLfbKa5JwmFypKL3dx4k0rmSQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6CMBymKpOMdL-bianESBLfbKa5JwmFypKL3dx4k0rmSQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Nov 2021 08:59:06 -0700
Message-ID: <CAADnVQ+2kPhfG_DOrYpibDfs-COC5AHyKEDbqPNWnPhLhrV=uA@mail.gmail.com>
Subject: Re: [PATCH bpf] cacheinfo: move get_cpu_cacheinfo_id() back out
To:     Song Liu <song@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, reinette.chatre@intel.com,
        bpf <bpf@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 1:14 AM Song Liu <song@kernel.org> wrote:
>
> On Tue, Nov 23, 2021 at 8:49 AM James Morse <james.morse@arm.com> wrote:
> >
> > Hello,
> >
> > On 23/11/2021 17:45, Song Liu wrote:
> > > On Sat, Nov 20, 2021 at 6:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > >>
> > >> This commit more or less reverts commit 709c4362725a ("cacheinfo:
> > >> Move resctrl's get_cache_id() to the cacheinfo header file").
> > >>
> > >> There are no users of the static inline helper outside of resctrl/core.c
> > >> and cpu.h is a pretty heavy include, it pulls in device.h etc. This
> > >> trips up architectures like riscv which want to access cacheinfo
> > >> in low level headers like elf.h.
> > >>
> > >> Link: https://lore.kernel.org/all/20211120035253.72074-1-kuba@kernel.org/
> > >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > >> ---
> >
> > >> x86 resctrl folks, does this look okay?
> > >>
> > >> I'd like to do some bpf header cleanups in -next which this is blocking.
> > >> How would you like to handle that? This change looks entirely harmless,
> > >> can I get an ack and take this via bpf/netdev to Linus ASAP so it
> > >> propagates to all trees?
> > >
> > > Does this patch target the bpf tree, or the bpf-next tree? If we want to unblock
> > > bpf header cleanup in -next, we can simply include it in a set for bpf-next.
> >
> >
> > Some background: this is part of the mpam tree that wires up resctrl for arm64. This patch
> > floated to the top and got merged with some cleanup as it was independent of the wider
> > resctrl changes.
> >
> > If the cpu.h include is the problem, I can't see what that is needed for. It almost
> > certainly came in with a lockdep annotation that got replaced by a comment instead.
>
> Thanks for the information.
>
> I can ack the patch for the patch itself.
>
> Acked-by: Song Liu <songliubraving@fb.com>
>
> But I am not sure whether we should ship it via bpf tree. It seems to
> me that the
> only reason we ship it via bpf tree is to get it to upstream ASAP?
>
> Alexei/Daniel/Andrii, what do you think about this?

I don't completely understand why it cannot go via -next along
with other patches, but if Jakub needs it asap here is my
Acked-by: Alexei Starovoitov <ast@kernel.org>
and probably the fastest is for Jakub to take it via net tree directly.
