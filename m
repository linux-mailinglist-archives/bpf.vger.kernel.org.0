Return-Path: <bpf+bounces-20325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA783C32F
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 14:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC23285337
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B94F883;
	Thu, 25 Jan 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhj7/Acg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665132189;
	Thu, 25 Jan 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187936; cv=none; b=Hz529A0qpOMyzHVdwSmmeAKXZt3hmZIwAK8c7jyLntHsR0J16f/rphTdLWA5LasJoS9acLV9dtEOqJQt8Oht0FnLDZOjP2UJWu+663e0hW39ckG7LqEqbbK7tHp9CmFYk5QhzS/TGI6Q/knBOeLHbrj11u3jFEws0W2Bmd59kF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187936; c=relaxed/simple;
	bh=ELvRx9TYX92ju1UeYZb5i5zyOpQZ2AlRQbLzGzWx9cM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6sFL+BgKeHEEdtbYhE+vjIQ7GXlrm6/QgjfJhrYq+4X3Vpi2XhpP+8oHIASr4hfOF0UHRAdjYWobZJJM2C8TjHJ8TgSRMWN4YWnYEN49CtDIpuI3dz2QT1RBY9lIp97PbLlK7i8W5k4aDgyDKR+ba6caLhlrM11jBM3l5tpYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhj7/Acg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a298accc440so738777766b.1;
        Thu, 25 Jan 2024 05:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706187933; x=1706792733; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ELvRx9TYX92ju1UeYZb5i5zyOpQZ2AlRQbLzGzWx9cM=;
        b=lhj7/AcgDM6mAijOFL86RA01WejQJrGp0cBur735j+VSEaPPiOfJY/ZT3aWwLzBmTq
         aEwgkjP048SjxBBEwfoom79xeoakMtXRtQ44je9lmQHKDpJj0VRWLKN+9W826AHXgoXa
         FHAkvx8s707iJWU/AhwNHFcmdd9alzhXw3AcAVWh1Wz/49GCIWThEmVVgvcDJHCDeX6I
         d8QWzYg5Wfrw5I4qUDCPZf6ZNaL/S11AEC2M6pcsoO6A8c8O/V+NH0twOoq72exdN6pe
         BebxjVwX1E59aFsI3+mnjaBT7q7sb1D2Q6SZKzelbOzPfZZ9kGoj2De7SxXIMYkohV0L
         SlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187933; x=1706792733;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELvRx9TYX92ju1UeYZb5i5zyOpQZ2AlRQbLzGzWx9cM=;
        b=qwRAcnAA/Y2lOz5rsn9iA9KxlS8micMJP+/P0pQ9R1bdEV9ogtFg1zTPg41hziyFdL
         sb/hyviMnX7ZQvDA5xCHO6ecc6u0kLiT09Sg7Y+kmu2V7OZV+RJ6SVHUZOH1MlcweTY4
         Cbu9ZTY2skvsXq5nd52Ne2e7d5d/8D17QexWpceZohkDl3sGgECV2VA3fWKhhHbfG/QQ
         7r8pQ+eobPKMD94aSci2yzWyXSR4tmliCkHyLgOaDH7He1cM3ObYwOXjmhrPD+eGYxJA
         wwUwsHN1AH4t+ONSF3oUtp7fl8cDrBXc9207k4L39WH4tcO2f7rXlQzm4BRtmMWTMVEE
         UYTg==
X-Gm-Message-State: AOJu0YyYSLPCroIMM0Zm4cqLI/w2opAVRShCErwEjTpfPatt7OciYef1
	anuRebTk/De9HoNAOdMHUvQ/32Pv6l602WacXltmoaf6c2tVNq2L
X-Google-Smtp-Source: AGHT+IGqK0JG7nni/RexIpcT3AcVECwMSyiwb6z0ID7KEBmx3bksMeHAAsEOu4WG8NFFImNJEXk4sw==
X-Received: by 2002:a17:906:d93a:b0:a30:86ec:44dd with SMTP id rn26-20020a170906d93a00b00a3086ec44ddmr649671ejb.67.1706187932839;
        Thu, 25 Jan 2024 05:05:32 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx28-20020a170907b59c00b00a28a297d47esm1015212ejc.73.2024.01.25.05.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:05:32 -0800 (PST)
Message-ID: <9a39fe710042c71abb252a38e1ec1bbfbe291e52.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject pointer spill with var offset
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf@vger.kernel.org, andreimatei1@gmail.com, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org
Date: Thu, 25 Jan 2024 15:05:31 +0200
In-Reply-To: <CACkBjsZjYewSh4ZHFbj-D_Z7kGOeaVLfROcEDE1beNEDn-aU-A@mail.gmail.com>
References: <20240124103010.51408-1-sunhao.th@gmail.com>
	 <5d33819c5f752755614882e30d971488731d97e0.camel@gmail.com>
	 <CACkBjsZjYewSh4ZHFbj-D_Z7kGOeaVLfROcEDE1beNEDn-aU-A@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 09:34 +0100, Hao Sun wrote:
[...]
> Testing this case with test_progs/test_verifier is hard because it happen=
s
> when cpu_mitigations_off() is true, but we do not have this setup yet.
> So the mentioned prog is rejected by sanitize_check_bounds() due to ptr
> alu with var_off when adding it to test_progs, and loading as unpriv.
>=20
> My local test was conducted: (1) booting the kernel with "mitigations=3Do=
ff"
> so that bypass_spec_v1 is true and sanitize_check_bounds() is skipped;
> (2) running the prog without the patch leaks the pointer; (3) loading the
> prog with the patch applied resulting in the expected message.

Thank you for explaining.
I booted VM with "mitigations=3Doff" and tried test as in [1], it passes.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[1] https://gist.github.com/eddyz87/bb517437767a8f01891cc6e6a847d448

