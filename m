Return-Path: <bpf+bounces-76909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF3CC96C7
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 20:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43C34303B4B1
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960232F0692;
	Wed, 17 Dec 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNG1Ma+u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C02EFDA6
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000091; cv=none; b=a0ydw16bjpujIpMaBZRmP+aPgcAca5UDBJlF1vuQm+2hOm0A0TzLUKCKr9Vsj/hAvXMRZO5c3MLoZmuark/0oQj6dSXHBoFR13VWa1GDFztdjIFy/oMtGbfKC+oUbC7nSGVkoi/S9A48GgkNFHEF0aEwLyFUqZmArjrBHZn5fZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000091; c=relaxed/simple;
	bh=RMw+RUquiS+ZY9yup/tF/R4bl/A9C/wlkHAs7WzEDjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9qs+DkFhVmhLdDfUCtIVf3l1htX3MRmKDQntccwmF3Czhyyjz8RM102keVyUrDvrtvUxijjWvHQcnbZSTCJ0XZ3NGQLYmKqprJPFs+Jfd9kg8Ld7kU2FtAFrBmwYl7CLa10eQn44+sZpgAW746maOcPgNOccVPCPZwrLSWwkBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNG1Ma+u; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso6668443b3a.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 11:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766000089; x=1766604889; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RMw+RUquiS+ZY9yup/tF/R4bl/A9C/wlkHAs7WzEDjo=;
        b=ZNG1Ma+utD4x7uXjEEgKGKQQ7HT2/93KpCN4mHYIPF1rIIBOn83KuZ+Hpn9ViXGNns
         OwjKX5RTKzRdPKdsnjbWrY5uLakQWNes/pZgFsdxvi/00aM7K5kio/xOAoJf5Cpt+8HO
         g6NE1SrU+0b6/qUSXG45hGczTig5K79gM0w/BI0pRPHIxHQ1c/+ZOEX7aeKa+SwhYDNU
         GsZWZ48EDj5lYnc1KQzjHr4OnCE4xMmyuC06FmJ7Kpev+G5w2YpCLYnACK5rk2+KSIIU
         H1Saj3vedVsah7B0bELRSE4yWxEn27/zjSXWt3aBY4NizrvOndXUfgzA6nSzcR50g8dY
         h1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766000089; x=1766604889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMw+RUquiS+ZY9yup/tF/R4bl/A9C/wlkHAs7WzEDjo=;
        b=wVpUk7fhtYRk3bkf89upuaO+c17ALvN85qQT7A+S3SEYpYJTT6PCTSOksSdmzXQSKo
         677TgdZ4sgx2BfM1nV8Lpwy+ppKDQfT9/P2zXE6PZXYutFhrfMS019gipbEhGE7SPUtV
         VXHwz0Kb37WHpEmUvBWz9X3DrSO3LdbPau6ppBvBQ+9p8qu9Ozy+ixD1PCTp5C94kXkP
         sAxrz4HmsCvAo8fxZYYrvxwEd0J24RXfEOMhdL0Xz29MTPDjfkfvn/i90qZXYFABEVSy
         fN1fvZAVpryFBbxiLUrajwTLyPHGGggLaJMYuqMUaQBo6Ct1E+u+y/BJxG+8lZ/XHFW7
         gT/A==
X-Forwarded-Encrypted: i=1; AJvYcCW/vczHQU27uTlSbGdwJOJO/58wqO38L2+LfSJrb7gW4zuV1cyvxvg/kmAvlRMVZfYUeIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/2O6HBue05pQR7IFAi8wZrasXIpzBD4VNeToRCOp816ujA9u
	tfXMX3pTEeis58fu7Rq1vVoj9glkIX9ndl1pSvsR5qdwUGhK9KweCgzu
X-Gm-Gg: AY/fxX6Dr++1/eBlIBoTjWnZYA9hagM0O9mV/Y5GLGUMhXYbSczvyJSO+tt37W2+/b9
	ZlH7P/ojK1HmJxjxb+KFpBy8FLjljahXgrfePTtjANJUL81908JbWlXlqrHPJ+Cb+wvjh08qWSV
	3il6ggHQerEZCtTqHmyU+P6o33l5CfSm4vSbbc3SsNKSFbo8AqaV11vOOE7528qz97OC6GXAyal
	s01idVx8XCoEx2ypBB38h5GfP91o64PkguaoJz/q3PdMgN71JUWJfPSjAYWbirHlxwmEKbnsHp4
	LDbjTTaLA8OCcHT60zByaWCwBswaD8Yrlj23fw8HJZRYSn4+3IkmGYJO6EB94mcHCntAKv5jrpx
	Cf53K5WdyY6anqFtxpOgoxbwd0nC9iRl1rMU8HyMVQjMhoQqEaaNjOVcMKYRSLZDSObBeiSH5Ju
	pzEQtOIGPcdmEi/IXFAHVk5iU1EtCOKwrwiPdt
X-Google-Smtp-Source: AGHT+IHMCjCodeJbjuDUQSw+OHX93kazMv79mFDEEsbG1CgMEMkCsnJmexRrjrWFbdgj3LyKaQYgcQ==
X-Received: by 2002:a05:6a00:1c8a:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7f6674468e3mr18092801b3a.7.1766000088639;
        Wed, 17 Dec 2025 11:34:48 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:9f95:2f12:bb69:e3e6? ([2620:10d:c090:500::7:a4ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1456bc5asm233502b3a.55.2025.12.17.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:34:48 -0800 (PST)
Message-ID: <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
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
Date: Wed, 17 Dec 2025 11:34:46 -0800
In-Reply-To: <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:

[...]

> So maybe the best we can do here is something like the following at the t=
op
> of vmlinux.h:
>=20
> #ifndef BPF_USE_MS_EXTENSIONS
> #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIONS)
> #define BPF_USE_MS_EXTENSIONS
> #endif
> #endif
>=20
> ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
>=20
> That will work on clang and perhaps at some point work on gcc, but also
> gives the user the option to supply a macro to force use in cases where
> there is no detection available.

Are we sure we need such flexibility?
Maybe just stick with current implementation and unroll the structures
unconditionally?

