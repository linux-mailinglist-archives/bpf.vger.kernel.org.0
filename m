Return-Path: <bpf+bounces-19458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEE82C2A6
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972C71C21B31
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B196EB73;
	Fri, 12 Jan 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRWvsh33"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163436DD1D;
	Fri, 12 Jan 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so15708465e9.0;
        Fri, 12 Jan 2024 07:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705072839; x=1705677639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I1BW+/RBUVVGnyZE279+XSC+1yYL53hkEdjOLq0rlQ=;
        b=GRWvsh33wZpIViaLre+J5Q0UD0h+Dkag3Ufb2dDXi7TP7tswSqLbOKAbtEeVJEGzbA
         jEzacjDMqGg3sLODNX3nNfFHM/CCBzbF3mkHyTbytiF5uVaFVcO86kbhjUDOIW/rkB6s
         A56XdwCpi31kOy3GeTDShkcxhUYjFyXvjfdmNvlZtj9Gs63jDf7Jj9mI5x3TZ2OiL+D2
         Ma1Wp1Qv+wZAszoC/YR3y/irIuwC0nY8AOn9WbLeIRoVut8MnPfW3o4Y3Fx63RBRZVE3
         2LdInY0rZ0ubjR4jkWd78FTepAqe7lRvMAsd2p32q+qjBOt88TxMVPHrxS65tUc+1O39
         0jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705072839; x=1705677639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I1BW+/RBUVVGnyZE279+XSC+1yYL53hkEdjOLq0rlQ=;
        b=sp1g9WMYXQFaFBIg/0KIFc/R4NkH8XIhgW1xqPSNTa8EMQSoR0NoHdQchhaYZM2NN5
         Excp3mmB2Elkpyc1/vOQzemByLDKZWx3ksnyOc46ZN8Lu2hxP9a/9k0tuF0C1ZSglSt7
         WFJHu9xQQbcmBRXdh0LsfU4PjuUD5ErXEAE41B1GFj53x+AhJR/4KweBOfFjeeLfBUma
         unE3VOZP8GEysV7QFY5PxAgqcqkKdBzHZ2VqxzzorBHU5pUCOigYsu5ykZWM/Zr23B70
         JizuU7akSLtQM9hWFK812LBpcH9/iYbsz41i1idw2poN4uVysD24+B0xymEw6c9povY7
         KGDg==
X-Gm-Message-State: AOJu0Ywh3y3FmvLpAH6SfCKURuOqMpl9P83nZ1g7BZIrTS/FSEikWLUA
	ab46XwqA16Qq/vFLE5tvhgTtviPV1A==
X-Google-Smtp-Source: AGHT+IGr1zqDhYRqrWFI1pYAikt11L8Pkdr9lZRxEgtaDUa0B4kuqiHhVpOn9gjSgTl5fGNkGB37DA==
X-Received: by 2002:a05:600c:45cb:b0:40e:6455:7105 with SMTP id s11-20020a05600c45cb00b0040e64557105mr804945wmo.20.1705072838504;
        Fri, 12 Jan 2024 07:20:38 -0800 (PST)
Received: from staff-net-cx-3510.intern.ethz.ch (2001-67c-10ec-5784-8000--16b.net6.ethz.ch. [2001:67c:10ec:5784:8000::16b])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b0040e4c1b0c14sm10157728wms.34.2024.01.12.07.20.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jan 2024 07:20:38 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: willemb@google.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH v3 2/2] selftests/bpf: Add tests for alu on PTR_TO_FLOW_KEYS
Date: Fri, 12 Jan 2024 16:20:11 +0100
Message-ID: <20240112152011.6264-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112152011.6264-1-sunhao.th@gmail.com>
References: <20240112152011.6264-1-sunhao.th@gmail.com>
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
 .../bpf/progs/verifier_value_illegal_alu.c    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 71814a753216..3bcccb4cbc85 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -146,4 +146,40 @@ l0_%=:	exit;						\
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
+SEC("flow_dissector")
+__description("flow_keys valid alu op with fixed offset")
+__success
+__naked void flow_keys_legal_fixed_offset_alu(void)
+{
+	asm volatile("					\
+	r6 = r1;					\
+	r7 = *(u64*)(r6 + %[flow_keys_off]);		\
+	r8 = 8;						\
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


