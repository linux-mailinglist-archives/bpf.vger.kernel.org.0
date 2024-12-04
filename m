Return-Path: <bpf+bounces-46046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1699E3184
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8EB168264
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 02:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A3178C75;
	Wed,  4 Dec 2024 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdbszBNP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E527715
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280123; cv=none; b=SrVQ1syMx2qVghq7vbk6RVEMc7b48URALGIhzXuZLtMtFLOkSVCnWYEKhVo2vMV+ipqG1gKSzDKw6LBS2n6DR5wIKKn2j5bYYQqojOBYGLP6KrtdHMMAfdyufQj7k43nA7+UpczsXq+UfydSsWwTKjyZW/6oRJ23fUVlIL0+QYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280123; c=relaxed/simple;
	bh=GR4SqSfDa0L/6ZPFyKuaEdnvN+gm4aY9iaeV6W4XSDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbRoBtC0QREtPrknFDbG4nBDfHq/WsQ7+rqoiaBtf8ojz5kruxdVmtRAGQOP5R8yNSpJdwL80IJc+oXF+48eKaJukQFaOAXeKMUDFyOstJSRdHABcsI3d/R8N1yWuMG8jWIWRpazkwzS8oPpDKhdRaWhkIT7t0RKe0iatU/L34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdbszBNP; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so56375485e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 18:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733280119; x=1733884919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4d3mN0BuOSsoMkdYNxjchoayjyUz4nDXno21TpF1rY=;
        b=mdbszBNPCCQbr/vf+ft/obkiRzzfDvxfD48v1PWuOJUEjtcVk41BwXETaR/6MJmHFd
         2ArzjX6146X+75pQfu7qVntaTtGYVbbPfqTq/JDRu2IG+nQCtaaA5mytKZow0duwouK5
         rgs4gyoqE21tW2TXeDzZl/IQGt35jWO6oOAEGX4a85VLJWpKKUFNqimAwqgooStSPTA1
         sMWyj5Yj7GX7C0oP48csZf+5nHqBFbae4CvsPBLCtLYV0iHfz+hCVdt8qUV6ea5WTOsP
         ooFGmEPzaiZv0yzoURCVcVzY8pYjlF1zYgDGbPGFvju6ZJAMjorP6ormavSSNSHN4X8C
         nTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280119; x=1733884919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4d3mN0BuOSsoMkdYNxjchoayjyUz4nDXno21TpF1rY=;
        b=KdBdU5XoIWwEcGKtGPRYJY1msmlsTM4BMdFqVYWqhDQ7jX6YCkfejwm4Y0hdIyWiJG
         05L29y9sfve+4oPkmy8+TzDj/snuDswVonV2wR2pOGpzm5ei86Cz+GPV0de9Sa6lqK/h
         QUKIgdenMdjsBdrdFgZYfEtQHRphDhCR9w6YsvubZDpq+akSpSRB93xRHC0gQ5Yb7WXo
         /0vMAUsCm0fsMp5dV6mvKuRBvN3POadTQNM3mEFjIQbnYpmUrjy0sx4uDb2T1FNJdACv
         KBphK9q70m8wKPkQkwD6ffxMNzzLsKljPLW2xfqjW1UZT/UCWoYN2SDvkjWwyliPzhFO
         4FZw==
X-Gm-Message-State: AOJu0YxuzrXgFnn9ZfEe9XcIIEoYrncy5xq6cphzOTDjcF/GJucnVOQp
	5svobmRsTxF5xizNU6MOSHW/RKeVwUiGCVnGqsuAW3+O0xd7nquEHXsLhFwkPJw=
X-Gm-Gg: ASbGnctBolIJuCUMbUqU7XEr0+UF3d3prh3epNYahDd7cpnh8/jwFlFkbVyLbHw8yiq
	WResmDGleIVFSm+wXHnoUNe7iTecl0XF6Zr4w4+7wlFBgUGsflBRyE6OIwUVsInmokKzQKCfFAn
	L11xYGh5oJ/G3GVlisgcaxLnCQO+oB6XXFnNTqhf+SpnetYvhlwCCo1F60TTr/5tP7GCf94hcKH
	iMf2I4Gn6CBDlrVfdaIQE+3PItbU3QRRrY83uhdXZiZqjjd//U70B7BFaqJvUWZzu/xbyqgjPdJ
X-Google-Smtp-Source: AGHT+IGlIRD4EHevk9oopnW6Nt9t75Ei7CXGkyELI1JLobfFYrA9GNPAmZGEHwUK8bFWaWR4DN4keg==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr47317085e9.30.1733280118866;
        Tue, 03 Dec 2024 18:41:58 -0800 (PST)
