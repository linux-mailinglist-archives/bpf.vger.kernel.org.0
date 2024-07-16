Return-Path: <bpf+bounces-34929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0501E93327C
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 21:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5763282171
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC13EA76;
	Tue, 16 Jul 2024 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMiTIJXE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6C25779
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159670; cv=none; b=QricYzbUZKwxh2CmvAOZBdcMO95bRYykHM1A/htocfXWsxfvJ/zBKqMdTEmSSivoNBzF+wnMCcXN6yVkEf/raFm+0PkDq+m1haHGiS1GRvUduJPpgJJQPUcLUZmDKhjWsgnMew/erq2tRUUGnVus0Ad0uphTncwpyBIXFoInMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159670; c=relaxed/simple;
	bh=BOo51glRXv0STiPgqejw+szXoaiyJ2hLu5VG3FyAzyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rv/zIvlqsKlbujfcwJIWNoUaIeW+XnPxaF96hpp2qXSsfm5fW/ku2gM3qjXz7XA6aNe9J3cAAnRYaIwIspH/ksukxMe29AhfqIJ8yrdSN89xyhFhB3Ycm81wtbkRvgJy71fZIbOmUhTSByfIu7SkGeTUKKlNbGc2b8ZmA96ItXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMiTIJXE; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25e400d78b0so2101214fac.2
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721159668; x=1721764468; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cmT7OzKfAKgG6ZPqarw7/V4qig3ex81MJ1JMWoZrl0Q=;
        b=lMiTIJXE5am6xHcEqjbD70qe93jPdoXIAmOMGpe1GYpiJ4Y/Hj8Gt3xRWL31tHsV94
         +IFvvSjYOLyjR4CEE6c6TsgutNNf3IWf9I8bAYAMDOCAv+BvKQvyYDcnwN5LkAS5QyCm
         7BsRownYim++pnlrQc/0V7M7/9xZ1WyFWlqIMjimXsM0daUTrD2Ou6DWJpthJzX3IeY9
         B4BZxk1FfoW7qF/o7fUz3/Szo7aWa9M6rob8Yj0Vx7cIFZ+hqESA1CjH+0j2nFTyiZZ/
         yk62N3VcltIwnjCw0qXdPEerUkdDRuRzinSsp1lnM5QgbFL1NTk5VgSDjQh1txp2kadW
         KUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721159668; x=1721764468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmT7OzKfAKgG6ZPqarw7/V4qig3ex81MJ1JMWoZrl0Q=;
        b=dmZ6SXJQT5e6b8aMmyWrezPq7rwgwsWhrbwZ31RtbnXAd3Vz01LzItgj3gJMfa7tgb
         IcFRS2dZG1hDw5LVzMZ9eaynfYNTeWM7aELy832WBBIwxyMxnGAoRQIJFPQjv/jk06xy
         XyoHkXDmhyoDbhmTKZLp7MWTmOBElAPfKfPFYY17Fhbcv/fx229dQ8wr0iAMfvQJHWOc
         Qw6dlmdYr6mVL5DXr5UUPb/v8Qul5k7KyhQdiBns2s0kaLq7qlmdz8xSVKtsSrQchXuv
         4EidzSTQZixgQrwN8B3j8enRyOpNapsjWrYs8JFZ1PhpttCzmOqldCb8VfQZ3Id7P/17
         iIGg==
X-Forwarded-Encrypted: i=1; AJvYcCWaUExPhlKRhjDOJwBUMWN/Asa5I1bmFC98S98qunYFdPRhDVrTQEv7OyFBflpH/G0CDQs+PDvL3QZYT/ggderYabgN
X-Gm-Message-State: AOJu0YxEixVebtZ3SYWIs/M+dKZUcBXxsVL7ibHW5fj9ORCBmwUqK7zJ
	dXL/VfPuPlkRcVy9A9JIyFOwVpw572+2AoVrnL67mmT1nWb3kIhHGD4mww==
X-Google-Smtp-Source: AGHT+IHQc9G9HAmY1w1oMjAdzEbhFcuNsR66M4WMekHCbZQfvG8qx1OZcIjWeihFzcowKIQ9rdQ7XQ==
X-Received: by 2002:a05:6870:c1d2:b0:25e:129c:2226 with SMTP id 586e51a60fabf-260bdf97ca4mr2715301fac.38.1721159667652;
        Tue, 16 Jul 2024 12:54:27 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d2b1sm6750750b3a.108.2024.07.16.12.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:54:27 -0700 (PDT)
Message-ID: <7b985aa45f8277036c8b2ec50277daf987929fcc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for ldsx of pkt
 data/data_end/data_meta accesses
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 16 Jul 2024 12:54:22 -0700
In-Reply-To: <20240715201833.3236556-1-yonghong.song@linux.dev>
References: <20240715201828.3235796-1-yonghong.song@linux.dev>
	 <20240715201833.3236556-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 13:18 -0700, Yonghong Song wrote:

[...]

> +SEC("xdp")
> +__description("LDSX, xdp s32 xdp_md->data")
> +__failure __msg("invalid bpf_context access")
> +__naked void ldsx_ctx_1(void)
> +{
> +        asm volatile (
> +        "r2 =3D *(s32 *)(r1 + %[xdp_md_data]);"

Nit: this test fails at the first instruction,
     hence there is no need to include it's tail.
     I think it would be good to keep these tests minimal.

> +        "r3 =3D *(u32 *)(r1 + %[xdp_md_data_end]);"
> +        "r1 =3D r2;"
> +        "r1 +=3D 8;"
> +        "if r1 > r3 goto l0_%=3D;"
> +        "r0 =3D *(u64 *)(r1 - 8);"
> +"l0_%=3D:"
> +	"r0 =3D 0;"
> +        "exit;"
> +	:
> +        : __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
> +	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
> +        : __clobber_all);
> +}

[...]

