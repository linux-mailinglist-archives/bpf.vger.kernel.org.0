Return-Path: <bpf+bounces-22613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85059861C97
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 20:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A341F25632
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D91448C6;
	Fri, 23 Feb 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jFRTxzxT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jFRTxzxT"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F82145332
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716846; cv=none; b=ZrUWi1NXzDBTODPCKrqPJGOQ6O9pEbx1xrt/97JazX1vHvDeO+wbi3hL0KHXyeVEC4WrozHtotNzvqv4upH/XQUKQGsXwcsdU+Ydx2+7J3x6TI8hKG18ELMu2x0qT2SQM3lUf7c2EQyN7ZPrjzc0OJlVkQi3XLxupY90jF4yarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716846; c=relaxed/simple;
	bh=ozctmQaVcnjJ/2I8I7yStTF+rWC5e6g/iWvkdX+cvvk=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=R2Em1W07oyHrHnJSSn3V5BbXpiifM+vWORV//6okWx0b/YFqlw3inhvuQQBOmUc7+YWAoFuCawDWo5FpnT6NpBu1rMgMjtKY9jstRiPxYxhGykXnyJXaNm6O85TY/ZXJKUTpITHQfsG7vx//ubNpHOcCNkbhuI96x8dHiuuVRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jFRTxzxT; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jFRTxzxT; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 61BC6C14F6B0
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708716838; bh=ozctmQaVcnjJ/2I8I7yStTF+rWC5e6g/iWvkdX+cvvk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=jFRTxzxT+sSKDd2P7v7S3VAM/duL1Dq4Fvh7Kv3vdizESeWprc2ExklEVYIW51NCT
	 nGdig0uKSLRWMAES0esw3m1M9Mtmqgu1C65q6Xo3gwaGpljF0W2ahZfNSG4ZCa4hcD
	 P4PbTMqoTk4hxzuIpWOEX2dgctHuxs/+q7Buk250=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Feb 23 11:33:58 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2D452C14F5FD;
	Fri, 23 Feb 2024 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708716838; bh=ozctmQaVcnjJ/2I8I7yStTF+rWC5e6g/iWvkdX+cvvk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=jFRTxzxT+sSKDd2P7v7S3VAM/duL1Dq4Fvh7Kv3vdizESeWprc2ExklEVYIW51NCT
	 nGdig0uKSLRWMAES0esw3m1M9Mtmqgu1C65q6Xo3gwaGpljF0W2ahZfNSG4ZCa4hcD
	 P4PbTMqoTk4hxzuIpWOEX2dgctHuxs/+q7Buk250=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id EBA95C14F5FD
 for <bpf@ietfa.amsl.com>; Fri, 23 Feb 2024 11:33:56 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BfReCsN0Xe-o for <bpf@ietfa.amsl.com>;
 Fri, 23 Feb 2024 11:33:56 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4E3EAC14F5F7
 for <bpf@ietf.org>; Fri, 23 Feb 2024 11:33:51 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id
 3f1490d57ef6-dcdb210cb6aso1361418276.2
 for <bpf@ietf.org>; Fri, 23 Feb 2024 11:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708716830; x=1709321630;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkwMxyU0Q46C/t8rQZ8Xx5eJVTBpDa+VcrdWSFgt2B0=;
 b=D7bwKe/QcUgLFovthy4RiOBkzpp3h7CZwr+UGhtrMoDB9ro+0x7GmAZwurxC9jkAkH
 w1raJrad2d6vH/VjWI6H4IemhBh+uCc4QQTNIFSocPeDdrPAgSFIMP6i7qDbExIwjCpm
 jmJ8K3sp32ahVVDvEHKuKHHmFweduHHxf4yTzVFKWYwdUIboz47x6hISYl6MfrFd34B5
 gIsoBzHRtEb6S7MXxG0TasrfNgnX6bIn/s9xAPdKVk+u+dh7R/hjbWe8IaBE8in6lM3+
 e56h+q0sIUENs4fuuEXLR8FjxN/bOa+b92cpwUJm1KBbUfQbkkzwljsSnHP5Z48YP+3y
 KmOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQJ98Zsie4SzTuuakfR8jmSSyP8n/F6r6r/jKLvfRTh7OzpWV7LmVG9TFpn3r56//L4m+t0PubQ0+1mFs=
X-Gm-Message-State: AOJu0Yz4W7n5A19wxYl5UJ/yD0GFHqNCtmW5z30VWIYgYL+1hnOjLhBV
 rf6wDDh8j9+e1+R2HtKI8/bnmtqh608TxG+XJIbWiYoslnLDWi+o912ss/YC
