Return-Path: <bpf+bounces-46286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43499E7533
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08ABF16A03A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621820DD54;
	Fri,  6 Dec 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neQ1RRQ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA520DD4C
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501463; cv=none; b=hS5BbU6xCgaGoTa55TeXp/Iq44h0ivwKNXWm/AUigRJNsmo9hITkmorlR5FaxiZ6P/Raww4+BqPQ4AU58CGJBaGoedfYbXwua7qOpIhlf4yhNa/OAk1dWe6vnbo4jnjKZDF+yKwKBizr6R4prsTRuhtQyII6clxj56PTX/ZCtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501463; c=relaxed/simple;
	bh=Dmxgr9Zprr6o8ots4z4nEH9kLIYlwLIvMSD6KoW9yd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4oqQwJiUmn4sXBEPCqVQc9brYXD/oHHJf9LzvT/vGrrwVFGs47Vo34jL/y+4qdm2AzQ6+9tgxgJJ8qYiQxbQaT2NC1ItDQEC0PvHFjF3xKxnylYn9Sj9gR7KqeDdwqRBAAQC0QU5hfZ0FbKQUAJ4DWoQL/0maGRsokLwbSDLSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neQ1RRQ4; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434a766b475so22061575e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501460; x=1734106260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HYDjW5kcuCcfipQTXjI09EcsauY2j6npMJPJ/1WDmg=;
        b=neQ1RRQ4WD1nYgIvy7fBCAsgv6vPtWVAz6vKvlf/qY9rfx880+HASKP60RvFmLAGxh
         j44jQIbOcK0ClazqjWGra/J1V6ttlYqi0n0pCqIYBgmOgITMNDJFAC7srcHon6s2y+Ji
         k0PeLNg58s9dW0txsxoJRQCtXxhLw8AQQ72oTQ1qdphSg8iRM72HsfnKtcnLFYLVWvqr
         0cHhxTaC35wyzQn1tMos0/BdYG973XG2KXwbq9//snDRzQ+MuLXJkKLMhmeS+HtfOCci
         l97hO13x3q7wCNPa+BjzT1yUo8x1p97UM0bjZw7xBpyr3VUYfcl7Tj4xBUvi55epHXVA
         ZEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501460; x=1734106260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HYDjW5kcuCcfipQTXjI09EcsauY2j6npMJPJ/1WDmg=;
        b=WLxNC/8Buo0lp5jEa4ZBwlprqW+evYuejIWbG2d5JAdH3JavnecDK+q6sbL0RQ37DF
         xwEx7iEEM4RjaDk4VnKmLfwpsHkC1tapx5CggYQl1eWlUcu3QBcet/GpPy9CHcK0XRVD
         nL1yUJTw6pHQfd4mDcxwUeJFEQK16bMebtin6OMb6+RG85M00DAqVM8eC3y4PWIgsGhf
         2lDNO00OJ1/eL0FqaPuOuXt3G5onCHDjeugDy7IwmZqcKFQx+u20twD4iPQFKWOmRTV7
         qFU+CVU699g8rjM+tpZT0O8s5c8ojodfyRIz8YXKq42jW2smFJmFlRt3FkOMDdm9KfxM
         DR/w==
X-Gm-Message-State: AOJu0YxSAS74Q+nheN/79tJbZ6Wh0c0InD0iN8ZJbWwT/8u07AUXYhe6
	UlwSJma1/ByI22POqtxBpEwHhQLjw3+ncAGXVPP7q7uH2/OeDu3194s+1XSUk8s=
X-Gm-Gg: ASbGncsYng5f5pQod9+xJ/uweavVz5Y5zSNQ4rZHtFPEM4o6/VvtOa1FaOoSBOMh/FP
	QZ7SIqi3/yxGcoL0Lbq0PB1xa4IiJNA47Ed9E/Z8pdj4JY3XyRImTIQ81hfGp2EiXAb0YUvqWPD
	jiI2b/kF9HkJTfxSFtEdlb30wFzqs1Xu6dUajgLD/TdLBlHcWj06HZKqZ6UMKRHzsilukVM66tY
	X3fQmVZtmaZ9sWgHlWUDkzVjCnH88mdxJ11EvwHbYm7JsQPoYXOeHQCu9h4NDz8uCS5w8HHSMxN
	mQ==
X-Google-Smtp-Source: AGHT+IF5tMtLL8GelH+5L4jipK8XQObMUHFmRAMPaAyPXzy2VRQvtqDKm+9sYGCUILx/XuEqjjDkvw==
X-Received: by 2002:a05:600c:5107:b0:434:a1d3:a306 with SMTP id 5b1f17b1804b1-434ddead1c5mr31540805e9.5.1733501459923;
        Fri, 06 Dec 2024 08:10:59 -0800 (PST)
