Return-Path: <bpf+bounces-46094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACECB9E43B2
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A016BC6BA3
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F7238722;
	Wed,  4 Dec 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXXhS8m/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF31237EC3
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332434; cv=none; b=jk1M6fnXar3ZJd+jbjVwLnFUy9iR4RuE6DbovR2qqVxLe1dooyXKzuYntjeilBhmQDJoK0kvzAEWHxYAsRlX21oGQXJ/Yx5Bh8Ksmj7UuduFk+gY85QentwRBShtesqb259qTm0tuFsIhT2ay4tBRYTXleLaIiT2PnVCj/sTfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332434; c=relaxed/simple;
	bh=Xfv/0ZKNdNbqMwdMyGksZ3XKV+Vl+FJZXjQa5yHFNkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuDLXNi9ycToAIbAM7nQ0RbpYMSfeLaXabVVma1sO74kzVfbQam9eM2hc2rObukVT205yK5lZCc3IIka0S81Jut3biTHqa6iKkLjiEDvbhwu3FVrOjBV6W6M9NArK7A9m9COtHRuVqWlE4tbCtAwUMlFBtyyEAPFvTzDK96ybao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXXhS8m/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2153e642114so118755ad.0
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 09:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733332431; x=1733937231; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=24+LrU9P9Zx9W8b/L6gNab372djoymgvX0kCUjkPrt8=;
        b=PXXhS8m/nJ/MvfA6dtkPV0MWIjqVzHx43Nm5ICB2ZKS7Gy7GdRIxWU//GIx7Hp4ZFs
         E+SIFSYYV8K/zxD5aXb95Qe0Eq4IcXiXkDbbRYI2plzmt4hqmufA1GEVz3X1s/w5zzhl
         5cawdHGvqIqsrruoNZBYG6ZiGGpcfeLxQReUo03Cd3QzWpiHnWx8VetcFefdzNgzgKlR
         jLEdtgiSEC//odJ/mCUGuWULf5CfY2yFRqGLipTJrQuXfK9+giwRvJH71G0Rs9AN/tl+
         Oo6r8iMqzD5b0QwgYVHF7BCeSPiAUTmZbRbp1wzALkioTtcnTxRi8UppzT1qdFxb01xA
         mvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332431; x=1733937231;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24+LrU9P9Zx9W8b/L6gNab372djoymgvX0kCUjkPrt8=;
        b=DTHzgw12e/pa1JBE9tphA5iADxbYp0j0ozX0gAl90eTKAbRwSC+1puq3NMKzDDUg4S
         Fg1ouH5LLZiS0n/DoeArMnWJ69rBgeRlBy5SloMutCetf35beNVmKbKNPDRS3KZ1sg9l
         BSmQV1lnn5ZJiCkvJaIngl41T5aomFY/YKh7scCXqvw+vo5lFElcIgu/T5BR2mywueA7
         p+w8bL0S+bm8CAwn6Rh44DfoFgbdX1buLePG7widbB9ByqKqzho0/pVnNeWql7o1QJSe
         jpLucKLr8RkZhhWxh5FZBkpAdwSssHgkIhS4Am+hBrq+q/D/hybiFoFA1u17xXyBjkTA
         wK2w==
X-Forwarded-Encrypted: i=1; AJvYcCUfrD/i2kC3OjKZOPlHuB+nmRNyl+8b6OxscPCvV/25VQ+/WUW6lM/JWskR0En5lzohNFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydAp/2/SoiSa/obTbKTJsEENJt7aArT6mTrc9nIxG6/4kE6AIy
	nfrJ7AuXHpzac+BCMLk4YtgVWh50lkzCB9gnfFSoRPGj+S0W4O0ad18AuOk9
X-Gm-Gg: ASbGncuPWA5xnTIzhwea2ZCdvTI/taTXoBZNHcuSgjWwMTwj/8k/a0T+SU3rBbt32bC
	PH2LjilpPQMmYCe3qNylmzkYpebZrxknEtNuU2hhbaxv3ZjnAbAzL1FuzgqDpfMXLBPJgeOhanL
	oSDNhN6VRWbuaih6ZgZ8SCyWzajF0uTLMzkHSZkG8TONWOLriW1joTtJTaXf+98rbXbQM2b7sk3
	7ergg0aQgJWHk0v9jgw06/wStXJOP8MHDmSsclxzPAPh2j8j4GQnQcoB3caSh6IRT7GzunWKqY=
X-Google-Smtp-Source: AGHT+IGYvbqdcBJ1JvPtgoP2B4EowS35QnKWwts2ZiaYe4l0mxbI3SbfM/cL1k/Pl41oQhRECOy3ww==
X-Received: by 2002:a17:903:1ca:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-215bd1b4604mr107865755ad.1.1733332431488;
        Wed, 04 Dec 2024 09:13:51 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a:5db9:45e9:ff71:ed03? ([2620:10d:c090:600::1:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7259470e2c9sm1232170b3a.190.2024.12.04.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:13:51 -0800 (PST)
Message-ID: <c1277e5fb5b32f3354c6e042380b3188aeefd146.camel@gmail.com>
Subject: Re: [PATCH bpf v3] samples/bpf: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  kernel-team@fb.com, yonghong.song@linux.dev,
 masahiroy@kernel.org, Stanislav Fomichev <sdf@fomichev.me>
Date: Wed, 04 Dec 2024 09:13:49 -0800
In-Reply-To: <778668f2-bb1a-438e-b075-05a12db726af@redhat.com>
References: <20241203182222.3915763-1-eddyz87@gmail.com>
	 <778668f2-bb1a-438e-b075-05a12db726af@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-04 at 10:41 +0100, Viktor Malik wrote:

[...]

> I was not quick enough to reply before this got merged, sorry about that.
>=20
> This will break situations when we want to pass extra flags to the
> libbpf sub-make from the command line, e.g. to build samples as PIE:
>=20
>     $ make TPROGS_USER_CFLAGS=3D"-fpie" TPROGS_USER_LDFLAGS=3D"-pie"
>     [...]
>     /usr/bin/ld: /bpf/samples/bpf/libbpf/libbpf.a(libbpf-in.o):
> relocation R_X86_64_32 against `.rodata.str1.1' can not be used when
> making a PIE object; recompile with -fPIE
>     /usr/bin/ld: failed to set dynamic section sizes: bad value
>=20
> I think that we should add
>=20
> COMMON_CFLAGS =3D $(TPROGS_USER_CFLAGS)
>=20
> somewhere to the top of the Makefile.

Hi Viktor,

This makes sense. Surprisingly enough, your example with -pie compiles
successfully for me, both using clang and gcc. I'll post an update
adding the suggested line.

Thanks,
Eduard

