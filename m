Return-Path: <bpf+bounces-78742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D05D1A83D
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 762863044869
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE469350295;
	Tue, 13 Jan 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="aZaSPe7G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388EE34DB4A
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323851; cv=none; b=RgyrGDZI7MHwy59fJVBP8bjuyQspFCuP+1Pz2Gtm5Y9M5tNuOXH0zaHxmxupS/79ouo2+Ti2aO4yazw+mKJ3CHUc1OwkAyXxNQ/GlKSJvUcAjoHLekRob3/8S9Io2gY1xEPFJydOpMF5JqwTSJME8zwU+OyrUEVExSG8P+nHn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323851; c=relaxed/simple;
	bh=myAwfZK3pBeUDJYltOPnMulKp5k0GkhmmxDW3qcNe8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=j94gkrGw71yu4L32CWBffTgsY8l6RyyOZVR8Iym9ff+TEi+sYXfLMI4uNfF1CD7QQhK94e4quHCa8ozSmBDqvD6DrLqbkh/W6X2a75/Zxvo46QJ1WytNvqQ/xS8IZv61Aj0q8UxXSEj/9+1uOCwzWxKJ+GAaIQjUFhMsQBGAn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=aZaSPe7G; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c2f74ffd81so806716785a.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 09:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768323849; x=1768928649; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/95kNCiyvFVaVHQF9HHwQ/ObVa9tN1q/3Mo53VWDQg=;
        b=aZaSPe7GEiXQU+/Ia4iw19P58g9RY+w5Zsvfg46/HPbQtXFn+IBiLpGoLKe5R05Hj2
         hZWjHFKtSI+VOCE+VPJ6gCJsQaUhA/syt9ELPM3wp7BTxH579SyUFZNNHX3uzN7lfq7R
         lR2AzOJzJlFbqGrOm9T2xd7ErfjUDTj62fRytvvHPQkmxJV4tHnSue0HhgRXhQXfrVqw
         yqtd3JPHZnfgLJnU940SiC/mQlDkAnojoup7TsoEUl3dhnSCmvse2CteuLPJLjTlhzpi
         BWqJjRYB9EsdbO41XS7qvmscXowl4/ZTvcIIpBBJmLTaq93rK35c8wVt1IAlIUQgtKje
         PsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323849; x=1768928649;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/95kNCiyvFVaVHQF9HHwQ/ObVa9tN1q/3Mo53VWDQg=;
        b=SOJH+mn0nH3TuOjqux3TZxUtRa4j5pT/fZScQrMIR9MCJkrrvCMXlT+vRPl+vPYi4d
         gfFrAVG77+LU6bucXwVZ7NPm4vUeX+o/OxhXGuPT+gJ/N98dJJY7QZ1pXvIMvhvUVvyu
         I6DcGRLn8Btcokxje4Sg9Rz5LY+N9fZAiC1CBkIu7Wrt6WapIgz49z5av5kI6C2IuuBO
         5Xn9BPEDqs5fON/Hk3cxmnxcSk702rgG6Ap3KU4zdt0wrviZhjNvK5tUoN/02+x7MiCU
         ty3vIkcJdXhQK9DmK8pO+AEzks9Z9lBqicox2VORx3wtcMyMXdQzSrBTF83m8x/DfNmU
         iEIw==
X-Forwarded-Encrypted: i=1; AJvYcCWB0FEw5+AjlNmImEE2oGu7R33A723ogadBtrSZZD/oPyvyVpwzj3sQmhlKwcPG09aSK60=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXd9bA+XXDPs319RWDXHU8ezffK9nmiGLKazDw0MtvIVH6Bxt
	MQDSvgrLhf7m9VGUlLjsCJtOmwQGwW88zNokvUTnun/ZQdvsoK2IEUw/4EBfzoxxK7U=
X-Gm-Gg: AY/fxX6ZbqidrB8ETvQ0KmTTJsHU+mVgXpRqmgQHvPYfoUTKtB1oHgDCy5EJqrsSoxs
	ta8QKseWwGbkSvo7nFDGG9ph3D5HQtr5YFQ8Ctk1po6mHpNGzzX5KpfFg+T6vq+AVu5GbdlvVBQ
	nH4cLUoXZDeIk9taisXirTbQov2+iiUEvYOPWkCrYWJSM4zAwpeC16sDFIJxT76OmNaTEis97y+
	FtoBaeXJ3iTuUusPTiqdLQLRz8j+QBoucC6QonuPpe8A95NR1Ur5olvU/yvGT5QXPjYjwgZPolu
	u2uWbcBzEfTmmWkR9Fmht6p++Ad5BRERSdpXDHq6VQpGt7Ws4RLpSSZ4L+39LO+/VQc0+GN5p2y
	WbF5MkbNtZZMKp/GaojrbMV4/6yNg8591ADmI+6u9i9KiRsRnl3g6pcDPYCBoSD9qeXADpcb63P
	h7DcIhRxv3IvE=
X-Google-Smtp-Source: AGHT+IHrigtzczoZmIUBtOr447a+SGkdCdiNOcuOwbuKwxgdHgPDklWiMq+lgoZcPPhV5w+rYtbkaA==
X-Received: by 2002:a05:620a:4444:b0:8b2:e177:fb17 with SMTP id af79cd13be357-8c3893dca80mr2949157985a.45.1768323848858;
        Tue, 13 Jan 2026 09:04:08 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f5438f6sm1728247485a.53.2026.01.13.09.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 12:04:06 -0500
Message-Id: <DFNMHKDB1A40.3D0RBKLJVJ5HW@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>, "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Fix verifier_arena_globals1
 failure with 64K page
X-Mailer: aerc 0.20.1
References: <20260113061018.3797051-1-yonghong.song@linux.dev>
 <20260113061033.3798549-1-yonghong.song@linux.dev>
In-Reply-To: <20260113061033.3798549-1-yonghong.song@linux.dev>

On Tue Jan 13, 2026 at 1:10 AM EST, Yonghong Song wrote:
> With 64K page on arm64, verifier_arena_globals1 failed like below:
>   ...
>   libbpf: map 'arena': failed to create: -E2BIG
>   ...
>   #509/1   verifier_arena_globals1/check_reserve1:FAIL
>   ...
>
> For 64K page, if the number of arena pages is (1UL << 20), the total
> memory will exceed 4G and this will cause map creation failure.
> Adjusting ARENA_PAGES based on the actual page size fixed the problem.
>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  tools/testing/selftests/bpf/progs/verifier_arena_globals1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c =
b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
> index 14afef3d6442..83182ddbfb95 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
> @@ -9,7 +9,7 @@
>  #include "bpf_arena_common.h"
>  #include "bpf_misc.h"
> =20
> -#define ARENA_PAGES (1UL<< (32 - 12))
> +#define ARENA_PAGES (1UL<< (32 - __builtin_ffs(__PAGE_SIZE) + 1))
>  #define GLOBAL_PAGES (16)
> =20
>  struct {


