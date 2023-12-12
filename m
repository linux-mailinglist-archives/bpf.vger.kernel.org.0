Return-Path: <bpf+bounces-17604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC01880FA94
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E121F21800
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07134597C;
	Tue, 12 Dec 2023 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGpL+XOR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6136BAA
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:55:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3331752d2b9so4199216f8f.3
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702421731; x=1703026531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QrupQaeoS+38stqe0rx4IUeHo/JZH/ATfJZajGunkM=;
        b=DGpL+XORraBrqNAAjipKeLs5pGfC+OgiNzBHWGYi6DojOxwHgo6YxWjPV3c7gSOo98
         UIdzWCeSYiKBA4DPfg0sfTIUx1okz+jL1pFytIEjlRVg+yMQe/UJI1uAYRrYpDYPLXSV
         9TPMbEbNho1E37yf+c2hYW8fJts7eAsW/1VAhStHjNoWC7Kb4n7Keq9L1oe/50gfXjaH
         0K3N1MasG92MVx8Hi9Du/E9o9wBSx16tXf6TwbzfsY06vIClwnFl6+xz9sH0A37hwxOi
         BqMCzan95iyblCokrawbqCC9VtGg6qJjPjY7LQuKWqrxytqcTdpO9RNgFkNiAI+lGwl8
         P5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702421731; x=1703026531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QrupQaeoS+38stqe0rx4IUeHo/JZH/ATfJZajGunkM=;
        b=IKl+FMOMtUY5lXpEJ/k7PXQ0piiWOlIBXmVUtNfDwEakH1qrNY1ITIUBS63o0p0LJ2
         FANOJRfJl1x5GX6D9hDgma3kt746iYmv9UfuuJVSXgf/r/LN56bEsehNqBlg85n0St09
         NeT1r7kkq8PIlmTDlv9mC8dPFMpSMWtJFoe0J8Y4GFToLJsLDCGuOqFLny8IEUdb6eW2
         Wb9YZks1t5EbVRSv0oEZHsbr6m0XcDg7CB96Uu+SuN5lMwQyQlBtXTouKtVpZ5GvCJmp
         SVeFZ0P8Pd9kzmGzJCAIqg6J8AXQYUfP9E7IhbP3OzBtdi6/14N1JWH8/mRNjjMNOKLU
         moTQ==
X-Gm-Message-State: AOJu0Ywd9j523uVjEOHsE9Nujj3HtBBbxsnCzagK4RnVrtgFVUGo1rQb
	Gtiq8FNsNcALvg2Bwq53F7AZLBgbwUa5/3PdUjk=
X-Google-Smtp-Source: AGHT+IFl7uVE8lfqRpvw/tVlmkOdwmiy5BKsVB9SxreXbHkbVDa3mjdqpYBW/MD5G7KzXwHuIkhSwJ+RbLDgkOazz7Q=
X-Received: by 2002:a5d:6310:0:b0:333:2fd2:8141 with SMTP id
 i16-20020a5d6310000000b003332fd28141mr4077635wru.94.1702421730563; Tue, 12
 Dec 2023 14:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge> <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge> <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
In-Reply-To: <157b01da2d46$b7453e20$25cfba60$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Dec 2023 14:55:19 -0800
Message-ID: <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: David Vernet <void@manifault.com>, bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:01=E2=80=AFPM <dthaler1968@googlemail.com> wrote:
>
> > > For example, let's take a look at #2 atomic...
> > > Should it include or exclude atomic_add insn ? It was added at the
> > > very beginning of BPF ISA and was used from day one.
> > > Without it it's impossible to count stats. The typical network or
> > > tracing use case needs to count events and one cannot do it without
> > > atomic increment. Eventually per-cpu maps were added as an alternativ=
e.
> > > I suspect any platform that supports #1 basic insn without atomic_add
> > > will not be practically useful.
> > > Should atomic_add be a part of "basic" then? But it's atomic.
> > > Then what about atomic_fetch_add insn? It's pretty close semantically=
.
> > > Part of atomic or part of basic?
> >
> > I think it's reasonable to expect that if you require an atomic add, th=
at you
> > may also require the other atomic instructions as well and that it woul=
d be
> > logical to group them together, yes. I believe that Netronome supports =
all of
> > the atomic instructions, as one example. If you're providing a BPF runt=
ime in
> > an environment where atomic adds are required, I think it stands to rea=
son
> > that you should probably support the other atomics as well, no?
>
> I agree.

Your logical reasoning is indeed correct and
I agree with it,
but reality is different :)

drivers/net/ethernet/netronome/nfp/bpf/jit.c:
static int mem_atomic8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *met=
a)
{
        if (meta->insn.imm !=3D BPF_ADD)
                return -EOPNOTSUPP;

        return mem_xadd(nfp_prog, meta, true);
}

It only supports atomic_add and no other atomics.

> > > Another example, #3 divide. bpf cpu=3Dv1 ISA only has unsigned div/mo=
d.
> > > Eventually we added a signed version. Integer division is one of the
> > > slowest operations in a HW. Different cpus have different flavors of
> > > them 64/32 64/64 32/32, etc. All with different quirks.
> > > cpu=3Dv1 had modulo insn because in tracing one often needs to do it =
to
> > > select a slot in a table, but in networking there is rarely a need.
> > > So bpf offload into netronome HW doesn't support it (iirc).
> >
> > Correct, my understanding is that BPF offload in netronome supports nei=
ther
> > division nor modulo.
>
> In my opinion, this is a valid technical reason to put them into a separa=
te
> conformance group, to allow hardware offload cards to support BPF without
> requiring division/modulo which they might not have space or other budget=
 for.

Also logically correct and I agree with, but reality proves all of us wrong=
.
netronome doesn't support modulo,
but it supports integer division when the verifier can determine
property of the constant.
BPF_ALU64 | BPF_DIV | BPF_K works for positive imm32,
but BPF_X works when the verifier is smart with plenty of quirks
and subtle conditions.
It works with the help of cool math reciprocal_value_adv()
in include/linux/reciprocal_div.h
which converts div to shifts and muls.

So should div_K and div_X be in separate groups ?
Should mod_[K|X] be there as well or not?

To determine the grouping should we use logic or reality?

I'm arguing that whatever clean and logical grouping we can come up with
it won't stand a test of real use.

