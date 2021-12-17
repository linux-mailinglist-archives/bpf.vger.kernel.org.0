Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2E4794F7
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 20:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhLQTll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 14:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbhLQTlk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 14:41:40 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BCAC061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 11:41:40 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id q74so9308841ybq.11
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vy7m7L3HLo47r/MyNPrwnTOoEr/TnJA8Z1/9+18LpXA=;
        b=iyqs2wJi1h/kHkFNxqjVZV9Uua1iYCOnMWQXgRRn8xuoRc+ugEsPze2Fzsr9vs3DB+
         XVcIT/opda+w5R2JzVx/6Q52lwzd90dAbi5TR3Ll8kHb55GUNvz76oe/Cj87sG82d7ep
         sULOdeXs2bsh0VncxSGYJmBdpL2o50uJiika8Kw/2PG6ymuY5Flrl2gk+15cYMKDOarN
         j0R/WCpbbSDSed91mkwaiKoQKKej6ZDDWLWWlyoyIP4z2AvG5M0y17F3UjRjxTMTWIh+
         Y8wXlVWrxwPZfiArdO5HNomn9P7vCT9AWy+58bdBbY+UlVQYdZT7MKmGKne7kEECIS8e
         P4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vy7m7L3HLo47r/MyNPrwnTOoEr/TnJA8Z1/9+18LpXA=;
        b=KaqWtIC6Z0b6KW19WaJMN3r6YiO0IMk02ZJL16UkeeJ2WbmtGRGBBFLGZg3zJlQojC
         18F5B2s0dXWr2Q4GoY5ZAmsKpvJ7CPyRWS+Tm6rp+12VuK5ZwpQSqK7Vie+OTlQ3s+4T
         aZ+lkrq/MeOdpw5/nmI1fvILG+V9nBPeKXgAhxs9Bit08aYS3UFt2zKpPbH2WrSBS4vq
         QQoohsakaSbdvqL1KBgG5EHaePfnO222ko8LWVPhKCm1F2GNizbIBai15/hAZMJ/RJe3
         6Pnz9dteEisZrFSJg6ynZo1IKmIkUkGN0B06lOnRiamx/RLzCa2qZMwhgU89diNnM+7z
         9mUA==
X-Gm-Message-State: AOAM533u6hWu5BETL0vOrUM520PL6O5rxiJ4pk0pI9uoWOrkgjGl0Nol
        pVRHPejIyVF0IVh29h+pnt6LDOSDMRxBwUp3OIC0PaTiE4Q=
X-Google-Smtp-Source: ABdhPJzoe6OUPrBKZy8h0FeWRKfkIoUDJ9IH6p57Gd2XYdmhpNxG3vrCqxrE8qHfohU5A9SyhUgdM7dY8CNxn2UaJKQ=
X-Received: by 2002:a25:2a89:: with SMTP id q131mr6908242ybq.436.1639770099705;
 Fri, 17 Dec 2021 11:41:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHMuVOB16tif6TRjdNVN9YjGc-UpOOwuo35SM+vY7Bf5=1+oiQ@mail.gmail.com>
 <CAEf4BzZZKC_rq8h=NiWByCCxJN9GGWsqGgcGbcUJA6L5duR5Hg@mail.gmail.com> <20211217192235.GA40254@Mem>
In-Reply-To: <20211217192235.GA40254@Mem>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Dec 2021 11:41:28 -0800
Message-ID: <CAEf4Bzbg2+RHhXQRB6tryQ_b3LFaLi-ibp0EjyBzASxkXW=z0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Probe for bounded loop support
To:     Paul Chaignon <paul@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 17, 2021 at 11:22 AM Paul Chaignon <paul@isovalent.com> wrote:
>
> On Fri, Dec 17, 2021 at 08:12:23AM -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 17, 2021 at 4:12 AM Paul Chaignon <paul@isovalent.com> wrote:
> > >
> > > This patch introduces a new probe to check whether the verifier supports
> > > bounded loops as introduced in commit 2589726d12a1 ("bpf: introduce
> > > bounded loops"). This patch will allow BPF users such as Cilium to probe
> > > for loop support on startup and only unconditionally unroll loops on
> > > older kernels.
> > >
> > > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > > Signed-off-by: Paul Chaignon <paul@isovalent.com>
> > > ---
> > >  tools/lib/bpf/libbpf.h        |  1 +
> > >  tools/lib/bpf/libbpf.map      |  1 +
> > >  tools/lib/bpf/libbpf_probes.c | 20 ++++++++++++++++++++
> > >  3 files changed, 22 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index 42b2f36fd9f0..3621aaaff67c 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -1058,6 +1058,7 @@ LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
> > >  LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id,
> > >                                  enum bpf_prog_type prog_type, __u32 ifindex);
> > >  LIBBPF_API bool bpf_probe_large_insn_limit(__u32 ifindex);
> > > +LIBBPF_API bool bpf_probe_bounded_loops(__u32 ifindex);
> > >
> >
> > Nope, see [0], I'm removing bpf_probe_large_insn_limit, so no new
> > ad-hoc feature probing APIs, please. There has to be some system to
> > this. If you want to add it to bpftool, go ahead, but keep it inside
> > bpftool code only. In practice I'd use CO-RE feature detection from
> > the BPF program side to pick the best implementation. Worst case, I'd
> > add two BPF program implementations and picked one or the other
> > (bpf_program__set_autoload(false) to disable one of them) after doing
> > feature detection from the process, not relying on shelling out to
> > bpftool.
>
> Thanks for the pointer, I wasn't aware of that ongoing work.
>
> For CO-RE feature detection, do you have in mind a bpf_core_field_exists
> call to check one of the bpf_func_state fields introduced in the same
> commit as bounded loop support, or is there some other CO-RE magic I'm
> not aware of?

yep, I had bpf_core_xxx() checks in mind. But even without CO-RE and
vmlinux BTF, if you can detect it from user-space and set .rodata
variables, BPF verifier will dead code eliminate gated parts that rely
on bounded loops, if that's more convenient.

But if bpftool works, by all means.

>
> In any case, I don't think we can assume BTF support in Cilium yet
> (soon, hopefully). I'll probably resend as a bpftool-only patch.

SGTM.

>
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20211216070442.1492204-2-andrii@kernel.org/
>
> [...]
