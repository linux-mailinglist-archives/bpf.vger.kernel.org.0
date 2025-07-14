Return-Path: <bpf+bounces-63266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C7B04A12
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04734A0B25
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19199277C95;
	Mon, 14 Jul 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8bpV63L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745D2063F3;
	Mon, 14 Jul 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530873; cv=none; b=X6vaGvH5xLNMUS1W/u4d6V8Ja/xLId5qZQtNgzVPe+0EoNLoLAABY50T2rgubKwVB3VvV0am59em8fz7qYEkGO5u4mXogGvvzWG4qZSdjVBNNu5ntJb9uLq3/Ceqj+2s0DfYILEifKj2tU9PSH/ipMsknmy9wIuISmRvJumXY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530873; c=relaxed/simple;
	bh=uExFKFTUaultmzk+DLD6RB4anLVGjPtv8on1LrKXl2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baTp6PFdpiW49iD+PUmua3kVPEhXq+3TSawxdtjBMHL9rEqwYEwGtrctz/39yLYa+dxcHER/QjUywXU6zfmx7OPb2YYcLoqsi1mrzVCsClT4Ddbm1HS6krO9BCWvbHA2zVmtegcmPN5LcIls/DcF3bzq9QxKLPO9U7U8S0Yc+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8bpV63L; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b34a8f69862so3944729a12.2;
        Mon, 14 Jul 2025 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752530871; x=1753135671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Hohiy5MoqQ6vEJ5URK0FjkoHOX3aDNhpQlprrunQlc=;
        b=U8bpV63LMAbL/wwnyEKVBUyObIOUdrnJkvry9QNrCJnKl3ad4N2QsgZ3Nn3cN7LF37
         Otf+o3Q2rVeKnecgvKE/J6Fvi4FOnya7YaJ7Sf8ibd5fg+dI2W4K5Za4Rv6HWgpP4JmX
         dloivkD7nYMOb6lTEyax9ZzQQC/ZL2ZzNeMDP7R3eVtuvOBn+t4K+0Wj+JE1xqkToUfy
         95EJhJyorw9BYNqKfZZsSCRBl7KVh7SbZpoE4sH++aQTy5sMQH/QyIAqxqBV9szoxAnU
         WngulnH4O4zsBZGEkWwyoj84mNwZ2Bdm9wkNQ6hknvmfkkGrNueSZiQeCBJDg/I7TGW2
         893Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530871; x=1753135671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Hohiy5MoqQ6vEJ5URK0FjkoHOX3aDNhpQlprrunQlc=;
        b=O0VkouGTSw/3M2U4Ukf0pzvpCTZare54zd2OjSXeCgGR09Cf7kh7CjVLS1A/Il3MSt
         xDcRYdSy+C2HgSZRaVSulVfE1ezTXhNuyD4DABcsfs88hFJZ5X4R/pMZzxV3JEYDRoa+
         n/342Y6DTjoz/ceR84qZlq/Il6pEJX45bO/jihdFIyPAB/5PTeOXoL3NR/nWr7Azhu5l
         1op+ANlPqA/mv/Y/UT8jNtAMrVlTv1/eByuziFiPUDRDnj1rEZICtIxARydkacvBba87
         iP/byQ30e66viuR7MhvGIriDrMWa9ldyG8ERQoIa8LZKoheYV8ApGv0zEqEhV3DEJC25
         I5gA==
X-Forwarded-Encrypted: i=1; AJvYcCVpOUh4mRK89vPn4jUUCFOFJzs4Q/O9qjgm8rMinDMd0AXshFt2b2Ljn5GnuQ0h327fy3NW3/i2z8Lz3ktW@vger.kernel.org, AJvYcCXAr3nSJpvoNJKqezM1qldYwl01RgoVHwPluyosWk/YJBa9JrltDePEtvULU2x5nKbz8+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/V3nwdQ4e+BmVDMy8oCpIQ9KU+xrxgOrqGkmrYtEFztpiAHf
	pxaOqRwr1mwPpvQhFJSmRM9KeVVOJ3El2XwwCBuKpXjReUDli+ZOUMZqKtYwBsGnIuyQyKQRKAM
	3inqeaxeg/FYK4fS7KsGhmoF2u/EscZc=
X-Gm-Gg: ASbGncsBPUUNL1U1nlMAff2lL8BBRG/y3Woenc842iXfFSet9ENKVX5E8y7bdNXGF97
	cHJOa8PVSCeQKod5A4oEMKhSvkglx5n8K/N25Wuo0f9cN+PHJ5o7r1VCYRkW7ZcS9Obx+c2RQiU
	IlIw90TlzswYjbXE/3b4u4jlMjH6BrTj9mVVORu9a/Yz7bgOnGM6fD7FQfLvXO9Wl2qfsmqMg68
	7F4Z3iiAYElHKXz1uM2CIk=
X-Google-Smtp-Source: AGHT+IHsvFeRK5R+hofMMhtzhzDXjHZCxEIZ9Oy7iZ5xZpQszWp6uvFs57zu5BmpEYPhR5vFefGiFlCLQiDPgtL9Mzg=
X-Received: by 2002:a17:90b:1d03:b0:31c:3872:9411 with SMTP id
 98e67ed59e1d1-31c4f586482mr25130599a91.33.1752530869899; Mon, 14 Jul 2025
 15:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <20250703121521.1874196-15-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-15-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 15:07:33 -0700
X-Gm-Features: Ac12FXwsKTEL1DfoujQxB67pxXTEZ5H3SCt03D4r9_vC27-zAyV17WNb8wuMYY0
Message-ID: <CAEf4BzaoKNNf5pr4z8vEokj3AyLNZYyjYQUOoEMMZHN6ETUg4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 14/18] libbpf: add btf type hash lookup support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:22=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> For now, the libbpf find the btf type id by loop all the btf types and
> compare its name, which is inefficient if we have many functions to
> lookup.
>
> We add the "use_hash" to the function args of find_kernel_btf_id() to
> indicate if we should lookup the btf type id by hash. The hash table will
> be initialized if it has not yet.

Or we could build hashtable-based index outside of struct btf for a
specific use case, because there is no one perfect hashtable-based
indexing that can be done generically (e.g., just by name, or
name+kind, or kind+name, or some more complicated lookup key) and
cover all potential use cases. I'd prefer not to get into a problem of
defining and building indexes and leave it to callers (even if the
caller is other part of libbpf itself).

>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/lib/bpf/btf.c      | 102 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h      |   6 +++
>  tools/lib/bpf/libbpf.c   |  37 +++++++++++---
>  tools/lib/bpf/libbpf.map |   3 ++
>  4 files changed, 140 insertions(+), 8 deletions(-)
>

[...]

