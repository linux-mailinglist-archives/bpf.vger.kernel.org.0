Return-Path: <bpf+bounces-78170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F40D8D00891
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 02:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB5EE301721D
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 01:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A691A01C6;
	Thu,  8 Jan 2026 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiFkRQVl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601061DFFD
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767834481; cv=none; b=gOpQsHysf3IoCrWz+3azoRmG65NqHiB/FZWobVaS6DXSCHismEB+qJoNtxSuy3serwepZBa6S1LAiEdhEqXOnirf9EMI0J5208X/fB4Oa2u4sFWHx9vGy7x9C7SOnE4RieECeTDcrz1mpvPvjg8FW/7QZ1uPV2OVCD9N3CcqMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767834481; c=relaxed/simple;
	bh=yM+hYYM9VGdNE9RWtbAcJ5t/rAGdGbBGHINu8BKLdZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cplFo5GaKlO7HEOY1QQhzlq7M1RcWXmsz/ABTze/XtiPfTNFWyjxILx02//QbfHDjQ+TaFB/n3npU40oGiXxB2+hbhjltaLGX/9iyOFR+q69OwtwWz2plNQu1c5nStMbxACBK7hXXpvFKWGD2j+H1uWzsnDVUvhI/gnAZ0947A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiFkRQVl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso10375535e9.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 17:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767834479; x=1768439279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WiTNbS4ADqeYeTKatUaRHUoXOYGS5H77qGbv1lRCpc=;
        b=kiFkRQVljzQM7YYtMNvLF0dh34Iz6ovostz/mQJHcN44PkKgp/mlKxOMXyUiTRdd+o
         spngvB9R4KJyaBrzhqQISr+UFaFyx2VYHz2HkmvhrGmJHCYK/c7YbFneHzfh6Rlfmego
         OY6yMSAOz9BPZFW+fdFgrmISRfgUQXTVC3q1Vj7wrgy/FCheLCF5XYIzU32yNO6yFu68
         di8/V6tEGNeHxhHTui4s0nNQ035oUdaooJeyc/3x0gCxBGuJ18w1l6djuM4fuZazmIyl
         +Qx+JgRAVVAtwH9rJj0j4U9gfxnNSQghJlps+JE0aBtDl/jBnQyA155NjlBFvTp2Ut4V
         Inxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767834479; x=1768439279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6WiTNbS4ADqeYeTKatUaRHUoXOYGS5H77qGbv1lRCpc=;
        b=Kv4Om2CeZ2Pungv4oUAjo412AvKZovE5Gr6fcoXailodUPUxOEOmzeV9gr0lTZKgnP
         iAnzy+JqTFDAptkYVwDSzGOo0rRR4PuJUiA/T/Hq+bJDKhYMYUeDKD1VnOGKDlMWOJdF
         /EMH8rAcQGWWLxcClFv4OceQuridqLvkY5VSoPCxavB7xwlhEfCpzGDLdHByqW1hkezk
         H2ZR6posI905y+D54/8+sPOwucUgBW5zquPjovTGufCqtCaf+TSnUThd3zaoG+SLhQNp
         dSEIgrrmww9ysoDEQH3EolO9d82Zjp/+70VO2VFHeQL5zVAY+duEgekREbMQ2dbHFZw/
         eUxg==
X-Forwarded-Encrypted: i=1; AJvYcCVNnj7BcavioMVKmKKmhvK6viubmput+geHcj7Qnai+nDoOsHp48aQ2TPYhHSmTK5zXggk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrPl4dBUABBePaJvmniZCQGXZ7RysWLQCsToa6gyyl6GcOrpV
	hdxIjdvr1sA+ylWZX9f3ifHu9meNTfGD0CsH3oOqy15iyTMM5qtMQcwAy/lPf3M6S+F8A6SZatI
	PXOuyntjAu0WIatB0ZB+eirPX9+19UEE=
X-Gm-Gg: AY/fxX4zRxjHBuWFrb4ZS/sPVGnTfjhTVjwMt/JaCwItR9d8XS53N0bo4JhADjFN2eH
	e82dMqWmY0f7bWZbYT2drmWd6bpeDwEo4m8m8hkIxe3RRUNW16TIS7XwSx3j0LdM+F4eCzQJCSE
	/8yTrUAVbQU93Ow4E0kgPjVt9zIPQRqHj9HOn+cO6p7JwJv6s9eqAj8WEUq6FAMiR+6sw6mipZ6
	s4/BhlQ534pjQ+6kKce4cR6gLiak6u3/pbEH9zV6/Y+OFMkJ6Ll7JccwKKgpfS3TqfMIrgVVLXY
	Z0PvFkecUU4SUvNrthgTu8k9vHnc
X-Google-Smtp-Source: AGHT+IHcE+O11eIkuB8Pq6b6GzzUvM1hbn8PKfSs4Xi2KgAXhz7WlRCt5JMPBi2f7MiAjvs2ZErgbrroW3qA4G8I/m4=
X-Received: by 2002:a05:600c:4449:b0:477:aed0:f401 with SMTP id
 5b1f17b1804b1-47d84b368f6mr51145025e9.23.1767834478570; Wed, 07 Jan 2026
 17:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103022310.935686-1-puranjay@kernel.org> <20260103022310.935686-2-puranjay@kernel.org>
 <39509bf2976a9812e89e5d1259fcaf1692b97fe3.camel@gmail.com>
In-Reply-To: <39509bf2976a9812e89e5d1259fcaf1692b97fe3.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jan 2026 17:07:45 -0800
X-Gm-Features: AQt7F2pL71GZIr9DC-FYsL2Hc7Vkm-tA7RZIz8osFHpl6ZgeOmkdW3EZE9DaWQA
Message-ID: <CAADnVQJitkFOZO3dmdZWuzfYgixqi_=P3qZZBoLPR9KxWiph_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 5:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> > +
> > +     if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D 0=
)
> > +             alu32 =3D false;
> > +     else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_val=
ue =3D=3D 0)
> > +             alu32 =3D true;
> > +     else
>
> If we rely on specific dst_reg range, do we need to mark it as precise?

I don't think so. We're not relying on the specific range.
Just like plain AND&5 would convert [0,10] range into 5.
It won't be marking it precise until there is a need to treat it as precise
somewhere down the verification path.

