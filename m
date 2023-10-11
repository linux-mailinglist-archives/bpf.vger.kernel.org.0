Return-Path: <bpf+bounces-11872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE61A7C4DEF
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253541C20CFE
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A31A711;
	Wed, 11 Oct 2023 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfcG6iAn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D91A71B
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:01:16 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3FBA;
	Wed, 11 Oct 2023 02:01:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405505b07dfso4056945e9.0;
        Wed, 11 Oct 2023 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697014872; x=1697619672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tEQZWkPMfvY8acdWT7VPDJUfmSEGoci9vBUKo7ObaE=;
        b=nfcG6iAnCzPaWTSXUNHeDJFtqqLEuZdb46vV2DQxJRq2eMTBDoaGQ+sPAeU4HAaXRj
         s+yRxZJb/a0ivGfiv0nhdzoDGLKac2XCdQB5ZEQyTHiuMUu4hECIbhTsiK9ZRkwePs1B
         JR2AksDhUNR0nYty/6eubhSFqZmmpPbRvqOZ0/l7P3Cn+0/M9ibXjGOXrFpjFGTfi6Eg
         ecWsgv4v+L/hwcopbgQZqFKmvlPBS5fIHafwuOgVO/uSrWKwFJntCdoQBJWJnuwtkTdq
         G7fmrUYhmkyt+6eO6Xt9DccqbcmLnN8hYXn8fXjfLza+p5dkkT2NWElPJ8e5y/nQpwv4
         RBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014872; x=1697619672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tEQZWkPMfvY8acdWT7VPDJUfmSEGoci9vBUKo7ObaE=;
        b=kILZAFsopc9q1ZQ9hDM1A1HPRJzZV4kfW96AJoS48uXrAVijkkZ1kaNqn3SB15tTyM
         EgehJIVF8J5EjvcNFGjZTfU6o+xs2D4SyzyVf6JJ0gcTtbVxMIr7G0Wu/vsCE7UsN8hn
         Q+c2S1SVZ/RRazCFxUwIRQ/Ya2HBXVERwdjzGpipo12LxLKS4eRbwxHrvQsMhVqUby+a
         ReyhCmhiPWsdOq/eUNl9apY8KdbpLdm9FVsrL0bnwdIbuMheviU8VIBIV70vDe396oHG
         Oadda/M5vSvvPsjn8mABwVSR/s9JMf8NrkcFutS4GuLV5KFXCPZz/e47d1/q5qpYQO8t
         sQ9Q==
X-Gm-Message-State: AOJu0YwycjKj8a9Y1ytjz1gLskelG4PD2vUmFGbPxGPFNw+mxzVg7gnS
	EddOxmnP7ruYWtNwMB8OTQ==
X-Google-Smtp-Source: AGHT+IGWN88l8oaPPpQ7BQpJJq6TGBCRSaAHVnSsNnsZI3/v9fmaV1VtaQc2MNeNwoLK+mR1pTdeAA==
X-Received: by 2002:a5d:6048:0:b0:320:6d6:315b with SMTP id j8-20020a5d6048000000b0032006d6315bmr15353783wrt.29.1697014871970;
        Wed, 11 Oct 2023 02:01:11 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b0032d892e70b4sm554100wra.37.2023.10.11.02.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:01:11 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 11 Oct 2023 11:00:14 +0200
Subject: [PATCH bpf-next v3 3/3] bpf: Adapt and add tests for detecting
 jump to reserved code
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-jmp-into-reserved-fields-v3-3-97d2aa979788@gmail.com>
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
In-Reply-To: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hao Sun <sunhao.th@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697014868; l=1323;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=N0h3pju8Lq5TulbCouToc5niZOBTvwsgt1HbEhNoYvI=;
 b=G/m6j8CrPTnWXF8rupUB1VRJ4E/DsmpanWHsgShBwpKp3EVcWmiQx2xJE5Xh6W2yssJPankl4
 aJ8gXFa84KLCxp+hU3VUCv05Fuyb12wZJNbYgRCwVsjBwaOQp0QXrOI
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adapt errstr of existing tests to make them pass, and add a new case
to test backward jump to reserved code.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 tools/testing/selftests/bpf/verifier/ld_imm64.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index f9297900cea6..aa3ada0062d9 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -9,8 +9,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid BPF_LD_IMM insn",
-	.errstr_unpriv = "R1 pointer comparison",
+	.errstr = "jump to reserved code",
 	.result = REJECT,
 },
 {
@@ -23,8 +22,7 @@
 	BPF_LD_IMM64(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid BPF_LD_IMM insn",
-	.errstr_unpriv = "R1 pointer comparison",
+	.errstr = "jump to reserved code",
 	.result = REJECT,
 },
 {
@@ -144,3 +142,13 @@
 	.errstr = "unrecognized bpf_ld_imm64 insn",
 	.result = REJECT,
 },
+{
+	"test15 ld_imm64",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -2),
+	BPF_EXIT_INSN(),
+	},
+	.errstr = "jump to reserved code",
+	.result = REJECT,
+},

-- 
2.34.1


