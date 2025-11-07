Return-Path: <bpf+bounces-73979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18681C4160A
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 20:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 554D24E6AA9
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A1A25A2B2;
	Fri,  7 Nov 2025 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPzEBZAc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845C238178
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542117; cv=none; b=L6T86CTN57UBy2mtY8NAGNjJwcxarnzB+IMveoBRBV8/cCQIfj4P7OuFUhQQBYqyn0lKyKONhP+7ht6Y7iPzid40KkBYI0T1vbjxfp/Fb3xDXOdceYrOvArKsIZVWDeKn9Cxct3OvuJN8y9Pe5mMK/KD3djwE8od1KK9KL+EYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542117; c=relaxed/simple;
	bh=3UEsLXz42p5VYvphPtcGmcpAmWx2sXLq3igNjcYIM30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVNdGR+6Z9kIsVEOTCSLP2XRooxIynsCpvqnnZh/ZmC8xw+wH051IPIISb5LMAEg8V8pIB/vM/otkie/WGVqyAkIvrKgg9dXWxAKF7J9iPskIy/Pml1u5PWVjVIuiTiZrh/n5uxQiN/p81tzz/PGSUHLaN21Cxhhs0xF3IYODpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPzEBZAc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64034284521so1839202a12.1
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762542114; x=1763146914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJVrVAk2TgA324H1MpYTwNs3mN4/yel0i6B4XK2Zvcc=;
        b=LPzEBZAcI63FZpGO6CanNBpMaz1VQhbJs0dNejN5Bkgip8Mzv3BBp1Myqnk65rEHdj
         sOcxGNw3PzxPTX3a+kFD084fqD1X8wvSUsz053AbAl9uKEvwpmOOihyEQzITQNVC3JWK
         PubIShXqP1pbRF9NRJ+b6Vhu4qLI85g0Uz4mKuReVoDekZF9i7Qn1c0HHddQmaViSINp
         KrjrrOpYWrIa1alUzfnym2sP8xG6ciI4nzpVQfeCN2nM814dI4+PyFuJLok1g+hyQcV1
         2rn638SoPFejCfnOI9x7g3/ufjxyO4Gye9+15T8ggAceyK32Gbjhp7WkjCaZ0jnP9b3Z
         dy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542114; x=1763146914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJVrVAk2TgA324H1MpYTwNs3mN4/yel0i6B4XK2Zvcc=;
        b=aTj2gQe8rvMZMxPorTKhCZV8yDsJPkXYGImW2Z40YvA6m3ewXJlAFMjr8WGGW0I/pZ
         MalT7krk2UW8cWBIMm6mKkbhqA4/FKhAD543XTxkUXAjdRP0dcYxps5XUQA/U9kWQm8G
         d3+qbxWvpG9Ux32vS7N4XtYs1QJixHh6j9X0gbf5RAbB+WY7j2zVhIqWVV41mACB4JNv
         ecKikxKS9vbyOvP17+OG5Ku03Ct/aBmQktGSxYNLB+wuUdpjFdhzLG6P3T4gjbt+YrIx
         /Gu1wFc3cRp5SY5a0E2vOPrm/aIagl9n9Xe0Oiy3BJPpE91kXxoPvJECsfpmFoVD+Lsq
         3Owg==
X-Forwarded-Encrypted: i=1; AJvYcCX+hkGsJx6l0PLPLhqozbHHbVZkhO5naaXe/GJ413b2qox60bwWnW8z5nbAO5UBQU9flmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7k+u70dBJrN2z1TR1DpSQvZaeuChp63cryn15TWsvWFql9Srp
	3fO1yMFVLts+YARKu0dcLkyiGs4BoTznWpexdk06Oo2fyLsptzFqMVl96gdnpU7wuxA1rrjYdFZ
	I1U0Rjf0IHTQaYQ8DHFzwD/GTE8f4IX8=
X-Gm-Gg: ASbGncuQ1a33c1ZN0uJHz8To+MYGkK9n0XYZH7NdOqlRa3Jw7G6HpPcYybzTyTo+mjK
	0wI2axCfVXTLT5N6zv88hUV/YGta1TrF+/GpoiVZuagxKOrBhJl5+cfcp2NSL3KPT4TelCGlYAJ
	k6imiBKzk3OEAcURV9wIcldRJOUFZXv3YLroHXnvXJiBk3TzaruPZZB19QsapOlcaNeeI5imtuh
	qil3CeCRXTZjJxGMxDd5Vu3sM1FoynHfQbPdA/KEXsnSqOwAfA3jVSCeOrp6VX5j8TWGbIG3jyG
	iARsmg04+d6XrOCnVoG8flIK0Hx5
X-Google-Smtp-Source: AGHT+IF7dq1hPfdyIJA5UzFH4+spgH6fajLAhisNInsc6hlrf0h6+FGpZpH4bHnV0wqnVESL0TVGtLLtE+7Mijxjp9M=
X-Received: by 2002:a17:907:3e12:b0:b3c:bd91:28a4 with SMTP id
 a640c23a62f3a-b72e031c6a7mr36894966b.28.1762542113615; Fri, 07 Nov 2025
 11:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
 <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
 <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com> <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
In-Reply-To: <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Nov 2025 11:01:41 -0800
X-Gm-Features: AWmQ_bmT3MVaf-ueo8Pl4FvQPz-FBP_Cv3IYAyt6Hf9mfm1PZnZzLEoX2Fni7FY
Message-ID: <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, bot+bpf-ci@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, zhangxiaoqin@xiaomi.com, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 10:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-11-07 at 10:54 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > > > > > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct
> > > > > > btf
> > > > > > *btf, const char *name, u8 kind)
> > > > > >                       goto out;
> > > > > >       }
> > > > > >
> > > > > > -     if (btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK) {
> > > > > > +     if (btf_check_sorted((struct btf *)btf)) {
> > > > >                                   ^
> > > > >
> > > > > The const cast here enables the concurrent writes discussed
> > > > > above.
> > > > > Is
> > > > > there a reason to mark the btf parameter as const if we're
> > > > > modifying it?
> > > >
> > > > Hi team, is casting away const an acceptable approach for our
> > > > codebase?
> > >
> > > Casting away const is undefined behaviour, e.g. see paragraph
> > > 6.7.3.6
> > > N1570 ISO/IEC 9899:201x Programming languages =E2=80=94 C.
> > >
> > > Both of the problems above can be avoided if kernel will do sorted
> > > check non-lazily. But Andrii and Alexei seem to like that property.
> >
> > Ihor is going to move BTF manipulations into resolve_btfid.
> > Sorting of BTF should be in resolve_btfid as well.
> > This way the build process will guarantee that BTF is sorted
> > to the kernel liking. So the kernel doesn't even need to check
> > that BTF is sorted.
>
> This would be great.
> Does this imply that module BTFs are sorted too?

Yes. The module build is supposed to use the kernel build tree where
kernel BTF expectations will match resolve_btfid actions.
Just like compiler and config flags should be the same.

