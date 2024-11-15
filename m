Return-Path: <bpf+bounces-44912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B85129CD4C0
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DBC1F22793
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6084084D;
	Fri, 15 Nov 2024 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb91M8u3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC438DC0
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631417; cv=none; b=ZXYufkp2y9DStsQ2YMS/yC0GRWwdSogD51Af8ne+hdPx2znpLcgLtwE1wFTERP1U9dhEnafolCDCy+7DlBA5w5KtA/rsU2yore0138q6aAXv8wb8xbrc44APzNX6xeURLbEFpe8iPUfYJTfL9R5PG8lwrr2Mst8h0VdOP2eLtSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631417; c=relaxed/simple;
	bh=CHqacG3x36iB7oLaJxLdifxVbhYwwCvLTR8xF6EDq54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i8PlavPwo3fyY6uIwX+PngEk24fOr63wJcSuE+C3ckDfqqFgp6IhGMpVHpUPpv3tUGVFmkBcd57qnvjedSRBqTp90/BTiTmMBTsNN6F0Hu5eUGwsOYqaZp/o4iFZMkSesa5n1oxA1YNsQwoeCEefIijxZi1VC7Kik1D8+UMpx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb91M8u3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21145812538so10279465ad.0
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731631415; x=1732236215; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ddP9oSWtuB14d68X5LVkgBBgtbWDCzsIHxObUABxV1s=;
        b=jb91M8u3F9mgBEbqbKs1C/ksWjE5kXEpUJvpj/yelpUUQeGSWj8jbKz9FqjLx3Sq91
         ifyuE7ef9Ef8Mfr7UBWSYcEUE3JsjUWoxvo7C5IdDbzihOcTfvjSSmp6s1fwpJX/+cYn
         zrQes8H+w7kyr7U4bIN+hzYgzcVzVX5qT+9PQwEr2X0IGwHesE0FLYTWQMHKfAmyOJsz
         aVUp5I+LthP5oyAlwgorXg6yJjx9rs8SNz8sGF7uv8o6hhX20sPKE021m9zVWO61HYSp
         UQrgshnhxVk4smOjqpxDU6p+0n0FJBRuf9EFoUOGfpM+mzcg4p4nMNmHApb3IpY9dhOO
         1h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631415; x=1732236215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddP9oSWtuB14d68X5LVkgBBgtbWDCzsIHxObUABxV1s=;
        b=RmFaAXwkIaSvIavJ+A2yIdQHQ11RfmkSbuyDfDGK5wn6DA1d3dSSLL0/RAc1OIqgri
         PU6Y1hN78OW05sAMzsluzDUHnjO3BZqmxdXPeq4aHDm+gngpEaYXXfNFAlIxIZQXIX3B
         7CTYZvokXJEcxhWvB1Z3laGP2dmuG+gnUXXWG3hlmvjsB+tk6LoYL2tbBTnaLcmUfvdU
         PbNTGQBLSwC1Sq7U4AOwQlDLmpzD/b63tzJiszRKyVdg3rJeL7XADabBEA56NtJAox3k
         Shaje0lwhcQL9m6/m8/v/+inqTRYMRbLDD+3BH1jZTjRVDOFNiGJsLsvgxdjHEwC5b7Y
         KLVA==
X-Forwarded-Encrypted: i=1; AJvYcCVjF/w2WCZJoCrwShNhj/mLkK1wh3K/PcdTF1KlzdUphJqR1qV0syGaHXyfj2SoyA4mW1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iQaNV7q6eRyyoqpQymADqCjcv7Y2G7DkiN4eUMEJ4Ssc2ZIm
	KFezSpkMZq0s/G+4pqQ3tlvTvhfy5q7/5kd/vSNoe3N1IPbxvqku
X-Google-Smtp-Source: AGHT+IEqTnAfkkSbSeISG81CySPjdP8G285uKuGm52DA7L5ZCYYgtDTKOndcgPgcEIymDTa2xS4PYw==
X-Received: by 2002:a17:903:18e:b0:20f:c225:f28c with SMTP id d9443c01a7336-211d0eceae5mr11040015ad.52.1731631415182;
        Thu, 14 Nov 2024 16:43:35 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc5df5sm2319795ad.10.2024.11.14.16.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:43:34 -0800 (PST)
Message-ID: <6855cb2475d684ed9f93e9a3f4bed2c8d4536ef2.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in
 opt_hard_wire_dead_code_branches()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 14 Nov 2024 16:43:29 -0800
In-Reply-To: <CAADnVQJ0mPBaVDpLHmHHrV3N3u_7M4D12MiOPv6=-fVSSC=o8g@mail.gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <20241107175040.1659341-2-eddyz87@gmail.com>
	 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
	 <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
	 <d34cbd7bf86d01ecccd70220078a7279756c8ec6.camel@gmail.com>
	 <CAADnVQJoRiZXRgzJt6pMFKqsCh93caARjA0hGQ_-V-B0VZ-+-w@mail.gmail.com>
	 <595a43d159bec96fd774c63024038006e8be2722.camel@gmail.com>
	 <CAADnVQJ0mPBaVDpLHmHHrV3N3u_7M4D12MiOPv6=-fVSSC=o8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 16:38 -0800, Alexei Starovoitov wrote:

[...]

> > The 101m -> 116m is for inlining w/o known branch removal -> inlining w=
ith branch removal.
> > (With 76m being no inlining at all).
>=20
> Not following. Which patch # does branch removal then?

- "bpf: shared BPF/native kfuncs" (patch #3)
  Build system integration and kfuncs inlining after verification.

- "bpf: instantiate inlinable kfuncs before verification" (patch #7)
  Adds a pass that clones inlinable kfunc bodies as hidden
  subprograms, one subprogram per callsite.

#3 does inlining, but does not remove any branches.
#7 moves where inlining is done which allows to remove branches.

Performance numbers for the simple test:
- #3 alone : 76m -> 101m
- #3 + #7  : 76m -> 116m