Received: from localhost (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273440sm7350535e9.18.2024.12.03.18.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 18:41:58 -0800 (PST)
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
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for PTR_MAYBE_NULL marking
Date: Tue,  3 Dec 2024 18:41:54 -0800
Message-ID: <20241204024154.21386-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204024154.21386-1-memxor@gmail.com>
References: <20241204024154.21386-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4160; h=from:subject; bh=GR4SqSfDa0L/6ZPFyKuaEdnvN+gm4aY9iaeV6W4XSDo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8CACeAztdDTrIuipP1NQ9au77EqAjkJfWW7NVj4 FnlDHWqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/AgAAKCRBM4MiGSL8RykkED/ 4yDbKf7Yht/GgxKa37kSeT+RfQViRXTCPMzAh+mYh56AdPu2yyfy1P9WzBwdj2jmhPvm+PCViRnEHV a+H6yw05SSLuUlvsPvBsAMUUG2mOWEm0XP6wkVTE/MBAcDIUJUWacfVK9IuH2kZOAPR54+zR1OA0Eh wlY42f5I+zxK3BjCCRmDFozpgehwA7eYe3VDsm2UZqgFCqbrvfnSVE9/BLnIwYzknaGAdWakRPahnb YRYfcBTLZTQPDicCA5OLwd/6yfOONYkmiW/stfewNXChmKF6SR/8215SdN24wDsPr1q2ApG5bwuhYP lJDn/qY2bj9JemoJe0Czctb8Z3Y6lvfRfxRSjyVpNsVsqVDp3aJMB/HMuPXR0wuD1o3JH7svy3Mvom xmFSsFBJdTwCOBw3/z7Zm2HtVeShGdpoMuJ393jqQA1oakCoXH1HtQtR1WMJ+7JzbW7spc76s6W3xs yRFTs7e3mLdRTliL3J+H8L+2hqjv2jPZ5oeq5CeHz5WBT0m8hRCaZG0/ea7r5apeGj8EAZxqtUIeUw TZMsg+cb6/tuCXzAt9MKgrvjfTTRLvrLMgtylSQzfoDTQvM7rELJEE7rMwH8SkJJmgqxQGX3kEedi0 tHJ+ptNwP1LVWjZQkIHm2o6avfuUjq+2D+aOk/U0vslZUb0WBLXzCGhPMIUQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that pointers with off != 0 are never unmarked as PTR_MAYBE_NULL,
pointers that have off == 0 continue getting unmarked, and pointers that
don't get unmarked acquire a new id instead of resetting it to zero, so
as to identify themselves uniquely and not hit other warnings where id
== 0 is not expected with PTR_MAYBE_NULL.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  6 ++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 81 +++++++++++++++++++
 2 files changed, 87 insertions(+)
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
index 000000000000..12096150a48c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+/* r1 with off = 0 is checked, which marks new id for r0 with off=8 */
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+__failure
+__msg("2: (b7) r2 = 0                        ; R2_w=0")
+__msg("3: (07) r0 += 8                       ; R0_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("4: (15) if r1 == 0x0 goto pc+2        ; R1_w=trusted_ptr_sk_buff()")
+__msg("5: (bf) r2 = r0                       ; R0_w=trusted_ptr_or_null_sk_buff(id=2,off=8)")
+int BPF_PROG(test_raw_tp_null_check_zero_off, struct sk_buff *skb)
+{
+	asm volatile (
+		"r1 = *(u64 *)(r1 +0);			\
+		 r0 = r1;				\
+		 r2 = 0;				\
+		 r0 += 8;				\
+		 if r1 == 0 goto jmp;			\
+		 r2 = r0;				\
+		 *(u64 *)(r2 +0) = r2;			\
+		 jmp:					"
+		::
+		: __clobber_all
+	);
+	return 0;
+}
+
+/* r2 with offset is checked, which marks r1 with off=0 as non-NULL */
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+__failure
+__msg("3: (07) r2 += 8                       ; R2_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("4: (15) if r2 == 0x0 goto pc+2        ; R2_w=trusted_ptr_or_null_sk_buff(id=2,off=8)")
+__msg("5: (bf) r1 = r1                       ; R1_w=trusted_ptr_sk_buff()")
+int BPF_PROG(test_raw_tp_null_copy_check_with_off, struct sk_buff *skb)
+{
+	asm volatile (
+		"r1 = *(u64 *)(r1 +0);			\
+		 r2 = r1;				\
+		 r3 = 0;				\
+		 r2 += 8;				\
+		 if r2 == 0 goto jmp2;			\
+		 r1 = r1;				\
+		 *(u64 *)(r3 +0) = r3;			\
+		 jmp2:					"
+		::
+		: __clobber_all
+	);
+	return 0;
+}
+
+/* Ensure id's are incremented everytime things are checked.. */
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+__failure
+__msg("2: (07) r0 += 8                       ; R0_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
+__msg("3: (15) if r0 == 0x0 goto pc+4        ; R0_w=trusted_ptr_or_null_sk_buff(id=2,off=8)")
+__msg("4: (15) if r0 == 0x0 goto pc+3        ; R0_w=trusted_ptr_or_null_sk_buff(id=4,off=8)")
+__msg("5: (15) if r0 == 0x0 goto pc+2        ; R0_w=trusted_ptr_or_null_sk_buff(id=6,off=8)")
+__msg("6: (bf) r2 = r0                       ; R0_w=trusted_ptr_or_null_sk_buff(id=6,off=8)")
+int BPF_PROG(test_raw_tp_check_with_off, struct sk_buff *skb)
+{
+	asm volatile (
+		"r1 = *(u64 *)(r1 +0);			\
+		 r0 = r1;				\
+		 r0 += 8;				\
+		 if r0 == 0 goto jmp3;			\
+		 if r0 == 0 goto jmp3;			\
+		 if r0 == 0 goto jmp3;			\
+		 r2 = r0;				\
+		 *(u64 *)(r2 +0) = r2;			\
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


