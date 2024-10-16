Return-Path: <bpf+bounces-42244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779789A1550
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F271F25C66
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13491D2F61;
	Wed, 16 Oct 2024 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENpptlSU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33861D4159
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115815; cv=none; b=sxECKXR4EjRVAI0jZSsSRBRbVOrXsSaLY0BO6zaIvPX6OCqtb79xpFgeNRXaDGU46+EcYLEfzIm0M/mkD6fav4L6E6c17ZbLGnCLnKYG7Crc2J+9WCDmK5ia6k4uCWbdjjYnjLkO4KZM1m8dW3jZAJv6OCeRUW8jeM9M/kAAcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115815; c=relaxed/simple;
	bh=ZaMH/+XaA0KHq65jvsHJlYGCrWE+YNgT/uTi+jCksIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dfKlD7urG6SKMeHIlar8zjTUeijmZ1I7AdWBDAi5qnpZnTiaLiPicjtj4BA2X5OW+iQOq8WrPyB0mIMOp/6OxtgPrsJIaAl9PRU02HwMxC+/MAWeuF4bU6ALI0dH+YKahf400JZTNjBv5gdT7XFiCWr4Jhc5ur3DGSIJB5pYPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENpptlSU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso230443a12.2
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729115813; x=1729720613; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4VgJKAyyRYYNAPy6hw50n7NxJVhG4MNuOvqJB9qCS0I=;
        b=ENpptlSU05kuB9By80uYW8aqp75ZoBJt6B4FY2qVu3rxMYOVSbgM44YdfIhiGCDNrz
         JGF2YavfTnlobc24F5DgKpaTPlJ+dH4M/+1VbCDghbJPoEj9n4av1alTK7zg7ofIETso
         1SJ9O1UydLa1y3nhLAGIXFU0Tsi7uqgDQyuSQRR8y9ks1NDgGyPNm4V2wyxO/oNHY3EY
         an8iESzAZclRnrWC+PHx9Sa31vtb4XrLPcEcNLSnx7v7o0kMkv2t/HmQOZNxhHcc9GaA
         SLOEKib/MBRlhJIGgfAAu6mxlfPxGU6A+8i1nD1Srk0rAcNy46tfeeThth6/LY+pfM7t
         tg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115813; x=1729720613;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VgJKAyyRYYNAPy6hw50n7NxJVhG4MNuOvqJB9qCS0I=;
        b=uTm5yUHqzSN2GWPkBP/uEKIolglXrpnF5YyqLpL/u6or/OpDBm+g74PIANkIkLWGRJ
         K4KL6xR5dMc7oGXgCP+2G6iJYIlacNWK4fV1mShYWrmWGhJ5SVaMr849TCg1F8xiibED
         FPWsrLC8Pq5xGofab4cQp4OTtkN95j66XL8sLNWupmaxnwSxYmvDptZlG1FURzz7Mk9I
         vzCWL7unWtUlB12EJfzUL6nbaMNy4ien4QY3rs/ZVduuIsfsAxXQytZuPhtfTc7Lw0pB
         Am6u+2Rlann+uDjwXn7V1EwyLQlYwRKLdoNvO2LWgLnEPL0wj25+4JdnTkoNRVlEJAJd
         qH6A==
X-Forwarded-Encrypted: i=1; AJvYcCWchSJu4eKMxiXJWau00FMtYHFdPMzcTZ9D0FoD/e2HdO472PO+Wlv9cNDMG6oe3Jswgeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdS9QUJhKiKsuud9vfg7CIPWFbLf5256U/o+lbQF9oGpwW3AK
	1+XR9RQnJxTA4t6BCELwdUXNA+BmXh5lFMPMZc757WnU36xfTn6/
X-Google-Smtp-Source: AGHT+IGrk6md/KuFFF7F3a6K+ClzwtbX/NLyqtlxtyYBfWMszocuG1+F99s+IwOhk7Xx+u4sRPSr/Q==
X-Received: by 2002:a17:90b:1803:b0:2e2:c406:ec8d with SMTP id 98e67ed59e1d1-2e3ab8bc854mr6699261a91.31.1729115813176;
        Wed, 16 Oct 2024 14:56:53 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84e22sm32887705ad.52.2024.10.16.14.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:56:52 -0700 (PDT)
Message-ID: <2450761417062a854035230fbf2829888462debb.camel@gmail.com>
Subject: Re: [PATCH bpf 3/3] selftests/bpf: Add test case for delta
 propagation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: nathaniel.theis@nccgroup.com, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com
Date: Wed, 16 Oct 2024 14:56:48 -0700
In-Reply-To: <20241016134913.32249-3-daniel@iogearbox.net>
References: <20241016134913.32249-1-daniel@iogearbox.net>
	 <20241016134913.32249-3-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 15:49 +0200, Daniel Borkmann wrote:
> Add a small BPF verifier test case to ensure that alu32 additions to
> registers are not subject to linked scalar delta tracking.
>=20
>   # ./vmtest.sh -- ./test_progs -t verifier_linked_scalars
>   [...]
>   ./test_progs -t verifier_linked_scalars
>   [    1.413138] tsc: Refined TSC clocksource calibration: 3407.993 MHz
>   [    1.413524] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0=
x311fcd52370, max_idle_ns: 440795242006 ns
>   [    1.414223] clocksource: Switched to clocksource tsc
>   [    1.419640] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.420025] bpf_testmod: module verification failed: signature and/o=
r required key missing - tainting kernel
>   #500/1   verifier_linked_scalars/scalars: find linked scalars:OK
>   #500     verifier_linked_scalars:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>   [    1.590858] ACPI: PM: Preparing to enter system sleep state S5
>   [    1.591402] reboot: Power down
>   [...]
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


