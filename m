Return-Path: <bpf+bounces-1363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D8713A01
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16231C2095F
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE95681;
	Sun, 28 May 2023 14:20:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C09566E
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:40 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109D6BE
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:39 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75cbbb10c69so223635385a.2
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283638; x=1687875638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuzOX4XFKmJOiLjt9d1z+UYL8/sI/TO2hkUeE9dOaVY=;
        b=pIgpfthuhb6Mnhw56ecRXBRcJW7j7c+VluFti7CCeBBkPQnolVzro99n2d2k3q9wVh
         tyfN1xiO5jfi+d+tlbW3+NWekJ7h8Y6xRnAwHEsGPihhN8+9XmYAdNUD/Lt+Aw64Q1so
         rjNhogHoiwaNmmGqUjafIirLMVrYkAdGdG9y2S995F56f+MgPuiIjVSiPa0zR1CBvYQi
         h1ya5fEltpM9yRVCQC88u54zZFmLl9mxKSP2ZNRbZVeASAcsNEUeDX2kfFgFDXGJGEE8
         2bnEv8X+tDuc33kDx/H6paD4ZujvpsnDdLDFm9uFLhSm+o5eqNhewYr3+b9deOA21wki
         AH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283638; x=1687875638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuzOX4XFKmJOiLjt9d1z+UYL8/sI/TO2hkUeE9dOaVY=;
        b=SUdK064vgcLu1EmWVoFFdsgOy5Wtqj+NEfhUueLFGYScI5wJbGpYTHVWADSqSmIRd3
         t8GH4U/8AFJlApG7zpKt+yrIp3bCIArQFtICdx+UCYu7GwSfeOLW9od2dWVgA3JljjT2
         8z8xxmArGEZr4M9jlTI1UhJv/xa0WOSQel0S6FX7W60dgBV8gfYlmNBZwSRCbWgFgYzA
         TNoCs0k06u63xeNnhLKWh10U2MW0DJVa6ffSW3zULNNjK2DZATneGe9Qw/urbMT0Fi5d
         7zB0+aIb/nltHGwgbV5mfbRyEqT4BAPGseGcL5PMvHrm6UqKdj9GltavFFgh/ZyR4H8c
         39fw==
X-Gm-Message-State: AC+VfDzq5NjPKpv4k8TtWKLCu/17ujVJD1EE2nHVLY3aEUd5cxgiBL4C
	+0cBoY3DSGB1EG2vhCRrWTs=
X-Google-Smtp-Source: ACHHUZ57oNNg1hSza9KcPDdCpPFY57VKUIzi+oKQ2Q1nc1sxswNBL2+BbgUC1D47dho3Y4wzplVlfg==
X-Received: by 2002:a05:6214:1c48:b0:619:ca55:9709 with SMTP id if8-20020a0562141c4800b00619ca559709mr8789386qvb.21.1685283638186;
        Sun, 28 May 2023 07:20:38 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:37 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 4/8] bpf: Always expose the probed address
Date: Sun, 28 May 2023 14:20:23 +0000
Message-Id: <20230528142027.5585-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230528142027.5585-1-laoar.shao@gmail.com>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since different symbols can share the same name, it is insufficient to only
expose the symbol name. It is essential to also expose the symbol address
so that users can accurately identify which one is being probed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19..a7a905a 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1547,7 +1547,7 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	if (tk->symbol) {
 		*symbol = tk->symbol;
 		*probe_offset = tk->rp.kp.offset;
-		*probe_addr = 0;
+		*probe_addr = (unsigned long)tk->rp.kp.addr;
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-- 
1.8.3.1


