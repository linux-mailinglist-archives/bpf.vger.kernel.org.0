Return-Path: <bpf+bounces-62043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A799AF0920
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D7742302C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEC51DDC08;
	Wed,  2 Jul 2025 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwGv7m/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654DAD51
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426276; cv=none; b=CU/dMd3lTNMCqUMA25i31VeFNtfNqP6kdphHObHFi2d/UVvCqpD75yp0LsJT7Ot37zdIgul7fAG/NZsivZNP5S/k+7Rxq9eEiB0Pfow06J4bdDsycOah0993gh7G0SEp6/iIP8vzb4CfE+aSnqpfu7JlaVh3PShUi11efzkhCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426276; c=relaxed/simple;
	bh=czoHnApkZ/ZgbaxT/kq30NigK9YjN8HbUnApF+cqNaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgEEbshBE1FnPzIqO/BWXCcMjpQELs0qoeIhW4IyURWoYkz906+XiCFlkxnGjpqzP73tibziE7cHhMzM9NLxPFkuvfrXY2ZcHmAJwRxGvGFv+y5M9UyjZPdgv7yctfBG5zTEFFDdDFfbcLKJZM897gpoj3ykuM3XCajqY4ePigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwGv7m/E; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so8187881a12.0
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426273; x=1752031073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWxm5xiXWjEe1Q9mDBvhbiPjdfGILC4nBRmOEBS4Tyw=;
        b=HwGv7m/EYnmHqIlWXc7sbd67AC8yrOpYBr5s5U2neWjXUYye6YGZ+D3gx9GL85U7Bd
         xiTAXcFl+M+Ubk3PpkoD16DLw5ifXg3AUdrYXIO54O8NcnzuIWFi3jOXIZXmJAFsqoWf
         +tROJ4ktaM91zbFzNwGCYlFyRtcsdTL2aJb3xrOffeNscoiFutZGCmh8Z51N5unrHTxc
         WlFWFruR8wznOtxi8lEmnq8KYzx/wK8iKWP4a5i9LWqXuWHdnp4LqSqg/bgTYCcz4Xat
         bOpkc3wvLQRdO6xrokokl9wAbHM2Gw7l0ZNZoja3WrdJxGRW5V7mk7Ha94OzKyjdU6IR
         6mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426273; x=1752031073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWxm5xiXWjEe1Q9mDBvhbiPjdfGILC4nBRmOEBS4Tyw=;
        b=FW9U8jA88omdhhSOpF2nrFNFDk3OTbl1B9Y3nmiUVnOLLBH3oTV33hhtu1uonKuiib
         ptC3Qp85N/wy+tRXD7dWCC4LLyvzzkVCxFckt7QySvPSQz9YRSlLbRxG3ivAZY3WFkdD
         7bhkbSllDceNpL7uv4QAgtyUF4IMhaShBtGrngnEfZcLv43VfZC5rhI0tQlYYGR4m9/+
         srVj1Erv6BsBawBI82WvYLPvy4GMekwdyziEUn++wY2stQ2+k+IWlpOYX1RS3x0R77mR
         2VpDlZh+3kaCstpnmqRJap9sbfsBeUbdJlg6ryIDI4QLQTeSU57S6q0t3kJoaqZNrF7j
         ej5Q==
X-Gm-Message-State: AOJu0Yz7Ix7Lsc1CwO8GAQgIa8MX7vAWfMtyhWHCehUhS1chJmjGTG5/
	tOk6QBXuRV4PBf8NtGrBYakMWxL1J29XO6B9XDfA1OwUT/rmkDiQo6lLmS2hsMGr0AM=
X-Gm-Gg: ASbGncsTpbuQRPhekCnv2libGSq7kd1A3RTdOGv3of+Um3KrFyXVcasuznTGU+gK06m
	J4iVcaK9pzWYYXAJkgMJa14GTv7WrDdr1YvrX8Erya6wbzp/u6DrJK9mRTBgjPrv/B0K5W+dqM9
	z+UA9wNofKjoAMZRdJtozlKXHEaQbn9BhSoMdfTvgPNmxVx8NElb2OyEbZHFRv1cVyV5RH4V+nn
	//cq1wZcR674BjvMvMTfR426J/iXqWJ/+ktLbwkr1kGlg70BrengPG4SjhXeK4YftzohcThUKfG
	fuv4XhUw+pucU3uPqJk3U+K/UthjV/Yiog9HBQZlw+nByQZZFrE=
