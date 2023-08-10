Return-Path: <bpf+bounces-7434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9C777294
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 10:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DFA1C21305
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744F91DDED;
	Thu, 10 Aug 2023 08:13:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292C1ADE8
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 08:13:42 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3D211E
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so449280b3a.2
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655221; x=1692260021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR96duwMScqqE4Do/jU3bN4CcpYhg3nXfWXt6kcMass=;
        b=TXdsabfFDEPwwJuaGZzBTo8pU4vepokuZPrymTlMQv1CvvfMKgCU29jA0QwH6nWuD0
         gznXsPzuwLjEwlDK0vi+3+2uRxC1XMbW+lp+jWxIiLx3wBIpH31hYECAny9GNhrdQoBp
         fQwpX0cY+EOzJNEIbOPRRsH7MYAIzMIZor3623Qqkm1xdI1C87niDDFOIeGXXw9YKZKm
         brvKjzr+H6AxlWG+iqKS93izG5cWAN1ArPQzOhLyXud37OGWuLg4IpUu1Ebn7x3jQUuM
         TpKXPVzkIRw4vQlWHA/ApQtbsInEvHS24H7J3wHllzsOpLmActmt8abO0eoPurB7QaOk
         svQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655221; x=1692260021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR96duwMScqqE4Do/jU3bN4CcpYhg3nXfWXt6kcMass=;
        b=O6H1lwqLLNqoI5iLt1EOXU5T/uxnt8S1VLPOA5v2aK1wyd2en+KS4Utci4NqkmD5AY
         sjHneRzIdijNFFbN1IG1ryg9JeR/XbbdSJDGJ4rPfkgskRVQzxuOcaPdzcrKg80085Ur
         7IKrcXLxiNkqydc6iqrbA5PzfryNUj6f9Bx7MzagDlR3qdJ5Txy3tkE/fBdjahwbFEiZ
         b8CTVGQJoYDmV0FqHP2UEN0r+NN3zXDG6sVWtKhei9pOeOg8PsQJiet8ASVYJP4Dwid7
         rpCUBOXSYFzF31mx0NysMUF3Xm1WsmuUn5CnkAJ4i9o9S103bXrzjP0v40Lw0RJqRX+l
         DFow==
X-Gm-Message-State: AOJu0YyNKQCayL+WCA7IcosbFFqaTJedCCR1AWYwe1GnoNzDhSpqUxYP
	Di5XbySyUjPfvlU9baIl/wxfmg==
X-Google-Smtp-Source: AGHT+IGLxHS6Efr09r8Fx5K71xSslYVl/sG2ni7ae6H65/+PX1fMA8cicT8FgwPTgOcMbX17lAwmtQ==
X-Received: by 2002:a05:6a20:1387:b0:13d:af0e:4ee5 with SMTP id hn7-20020a056a20138700b0013daf0e4ee5mr1482972pzc.18.1691655220823;
        Thu, 10 Aug 2023 01:13:40 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:40 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	muchun.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC PATCH v2 3/5] mm: Add a tracepoint when OOM victim selection is failed
Date: Thu, 10 Aug 2023 16:13:17 +0800
Message-Id: <20230810081319.65668-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810081319.65668-1-zhouchuyi@bytedance.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch add a tracepoint to mark the scenario where nothing was
chosen for OOM killer. This would allow BPF programs to catch the fact
that the BPF OOM policy didn't work well.

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/trace/events/oom.h | 18 ++++++++++++++++++
 mm/oom_kill.c              |  1 +
 2 files changed, 19 insertions(+)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..b6ae1134229c 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -6,6 +6,7 @@
 #define _TRACE_OOM_H
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
+#include <linux/oom.h>
 
 TRACE_EVENT(oom_score_adj_update,
 
@@ -151,6 +152,23 @@ TRACE_EVENT(skip_task_reaping,
 	TP_printk("pid=%d", __entry->pid)
 );
 
+TRACE_EVENT(select_bad_process_end,
+
+	TP_PROTO(struct oom_control *oc),
+
+	TP_ARGS(oc),
+
+	TP_STRUCT__entry(
+		__array(char, policy_name, POLICY_NAME_LEN)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->policy_name, oc->policy_name, POLICY_NAME_LEN);
+	),
+
+	TP_printk("policy_name=%s", __entry->policy_name)
+);
+
 #ifdef CONFIG_COMPACTION
 TRACE_EVENT(compact_retry,
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3239dcdba4d7..af40a1b750fa 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1235,6 +1235,7 @@ bool out_of_memory(struct oom_control *oc)
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
+		trace_select_bad_process_end(oc);
 		dump_header(oc, NULL);
 		pr_warn("Out of memory and no killable processes...\n");
 		/*
-- 
2.20.1