X-Google-Smtp-Source: AGHT+IGccsgslU+g7fG8RH5vESyaHGN3kG/kY82DvxdiXHadySf0pGOPfauWUKWsGoYLdLArro/ecQ==
X-Received: by 2002:a25:d391:0:b0:dcd:3663:b5e5 with SMTP id
 e139-20020a25d391000000b00dcd3663b5e5mr746234ybf.25.1708716830219; 
 Fri, 23 Feb 2024 11:33:50 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a05622a01c600b0042c61b99f42sm574541qtw.46.2024.02.23.11.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 11:33:49 -0800 (PST)
Date: Fri, 23 Feb 2024 13:33:47 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240223193347.GA2026@maniforge>
References: <20240221191725.17586-1-dthaler1968@gmail.com>
 <CAADnVQJq0aG2kF2KN1SCM9cZtRLqxKG=UkF=5-XWjFBbvLZhhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJq0aG2kF2KN1SCM9cZtRLqxKG=UkF=5-XWjFBbvLZhhQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/asokSCFx2_1hgrh0Y9ucWX41cJA>
Subject: Re: [Bpf] [PATCH bpf-next v4] bpf,
 docs: Add callx instructions in new conformance group
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============2453874186817021879=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============2453874186817021879==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqDR/5myZN5HNQ8X"
Content-Disposition: inline


--nqDR/5myZN5HNQ8X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 09:28:47AM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 21, 2024 at 11:17=E2=80=AFAM Dave Thaler <dthaler1968@googlem=
ail.com> wrote:
> >
> > -BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K=
 only, see `Helper functions`_
> > +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K=
 only
> > +BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X=
 only
>=20
> ...
>=20
> > +* call_by_address(value) means to call a helper function by the addres=
s specified by 'value' (see `Helper functions`_ for details)
>=20
>=20
> Sorry, we're not going to take this path in the kernel verifier.
> I understand that you went with this semantics in PREVAIL verifier,
> but this is user space and I suspect once PREVAIL folks realize
> that it's not that useful you will change that.
> User space has a luxury to change. The kernel doesn't
> and we won't be able to change such things in the standard either.
>=20
> Essentially what you're proposing is to treat
> callx dst_reg
> as calling any of the existing helpers by a number.
> Let's look at the first ~6:
> id =3D 1  void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> id =3D 2 long bpf_map_update_elem(struct bpf_map *map, const void *key,
> const void *value, u64 flags)
> ...
> id =3D 6 long bpf_trace_printk(const char *fmt, u32 fmt_size, ...)
>=20
> They have almost nothing in common.
> In C that would be an indirect call of "long (*fn)(...)"
> just call anything and hope it works.
> This is not useful in practice.
>=20
> Also commit log is wrong:
>=20
> > Only src=3D0 is currently listed for callx. Neither clang nor gcc
> > use src=3D1 or src=3D2, and both use exactly the same semantics for
> > src=3D0 which was agreed between them (Yonghong and Jose).
>=20
> this is not at all what gcc and clang are doing.
> They emit "callx dst_reg" when they need to compile a normal indirect call
> which address is in dst_reg.
> It's the real address of the function and not a helper ID.
>=20
> Hence these two:
> > +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K=
 only
> > +BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X=
 only
>=20
> are not correct.
> call imm is a call of helper with a given ID.
> callx dst_reg is a call of a function by its real address.
>=20
> This is _prelminary_ definition of callx dst_reg from compiler pov,
> but there is no implementation of it in the kernel, so
> it's way too early to hard code such semantics in the standard.

Dave -- are you OK with us just reserving the semantics for all callx
instructions, including src=3D0? At this point I think it's probably just
best for us to boot the whole thing to an extension.

I'm happy to send a patch for that if you agree (or please feel free to
send a v5 of this series which just reserves the group).

Thanks,
David

--nqDR/5myZN5HNQ8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZdjzGwAKCRBZ5LhpZcTz
ZDAyAP9EjBNLZhSAh7AGADKMfnox3Byuh7TNzpWprJc4oTUGHwD+MyT1LAORPwyG
asVXe1cBLnDM3DMOlMf8ad6jok6ukAw=
=CVFA
-----END PGP SIGNATURE-----

--nqDR/5myZN5HNQ8X--


--===============2453874186817021879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============2453874186817021879==--


