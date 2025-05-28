Return-Path: <bpf+bounces-59128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0EAC62AD
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E451BA420F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2B244663;
	Wed, 28 May 2025 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNJMwxMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0481243956
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416264; cv=none; b=eJ6/koRxTYZ0ER2ZJ+2ZYIHzWM3/nWzXk8SnjaAy1/rgGgO7T9QObFctnL8BOlirHVxJsSkx44sCcQ7+PzexIrerCmVriwAe+imi7r5T9VIvwReu9bK9nup6wmb1ZARk+i9SmdNf4VCx9EVBXMthW1x835Gc9p4wqzRMSSNk+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416264; c=relaxed/simple;
	bh=c+HSWpQf08Q44emJxl1wVdQK4QxnYmtKYA7yWiIUvCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCSmEFOglssxtzqD9RMriwEXYs50EElxzC0mEt3QGyKAaEC/oG2D7gOsUAvinxmbIOskfhYV4hxbC4WzCF8gFGTzCu8EeBRPHKTkJTHQExO8kHT2A2DRK5cE1P995jYK7f7h5WEtFltnO6N4JEZQc9p86LYkF0JjDr28RXvYUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNJMwxMH; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7dc83224d5so527603276.1
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748416262; x=1749021062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AaLq2vIVSn6sAsC6KdBYVc9RopsAOBmwh5AN5b2x62Y=;
        b=mNJMwxMHHGsN1vBgo/5DUkktip3Jq6JmO9hTMipOmS8R/6ZV8eXRzG2TPJpYmaFnrF
         4A3OkyXaTPZf1dCU8VG1i81E+k1TSw/dUaku9oD2JYS31vOaNy82e3CDXiEVaxZB1V25
         gzcRMuMxGttgXiF/itMmr0bBsYfNBeeDvTF3Qwi4rgzXPqCJ/vUeZBPwdUYOiewur0sR
         F7O9aqT9G+1nIYYSokzy3jH9cAnoXfXm0gssh7heqJEgq82b9OkPCL9ldfyEKaBd1/oV
         PTpUxBS6HfJvpGDB4a7MdrL5Of/Wuf6+Hu5/63Jc9uGsZ5AOppoeZ7e1Bq3p5WO9QHMB
         P5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748416262; x=1749021062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaLq2vIVSn6sAsC6KdBYVc9RopsAOBmwh5AN5b2x62Y=;
        b=AefEcs8AW9MzjIbp8rRqupNL1NVGn2sa1nFkhCnaBeK3DgN0nTdGINoN1LSdznJnUe
         EVZVHKvaNE1ha7kEfkSyoqcmTDr4nwxKpy94h/yIBSp+rsGmp6yoqtvHsXvpqZABYDiJ
         W7KLR+vqwu0N81G1dQnsmhD8eoc87H8Xp5IlwrQC3KOrlHHmy9WMyytYz9keJ+o7OVZ/
         UT2K1HMA5yPPZE2mquIhAaJmS344FTsoaDDioVBkxLuafk/Xq4QRhfaSkxuzeAKWfHrg
         gRU1Pk3ukljBJvIQS7eJxUbrWzQTgRA4evQ+ZRIa0cRit6tVlG60AJBP+UpY5u/lnre9
         KSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+6uwS41WzO1tDZtJQHgSH1d6aC3akrLaerhcB+zD/fSGzFAdofi/m2y82EAaARx1TyqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOL1ZdkRplPiAMdJkKG0zrWvwl53Rw9xk+amQx2QRFEvvLRLKz
	5lhNTCT89F5InL7k6p+nAy7YP9PCbzpELXsMnX46x3X4eTMKs9jVpfFlJa6bNyx1a4UozPB1Zon
	oRnKn4eX/npB0RRxK48dcwEOQbY5kkRY=
X-Gm-Gg: ASbGncv/YkaepRVC5VucQzUFVNGcG5VkZIh8zAxDwAOq9q5jcJaxP5MlmVC4nvRrjyO
	wn+G181/S3jiH3/g9wPEdGaAgBCqPgRvq2rM8/ithoC/UYIgO5SaGmty/Ip4OlnsH6aqZIZGgf5
	I2jj6+TAJs38q5sV5BG2+Yv0K9+bf7cs0u
X-Google-Smtp-Source: AGHT+IHPa2QiVMuRTetNj3txcx4tNUMhc54lA9upSo2nD2LC+EE/pJ47A9wsr+6/e0F8sZ19aTQbiDrxZxZ3qg2MFrQ=
X-Received: by 2002:a05:6902:2d06:b0:e7d:89d2:a2bb with SMTP id
 3f1490d57ef6-e7dd031fc28mr5145760276.3.1748416261838; Wed, 28 May 2025
 00:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
 <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com>
 <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
 <CAM6KYssQwOnOqQT6TxHuu1_vDmmuw+OtFB=FwPLqbFcv+QdVrg@mail.gmail.com> <CAADnVQLFM9s_Ss7eqyx47tiY8i2b2dt=RMPHMC_s67Ang1rNBw@mail.gmail.com>
In-Reply-To: <CAADnVQLFM9s_Ss7eqyx47tiY8i2b2dt=RMPHMC_s67Ang1rNBw@mail.gmail.com>
From: Raj Sahu <rjsu26@gmail.com>
Date: Wed, 28 May 2025 00:10:45 -0700
X-Gm-Features: AX0GCFsyE-tU08AjAXtSeQJ77-J1ZI9Rqdn7FfbK_545KYaTeWzzDI1aTu6O6Zw
Message-ID: <CAM6KYsuVe10f39kfaJaQEUGGA7xjmkALxjRSQxJRcGKAw4KtGQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> That's exactly the case I was concerned about earlier.
> These two insns might generate different JIT images,
> so to prepare patches for text_poke_bp_batch()
> the verifier needs to coordinate with JIT.
> Replacing call with mov is a danger zone.
> iirc "mov %eax, 1" is 5 bytes, just like "call foo" is 5 bytes.
> But this is pure luck.
> We should only replace a call with a call or a jmp or a nop.
> See map_poke_track/untrack/run logic.
> Maybe we can reuse some of it.
.
.
> text_poke_bp() takes care of that.
> That's what the "_bp" suffix signifies. It's modifying live text
> via 'bp' (breakpoint). It has a multistep process to make it safe.

We were exploring the suggested design on a high-level.
The idea of moving patch generation after verification is really
simplifying the code.  We are also exploring whether we can
move it all the way after JIT.
There is a clarification needed.
If we need to support global termination, we need the call sites
(prepared during load-time) and pass it to text_poke_queue() which
will take care of patching the call instructions in-memory.
In this case, the only information we need is the call sites and not
the patched program (which we can free-up towards the end of program
load once the call_site information is obtained).

However, if we want to support per-CPU termination (for the case of a
super large per-CPU map causing large runtime, etc), we will need the
patch to stay around.
In this case, the termination handler (bpf_die in code) will perform
the `rip` change and stack modifications.

So, are we looking to support both, or just global termination?

