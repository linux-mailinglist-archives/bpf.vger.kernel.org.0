Return-Path: <bpf+bounces-1045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52AE70CB63
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9682A1C20BCC
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD86174DE;
	Mon, 22 May 2023 20:41:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E484174CE
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:41:32 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8C94
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 13:41:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8217b3d30so8752822276.2
        for <bpf@vger.kernel.org>; Mon, 22 May 2023 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788090; x=1687380090;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgLToyH0lnEbwO8zhqRrZrm3XuhDqU+MJzbkMRH5C7k=;
        b=K5zoWRcJdhHs4Vn8kI3E4+lDj7GTBugL3Ry0p9774ja90Sj0bOvmnfon6gLnZQPS87
         CLBBLKJX6uT9gNbXzYjCXkoR/Gk1a6A5XeQkK4k+hWThTK8AR4SnzfZf5tPJUF8HQrOx
         liqCS97QVPLwWlATh4pRcEDCGSXPYAlZ4XTm6aYYOj1rAVpca7T/6ckb6ozaeIWa6l+c
         Njg7fpDZV1H9/EgFG6SBzoTVhR4VdmIZwvRP2ES0W20TqYm6xugAXQ6bN1Xd4QgqhRWK
         8Z+5r5GAA+HQTVbMDwc1x/x1qKXkjiS3qDMYFQ4TFOoPBGKxV0BuFt7Cf7QWsyXyF70+
         JSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788090; x=1687380090;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgLToyH0lnEbwO8zhqRrZrm3XuhDqU+MJzbkMRH5C7k=;
        b=HjLuvUWkLIwyZ9A6yAD4VCitmX+QNYr8icp8VGfLMp+qkQTXtSK5PYmxZL4dyzHipl
         lM6jOYgJSGeLIOt3fE4UC4PRsfXKEFEzltcOczsYM5d7EBEzS/feEiCsxoJU7PWvd1qC
         EgmxZiQ2RUXPdEMS/RWiinDvrRI/bjikhH39g7xkBi6SEvap9lrqo2mgP/Az/LE6CPD6
         HUhl0+ehB9dm4n6eLb34egzRlaH8hdxGmzzapWIlaKh+kmpPSjz0wjjf4yklDKyDZxlo
         qagDl/eyKZVy2CT6X7Ay/kMZ7V0Csi7MrO0iQgefMzAzErLHVgY5LPkLXexnRNKUf5Lg
         gubw==
X-Gm-Message-State: AC+VfDxsLHhHD2fE6xH7yx6H5s1jp3u7mlJjRYGcvpTiYDc+kkd+PTB7
	nA5VwWp3ybiwc/Z75W0rmZU+uRb55yYT
X-Google-Smtp-Source: ACHHUZ5cGmZiaHup6R57O0NY+JxfLefgb7v1B8WJ6vcL6g3Tk820S7eQCuWHWQyEwjIocNOdCEtubtQ2RsgT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a5b:110:0:b0:ba7:5d7a:b50d with SMTP id
 16-20020a5b0110000000b00ba75d7ab50dmr7092496ybx.10.1684788090119; Mon, 22 May
 2023 13:41:30 -0700 (PDT)
Date: Mon, 22 May 2023 13:40:46 -0700
In-Reply-To: <20230522204047.800543-1-irogers@google.com>
Message-Id: <20230522204047.800543-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 2/3] perf bpf: Move the declaration of struct rq
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

struct rq is defined in vmlinux.h when the vmlinux.h is generated,
this causes a redefinition failure if it is declared in
lock_contention.bpf.c. Move the definition to vmlinux.h for
consistency with the generated version.

Fixes: 760ebc45746b ("perf lock contention: Add empty 'struct rq' to satisfy libbpf 'runqueue' type verification")
Signed-off-by: Ian Rogers <irogers@google.com>
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
2.40.1.698.g37aff9b760-goog


