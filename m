Return-Path: <bpf+bounces-58957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58476AC44FA
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 23:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A2E3BDE07
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 21:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6D213253;
	Mon, 26 May 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDCOqRNv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BB3C465
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748296178; cv=none; b=jm6wW8TNHYQwJMBBGYg9ImDUZtdXFR2qUrYEx/ThIzRc4UBwokzpOj4tJY5sxRcP+tOQzdmgd/8sPq/sX4mj25ACyN5szWN4wyobKz39UEUVPUR6wEadjDJ8MfE5aT0o2OX3VxN5eOfazJCSRbb/kq4MlmEwlQR5UJquY/g+EMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748296178; c=relaxed/simple;
	bh=wqqXTkSOJ83bhbqvAlRJG85QPnioVrPc3VZrXBjMSUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eU3b3oIgnBTRtBHc/goQu8Rvo0wytkUuLtkAv3sfS0UnnH4njoHwdVY6twAlZ2HJ/MEVV3zKLRYqKHsyxlrhOK+EKcqleaISV3ilEX8NTyAdz/8RUboSPIE7I9DQkGA8mIwA9jXWBy+pia46PsEIQq9NLV+2whmGaKXPfHbtgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDCOqRNv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1695521b3a.2
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748296176; x=1748900976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVyFrveLvCGGAW+1uHri7pseero3CAJL3suwnEjNOrk=;
        b=NDCOqRNvVZmGZuddsHI9As1Up2SidJEqnbzcfjLJA2fAxDfCHfknUQ1B86nfv3EBpx
         7uM9hWeagFlB8tF3zTAFQF7YP2MyGx3NyiVzSbhfQb1lutYp39QKQ4vG/AXHs9BqFLDD
         6JkRem4k6NT2wcd0oeGxjc+MPDKUdPGw0XlSuRPcgPcTrQMGc0hmSSLE036gI6j25stk
         TNyBxPvLrG+/kv8PtIPiOgjUuKU+7gF2LwlO7iUadDRRqxLolYLtcmdZx50u04OX1Uvi
         PJq2x3/ocjpZO3FjJzjNPbbbiddT7S3QceY7GAh1qZjL+zZ9YyqDhtCSfokwlqgGpYK2
         CXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748296176; x=1748900976;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jVyFrveLvCGGAW+1uHri7pseero3CAJL3suwnEjNOrk=;
        b=ZZjV9JCuzdx8bF9NgeIqm6n2Qkbe1OWxlqZ0JBR8O2SkxAsaWXuWs/7FYXH015chWW
         PDifja6Gl5ovOdSs8htp1KrZ2R/tE4lbd1z5x7LaeFuNa+/VxkW+kRcy6Mjh8pqrQjwu
         4sUaxHtByP8WqIP2pgNtnQujtnPmKkRvLfNs3Buol0rnQqjNk07LJLHwUS4S4A2phz0E
         kqYRvkVTP4q6usMqWv36VR45aYlWq/gmrdFZgRNOGFj8uPkRrei1/JVF5eeDA+emo13h
         P6QLuA6/txa1oG22toiN25hGrFIady6TMhX2p90aythfpfotVi9v3td64OnrHv2mtA9n
         UaKA==
X-Gm-Message-State: AOJu0YzQBw1tcJZbrWLBugkVR5atzrq7gJB44bvG9hjKAj71101bDh9C
	zXeuqK4m2Hg70BzTrrHZWZpxiT8UxT28rAAWaUttyR1idqQaupETNN9LPge6Xxk3
X-Gm-Gg: ASbGncsgtc07sJoKALcjJKq40b9VN41qowvaaTFu+Ff8Mc3pzsjqtPGO38D+AIOq5c3
	vvJG4Wx+7vPEcjyJsbRZpHPQE9HKs9mNUDZFTbV8sW83skA2DbyWZ/Bxs+McU4DOq0PRfLX7rGB
	+xNw/QJTWndi7g/83Xq1Y2drvQImP8i8jJKmcyFbpjSf7mNnaytfPbTCHbwO6TTzM0wuOgBRA5A
	t+bvYrXIgxlAVKbX+Sii52wdMmCQB/QIDN0uCOlfsmKydAPPlveEXY+2KaMNBMiZgZAfiDwiJtp
	mTQTHvc6yN39u7nzheGMXusnVp8vLbp4JuJFfCWugXKx5ToCsExyPaq+Diom5C2inA==
X-Google-Smtp-Source: AGHT+IED6wG6ovc/Kv8jZq0EluA9fR3CEzG1XUrs47HZ1Dwwms12xqNoM+W/V32Lkan4M2Zjorq3HA==
X-Received: by 2002:a05:6a21:6da5:b0:215:e1a0:805f with SMTP id adf61e73a8af0-2188c37d5dfmr16722004637.31.1748296175674;
        Mon, 26 May 2025 14:49:35 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:1c77])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2c1410a08csm5727220a12.38.2025.05.26.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 14:49:35 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v5 0/3] bpf: Warn with __bpf_trap() kfunc maybe
 due to uninitialized variable
In-Reply-To: <20250523205316.1291136-1-yonghong.song@linux.dev> (Yonghong
	Song's message of "Fri, 23 May 2025 13:53:16 -0700")
References: <20250523205316.1291136-1-yonghong.song@linux.dev>
Date: Mon, 26 May 2025 14:49:33 -0700
Message-ID: <m2ikln82ky.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yonghong Song <yonghong.song@linux.dev> writes:

> Marc Su=C3=B1=C3=A9 (Isovalent, part of Cisco) reported an issue where an
> uninitialized variable caused generating bpf prog binary code not
> working as expected. The reproducer is in [1] where the flags
> =E2=80=9C-Wall -Werror=E2=80=9D are enabled, but there is no warning as t=
he compiler
> takes advantage of uninitialized variable to do aggressive optimization.
> Such optimization results in a verification log:
>   last insn is not an exit or jmp
> User still needs to take quite some time to figure out what is
> the root cause.
>
> To give a better hint to user, __bpf_trap() kfunc is introduced
> in kernel and the compiler ([2]) will encode __bpf_trap()
> as needed. For example, compiler may generate 'unreachable' IR
> after do optimizaiton by taking advantage of uninitialized variable,
> and later bpf backend will translate such 'unreachable' IR to
> __bpf_trap() func in final binary. When kernel detects
> __bpf_trap(), it is able to issue much better verifier log, e.g.
>   unexpected __bpf_trap() due to uninitialized variable?
>
>   [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
>   [2] https://github.com/llvm/llvm-project/pull/131731

Combined kernel + llvm changes work as expected.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

