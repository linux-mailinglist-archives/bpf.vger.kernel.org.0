Return-Path: <bpf+bounces-3270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B614473B9BE
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87DF1C2126C
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19682BE52;
	Fri, 23 Jun 2023 14:16:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EFAD42
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:26 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D831FE3;
	Fri, 23 Jun 2023 07:16:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666edfc50deso546391b3a.0;
        Fri, 23 Jun 2023 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529785; x=1690121785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyYbQyqyiVM9g5n2rww2bISilT8aqkXPzSI5XyPezvE=;
        b=rc4C3ccfx0jwfetoVqdJtQiE1K+Bj6ap+X+TfgvxuOXVg1tRGjttnP4T2olJOa5hKm
         2mCK0RnFB1HbBD/Yc00jlCFh8ANdNB31ru1xcfL9sfm47/TtcCKyIXKkHwSeLV3q/kg8
         ydT1UgZ2lxdPBXI59AYStUdC6jCY70y6w2x8qCPc7qZ4M/pb6junIiUVQ4y2XmHrjWvo
         LSIUs7TVPp4u8CZ1BFn35gmLgslHR1RqEeovtkMZpZBIcg7LDHx5qjEADscHBnvPN6Ym
         o3GUz9Z+F3480hGU144fc3e2Xo1yH/8fWYR/jLfaEVlZsaIqkxkJSK45L4qJi6ohkiYh
         ITjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529785; x=1690121785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyYbQyqyiVM9g5n2rww2bISilT8aqkXPzSI5XyPezvE=;
        b=H/2a+tGJQ8npukiVs5FOarT+i3bt16+rTR+526nLFWQpGS1uOqQUJwuRhFCplYdQE4
         rIYUI145ERFTjw81Pn/EEq+INvCZZSL+0CSCUTydp4Mv6ZKl5ivPUs6vQWEYYfvJSTgv
         TW2LMfY0o+vl0gk3b+9BEMtR020EC7YKLWgdzJifH4U2rXMsmmTG6+KW1dUMV4t+JszE
         +jGkd77vwW5phyUM8R82KkU9JXedjG+BcIYWNJCJlHkTqIGFn+eJWFdROvdoi4thdq9E
         SoFDUG8DAUGATPWyGezmVT2UvBDBSABjxBx9a7E5UwU/0Y5fWySq0R8oa+k6tfMDETrJ
         ZjgA==
X-Gm-Message-State: AC+VfDzSREgnOK3w9L9By3HTXiuWWVkWDqM1yyhs9uHYdzO3pGKIMRxb
	wf67Lc7tqWMHe9lQG4zABeQ=
X-Google-Smtp-Source: ACHHUZ4oOBkCzl13+tx5iOSJz7xToUEBctfORkjSC7M6BiBU+LQQrZS3eeccQiFD8jdE6zKiMCw+NA==
X-Received: by 2002:a05:6a20:a122:b0:103:7b36:f21 with SMTP id q34-20020a056a20a12200b001037b360f21mr36271012pzk.21.1687529785347;
        Fri, 23 Jun 2023 07:16:25 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:24 -0700 (PDT)
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
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 06/11] bpf: Expose symbol's respective address
Date: Fri, 23 Jun 2023 14:15:41 +0000
Message-Id: <20230623141546.3751-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
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
 kernel/trace/trace_kprobe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e4554db..17e1729 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1547,15 +1547,15 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	if (tk->symbol) {
 		*symbol = tk->symbol;
 		*probe_offset = tk->rp.kp.offset;
-		*probe_addr = 0;
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		if (kallsyms_show_value(current_cred()))
-			*probe_addr = (unsigned long)tk->rp.kp.addr;
-		else
-			*probe_addr = 0;
 	}
+
+	if (kallsyms_show_value(current_cred()))
+		*probe_addr = (unsigned long)tk->rp.kp.addr;
+	else
+		*probe_addr = 0;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
-- 
1.8.3.1


