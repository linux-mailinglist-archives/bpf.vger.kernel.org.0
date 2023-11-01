Return-Path: <bpf+bounces-13800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B627DE0D8
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 13:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA901C20DD4
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F417C11CB7;
	Wed,  1 Nov 2023 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltM61i4f"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215E1C30
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 12:34:05 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A58102;
	Wed,  1 Nov 2023 05:34:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50930f126b1so2599142e87.3;
        Wed, 01 Nov 2023 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698842042; x=1699446842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9Pg+WxBX7vVh8/93O1aJ08ibN1FlpxRcOHpc2+Gdpw=;
        b=ltM61i4fimw0ZVsKQFv6OCcJFxHluZEYZLk+Fw4nglPa9ZFnCB4fklag9KxeqLvxu4
         0n3WvJUeasDI8VDC1Ecj4XzsQu28uTuMiuGBwDGFihYIkMbHFLckZ2D6O0RC7DeDuXfp
         PV833CDxdpEQS/QW9XwtU9fQfUFnB/DJuxEbYfPLv9rAjUvbiLEd4+AHbp3CkpLycy/o
         hO0tQVjgxvJ7KgcOt/p8hEZQPeQWain98xWKkOaX2FPpWPwyNur7+oXNGDkcPiSagnSs
         IQtSlce1FexN7Ta5Ujt/oJZ1m/py9gs1fZvcOdY8u6ZuaHa6TAxdMMq5O2la0eylEwif
         2PEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698842042; x=1699446842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9Pg+WxBX7vVh8/93O1aJ08ibN1FlpxRcOHpc2+Gdpw=;
        b=jzXElyPFLhZwO36G6pjg+yf8T/o8I3YmDwdVQEqpRi1Q2nw4ibZncb7nATjxjCTv6J
         G0gJgOrxRKZSmfZwvUAYQELjYXkf89ChLBHQjTo7K1ih6vgUvrCrHE8bRpI25fQ85vMM
         mcSgGxOHfwl8tDyMMGFgfF02cbQYNXh7XEiiPfyROyXnwBeVPHzQnJE5MOcIehuGS2gt
         FZBlAt71WanmMg70us7GezGt+9VN/5eZk0Jp9kl7aUQuQJhchTBlDPAgDxKqhD/u1LCF
         Jtl/j5pDKGWMQfS1ko8FiPIrGdZxLEDj2qnh9XszmOaYWt8+JKtPDRazR7x3BCrLO6NT
         vN3g==
X-Gm-Message-State: AOJu0YzACMhzXDM8QWilffGWy2hEokVVTSQhYOaZAWOF1oSRvfKdBz+t
	QSpdRZh1jCJYvXJVZmftp7vUT1dBzA==
X-Google-Smtp-Source: AGHT+IEseOnw9uSRtsItY9jjieq5eLKwN1URM75IvkeXpVfAapzaf8i3jqxYYID0yAtFkhtoNuFfdg==
X-Received: by 2002:ac2:5a4c:0:b0:4f9:51ac:41eb with SMTP id r12-20020ac25a4c000000b004f951ac41ebmr11108529lfn.16.1698842042115;
        Wed, 01 Nov 2023 05:34:02 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id fk15-20020a05600c0ccf00b0040849ce7116sm1453505wmb.43.2023.11.01.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 05:34:00 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 01 Nov 2023 13:33:52 +0100
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add test for immediate spilled
 to stack
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-fix-check-stack-write-v3-2-f05c2b1473d5@gmail.com>
References: <20231101-fix-check-stack-write-v3-0-f05c2b1473d5@gmail.com>
In-Reply-To: <20231101-fix-check-stack-write-v3-0-f05c2b1473d5@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698842036; l=1559;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=X708/twj4ALP3sH/UCKpd3VcD0BtAnZ51P5Y+lRiPRs=;
 b=++oeE46PI1J1crf5k1aYBSJFGizoKfdmleJvtvCppmRPIRWoLkWYWOgFnuBuvRm0LbN0LU73p
 3GjqBRHyVTzB9WCDwWMoEWvY2xJsO31BC3cO6OBZh0tFUue4GzS0CxR
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=

Add a test to check if the verifier correctly reason about the sign
of an immediate spilled to stack by BPF_ST instruction.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
index 3af2501082b2..b616575c3b00 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
@@ -65,3 +65,35 @@
 	.expected_attach_type = BPF_SK_LOOKUP,
 	.runs = -1,
 },
+{
+	"BPF_ST_MEM stack imm sign",
+	/* Check if verifier correctly reasons about sign of an
+	 * immediate spilled to stack by BPF_ST instruction.
+	 *
+	 *   fp[-8] = -44;
+	 *   r0 = fp[-8];
+	 *   if r0 s< 0 goto ret0;
+	 *   r0 = -1;
+	 *   exit;
+	 * ret0:
+	 *   r0 = 0;
+	 *   exit;
+	 */
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, -44),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, -1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	/* Use prog type that requires return value in range [0, 1] */
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+	.expected_attach_type = BPF_SK_LOOKUP,
+	.result = VERBOSE_ACCEPT,
+	.runs = -1,
+	.errstr = "0: (7a) *(u64 *)(r10 -8) = -44        ; R10=fp0 fp-8_w=-44\
+	2: (c5) if r0 s< 0x0 goto pc+2\
+	R0_w=-44",
+},

-- 
2.34.1


