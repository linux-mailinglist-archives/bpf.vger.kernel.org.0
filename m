Return-Path: <bpf+bounces-75798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605AC960AB
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 08:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8B604E1996
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE82C033C;
	Mon,  1 Dec 2025 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="d+sms29G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1032BE62B
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575027; cv=none; b=lapac4ks3mJDORaTh9GnBulzG2zWKHBsW3HTeGePuBShrPQyuDuAS3BpaEWq+aIlVQ7+z5CQjatJGjOJ3/HKmJW8UZkauDQ5exAC8ptHO/iQ8SzzSwQu3RDcoshlZrT2p1xd0aJbGRgsYLBm2txQIfoyXLIM1SuRV4iJ1+zZJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575027; c=relaxed/simple;
	bh=qAl1/HmWCrv4uyJrWR8624bc2Ccvvv/e4QurPuHlPkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heNB2mU8AjNcGHU91tnaiLICmx/7/LQpJcI7hkmgYtr3dXmoaU4iLcQVo3ZmAZlpmcM6x9Gg/Aw3hXX3s2daC289+4C4yo5iICNYl2aGep7Eb/yzMnPTd5H/FL8hi6FacCFWrcB9yeU8ejscAWaCHdpR0ERD2kPKpFMthwfQfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=d+sms29G; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5957db5bdedso4361228e87.2
        for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1764575023; x=1765179823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHQ5c/jMP38KRsojqFT/8viuRxtIPmQ4i+S/ztKCzkE=;
        b=d+sms29GdiQwSTV+O8xGL1+G3YWULdlgT2PXIS/6ymA3BPIH0RYwqKi/tNDDgoqqUe
         jRarnlo/eV2wpnChgur+84oJh9LdYu1gte+zITmx057vn3g5KWPXgkW8+6uHCOOOeMU7
         1acXXpUCXm40EdzmPHH3SGjkOddJsbcCOXfQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764575023; x=1765179823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHQ5c/jMP38KRsojqFT/8viuRxtIPmQ4i+S/ztKCzkE=;
        b=uEotsu+PJ7J4vDDAv32F4lgDuGsoFoRyqtzh8Any0RwkbvI0gXdyP7XKztkKI3oTQU
         zLzf7JHQ98JAzL6wsn6DLHtocWOo5/LbDERIXFc93T7T2mnYPqed0dKRemB6l41I1ulw
         PdVUCbmFYc7YlZW0AtcDSg7wr7YRja8IXvTvhE44Y/VM3ktkPQ91GqPYbjL+FHSO2A8z
         kAumgwf1030kT2tlpRCH4XNRKbs2qmQx6HbM0XvITLoHChgtLNBt9xjSoRe9Fxg6uNeD
         oo7mRc7nPfEYQXCN7CjO7UKmnBzAA+Gb4cnC1EdC3YFcbOTL/ZNBpU+r6gd0IhZfjaEa
         Og6g==
X-Forwarded-Encrypted: i=1; AJvYcCW8s0Z8FIkbKhBvEox4sei5bNrfMsMvYLrQmP+AD2w4x56dW7BL8i9YAv9043xtcqoPAJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwiEe3yiGsUrR4bAsjR3zSODymUy4A2xQ53j0e7ROWjlBb5Mf
	8NQEENumGNRIAuBpUtMdJpHhL8xOEwdhpZVK7HMpAigKrk3ahW7P8p89iQTEm36eH3el+Vpi6Qt
	oi8JfoS0JCDos5ERUlABo4+EETW1q+SUmGYaWbMWFwA==
X-Gm-Gg: ASbGncvR10Q5xPmnWnno2FSG1V85KLUUeiI/oiBCduZNdIQT/c450rMNguBvLphKbp7
	Y1nY9mk2SX8/UYa1zceFPCUwn7x3qrsTRYDeyPmvyw04uTNk37YADA8douCg6+ugiPwY4EKeXnQ
	pB//dR2ZnVQ/k39JDPaK12lf2QBenr1QF69dGy2JMoj6BIduFspAwYJuaFxabiBMsTjoW5OZyD0
	XrEOMoQ/YmKlDuevagEfDFACpjSYwlr/MHXg4gGGKTwAaVTWryA8B9DNWc7fcf8qXvfTgSh
