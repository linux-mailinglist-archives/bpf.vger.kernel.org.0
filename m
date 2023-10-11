Return-Path: <bpf+bounces-11871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013557C4DEE
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E431C20F5B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290CB1A71C;
	Wed, 11 Oct 2023 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZjY6/1M"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246141A70B
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:01:15 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E543DCC;
	Wed, 11 Oct 2023 02:01:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso60949565e9.0;
        Wed, 11 Oct 2023 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697014871; x=1697619671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vbwy1DTa+xrXLdPgkHBhYG7WPtaZiV7ExMS9XxhnwBY=;
        b=EZjY6/1Mid58ezIm0IykbSudocNNeUWwUfIrN5ROBf+GPoiPfQpdl1DUb2+OWoSqNd
         ukGrOqS9KGnenq2T2L8EJJyxQd6c2QXAN89RPWiNiv6AP1jVRvPFHUbT3fAuqft7vozx
         IboRGhyrfDmAwMsIDaxnKBHsi+Y3jzbb4WuOzd2xlTiQKZlUJVTdE2QeF85zlgx1FMHw
         7j8ZQKHOYegd7kXWHDYhxVfIqF3ee/gaL61/GOd5CNHQMbrIkw0Hsi6HnpExk481oJcC
         VCL1syD96wNTxSzqR3YIrEDzM+Hn+CJy660oZq1FtdSKrURGfpWGNnJQ4WWvDbWfoErl
         ALhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014871; x=1697619671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vbwy1DTa+xrXLdPgkHBhYG7WPtaZiV7ExMS9XxhnwBY=;
        b=Sg4qOotVBEY2ES1L/gi/ebtqBwtQ2ecYid9MtCUg9kl3rnJgeragugeNBap/zGPsTv
         CvhPytuZtVt+ynKOKGvEr7Ga89sNVnRqWhGnyk96pE0Vjs0i0n4Su9mlpp3QyyLV/Zv5
         FCuCOSuFz+RXvNqUylz6D0WSYi9vRLZ5JuvZxQ6M/ADl0IaLKw74HWV/5SYzCuWtaYwR
         zPQzgajTqVGTK9ca2C75W34oNLN46szmvBVqK6EOnyV6KFrXjziTjy3kH6TSEsNmJsyX
         8iSuxNYMcM1L0LrbWs8xl6rI4EmEGLVvUAI1ac5VNdIgduXK+B3W4gpxfJmnM1VonxuW
         q3Xw==
X-Gm-Message-State: AOJu0Yzanwjhb/42KvQSzTha79SIMLQoicfbOOUsIUcWXK8HYsjibcYq
	Rryz7bVEbuERqdcgdFHF2w==
X-Google-Smtp-Source: AGHT+IGBBMWQZwDnNe49hCFIW9WBw2gR8WhwdKeWdXPf7JzOoK5hVqLtQiozjPKLwr3vnaczJnotcA==
X-Received: by 2002:a5d:4ccf:0:b0:32d:8183:d130 with SMTP id c15-20020a5d4ccf000000b0032d8183d130mr1919084wrt.38.1697014870955;
        Wed, 11 Oct 2023 02:01:10 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b0032d892e70b4sm554100wra.37.2023.10.11.02.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:01:10 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 11 Oct 2023 11:00:13 +0200
Subject: [PATCH bpf-next v3 2/3] bpf: Report internal error on incorrect
 ld_imm64 in check_ld_imm()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-jmp-into-reserved-fields-v3-2-97d2aa979788@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697014868; l=1218;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=NpK8w4p3AM1Yt2pHCIYFXt2HHedlpqbbEwnK3w779ho=;
 b=Z8LwFU+VSMfCVZLDofhXitGHupOoUYkUAP9EGZDsNsJ8Z/YBcEFwXm+z5A2K4P7h9KLrAeCfD
 8hDC3GMdIRQBrq7pfiXNn+0dZI1DdPVr3QQ2xJU0Ii0TQLMDxkciGnB
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The verifier currently reports "invalid BPF_LD_IMM64 insn" if the size
of ld_imm64 is not BPF_DW. The log is not accurate, bacause we already
have bpf_code_in_insntable() check in resolve_pseudo_idimm64(), which
guarantees the validity of insn code. If the verifier meets an invalid
ld_imm64 in check_ld_imm(), then somewhere else in the verifier must be
wrong. In such case, current log is confusing and does not reflect the
right thing. Therefore, make the verifier report internal error.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 725ac0b464cf..d25838a2c430 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14532,8 +14532,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	int err;
 
 	if (BPF_SIZE(insn->code) != BPF_DW) {
-		verbose(env, "invalid BPF_LD_IMM insn\n");
-		return -EINVAL;
+		verbose(env, "verifier internal error: ld_imm64 size is not BPF_DW\n");
+		return -EFAULT;
 	}
 	if (insn->off != 0) {
 		verbose(env, "BPF_LD_IMM64 uses reserved fields\n");

-- 
2.34.1


