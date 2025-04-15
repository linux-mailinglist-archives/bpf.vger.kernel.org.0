Return-Path: <bpf+bounces-55912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C47A89054
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549513A692B
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB824C98;
	Tue, 15 Apr 2025 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCroCMtR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB61361
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675829; cv=none; b=berZ50yoGmrD7W+1riXH+w2VF1YeEK1BCY7h5mcui9fRkX+4UvChBBaEa8tIEjComYa1VLeoq9NA++PjfFT7RomK6+kDSHw6VmtS85vJEnq58g9gqZphRfdArikeOZFi7V2BKs9RJNDfeVG2ew3jPYILb+5E1Rjj/ojkaBonTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675829; c=relaxed/simple;
	bh=UxLRVc9zN7Y/2tJoFnS+SK2OL9zNZM5qBOiucVYDMuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvM+5OUobThfSkWXWZIe2KQ3/BtLXT0w3SGpNyLUsflVa53oHeMEGrAMQzafOsoVOfN8Gu4JpSSyE7CCM6tj0UlxdvgBZDMmK/7/2CF68ELgMTjpKtwOe4Xc8/zWimYcEH3dCXdAOcQ8dF+JUZ5KzqhnHsWpDLDW+QuJ8nZumvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCroCMtR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso2780647f8f.2
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 17:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744675826; x=1745280626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGu8L2jYPlM4+AF2ODgXzf7FwJ9HNL/XiopjCiASKuA=;
        b=aCroCMtRyRMjPSEg/DW6kCMhgaHT3Bav3PMCqHc1GT/ZsbT1QggsjJjxyk+em9NJFh
         sszzUZaoqmmmI5zG/Auxgyz1t8ThF80u+l2B4cJMXczE9aVK/EymxZZ9QPIuFPadkbe1
         dc85ALuGPNt+WIhXu8eszy4MobAYf7hCBUr5ZnnH6g1RaaXp4B/mbN/gF4HSHPOCd+Fn
         AUTyJSk1bWvR59o0vMzwa+cho9koP1XjEH88aaJqfjGsRmkGgP5F34XDgpe0uIjm03C/
         W+TCMNPxo1MRFsdcFq6LCb9eUba0LkUBj15CY+gKg0OHTjVpROCVi4AKkxLecvZLougL
         UAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675826; x=1745280626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGu8L2jYPlM4+AF2ODgXzf7FwJ9HNL/XiopjCiASKuA=;
        b=iBS0POZPuHpPUhA1pmOOF2dzTTDIho212HjRrSiOWfZ2YKzDA8qovAxcbkRI6aS28j
         eh5wcpjW/sSLN5/gchfuqbC14puGbrgQMPa55KgQkgQIPnFtkTUN7yMLLAw2kVibOIov
         /dBpIM5qn+XuNZr8kjK2L6scMJRQW8HBGvVdxfuDba2KeUMCaFehJaDxIeOjZNfVnbJS
         5EyEzkJkVpKIglLcfWYXxSx5VHijAsyncPmuw2vftVWeoq15lgTqBa2AcFklZEcJAIO7
         kTLPf4WGIaeGhujtV8SVz52yNM6DXZRWBp4I/c1uMbNQoUk7KPCiFzkkffyOXAzsIjrF
         RPWg==
X-Forwarded-Encrypted: i=1; AJvYcCV5xGxeCCmWf5b5gdxsbKYX4EqC1xpkiUTfp5oXsp6t6WO4eB+FbIFWzW4s8IYL/uv145E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7obiiNBYphUhqdoMUgHYbpSKbje+a7/eTWnO6dtspN0qHxxs
	CqeFxH/D/dymKstxRldvmSqMGftQ5egK2lq7/zkzXK9s2tscemUJAq033YGtjw9FdKSIFfCxlAk
	NJ3+F5v12FlLcYPAnIB2NqHjytnQ=
