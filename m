Return-Path: <bpf+bounces-2200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3761728EF8
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 06:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0AD1C210D8
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 04:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1215BA;
	Fri,  9 Jun 2023 04:32:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2FB15AC
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 04:32:53 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51230E5
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 21:32:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb397723627so1725478276.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686285170; x=1688877170;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDlEfBbym2UKOdEUfGTXbXJzggygNVLpeRONZtrZ238=;
        b=Pg+v1RbQTeV1POXuMbh477bKylMdkWdHTGsodk4EDgoVrGTXB+9d1pkhl9ukNceJmA
         FksFheCI47sJraF7JPBk9V8uBY7xCCbVkNAl7rhr5C8D0/lnathSsti96EREsm9cppsb
         pj6eUxHTL0jvRSwzbzCwkCxeP7RB+lUn1J6iowaRI2p2Llu1JbVSjeuw2N0Uvglz/KOv
         Nq+5hDen91mprjzq+aDBmSVSgotOvMugb5b3r1itTJiZHp96ujZGFGSluiZXF488Swfk
         i4p/SITRNaZ3HHhn7cgGGI10j2A6YH7SdU6kd8kTbGqh9FZw4rYcIW+nF7DcYebAMp2E
         69jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285170; x=1688877170;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDlEfBbym2UKOdEUfGTXbXJzggygNVLpeRONZtrZ238=;
        b=MZuNytgzFDPIhVYcX9WNiWjawgNjVQ8c30F2T1wCQmSqlefH33KGoAPa4g9lws4E2Q
         rai8lMGKNVc/RDyQwqMvzzdR5NFhXx4hdTLyrid9fwbHZxR0OhI3N/iOtHXb/xFtKA+g
         xe33c5sZkaMwOTuzFcWTu/BV9gapa+6CVvHBH+2SYBL1/wiiCbHMGHEw50NCDWzSUKnQ
         PBcnUct1ypDoFlKaHD4LA8BixZH79w/yow0tKR1ykuJwJSi8hwhHp8g4qeYkFS9V5mSG
         bgMNfamxqvVxy6zj8lYeyoWDh06LWJVbtT46T0GinykKrLmd7QBPICLhVgXXGeLYP873
         NL8w==
X-Gm-Message-State: AC+VfDwMifPUflZHbWOEIEH1ZaNV90AZXw1Czc/WfargBx9urdQR4gdD
	5xA5gBS3LE6VAjLmyEQf3QeLz1bJ0ltQ
X-Google-Smtp-Source: ACHHUZ4uF6M9FeGQA6l0x9G2cxJ5uV2EoAKqpKuH9AtgS+wd2HjYaLsgrqwd5uVhIWH+AKWyfwyfocyOJGkH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:fc24:0:b0:ba8:6148:4300 with SMTP id
 v36-20020a25fc24000000b00ba861484300mr65057ybd.6.1686285170622; Thu, 08 Jun
 2023 21:32:50 -0700 (PDT)
Date: Thu,  8 Jun 2023 21:32:38 -0700
In-Reply-To: <20230609043240.43890-1-irogers@google.com>
Message-Id: <20230609043240.43890-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230609043240.43890-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 2/4] perf bpf: Move the declaration of struct rq
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

struct rq is defined in vmlinux.h when the vmlinux.h is generated,
this causes a redefinition failure if it is declared in
lock_contention.bpf.c. Move the definition to vmlinux.h for
consistency with the generated version.

Fixes: 760ebc45746b ("perf lock contention: Add empty 'struct rq' to satisfy libbpf 'runqueue' type verification")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c |  2 --
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h     | 10 ++++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 1d48226ae75d..8d3cfbb3cc65 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -416,8 +416,6 @@ int contention_end(u64 *ctx)
 	return 0;
 }
 
-struct rq {};
-
 extern struct rq runqueues __ksym;
 
 struct rq___old {
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index c7ed51b0c1ef..ab84a6e1da5e 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -171,4 +171,14 @@ struct bpf_perf_event_data_kern {
 	struct perf_sample_data *data;
 	struct perf_event	*event;
 } __attribute__((preserve_access_index));
+
+/*
+ * If 'struct rq' isn't defined for lock_contention.bpf.c, for the sake of
+ * rq___old and rq___new, then the type for the 'runqueue' variable ends up
+ * being a forward declaration (BTF_KIND_FWD) while the kernel has it defined
+ * (BTF_KIND_STRUCT). The definition appears in vmlinux.h rather than
+ * lock_contention.bpf.c for consistency with a generated vmlinux.h.
+ */
+struct rq {};
+
 #endif // __VMLINUX_H
-- 
2.41.0.162.gfafddb0af9-goog


