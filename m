Return-Path: <bpf+bounces-58682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF119ABFE9A
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 23:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0420A3BA8FB
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 21:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED828FAB2;
	Wed, 21 May 2025 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejCzcBW3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD071799F
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861389; cv=none; b=O++03cBMD4LkDFKDMCYnFNO+398fJ3XQRcM57USvSpppfPf3iNMbjd70B1csHOYmvCvctLKErlnaa+aR8CWOx8ajIshO8y3efP5FX6iCRKtDDPFs40AGuUSTUres0mQ0VCowJ3tteh03CK7Dy0i9vcwgRjo4VLxZEi5hqMvj05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861389; c=relaxed/simple;
	bh=mx+TDnI2Idgej1assA/XegxI16Im/pNmY6oHxm+DJkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDQ3/gKbJ7VkQuZtR4umGeNYQFT7kDwBhZ3abVsSYsxPZgqBHQXRETJZYDBKS86WFIa9yS094X5zToMOeiV4lTP85uFm0fXIA6VNMSsnWFmn4QEyl/lgxPhGDM1o+O1OJUFyXVP2CSQbzSNrGAdMkux4e3yhwvQe6TQ9rf1heGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejCzcBW3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73712952e1cso6812258b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747861387; x=1748466187; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g0Vc/7ITwfLEcXMpnoQ8sCEGUKvIzL20bUFyCCPtR7A=;
        b=ejCzcBW3YUdN7RN/mkwFdgcl6sPtlwdv3PPWKJqtkPubJY9He93l552dTKvTwaoEuF
         ueHulCFazB8CbrPC+s7P1lqpSmrFMBgQnA8YK7XVrwYBhiC7B0QHeuAyC7fNZW+dOPrS
         W/bbkww9h3rhJLThwQkJOf/AAUEiMkcKLvDgChzcxlDHnh7nXa98EgNFQ+mk3bcb42tm
         kOtbGgo8ylnTRj+xgle6Qd79ISxD/FFmdie20HGGaGzQNtHrPpNV9y5EQzNqel2ca2pZ
         hs2DIGKdXGuDb/DOVeVktf4v0/MEFLC9TgHg48i38+gv5FHXV9Delod+7LcSTDdKsxGS
         xL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747861387; x=1748466187;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0Vc/7ITwfLEcXMpnoQ8sCEGUKvIzL20bUFyCCPtR7A=;
        b=wleyIwvBrD/kB3rpITFy5CJj4OO+j/7EFzRpT9ATAq+aJIFvGLeU6kSUl6Y4I5mZLl
         6ek5Q8FNyT001LGRKY+Y1+RCyLWbvpxn2MUTMG8snEm2Eiz2+/TAq0NoR5ZYvPF8P0fx
         3QFFzmbyPNzn76htCpOWNakEL852TJHeFmqzvBBrS6tbtdZQgji7i0OkpW3JRHgB2V+3
         +9QQ0lzinigBowW2PJW+Q55sZkb4yNXRlTokhOufb5Ff0XuovIdJE6BHum436C8ZgOKm
         +/FfVKwAOz2qNLw2KJoTUmfZgbMP+0RMZS/uOzNASOt5EeayxLh6jB+JsQDO+LyUz2sE
         yidg==
X-Gm-Message-State: AOJu0Yxnr2/oY8zGedIZpbjG+UKbaAT7Uwk/WhLkdx13wY8QSBRmPTy9
	qv3C3fZF0H8rZ4utO+rbas/1mS3NhLqE2hNeW+nigKZlHE7seLwQ3B4q
X-Gm-Gg: ASbGncsgdFZl2lnOk6DqYO6JbyMy/7pCVmkRyOpxc6/betzYqbIlPpegWfny3sSDcAD
	qioeOjw6M9LsXe3eZlzR1DdNlfUF27cnzjlJ9dDvqNUmgbHRLWZmIdtwAqELYTKrDUNOYbj9oUz
	VKBKEkwHv5goJQnlrKVhoSg1KiMOjQMvtyoY0o4vytCbrqIJwnvgRrHO8ZvRM7OP9aGybRAiSOc
	qCMKL4sGTDsPRw9sCKIK3ikc2ZFtitm5blba4RQx0aS6has4GYaGyQLdlELkSupgH8Kv9itvQAk
	3vYCNBe5GB7gQow0GTrJuKsNLHNeXFpTmHj9EUOtbIaSBi3fcSeN2go=
X-Google-Smtp-Source: AGHT+IHW7Y0/Z06om0CF/dyCdUORMdVdHBjFPyEDHGmL9s8wLlcwQQepN/wrBOZ3khmdxfNcggovPw==
X-Received: by 2002:a05:6a00:9094:b0:736:57cb:f2b6 with SMTP id d2e1a72fcca58-742acce138dmr29792027b3a.12.1747861386946;
        Wed, 21 May 2025 14:03:06 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a31desm10385975b3a.171.2025.05.21.14.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 14:03:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
In-Reply-To: <5761ffe9-fc09-4f06-9311-0eed40a693fb@linux.dev> (Yonghong Song's
	message of "Wed, 21 May 2025 13:57:53 -0700")
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
	<20250521170414.2773034-1-yonghong.song@linux.dev>
	<6dd9752a-4bec-423d-8936-8757251f2b50@gmail.com>
	<5761ffe9-fc09-4f06-9311-0eed40a693fb@linux.dev>
Date: Wed, 21 May 2025 14:03:04 -0700
Message-ID: <m27c29d6d3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yonghong Song <yonghong.song@linux.dev> writes:

[...]

> It does not interact with subprogram due the patch 1. Without patch 1,
> the error will happen (see commit message of patch 1):
>
>   0: (18) r3 = 0x0                      ; R3_w=0
>   2: (85) call pc+2
>   caller:
>    R10=fp0
>   callee:
>    frame1: R1=ctx() R3_w=0 R10=fp0
>   5: frame1: R1=ctx() R3_w=0 R10=fp0
>   ; asm volatile ("                                 \ @ verifier_precision.c:184
>   5: (18) r2 = 0x20202000256c6c78       ; frame1: R2_w=0x20202000256c6c78
>   7: (05) goto pc+0
>   8: (bd) if r2 <= r10 goto pc+3        ; frame1: R2_w=0x20202000256c6c78 R10=fp0
>   9: (35) if r1 >= 0xffe3fff8 goto pc+0         ; frame1: R1=ctx()
>   10: (b5) if r2 <= 0x8 goto pc+0
>   mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1
>   mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0
>   mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3
>   mark_precise: frame1: regs=r2,r10 stack= before 7: (05) goto pc+0
>   mark_precise: frame1: regs=r2,r10 stack= before 5: (18) r2 = 0x20202000256c6c78
>   mark_precise: frame1: regs=r10 stack= before 2: (85) call pc+2
>   BUG regs 400

I see, in that case it is a useful test case, thank you.

[...]

>> - both src and dst registers are pointers to stack
>
> I actually thought about this as well, e.g.,
>    r2 = r10
>    r3 = r10
>    if r2 <= r3 goto +0
>    if r2 <= 8 goto +0
>
> But since r2 is actually a stack pointer, then r2 does not need
> backtracking. So r2 <= r3 won't be backtracked too.
>
> But if you feel such an example still valuable, I can add it too.

Makes sense, thank you for explaining.

