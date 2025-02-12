Return-Path: <bpf+bounces-51195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AAFA31A42
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 01:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2553A2F89
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 00:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093123A6;
	Wed, 12 Feb 2025 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPDqqGks"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD710E0;
	Wed, 12 Feb 2025 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319300; cv=none; b=Kc5h/+vVf8bo6coNH705FZP3FzkbPhn5AH4xBRuzv7ve+IqpJSnqdshDaoK39KhK1Fq4LwdHjX5m6xkedlyULam76oIinoiMcifLbemccZRmyZ9L4G4TmHVH6dQsZoAmJJ5EpKUqWKMuAqsHvvaeEj0UddC6pMpt3Cw1OIRsb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319300; c=relaxed/simple;
	bh=3AKa/KbMk/yw089tqH3tkLRaF88cQLPcFZ9q4ApzqvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DgZ5J77wo9CkhyVkC5OcGQeyyZ0GCB2u69IJCfNd7GP5QR5fZVyXNMhppgbiQ/qlViYzJ2zrLglz46S1YyWamykepwdGicW+nH816R9YzClMTOF6evrR2XfOIKDV/QB/fMExJ17Lv4eZL5Necjp63PTW6DChHiWJxuKnT/iLAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPDqqGks; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so5256382a91.2;
        Tue, 11 Feb 2025 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739319298; x=1739924098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0g64+bAu6IO9b+R8khvsANq0+6GQirg6dDpJG7gTDt8=;
        b=EPDqqGksWCVcre9kuIi99Xybl5dPUenGcv2TKGRyewIa8e3/VdyoiLRK8l15AV5jS8
         q1xZ01YyjIWTgfbIlG8485Ep+gq/jz+6NQQ48Nq7pgXI+2QFn8izwQyp5vCUq0ow8XJG
         SblZoXBYr1m/WxOrSqEFBq4hcuUBqxC3TGbz3eVKivP2foo7UKiG83CNNhQGONSF6Rb5
         6tNgt913Z3Cjo+ME3c0CG54eLSOOnBxTV+teD0zOkwe40V2WyR2+P4EJ/s+W+0eltoMR
         gzjx5Qq45ixXt2cspm/gpi8XGGVTs1UuC1dqOKFaI1rZMjjCiL19c7Ga3RTD+7UCVmuP
         XVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319298; x=1739924098;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0g64+bAu6IO9b+R8khvsANq0+6GQirg6dDpJG7gTDt8=;
        b=MHxjFiq+LRG0+rxWZub4rZ4d2JV6LMWOUJMhHIkMirR8W4dVb/xn+XU3f7rxsF3FVR
         J4fV0xjKjBDeEAqyjTxf52lsQVXwmygXLbrdgAHD9Z3msdoXnImsfnCGJa00ijCI2s4m
         c+GfO7QN6cEOoHLeeOCc0VmeHfXDErQatqUJyGNmWoAFVmOGq8lBL1mw7VYcBTKMbvMu
         +CsNg/3AufwBcFijefh0Lp4LmPibJy3SYmp/9ZVNRQFS9CLeTrGgwlKd8QslEetyVQ60
         l3FcOgmOgbueQiwnyVeFSr5DTm0s4yylpQ24kZJASUdP4gIBUjacOY028nGgHqBvefdN
         5JNg==
X-Forwarded-Encrypted: i=1; AJvYcCUW6uVzJ/zZLJQ/gk0CepL6q8lwlfNG/gFzJ5GAbShtcvOeY3FFXIO2vJEhkGczR7PZjMY=@vger.kernel.org, AJvYcCW1renMOEC7qbPa6Zh6nvSq2ayg3E77VeYVSqfODqPjRfF4EyXWtw9FqbyiXrGgJJZoEhNlomRE+byzkB6J@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFEusmetSGtUA/tBaMIHAeK/feQvUn4ZZ97pviSaBrBQZatu5
	1fY7ot+kUWOZpS9vAyJjmS/WDM9rlL3Na7RJkwCHBtKZQb8FR/A6
X-Gm-Gg: ASbGncszGHG6fRSFkwnjzXegyfM01eDUwud7XCYW45Z5qKrcrYG7H10eMjWHTW/kF+X
	oyscBE9qj/P823AV1SWq5hdjvTY5ZHY3x223FMOaZBDPGwgH3nvu3/8QIuZRepX8gaBhnk66qev
	mEPzJg/Tk6aQNRHtdwB3Rfzttbd0aMz+oV+R4kZAY3Kq7fjy/i//VrL8pXqzfKKffFmJu/6oZiM
	faeZ9GnAZc2ErmNFazFpFICQl1lz/zjmEpTZ2637CVJya9NszpHjTZgEOQk+fqCBfkMVUvst7yM
	9WNpT0Bor3nN
X-Google-Smtp-Source: AGHT+IGsXIH+f84KqAToP99Sh3SeIBndc/AQvegIuSnt+d3ClLLtcoD2z4mAFZARz+V06Rh95tBDlw==
X-Received: by 2002:a17:90b:2f0f:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-2fbf5c0d99bmr1935952a91.14.1739319298382;
        Tue, 11 Feb 2025 16:14:58 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b7b20sm176187a91.17.2025.02.11.16.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:14:57 -0800 (PST)
Message-ID: <40cb834c2e034dc991a6b0c8140608dcd2e9e5fb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 26/26] selftests/bpf: Add tests for
 rqspinlock
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra	
 <peterz@infradead.org>, Will Deacon <will@kernel.org>, Waiman Long	
 <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Tejun Heo	 <tj@kernel.org>, Barret Rhoden <brho@google.com>, Josh Don
 <joshdon@google.com>,  Dohyun Kim <dohyunkim@google.com>,
 linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Date: Tue, 11 Feb 2025 16:14:52 -0800
In-Reply-To: <20250206105435.2159977-27-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
	 <20250206105435.2159977-27-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 02:54 -0800, Kumar Kartikeya Dwivedi wrote:

[...]

> +void test_res_spin_lock(void)
> +{
> +	if (test__start_subtest("res_spin_lock_success"))
> +		test_res_spin_lock_success();
> +	if (test__start_subtest("res_spin_lock_failure"))
> +		test_res_spin_lock_failure();
> +}

Such organization makes it impossible to select sub-tests from
res_spin_lock_failure using ./test_progs -t.
I suggest doing something like below:

	@@ -6,7 +6,7 @@
	 #include "res_spin_lock.skel.h"
	 #include "res_spin_lock_fail.skel.h"

	-static void test_res_spin_lock_failure(void)
	+void test_res_spin_lock_failure(void)
	 {
	        RUN_TESTS(res_spin_lock_fail);
	 }
	@@ -30,7 +30,7 @@ static void *spin_lock_thread(void *arg)
	        pthread_exit(arg);
	 }

	-static void test_res_spin_lock_success(void)
	+void test_res_spin_lock_success(void)
	 {
	        LIBBPF_OPTS(bpf_test_run_opts, topts,
	                .data_in =3D &pkt_v4,
	@@ -89,11 +89,3 @@ static void test_res_spin_lock_success(void)
	        res_spin_lock__destroy(skel);
	        return;
	 }
	-
	-void test_res_spin_lock(void)
	-{
	-       if (test__start_subtest("res_spin_lock_success"))
	-               test_res_spin_lock_success();
	-       if (test__start_subtest("res_spin_lock_failure"))
	-               test_res_spin_lock_failure();
	-}

[...]


