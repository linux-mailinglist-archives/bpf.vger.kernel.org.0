Return-Path: <bpf+bounces-19322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9518C829AAF
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 13:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205E4B25154
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449E4879E;
	Wed, 10 Jan 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRL6Ncmq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DC4879C;
	Wed, 10 Jan 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3367601a301so3783827f8f.2;
        Wed, 10 Jan 2024 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704891223; x=1705496023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqABKYiwKfM7K5loAH80ReCJ84H8NZ8M9wGBWfUZRzg=;
        b=cRL6NcmqpLBo1TI++VA0idxwRZTzYO4j+NGmUEy/wEiM50wmSHeMZACmRGq8ohI6jl
         F+f0jXIDFj8SB+ZBU2HdQHWVyyS7BLcR/3kU2c8JZd50n6KwaII96f3+TfbtX7JwN2HT
         sL+70i0e2delGzgA+Nm1JJGNFAJbmjzy78pWfIg4YsFWyapbPVH1GdCzAmtgl8+KPPEg
         NH2IAbSPND6KDkNYjbuuCuxeZy6Ynxn72iqheBnuTZao+NmyPau4bgH/1IBDLTTpj2hK
         p3le1iZvmw6yWQYR9IvAtNwptkFEoxty3PSKc70vTQF7ivVhok1Eh3PDjQAd8prNb6Tj
         kgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891223; x=1705496023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqABKYiwKfM7K5loAH80ReCJ84H8NZ8M9wGBWfUZRzg=;
        b=ODcDz6l90DT9sUIWM+CWIfv5s60oqrU1sS0DSKg8q35bNYci5n9JnwfmS5JiPWOMjZ
         YX4Wga9Wo0TJZkZft3N8sdv6jRoxfDB24oVb5Qz1+ecqBMESj8kaP1VOCcckiAeRem6Z
         ekL9ZNioo05MlPSiUe1B0O4jUr8uYUxrO68IpnTSVERdfZ8u/3u5z362wUJeMe/knVyu
         FibDBCe9H4u7yx4cIS6g0KnnDSGYgoVGZGqMkGJYunEIPcBN3r3f0kJ1dj7Xpe5Oz4x0
         LqriRSin1llLZ58VvPL6pjGGl5qSHf4pvjAitBZox/K1eGMmt4Z7Ozjm3Z4YXFAd1rD+
         Xq+Q==
X-Gm-Message-State: AOJu0YxqKswQ0PTsPB3HhsAhr7vzNk51zLzLes9WtSnlp08QfglSup/r
	u9I4D3bK+Llc+XNASlSa+6attHLaeA==
X-Google-Smtp-Source: AGHT+IHZ/cnVzir4rkEaeBH6BGccxR53Y+on+jYdJPd05gA69rsuGWRAVTUjLKRumKnYpWwT3nGpOw==
X-Received: by 2002:a05:600c:46c7:b0:40e:52d7:a951 with SMTP id q7-20020a05600c46c700b0040e52d7a951mr370143wmo.244.1704891222627;
        Wed, 10 Jan 2024 04:53:42 -0800 (PST)
Received: from localhost.localdomain (46-253-188-135.dynamic.monzoon.net. [46.253.188.135])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d524a000000b00336898daceasm4833238wrc.96.2024.01.10.04.53.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jan 2024 04:53:42 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: ppenkov@google.com,
	willemb@google.com,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH v2 2/2] selftests/bpf: Add tests for alu on PTR_TO_FLOW_KEYS
Date: Wed, 10 Jan 2024 13:53:17 +0100
Message-ID: <20240110125317.13742-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110125317.13742-1-sunhao.th@gmail.com>
References: <20240110125317.13742-1-sunhao.th@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two cases for PTR_TO_FLOW_KEYS alu. One for rejecting alu with
variable offset, another for fixed offset.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 .../bpf/progs/verifier_value_illegal_alu.c    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 71814a753216..49089361c98a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -146,4 +146,41 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("flow_dissector")
+__description("flow_keys illegal alu op with variable offset")
+__failure
+__msg("R7 pointer arithmetic on flow_keys prohibited")
+__naked void flow_keys_illegal_variable_offset_alu(void)
+{
+	asm volatile("							\
+	r6 = r1;								\
+	r7 = *(u64*)(r6 + %[flow_keys_off]);	\
+	r8 = 8;									\
+	r8 /= 1;								\
+	r8 &= 8;								\
+	r7 += r8;								\
+	r0 = *(u64*)(r7 + 0);					\
+	exit;									\
+"	:
+	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+SEC("flow_dissector")
+__description("flow_keys valid alu op with fixed offset")
+__success
+__naked void flow_keys_legal_fixed_offset_alu(void)
+{
+	asm volatile("							\
+	r6 = r1;								\
+	r7 = *(u64*)(r6 + %[flow_keys_off]);	\
+	r8 = 8;									\
+	r7 += r8;								\
+	r0 = *(u64*)(r7 + 0);					\
+	exit;									\
+"	:
+	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


