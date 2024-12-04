Return-Path: <bpf+bounces-46111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A06569E464E
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D054B37088
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6177718E743;
	Wed,  4 Dec 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFC1Vo5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36C18DF73
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344847; cv=none; b=ORt6hcplVKz4BlLA1PA0RqC5MOxiBQipWzWXSZmDqy5LXKZyw8PGnK1IizvudBNTjDfbjNrv/xKXNRMnH7zpAAvboRgIEM53eTPnWFh4dugu0kb2RFG+h2Xa7CT37u13owRpnlHnCHPvUBw6/+SnbN/WqqxFfnu3OsBYm+Ctrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344847; c=relaxed/simple;
	bh=fG8pKOQtdQunXVA4882q7qxtmYTk26d3pVMwS3ofGfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYHlGegGJez5EHSUkIEAD3NSXlY/4O/STtbzLD7lHSIdG50ZAwKvgIxJOaooATunXI1o/atHGpCqrqIek6A0hOSFhod72hxQgNfWcSxMIrldJ6pVtEc8yxprxRQPixyk+E4rK0WchwnrFR0IsBRBK/lQVGhhilI4lb1k1GFyCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFC1Vo5m; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e3621518so164862f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 12:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733344844; x=1733949644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQDOO2VeDqhzzwgKknvf4I53OwtqG998Fp54DmiIA7I=;
        b=JFC1Vo5mbHODUyVQ9lcCgI+KL++yVThdmmuTRD8qLKnpIQWByLEdsoAUppS5LwbwhL
         siR8vsoPl3IY+ViJAY5TgDdrTXZjlbhqk0BcHXRvMmLPa23lSJPsjl7XDaS/u8WubsFs
         XIQ6Z6i8o+jUOEiaHTJHjT6bzkK+eunKj1Bhor8AF4L7pBqGZ2a+1C051aQlXLS6PbIN
         0EyRd0f56If5n09+KqZC+jzZGya8ZmJMhJB4RVU802kDCoveHPzm0Wvp8EU8tSdHHH6i
         NWO21m4W0AE7mkMwEcrCj1Jjp4ZD7qkcu8yrYobQRT+w49t23zoEP4PV3RPEPfsYj95b
         eUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344844; x=1733949644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQDOO2VeDqhzzwgKknvf4I53OwtqG998Fp54DmiIA7I=;
        b=u0E122DRIwTtVvRpZJXhCiwKApaXrW16IlL6Ql4QK2a7xSRvUfpwOmWS6pVkR0cAoP
         CYK0XKfkccZDVKFJ7yrhvSCk5dzga1cL6xNz9cVgm+lJ088xWpF4EpxwZjBY+GCJ5GBu
         AQFlQNJI2I+8VFwBDlo/HmgBy02UuuQjNZGKPOmg62Z0wvL3c75w9fFIrbOaxZeqLPf+
         l3/NVbENzPUIcvJhM2J7L0DVEBdTGkekLvTXWnw3clnjHwAvUogLlqQHC7d9K/DC+s25
         KvJvUlEAW8dAQjD8QBTVewqxq0b908r+9VN3m4aMJog5cSh87nKEmeM/4TTLeJpNAWpG
         e0pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpRT31W+vsanJo/dqbllmDsd8yLRn5HvaHLwIW856qrRbbn5JmB1t3AwMJdsPw7Gg6YFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSVBkUlGQv3sFf2vQ5QaD1N7x245O/L73Yf/uXguFnqYtW2R8
	SdKofOSfcBfxOD5qR/pDWBrX1N74WCh/3xjEzlr5iAfqEuNiI4K+dcUTszySgeuzgHTIAtQLsos
	nhmc/IEG5ZD2kemxR+gJlQRzXvkM=
X-Gm-Gg: ASbGncswM+Sw6a0L3Z5P5jvG/Qmd0COc1Av6dVxSgkZ9OJ4p36gRCjA65FopFvISYgX
	i7qBfcV9+U8KmeFZ8GtW30Mdp7pfoE0JESQ==
X-Google-Smtp-Source: AGHT+IEGO6c8cUpCO59Gk+mSN+pc2lMI/fE0X+tTNa/URtnn4Ex457De8qIQYuGY5pmoSp0bS8jizT7RA8HR93nC8F8=
X-Received: by 2002:a05:6000:381:b0:385:f677:859b with SMTP id
 ffacd0b85a97d-385fd3f23b8mr6090714f8f.10.1733344844335; Wed, 04 Dec 2024
 12:40:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204024154.21386-1-memxor@gmail.com> <20241204024154.21386-3-memxor@gmail.com>
 <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
 <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com> <CAP01T770rUveB4Toj_gU7Fy-SyyTr0EvaCBDTxdkGBz2bBBAzw@mail.gmail.com>
In-Reply-To: <CAP01T770rUveB4Toj_gU7Fy-SyyTr0EvaCBDTxdkGBz2bBBAzw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Dec 2024 12:40:33 -0800
Message-ID: <CAADnVQLa7ArR0ZSi_zERZxWCCvi6u6TdmOpfkveuRo_EwGqsQA@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Manu Bretelle <chantra@meta.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:22=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 4 Dec 2024 at 21:19, Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
> >
> > On Wed, 4 Dec 2024 at 21:12, Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> > >
> > > On Tue, 2024-12-03 at 18:41 -0800, Kumar Kartikeya Dwivedi wrote:
> > >
> > > [...]
> > >
> > > > +/* r2 with offset is checked, which marks r1 with off=3D0 as non-N=
ULL */
> > > > +SEC("tp_btf/bpf_testmod_test_raw_tp_null")
> > > > +__failure
> > > > +__msg("3: (07) r2 +=3D 8                       ; R2_w=3Dtrusted_pt=
r_or_null_sk_buff(id=3D1,off=3D8)")
> > > > +__msg("4: (15) if r2 =3D=3D 0x0 goto pc+2        ; R2_w=3Dtrusted_=
ptr_or_null_sk_buff(id=3D2,off=3D8)")
> > > > +__msg("5: (bf) r1 =3D r1                       ; R1_w=3Dtrusted_pt=
r_sk_buff()")
> > >
> > > This looks like a bug.
> > > 'r1 !=3D 0' does not follow from 'r2 =3D=3D r1 + 8 and r2 !=3D 0'.
> > >
> >
> > Hmm, yes, it's broken.
> > I am realizing where we do it now will walk r1 first and we'll not see
> > r2 off !=3D 0 until after we mark it already.
> > I guess we need to do the check sooner outside this function in
> > mark_ptr_or_null_regs.
> > There we have the register being operated on, so if off !=3D 0 we don't
> > walk all regs in state.
>
> What this will do in both cases::
> First, avoid walking states when off !=3D 0, and reset id.
> If off =3D=3D 0, go inside mark_ptr_or_null_reg and walk all regs, and
> remove marks for those with off !=3D 0.

That's getting intrusive.
How about we reset id=3D0 in adjust_ptr_min_max_vals()
right after we suppressed "null-check it first" message for raw_tp-s.

That will address the issue as well, right?