X-Gm-Gg: ASbGncu7EihuuYDvdkGkr0x91GE0kx85NAZDxpfAltyhwUopvLYDyopaBWzAMpjncvf
	aRQ9vTf65Kpf+2bs6NBNgj+KEgHB+R7xQ2jtLCREbbo8FO2pNeg9W/FA22InEn/KE+eG2CNMB5r
	ONBP6si21KChpAG2UMUexCBxBfUDIWDC8zDjV0zkhUMDviYkgL
X-Google-Smtp-Source: AGHT+IFX6RYJPH7c+B6PUPKcXWxTwGbrREW1Qj2Vy/QMXVtArM3XhQpAEJf1qVcqWvQp67XNq/C+2vOlmt7vJUyJ+fY=
X-Received: by 2002:a05:6000:2906:b0:399:71d4:a9 with SMTP id
 ffacd0b85a97d-39eaaed5709mr11320694f8f.52.1744675825568; Mon, 14 Apr 2025
 17:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJ6NKjhWbr=ya4=R7HaWyyiFneLLisByW3JopfQQYLrpg@mail.gmail.com>
 <20250414234924.86039-1-kuniyu@amazon.com>
In-Reply-To: <20250414234924.86039-1-kuniyu@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Apr 2025 17:10:14 -0700
X-Gm-Features: ATxdqUF0T5Iq62_rLouH9UoDA_YlNIO0N6VRHfUmR_IvXpdPVvsi851rf_QbFgw
Message-ID: <CAADnVQK7i3usoOn_yTgtDiApW29U=OLbRnaN0Sa517h5U0uUcw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 2/2] bpf: Set -ENOMEM to err in bpf_int_jit_compile().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Vasily Gorbik <gor@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Shahab Vahedi <list+bpf@vahedi.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Paul Burton <paulburton@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, syzkaller <syzkaller@googlegroups.com>, 
	Wang YanQing <udknight@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Date: Mon, 14 Apr 2025 15:32:21 -0700
> [...]
> > >  bpf_int_jit_compile+0x1292/0x18b0
> > >  bpf_prog_select_runtime+0x439/0x780
> > >
> > > Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to ena=
ble jits")
> >
> > The Fixes tag looks wrong and I suspect you root caused it incorrectly
>
> I chose this one as it added WARN_ON_ONCE(), but if we
> go back to the first invocation of bpf_int_jit_compile(),
> the tag will be
>
> Fixes: 8f577cadf718 ("seccomp: JIT compile seccomp filter")
> Fixes: 622582786c9e ("net: filter: x86: internal BPF JIT")

That would be wrong as well. There are no issues in the above two commits.

Let's keep Fixes: fa9dd599b4da
though it's not accurate, no one will be backporting that far anyway.

> ?
>
> FWIW, syzkaller reported the same splat in the seccomp path too.
>
>
> > and the "fix" adds a ton of churn for no good reason.
> >
> > If CONFIG_BPF_JIT_ALWAYS_ON=3Dy and JIT fails for whatever reason
> > the following should have executed:
> >                 fp =3D bpf_int_jit_compile(fp);
> >                 bpf_prog_jit_attempt_done(fp);
> >                 if (!fp->jited && jit_needed) {
> >                         *err =3D -ENOTSUPP;
> >                         return fp;
> >                 }
> >
> > so the prog won't load and won't execute.
> >
> > jit_needed will be false if CONFIG_BPF_JIT_ALWAYS_ON=3Dn
> > and if fp->jit_requested =3D=3D true then ret0_warn may indeed stay.
> >
> > Then the fix is probably just this hunk:
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf50..662c1bd9937f 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2493,7 +2493,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct
> > bpf_prog *fp, int *err)
> >
> >                 fp =3D bpf_int_jit_compile(fp);
> >                 bpf_prog_jit_attempt_done(fp);
> > -               if (!fp->jited && jit_needed) {
> > +               if (!fp->jited && (fp->jit_requested || jit_needed)) {
> >
> > or maybe this instead:
> > -       bool jit_needed =3D false;
> > +       bool jit_needed =3D fp->jit_requested;
>
> This looks much cleaner, will use this in v2.
>
> Thanks!