Received: from localhost (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5281229sm97942455e9.26.2024.12.06.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:10:59 -0800 (PST)
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
Subject: [PATCH bpf v3 3/3] selftests/bpf: Add raw_tp tests for PTR_MAYBE_NULL marking
Date: Fri,  6 Dec 2024 08:10:53 -0800
Message-ID: <20241206161053.809580-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206161053.809580-1-memxor@gmail.com>
References: <20241206161053.809580-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652; h=from:subject; bh=Dmxgr9Zprr6o8ots4z4nEH9kLIYlwLIvMSD6KoW9yd4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnUyEssYcAlbxXQANgEod+HV8ecW/r5qGAJYH2HGhW e7ooEQGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1MhLAAKCRBM4MiGSL8RytQgD/ 9EWl20jfS7lnaUU56KySs6U+BfIVO7I83eqC7iCkzZDNfqlTfYkiq9khMh1BLne68XVGQ2pNLp8CN/ OXnqRfZcKSIg7B3QsFndJm/trOkd/M0vddo+RufrrHULtRPv5908akLcL6kAUqpVE09gQC+A97XQpc qhhLYW6Io9emGHHyDMxaVhtCNgseJjzwDdtdfebu/VtUhA2aQQOH1LQ+3zBiAQMQ8TfVHzA+61Wtx1 R8KQnH0FmQvQk4Kx9hVE9Sv2X7Wg/EzYvcxsD0qbTm2i7ahj0J/qpLxB0jjlmfrWBUSbOH/Mz33lLM +4n39RhRql15qYnnMygASRXulXha6b8/84eSCNFbRGtcGQIXtnqvMaqmWGIwMStGZU8XD7lOTqfm2E enBqVa8FcR2rcM8Z29HvOJTv7s5R8/oFGcoUgSRoJDsYf5Elo6DVOvC9WnnFBXcvlYf52HSuG3zb5p jxLQ3iIk4LJpvsuFWkl340YFI420MEYOFpP7t0J0pqsUnxJFD/iYRzIlfx48GQXJ1zkW0EIDHkNDBo AoYtPyKE4DxVCKLJLVQ59CWHYGKJVwRhfEXcxBYm/PQ7eWTkFOpsVyHXQ8KpI8iLg78o2Wkir8i4sd jtx5ipULTrhmaZJ9mV7a488NhRcyjv3KOGNqfoTg2irXB/QOEnea9rTWpQPg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that pointers with off != 0 are never unmarked as PTR_MAYBE_NULL
when doing NULL checks, while pointers that have off == 0 continue to
get unmarked and propagate unmarking to all other registers sharing id.
Lastly, ensure that in the path where pointer is NULL, the unmarking is
not performed for any registers sharing the same id.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  6 ++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 90 +++++++++++++++++++
 2 files changed, 96 insertions(+)
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
index 000000000000..a87f25ee61ff
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -0,0 +1,90 @@
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
+__msg("4: (15) if r1 == 0x0 goto pc+4        ; R1_w=trusted_ptr_sk_buff()")
+__msg("5: (bf) r2 = r0                       ; R0_w=trusted_ptr_sk_buff(off=8)")
+/* For the path where we saw r1 as != NULL, we will see this state */
+__msg("6: (79) r2 = *(u64 *)(r1 +0)          ; R1_w=trusted_ptr_sk_buff()")
+/* In the NULL path, ensure registers are not marked as scalar */
+/* For the path where we saw r1 as NULL, we will see this state */
+__msg("from 4 to 9: R0=trusted_ptr_or_null_sk_buff(id=1,off=8) R1=trusted_ptr_or_null_sk_buff(id=1)")
+__msg("9: (79) r2 = *(u64 *)(r1 +0)          ; R1=trusted_ptr_or_null_sk_buff(id=1)")
+int BPF_PROG(test_raw_tp_null_check_zero_off, struct sk_buff *skb)
+{
+	asm volatile (
+		"r1 = *(u64 *)(r1 +0);			\
+		 r0 = r1;				\
+		 r2 = 0;				\
+		 r0 += 8;				\
+		 if r1 == 0 goto jmp;			\
+		 r2 = r0;				\
+		 r2 = *(u64 *)(r1 +0);			\
+		 r0 = 0;				\
+		 exit;					\
+		 jmp:					\
+		 r2 = *(u64 *)(r1 +0)"
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


