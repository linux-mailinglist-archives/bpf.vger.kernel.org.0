Return-Path: <bpf+bounces-20892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D291F845022
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B228FEE4
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990CF3BB3C;
	Thu,  1 Feb 2024 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYWzs4sM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EC3BB2C
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761280; cv=none; b=dPhey3xlMx70He+48eVWDvbLKvUxeOfzeKOULqxhNNNBGa4dI6u2FKPnYM9Db3MB1SehFGM43TQZWoynIWsNn8wo0yNfna/q6s3m77sSdrlNbP55OHoSw+AyhQlTIkPuLkraU14r6BtHUSl/k998pxgHwzi0LeOl0FEr44iRcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761280; c=relaxed/simple;
	bh=8/CsqgYsgnzXyV2WkXGz0peItpfG969p0XnileF4+5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHKNsu89jmNw8i9ZGPG2rbU/6fAaZIx1FR5bOc2SBAxUwmGP9XkXauxNu5DV8CI2LFp4ylX073uukxa4YWpxGb0+hghvGMnbuHYy4Fbss1cpZKLnB159034qPaAMu5GARG+xOpw/aZ3i5jLuMwHJkwZ3UZ08BURt3NuLtHcnDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYWzs4sM; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5112cb7ae27so861744e87.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761276; x=1707366076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e751ZAVsIPuZft7onPZSCr8w6RHxKKY+J2i9lIT9Goc=;
        b=cYWzs4sMeHKhNMdoiZB4vzZcqcRaQvErFnP01PVuUKm4dPD1ZYGu9xk6TWpLnfi5E0
         qO8afxZb/uXVyT6z7xWbPvHhGDwU4vTSVV0A4vvBCrQkf7VuxGZ6PZ7CbpT9f4L/sk95
         vt5VdS2D328qe4f9nyMM2favCTJ+rLCrtnInpVR+it5zhexiwH+tqvxO6ATJIdPPVA2S
         qSq+z6MowuRZy82aH3TXDsUIlp8qIGxK71euCAOnBIEPcEjU1YbC+R3Rybn3WooDyKmX
         TNigng4h2PCU6w+HmOJyUHRWxVmWrU4/VK3vLYyjAEnjwYU9lLXTZVRYPErMBY6ks4me
         TA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761276; x=1707366076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e751ZAVsIPuZft7onPZSCr8w6RHxKKY+J2i9lIT9Goc=;
        b=ABd6ZsLoUY3B0befd+kCpsGOtNERp/WrKb/6I86GYhpohNQrtnTU5zj4+hMvUYJ8an
         YmJS8pSFwU+/jAouRkaC6SYolkiqfO+aNRdNQ6EVXiBfQtAJ4KUcjJl6kHNIP5LDPWAw
         H/pG2PkuXAHIbvff0MrNrRbMBdr1G51OocglfpvCQJpye5M920VNSVw2ZySdAOLlK8vl
         mBGBbk1v0JwELJLe/+YcMLh33YbjRoBciQ634m83wiX5GFTzxYYdd+kjs/Tl2gTwYbLu
         1mnmYnXLHH2OhTSbkPqpuZ/DTRC2PjhrZOmT3eUwLktzs7ifQ8jxkbhIxreyszK5Scep
         2Lag==
X-Gm-Message-State: AOJu0YxmJakn0Mv+p5+u55e+ESgBUMXzRRjWJb7bYkyePPQT/PmCZzS9
	4F3/nmITOhB6ZLvSQJ08u0Z5z3fexZk2YGdihcLbyN/AMdNIWxWMXGxIoH+AQhk=
X-Google-Smtp-Source: AGHT+IHIwTytGPxsK9vzSqdzPMoV2rjWER4idjtXgM7vt0AttPIMzS0XGDoQylZs9vdCIWDlzUfXpw==
X-Received: by 2002:ac2:58e4:0:b0:511:1fb6:eb42 with SMTP id v4-20020ac258e4000000b005111fb6eb42mr831272lfo.61.1706761275505;
        Wed, 31 Jan 2024 20:21:15 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id fj18-20020a1709069c9200b00a3496fa1f7fsm6845034ejc.91.2024.01.31.20.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:14 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 03/14] selftests/bpf: Add test for throwing global subprog with acquired refs
Date: Thu,  1 Feb 2024 04:20:58 +0000
Message-Id: <20240201042109.1150490-4-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=memxor@gmail.com; h=from:subject; bh=8/CsqgYsgnzXyV2WkXGz0peItpfG969p0XnileF4+5w=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwNY6BE6oFflfQh4oOP2N0GKs12XgnhYrBHW Fforz0M1JWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDQAKCRBM4MiGSL8R ylDHD/kBK6uWn6e9ENv2KcjkZzHZrIT0BZ5VnCMog4vFzZYUzXQ9tdvNyJs//YMmU3DpSeyv43T rOUFgDOEm6vH9tYhbk41BlplGqzgVF3v3oCmrEZRYmzsadwID087T+D84T5jUh2p2eyWmdm6KNq JMIxmQJUzWtdbXaSQ/kPekwil97dttoFn+tL3y+gy5R0HssoW5IFy76xTMTjH9H0B/O6Na82cMS kF6aAZcqqCUBEnosp8xT7/X5CPUOsQTT0BQwX4gyI5T9SSaph6ALTzA2HsM7VR+BS3Aib9DEvxi 1YHbP1lxlyl5KzckTBJqq7I/BvHJblMg4WLhk3WjNoaXlpSdrp9KoxeupBxej14pMgyg9S16g4S fuam8Wy1vvHUog8GCyi39F10dP8xRrcZpitOTAJZTReKR+alh33Kc5xYe6sfCB/oFXBZV2zA1v6 tbNIZO1CQoqlfwDY/noaQKVRv01Jm+wzmFJK4hVJpO+IoNzmWtPtZG6cdDsGBEx/TbYUtQIeQRH KDtbtKFfLcFSZ4wVS2+LuBn78zTKVQz+mwNG5FwUQU5Dp6fVjNUAK6Qw4kdbCQgx5RlR0/x1NdY d0MxUurM18li4NG9+PIAcKAVUCNN4n/s7ZjRzgSAcBDiMoO/L0MZYuabUrL1uzLX4K1j0jvcORT 05N0dcb7xogiPZw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a test case to exercise verifier logic where a global function that
may potentially throw an exception is invoked from the main subprog,
such that during exploration, the reference state is not visible when
the bpf_throw instruction is explored. Without the fixes in prior
commits, bpf_throw will not complain when unreleased resources are
lingering in the program when a possible exception may be thrown.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/exceptions_fail.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 9cceb6521143..28602f905d7d 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -146,6 +146,13 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 	return 0;
 }
 
+__noinline int throwing_global_subprog(struct __sk_buff *ctx)
+{
+	if (ctx->len)
+		bpf_throw(0);
+	return 0;
+}
+
 SEC("?tc")
 __failure __msg("bpf_rcu_read_unlock is missing")
 int reject_subprog_with_rcu_read_lock(void *ctx)
@@ -346,4 +353,18 @@ int reject_exception_throw_cb_diff(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("exploring program path where exception is thrown")
+int reject_exception_throw_ref_call_throwing_global(struct __sk_buff *ctx)
+{
+	struct { long a; } *p = bpf_obj_new(typeof(*p));
+
+	if (!p)
+		return 0;
+	if (ctx->protocol)
+		throwing_global_subprog(ctx);
+	bpf_obj_drop(p);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.40.1