X-Google-Smtp-Source: AGHT+IHOUj6THnb/b20nei73ChGWwBOZ1rorbvhssYxPF1zxID1D1/GlQSgB8JugKt0/N1mf4bFLwuP/LIfdoRDiBjU=
X-Received: by 2002:a05:6512:3b29:b0:594:2e8a:1663 with SMTP id
 2adb3069b0e04-596a3eb26b7mr12475591e87.17.1764575023086; Sun, 30 Nov 2025
 23:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125125634.2671-2-dimitar.kanaliev@siteground.com>
 <b37af1dcde7b7efb4dfc0329ca3ea1c3f4ede7e9b8eb02a1eabd042d561f00fd@mail.kernel.org>
 <2fb2cuygiz5ljalrbpizk4njnj4dojx53c5fxy36ock5g5w3r7@7pigobi3ymw4>
In-Reply-To: <2fb2cuygiz5ljalrbpizk4njnj4dojx53c5fxy36ock5g5w3r7@7pigobi3ymw4>
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Date: Mon, 1 Dec 2025 09:43:32 +0200
X-Gm-Features: AWmQ_bmJWp71uAF_TFb4bnUjGuMqINvENWnnUCm_seNPjVxkXMc4XWTEbuCWjWk
Message-ID: <CAHx3w9J35G0bn-TyKEJ_u0A3NxupzvQZKmq_3JirwFdGk-P_tQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] bpf: Introduce tnum_scast as a tnum native sign
 extension helper
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 10:56=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Tue, Nov 25, 2025 at 01:22:13PM +0000, bot+bpf-ci@kernel.org wrote:
> > > diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> > > index c52b862da..ed18ee114 100644
> > > --- a/include/linux/tnum.h
> > > +++ b/include/linux/tnum.h
> > > @@ -63,6 +63,9 @@ struct tnum tnum_union(struct tnum t1, struct tnum =
t2);
> > >  /* Return @a with all but the lowest @size bytes cleared */
> > >  struct tnum tnum_cast(struct tnum a, u8 size);
> > >
> > > +/* Return @a sign-extended from @size bytes */
> > > +struct tnum tnum_scast(struct tnum a, u8 size);
> > > +
> > >  /* Returns true if @a is a known constant */
> > >  static inline bool tnum_is_const(struct tnum a)
> > >  {
> > > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > > index f8e70e9c3..eabcec2eb 100644
> > > --- a/kernel/bpf/tnum.c
> > > +++ b/kernel/bpf/tnum.c
> > > @@ -199,6 +199,19 @@ struct tnum tnum_cast(struct tnum a, u8 size)
> > >     return a;
> > >  }
> > >
> > > +struct tnum tnum_scast(struct tnum a, u8 size)
> > > +{
> > > +   u8 s =3D 64 - size * 8;
> > > +   u64 value, mask;
> > > +
> > > +   if (size >=3D 8)
> > > +           return a;
>
> The unsigned tnum_cast() doesn't have this check. I think we want to be
> consistent here, either check size in both or none of them.
>
> Given you next patch added the size check in coerce_reg_to_size_sx(), I
> suggest we simply drop this.
>
> > > +   value =3D ((s64)a.value << s) >> s;
> > > +   mask =3D ((s64)a.mask << s) >> s;
> >                                     ^^
> >
> > Can this invoke undefined behavior when size is 0? When size=3D=3D0,
> > s becomes 64, and shifting a 64-bit value by 64 bits is undefined
> > behavior according to the C standard. The guard only checks size >=3D 8=
,
> > allowing size=3D=3D0 to reach the shift operations.
> >
> > The similar function tnum_cast() handles size=3D=3D0 by producing a zer=
o
> > value (since (1ULL << 0) - 1 =3D=3D 0), which is well-defined. Should
> > tnum_scast() also handle size=3D=3D0 explicitly, perhaps by adding
> > "size =3D=3D 0 ||" to the guard condition?
>
> IIUC size should always be one of the values return from
> bpf_size_to_bytes() with either BPF_W, BPF_H, or BPF_B (guaranteed by
> bpf_opcode_in_insntable and check_mem_access), and thus can't be 0.

Ack, thanks. I'm leaning towards removing the size validation from both
tnum_scast and the coerce_{reg,subreg}_to_size_sx code since the latter is
guarded like you pointed out, and the check doesn't really exist in the
current implementation either.

