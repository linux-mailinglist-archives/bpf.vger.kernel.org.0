Return-Path: <bpf+bounces-46184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2EE9E60A9
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 23:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8016284627
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9FA1CEE96;
	Thu,  5 Dec 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOtrbR8o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EF1C3BEF
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437921; cv=none; b=girCEDyHHii+QTTsIvzJOXGB5ADz+LLj5cySCDybAxCULyZtSIVTc0nRRf35G/M/lvB8BTj/9MVkst0SpyTYYp6XIQ3ap6/2AulmGaXd3iLuOJIBJ8Z6EKK19tkl2Gge7PvIDBs7yA2C0nQWI00RrWE949dDv29PUD7EJx5SF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437921; c=relaxed/simple;
	bh=UF86Z1dQj/KsU3Ra+wcuwqEKaKGOLHEpyZ1QKIxoEbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbriLjm2tlSsi5ZeQT4XjE6/EMI/8U0JUW9dPQ5HDVaEhVsCHWGypBSGYW9mTtUeMpW+DZ/JXSOgBf8Z4+Rk4wVGJVkkdZDC8sM/WvGJEAlLLcGOkL6oxYeXmps7viXUvyVPfNpTYkqb35t6aTIjHadhn6K+GVapMOtCBLIK6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOtrbR8o; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a766b475so14624445e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 14:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733437917; x=1734042717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXHxvH1NprBb3IFUDDf4E5nMmL53C2Ip/f4wnlHCckc=;
        b=EOtrbR8oYow3Vp6bT85oNo6M6cwjWyPqXBMe1Nk0JpWaXgdgsFlGrfpFUB2aC83q63
         ln/bpQ0EX25/3T2DxWnrOwoK9XQGE8RylO8fzAMyxrzvZWBR5A/j5A2zvmgRJaBPvslN
         au5s2drTdjxVCdjSh5E7Bli2Er1w5VnhrUDB3MdSzNtzwQIPcbPeg1Cp0vkOasY997iF
         P3kYzDiFk5DI/aUlIcua2fvrTEBaueNIo7xZYGafP39KIGx46XkvFDPCgZrpjrJeE3jy
         er84Y2uBivNm40ZLhQE0QbiG7oLV08VhxzzN3oaAzFw1qD4WznenwK7Kq7pVaLKThVVB
         jK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733437917; x=1734042717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXHxvH1NprBb3IFUDDf4E5nMmL53C2Ip/f4wnlHCckc=;
        b=WZhSYJFZmqgi9qKl9BBE1mfDgL5Wau+rAXVtfqhWd3wTKrkX/l3zBvyoE6aQXT5DcH
         wzI9oaWzKJ30667zCCz1xLd5+XwCfDqXPmri/N5i7NlcWKw/I9gXrhd7Ff7KvHPfOYLm
         mu2Nc0/QqTRbqAb2Kgo9+5gwUZU9wSLz14RekfUBsviLpfukf9yaTJLCzhcz70nq8bkk
         S1VpMLXKQb2IKvlszq/JyYFGLkJ7Q+Ef6bVW9+zplSfdzKwVJ8huOx/lCTWxtULjQWok
         1KQHb1u/bxqIodFIOxhiK+1uZlVVq1Yt4F3Jy4UmXPffZ/VtYSnyby4B1Md5k0DKWJ6h
         f/cw==
X-Gm-Message-State: AOJu0YwCwWlF58Xh/39llSg9Iqa6jY0JEekQFc4frB9W8iC8VHRnAyS2
	zVagHECn7bdV7D0H+LyBBUfsRDX7R2phitdPAOCbS9EtNfyjyKXvkA1DCjIXRks=
X-Gm-Gg: ASbGncudq3CTfh1qj+mEM3W8olL9QWcf/oQZDEOCd4epf928i+dfSI9TMOkqltFoci9
	vc647ookNlvv9cqlqP4yJLMxuZ2Gtcm1EwwYS9JNZOhEgfaDYsG7smhF8kXN2SI4zQ4cFEZ5Fdy
	JUchKDJeAIsTfFHOl65IjycbyK2o5s3C5fz/KjWo2nR509wMytMm6M97HiFm+60bbDOQjSKnv1m
	vZXeyaBYkd6UCHZPgdprjefrnQWmEPV9NrVdBmQnyOAWiI7Abriw0Bve+LBDVqqcbBr/Fdx3urY
	oA==
X-Google-Smtp-Source: AGHT+IHcPZpMVD7Thn0dkO+X/9B5Z2/PX9BHQgYnbtxb3gZ20f0Eoy22xDNPATitPRQsnYYCOAM9cg==
X-Received: by 2002:a05:600c:3b88:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-434ddeb85aamr8545325e9.16.1733437916960;
        Thu, 05 Dec 2024 14:31:56 -0800 (PST)
