Return-Path: <bpf+bounces-76910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35487CC96D0
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 20:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2B6301EC49
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71622ED853;
	Wed, 17 Dec 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxZ1D38o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A448186E40
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000152; cv=none; b=OoCogjxMis7acIzkqaP4DVH0yXk8nQSV91RlrTJGGVyPWJVfhcNGYj6MxPbkoj3JKFyyW4yj+7o6HSzaqFReymio+1SKiAn7romDwudp/R2CENNm+JFSvuDkK9kYJynXMwsXQvFuBUN9IF4ROGzU59w9UhaTDLE23pGoKSY4/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000152; c=relaxed/simple;
	bh=UoeXfx8EG7vyi2BOz3f7XsIoyaooHYovfybXMPLb0fI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MsAecFVtRehUH1yNn+0bVaIGlDVOxc3Xh1JR9yaG0+xjh2CZryoMKY0VcPN4Uj2PrABLEbEmd9LNDCLy8Xe3FTSgHk6kdA2hnt6XdpKTz0cVG0JOUjObcfCKjmW3bKcDEwPyoIkr+baQmeBeSbtlbt5LOdH1S0lk3o+qS4wKp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxZ1D38o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso6669646b3a.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766000150; x=1766604950; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UoeXfx8EG7vyi2BOz3f7XsIoyaooHYovfybXMPLb0fI=;
        b=YxZ1D38oxnh/u5ur65CAW6nQui1pl41PtgaOhUQrUDnavgfR3fXuG/V8pKMvJ7zd/2
         t5P+miMoxg2jmBwQidN3YOTbNTx/3Ugdx6T9KKG/inOrTsGg///NjXVU9ArEGmYuCiAJ
         Vzqkc8c6EKBqcCkgu8blu4FSE0couwca2w0Q9SR98zh5ErCiAuSobwAS47IGjR6nlhEk
         JZuEEhOjE0hsgZgrLZW/EVxXEnFGXwS5cuIcxxOE/OmrVvTSmZ24Qd1kiFERe03iY56E
         Cjlzobr+LOryhGvePPvPClI3bismI8vWm2ZgJfg8grKoAKejaReJ7vAC1e3VCh/XUJHz
         4bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766000150; x=1766604950;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoeXfx8EG7vyi2BOz3f7XsIoyaooHYovfybXMPLb0fI=;
        b=fF3w+P+Hw+a64EWSrXoOk4zhU0Uo8oA9mn2F7WEz+d8jgHVdcPSNnDbODA75a8MEfz
         lRUD2SyU0Yj3Nq/304a5CvPdp4YOW3qY9M/H7BDr69XW8qS308Zsaavq02pI4avLA6mf
         QaFsTypusIfoB2KkeUOj9LikoRLn3vbWYiNCVD6UKXS1/1+om6LIO9EzEalMhhErGeGB
         0RRjKlcIrYDumsTrvKSZ3pNGUM8a0FWIVxCCg9/EzQTXw60eXiCpHwYVCJ1oUDyxg673
         rxx32uqHtDzRZmpP/LOurVYQpkL5eqKbQ21u5jwZdrhYtTwEG0ycWlzvlU/mSXCWj0KP
         G94A==
X-Forwarded-Encrypted: i=1; AJvYcCXsRBxXpj96K8gftWl1pjZSSnO55PoHfHs68qSVUp6I02x0bj9ct4SCGSu9Ue45Edh47Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHfxYEIAuehv2pF77fZhz9m34xz3sOfHQIEvmBM/nGev7QLGBx
	rnsfm0WabqLH6QLHO5A2mXK0DgS7AR3XC2tiAxRNI+DG7Gz+8y95KgHK
X-Gm-Gg: AY/fxX7jKt8g/X2qXgyniNyXjffxA3pQKMFgiGe5aoYuv3PxIaLfVTJTr/TpNOaJWbl
	qV177H0gLBF8JaXM3TGs9yYDakFMYDAZ4aGJGly1DHrDMwtEkPr9uWa9CvAZQcoZ2RUIBT4s4nC
	x9Vu3WBlO9+amMiYDFpR58SELSWzaoS9lqFbMsnUj5nb862GZ3KRdD4mbmDuP9M/4Vzpz5ShiR9
	rXkaASlujUPbbWc0oildH8MEuqUYe1VmcVnz62yeHFkbzMc21SFJpEbP0MYRDTReChAg6P4m1M6
	8Bx5/tCGnOi3PAUHvFDdfv0mN8LU9E4Sf+uwMymV53xylBIIbMIaSvt+zJnZVBS3FjnWAEdYHg1
	huVPFKZn7s0xM4GUJwBKuNBwjcRpLudHsbe1C1aKOhJuMvrv+gSmZsi/l10F/luvsf2jZkAY4hP
	9hItL457zKv1FmGxC/oqSlMz4XUJ9o7jbXpGCNRtuMT9TIX+g=
X-Google-Smtp-Source: AGHT+IG8iik5PnYG7XLtaYqGEcj0BxlMsUbN/BZkk4zxGPnA9iT7j3dg4UsjgNFRsIhfwgQLg6oheA==
X-Received: by 2002:a05:6a00:1d0a:b0:7bf:5011:d1e0 with SMTP id d2e1a72fcca58-7f667445ce2mr17078384b3a.2.1766000150216;
        Wed, 17 Dec 2025 11:35:50 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:9f95:2f12:bb69:e3e6? ([2620:10d:c090:500::7:a4ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe14761014sm234904b3a.62.2025.12.17.11.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:35:49 -0800 (PST)
Message-ID: <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize
 nested structs for BTF dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Quentin Monnet
 <qmo@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf	
 <bpf@vger.kernel.org>
Date: Wed, 17 Dec 2025 11:35:48 -0800
In-Reply-To: <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
		 <20251216171854.2291424-2-alan.maguire@oracle.com>
		 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
		 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
		 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
		 <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
		 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
		 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
		 <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
		 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com>
	 <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 11:34 -0800, Eduard Zingerman wrote:
> On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:
>=20
> [...]
>=20
> > So maybe the best we can do here is something like the following at the=
 top
> > of vmlinux.h:
> >=20
> > #ifndef BPF_USE_MS_EXTENSIONS
> > #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIONS)
> > #define BPF_USE_MS_EXTENSIONS
> > #endif
> > #endif
> >=20
> > ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
> >=20
> > That will work on clang and perhaps at some point work on gcc, but also
> > gives the user the option to supply a macro to force use in cases where
> > there is no detection available.
>=20
> Are we sure we need such flexibility?
> Maybe just stick with current implementation and unroll the structures
> unconditionally?

I mean, the point of the extension is to make the code smaller.
But here we are expanding it instead, so why bother?

