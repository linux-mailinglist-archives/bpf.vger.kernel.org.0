Return-Path: <bpf+bounces-21904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD4A853ED0
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00619286225
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E65627F7;
	Tue, 13 Feb 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS2r2aVh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD526215D
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863730; cv=none; b=VRteqK21vJ+DMmJU6bijrON7mI+awAvlLFf+ao+0my2R0WnxTJLSym2ccXI22rTMIefK08EeFiUXpFueVi9IjxGvc9IS+14sodvar3IBVneCFVUmYP+vlKZvXOsubfIJn9j2TtK6t+9UPJ6PuLHuTbv8zMLFrXRZsVUWrSCODEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863730; c=relaxed/simple;
	bh=yjNzhd9BjF/A7WT66iBo/o7puvx0LOZDmYl8Q58mrFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd/1kstoUD0BZfbDjx4G2C/fAc8p90Rb76okBl2PIM+Ta+Ftf8vWf+Z/ysE7eURvceAocYusIZYcZB/uuIfbjZt7VGOAcCZEv9LFyaq/gOODGke/UY2bdoboADyyWdDfWV2rqTU6Af6B3yht4lHjkmUw2mHFeael6182VmyLWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS2r2aVh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b2fba3176so2871462f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 14:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707863726; x=1708468526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjNzhd9BjF/A7WT66iBo/o7puvx0LOZDmYl8Q58mrFQ=;
        b=OS2r2aVhrNhw6o0qFa6Tg3wXIwwkTRJXke2z0vgAe2DRd11158GAfxFVZ6jgegy4DV
         i0tBkJtMKO8HVcN7wCjSGL68Ml+wIXiBiSZ6v3g0oZTzCdbPask8VuYBhimjwX4hz61c
         ZF15uBT8Gb22tLECVIKI+2s3P5y1J0ypdfsyAxVrlmXW2PjhD1/pIIvwfSOYFQaC1Xhq
         ltZtBS1S3mQrOx9reJmiR1yX+opCpKvaOK0teEKHL+EJJnGvvMRkxHUk0pe58hQok/1e
         rZA00wgzPMCysujBmxKDWyxD9OMij4tyidyxrHouLe2wVkmBbD9A1olVEfe9xTkWuxaY
         R9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863726; x=1708468526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjNzhd9BjF/A7WT66iBo/o7puvx0LOZDmYl8Q58mrFQ=;
        b=gLhzVgZP3nAh3QopVMVDKOZThx6u/ZcqNbCNiPwpaN/2ulReNocSEr3nFco5vI5O0d
         g/E2+RTP15l8m4WLqT9vYmdkjAIS+9BbTSfhyr1k6IJxYcXvxndbWqFpP2rnFL9mIxP4
         XATF6dOXmGyGImYSW1eRySPTHeghDJzhaUCsHR4yEDJ8QoRUKsPasiIHCiQY+idUrICN
         VLkXHI/l1v+CNRH7A/+TLazYyzyZ3loHtp5NhwHBbKILG1+87YMj/ix+1movmU/J6AVa
         21BY0Hy3V5+OIarkdpCNSRH1/h1OLXtV1fK3sRKXeAWpdc3vobTWsiCCQrEXgt3WBDZC
         3hQQ==
X-Gm-Message-State: AOJu0YxlsXPkBalT9/jT2u3g9SMmJo+7Z95iyGrZigavxdjZHpgrkBxI
	PcpdJxy2HmyV3x8/QhJs3xhTb7v3Nq1a7akG1Bn/PqwY3bUfs3ha+AR5Mx87LCQG5Eo0hzK3gF6
	pTxEQVfSioj93u2KWETypc+iAjbc=
X-Google-Smtp-Source: AGHT+IFOePiOZj5eAAYPwau50wg17njgKiZ7Ym7FPDIGrQZlNeg2NJ/2uAj/LMAGT8ZTKloQZnXFtpYqyH/2CyK5OfI=
X-Received: by 2002:a5d:50ce:0:b0:33b:66a0:4a85 with SMTP id
 f14-20020a5d50ce000000b0033b66a04a85mr424194wrt.64.1707863726493; Tue, 13 Feb
 2024 14:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-17-alexei.starovoitov@gmail.com> <CAP01T743Mzfi9+2yMjB5+m2jpBLvij_tLyLFptkOpCekUn=soA@mail.gmail.com>
In-Reply-To: <CAP01T743Mzfi9+2yMjB5+m2jpBLvij_tLyLFptkOpCekUn=soA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 14:35:15 -0800
Message-ID: <CAADnVQ+FMHN9oMd+Tvz_9wonW6JoGgPboLAJ6ysa+26jNK+Mpg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 16/20] bpf: Add helper macro bpf_arena_cast()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 12:54=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 9 Feb 2024 at 05:07, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce helper macro bpf_arena_cast() that emits:
> > rX =3D rX
> > instruction with off =3D BPF_ARENA_CAST_KERN or off =3D BPF_ARENA_CAST_=
USER
> > and encodes address_space into imm32.
> >
> > It's useful with older LLVM that doesn't emit this insn automatically.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> But could this simply be added to libbpf along with bpf_cast_user and
> bpf_cast_kern? I believe since LLVM and the verifier support the new
> cast instructions, they are unlikely to disappear any time soon. It
> would probably also make it easier to use elsewhere (e.g. sched-ext)
> without having to copy them.

This arena bpf_arena_cast() macro probably will be removed
once llvm 19 is released and we upgrade bpf CI to it.
It's here for selftests only.
It's quite tricky and fragile to use in practice.
Notice it does:
"r"(__var)
which is not quite correct,
since llvm won't recognize it as output that changes __var and
will use a copy of __var in a different register later.
But if the macro changes to "=3Dr" or "+r" then llvm allocates
a register and that screws up codegen even more.

The __var;}) also doesn't always work.
So this macro is not suited for all to use.

> I plan on doing the same eventually with assert macros too.

I think it's too early to move them.