Received: from localhost (fwdproxy-cln-035.fbsv.net. [2a03:2880:31ff:23::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cc2fdsm73726415e9.42.2024.12.05.14.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 14:31:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Manu Bretelle <chantra@meta.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add raw_tp tests for PTR_MAYBE_NULL marking
Date: Thu,  5 Dec 2024 14:31:52 -0800
Message-ID: <20241205223152.2434683-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241205223152.2434683-1-memxor@gmail.com>
References: <20241205223152.2434683-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3974; h=from:subject; bh=UF86Z1dQj/KsU3Ra+wcuwqEKaKGOLHEpyZ1QKIxoEbg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnUii0hpXQXNM/hzCfatvKyRsKljBnCNHMipsqlOu6 jngTTKCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1IotAAKCRBM4MiGSL8RyohZD/ 9v+WveMuXnISgRD0Z0Nt+u1u6DRy6IGlv1LE1TekDcSOZ/VIB0Yie5ItZBXstyxH3gIITT/TDD1zRU mlL7y1J91bDMowqYuBP8nfMx1IogBaAcY3ZzgpTL9w86SS2Lfsm9jNB1+AsfR4SoKmGItFHSGoB4IP 87gn1UuRxsMC1Bvh44IUo+FuRz10YOOIvk8SnbbYpZWdEOz7FP9bJXJaJGhauT8M7fIQxaMTrwAUlF ipcvM4M3dfxmpY89+S1PM2l5XnlNrjKOvfLlMfj9xbbMdtMxXFspG9hOENoCYB+a/Ej+/k/QEpcgF2 5MG+kAY8Mj1Xpp+OS/hGdMF/3nkxNrmCeKcZ50Dp2Zjj4C7tvJP/ZaBT7ij2Vix1/q5Arbgasa2K5J mfVALfPf+WOtOgDrMClr+RMPAQdrRWFCtmqokTeE0IuvBz45r9Ut/pWQwKjJP/Va0MERt2wztoC5T5 SqpNq2UNlh08cf9PxoWtjIqX/tL3LEhmTn2lvNpJ2B4u5Bk/dBeRrJ4MDrjXbtWct76qYaCJTARIy4 X+nUF7qmOdfEXxUp28krQ5+y58HnuIdeCSGvh/sDLDsB6ApYWf1eAefEOIvktEVhA04hzqgl1g3peR VR5Es9RVb23cg8kj5Ey07pxcDLSQjUbWCYuJB/LX8+o8r6dT+CfqFNkCohXg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that pointers with off != 0 are never unmarked as PTR_MAYBE_NULL
when doing NULL checks, while pointers that have off == 0 continue
getting unmarked, and also unmark associated copies with same id but
possibly non-zero offset.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  6 ++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 80 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
index 6fa19449297e..13fcd4c31034 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
@@ -3,6 +3,12 @@
 
 #include <test_progs.h>
 #include "raw_tp_null.skel.h"
+#include "raw_tp_null_fail.skel.h"
+
+void test_raw_tp_null_fail(void)
+{
+	RUN_TESTS(raw_tp_null_fail);
+}
 
 void test_raw_tp_null(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
new file mode 100644
index 000000000000..68de752cfe53
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+/* r1 with off=0 is checked, which marks r0 with off=8 as non-null */
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+__success
+__log_level(2)
+__msg("3: (07) r0 += 8                       ; R0_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("4: (15) if r1 == 0x0 goto pc+1        ; R1_w=trusted_ptr_sk_buff()")
+__msg("5: (bf) r2 = r0                       ; R0_w=trusted_ptr_sk_buff(off=8)")
+int BPF_PROG(test_raw_tp_null_check_zero_off, struct sk_buff *skb)
+{
+	asm volatile (
+		"r1 = *(u64 *)(r1 +0);			\
+		 r0 = r1;				\
+		 r2 = 0;				\
+		 r0 += 8;				\
+		 if r1 == 0 goto jmp;			\
+		 r2 = r0;				\
+		 jmp:					"
+		::
+		: __clobber_all
+	);
+	return 0;
+}
+
+/* r2 with offset is checked, which won't mark r1 with off=0 as non-NULL */
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+__success
+__log_level(2)
+__msg("3: (07) r2 += 8                       ; R2_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("4: (15) if r2 == 0x0 goto pc+1        ; R2_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("5: (bf) r2 = r1                       ; R1_w=trusted_ptr_or_null_sk_buff(id=1)")
+int BPF_PROG(test_raw_tp_null_copy_check_with_off, struct sk_buff *skb)
+{
+	asm volatile (
+		"r1 = *(u64 *)(r1 +0);			\
+		 r2 = r1;				\
+		 r3 = 0;				\
+		 r2 += 8;				\
+		 if r2 == 0 goto jmp2;			\
+		 r2 = r1;				\
+		 jmp2:					"
+		::
+		: __clobber_all
+	);
+	return 0;
+}
+
+/* Ensure state doesn't change for r0 and r1 when performing repeated checks.. */
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+__success
+__log_level(2)
+__msg("2: (07) r0 += 8                       ; R0_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("3: (15) if r0 == 0x0 goto pc+3        ; R0_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("4: (15) if r0 == 0x0 goto pc+2        ; R0_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("5: (15) if r0 == 0x0 goto pc+1        ; R0_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("6: (bf) r2 = r1                       ; R1=trusted_ptr_or_null_sk_buff(id=1)")
+int BPF_PROG(test_raw_tp_check_with_off, struct sk_buff *skb)
+{
+	asm volatile (
+		"r1 = *(u64 *)(r1 +0);			\
+		 r0 = r1;				\
+		 r0 += 8;				\
+		 if r0 == 0 goto jmp3;			\
+		 if r0 == 0 goto jmp3;			\
+		 if r0 == 0 goto jmp3;			\
+		 r2 = r1;				\
+		 jmp3:					"
+		::
+		: __clobber_all
+	);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


