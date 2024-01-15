Return-Path: <bpf+bounces-19523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101AD82D4F7
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 09:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F9D1F219B6
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323707475;
	Mon, 15 Jan 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxcb6PBK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446806FAE;
	Mon, 15 Jan 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso14061785e9.3;
        Mon, 15 Jan 2024 00:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705306837; x=1705911637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPEUBbd6YyFY5XpshsB4nRVGBOt6Lh2x1n9bnlaCTB0=;
        b=Yxcb6PBKNeG8ktKUZfVHXVwiiy9NViRd6c3CtIXUkZRWzU5dSRD7fZXNrM3T6/CsdD
         CCGcTi8p26xgRxfKSyA//NePTg1qN2Ug8zsx0C14EnnbvliDuk4fGFS3TCTDAUh4JAdB
         qmBxHRKnEq0fU9GgmVx6sI/aMPyEughudux9CvxJjmo3zV636aH7QVuYelRncu6oFlH2
         SLje4/YoHJJXwU87tAvSqCxXbULCxXdRfiuVD/bN1XRNsp+UU94EItGqXRtQjaJn9ZEY
         tGP9io52loXi75nE0UWuUW6XYZI5OhK9JSo0sGnvIrK3jEmQ9fctox6wlvvxTUxAcvNY
         EZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306837; x=1705911637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPEUBbd6YyFY5XpshsB4nRVGBOt6Lh2x1n9bnlaCTB0=;
        b=VQ8nuG+KoZH50J4Zvwl0o/6RuXgrruHR+n/hyOWv952iEeFw9XRnj67fRA9C3IO4qN
         kgONxWt/cUO8b7zFpiWUn2evbY2KhUlrUdIV9SCUgVqEdjbLwjp0/asW3mdL1vQnALzb
         hrlMYSoY4dLSvn8WI5HxleEYI/35qLOkpHgtqrHcwmqhNMHxruMm3/bK+R5JRhH0JJYC
         myL48UEpW6gepeZrLNaO7pBKVc+2EWTiuqhCEZO9pOt2YTso07zss21c6y69l1zhF4lt
         viwZ+DKjHKX+pX2EBm6QBRdDCajUphUjZN32eQg0282ioDcv2wGsVBtKVMnXgslqqJ9a
         2MGQ==
X-Gm-Message-State: AOJu0Ywt22ZcVh76/T6mF0CtCCM7W5CgbgPrmnAw0nqvTqbGPr250bLQ
	BZlxQbZzCtSlbttQ3Y8oFsXP9szSkQ==
X-Google-Smtp-Source: AGHT+IHtupY3BThxNfDZY5xZCItDpyEGHgdJeJnGq9MuDhEU1VfnfnmD47+LQJ4Q89BTUm6IH2UrhQ==
X-Received: by 2002:a05:600c:4292:b0:40d:3b0a:6edb with SMTP id v18-20020a05600c429200b0040d3b0a6edbmr1856776wmc.183.1705306837028;
        Mon, 15 Jan 2024 00:20:37 -0800 (PST)
Received: from staff-net-cx-3510.intern.ethz.ch (2001-67c-10ec-5784-8000--16b.net6.ethz.ch. [2001:67c:10ec:5784:8000::16b])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040e47dc2e8fsm14981194wmq.6.2024.01.15.00.20.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jan 2024 00:20:36 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: willemb@google.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH v4 2/2] selftests/bpf: Add test for alu on PTR_TO_FLOW_KEYS
Date: Mon, 15 Jan 2024 09:20:28 +0100
Message-ID: <20240115082028.9992-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115082028.9992-1-sunhao.th@gmail.com>
References: <20240115082028.9992-1-sunhao.th@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for PTR_TO_FLOW_KEYS alu. Testing if alu with
variable offset on flow_keys is rejected.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 .../bpf/progs/verifier_value_illegal_alu.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 71814a753216..a9ab37d3b9e2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -146,4 +146,23 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("flow_dissector")
+__description("flow_keys illegal alu op with variable offset")
+__failure __msg("R7 pointer arithmetic on flow_keys prohibited")
+__naked void flow_keys_illegal_variable_offset_alu(void)
+{
+	asm volatile("					\
+	r6 = r1;					\
+	r7 = *(u64*)(r6 + %[flow_keys_off]);		\
+	r8 = 8;						\
+	r8 /= 1;					\
+	r8 &= 8;					\
+	r7 += r8;					\
+	r0 = *(u64*)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