X-Google-Smtp-Source: AGHT+IH2jWPQ7d4nlQVYHvYWaTPKh+W4oBccTv4jmKatbNpY9v2h1t2LjNI+W2N9DRTAOlJnhKb7Jg==
X-Received: by 2002:a17:907:96a8:b0:ad8:9f9d:b139 with SMTP id a640c23a62f3a-ae3c2a8207cmr107538666b.5.1751426272650;
        Tue, 01 Jul 2025 20:17:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bc2dsm1001409466b.136.2025.07.01.20.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 07/12] bpf: Report may_goto timeout to BPF stderr
Date: Tue,  1 Jul 2025 20:17:32 -0700
Message-ID: <20250702031737.407548-8-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; h=from:subject; bh=czoHnApkZ/ZgbaxT/kq30NigK9YjN8HbUnApF+cqNaM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFR64huDM7HXpTiNI/G9+zHFdh+X4PQmnHJz6eU ANdUmoeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUQAKCRBM4MiGSL8RyshqEA CFMYo9T/y4gvXT4e/NaRaDuk9D3tq85XDmXRQaAl0fujdn4CxVpFtNeeQq+xU+iaoiGbKO/0pH36Ce 2Y93O1Hkgs3VfnyXmKHw26XMWDvboEmbOQUJEj/bDtI8qPG2oJy8IkgGyEWNU7xFgOuwaRVXqaG65U agJWYJvXn90Qk8JdcBR0ZftlsjxpcFWme5DXmIDyk4xANCpl1ZltkAV+czV5jYdKFGgYP8FTiRk49G RCxh1IqrAqCKGnu87+HsokzPWeB1TiCCTSwOFsuuqPlL3wCLx7QCOdzpD4g5zl5fZ+mfqmhCZwutEn KjgPdQuhxN0ozZG/+tgfRbs4VuKXs1x9J4xP1QeEaA5humB8BlSi2aRoFap6K8ObnWaVBOZX2z8vdc hThwXSYNTqPCuMtYA2i1778c9/46GdsUE1g0foN98Mu0PTGsoL/dTuCCR3wawBtqlB9XVN8mjq+t2t F70GTa+z3bW70LP5FbBrayGOcmuPx5cY3DU5DoEg5lLDrJGIa1CidXQRnH4+WYhi+S/YlFQekaELa/ FQomNdjc2SZjvKWDivA5JM+BoVSUlKxVE7p8T4UcKKeP3f0xIIRhaCStzr1JG1/wq35f6M4mbmgs47 2NatL/jj18d+ZHV/6AdzWGB54a8V50Zz36WJTK+Mgsb3iqEiS5Dxv9kXyhyg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting may_goto timeouts to BPF program's stderr stream.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ab8b3446570c..47dcc4f19050 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3168,6 +3168,22 @@ u64 __weak arch_bpf_timed_may_goto(void)
 	return 0;
 }
 
+static noinline void bpf_prog_report_may_goto_violation(void)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: Timeout detected for may_goto instruction\n");
+		bpf_stream_dump_stack(ss);
+	}));
+#endif
+}
+
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
 	u64 time = ktime_get_mono_fast_ns();
@@ -3178,8 +3194,10 @@ u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 		return BPF_MAX_TIMED_LOOPS;
 	}
 	/* Check if we've exhausted our time slice, and zero count. */
-	if (time - p->timestamp >= (NSEC_PER_SEC / 4))
+	if (unlikely(time - p->timestamp >= (NSEC_PER_SEC / 4))) {
+		bpf_prog_report_may_goto_violation();
 		return 0;
+	}
 	/* Refresh the count for the stack frame. */
 	return BPF_MAX_TIMED_LOOPS;
 }
-- 
2.47.1


