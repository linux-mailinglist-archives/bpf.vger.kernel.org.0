Return-Path: <bpf+bounces-1865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB4723168
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0ACC1C208C2
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725BF261F2;
	Mon,  5 Jun 2023 20:28:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9121118D
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:28:20 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D46109
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 13:28:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565ef5a707dso73856037b3.3
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685996897; x=1688588897;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yhF3LUAjC5vv5lFpyo9KAPX59o4Esq1dpIkjb48etw=;
        b=Cwb9qmQoXri1hiWhnNQpPPy/l2PGyCe56sNTUhcoGcqlVn9Cj4V/od2CHKPQrkR3or
         aB5S8nzckVosZKUNJHDV9Uef0JeCzJPvR9SiBaVOL/elx6AA913AwbHLMC9XXqDTFuZE
         kjPdr00K3LrnoSQ80mmAZe/3ehN66LKKDJ8UrzqoevmbY2VTYY8fFXX61n7BQRUUZqOo
         HSObiLwsQZq075I2N5yr2NRoS9yRUZrRUQaotTkeorQp2G/ro/nWouz09cgWbAhUhMyO
         qDNJzHdv1IzP9/+eNJ4qa8BTbHpHFpRCTakTbaCGLrAFuPD8wN8GFNTxq9LPusvpXomX
         tSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996897; x=1688588897;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yhF3LUAjC5vv5lFpyo9KAPX59o4Esq1dpIkjb48etw=;
        b=h0Uj+2fix9SJnOLPDJ8xbHzN/5KgYx5GY2PoGYEC499Yymp/gKCScg/1sMdTikFj0k
         cfkScNn16nu6eMaE0Kgf6tmOBwRNPObfYL9jxgd9BpQlKSQwO6sQbDn4lsILztSyidzs
         QjQeAdmhDSOSUxlKn+XwVu/4AGJV0SojkS3voXYrHuF/RbocpXf20skDz65CL/TITECD
         eZp5WNHQOyoUvu3acynjp8ItuCBAGJPAwsAqTo0fjvvqUlvtoAS9XleLAIYowk1a5E0l
         +2B/1hVYJB8HQh3IyONzaOwVFDRRD54h8pEe0e1kA8UKlddmF4GIj7JVmmRwBEFdzLNP
         o0NQ==
X-Gm-Message-State: AC+VfDwlFQ+iHFBxoHuf0M0Mriq5M9ezrQxzQ7j57Zv6KVysno5Yy61H
	1XAz9tEZh6jT5jO7SFADI6htqj/Jikma
X-Google-Smtp-Source: ACHHUZ4u6C4UhYkOI2bUkxhmrLOQ3XfOKZb5cb6MpfESQvWxRLl1tDTyvOQVOTjul74lpbI4NWKkjLcVyhyA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bed9:39b9:3df1:2828])
 (user=irogers job=sendgmr) by 2002:a81:b504:0:b0:565:cfdf:7a70 with SMTP id
 t4-20020a81b504000000b00565cfdf7a70mr4712056ywh.2.1685996897710; Mon, 05 Jun
 2023 13:28:17 -0700 (PDT)
Date: Mon,  5 Jun 2023 13:27:10 -0700
In-Reply-To: <20230605202712.1690876-1-irogers@google.com>
Message-Id: <20230605202712.1690876-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230605202712.1690876-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 2/4] perf bpf: Move the declaration of struct rq
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
	autolearn=unavailable autolearn_force=no version=3.4.6
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
2.41.0.rc0.172.g3f132b7071-goog


