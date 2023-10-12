Return-Path: <bpf+bounces-12002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06A7C6576
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB6F1C2101C
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A5CD505;
	Thu, 12 Oct 2023 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8zVI41i"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47CD2EE
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:27 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04793F7
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so491889276.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091862; x=1697696662; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxamHIx1jUF9It77r6uwgfS9ZFGoD4IN9k99wcYK8j0=;
        b=J8zVI41iBLEzFK6xfF7bvVb58u1RLrs8zqD1dWAu4zQ6LShWFDvlVcmp3LEoZ3v/5K
         I5Vx019v+IVGXsRcsJ9xkTizIhZ8SdzpZlDaGDOzfPKrvELyxudIKyEKKrQ3O0jIYPeC
         JEL0ZAqYvxJWDPvA+M2f/+FmET2NgjkY6SXzKyjT5AKf6SgK64cVre37tilG/nkFPHem
         cY8dJMcGMNoW179vz8dG+U3KEKgIsRxlvRDA7B3HFOss36gNBbv88ypLe4uEi3wzRw3Y
         4edQLaYX9wF6lAZtAsRz2P3/14mruysPE89YFTKWxlsaRV6e85UoffCSPEL4DW1OhTsq
         5iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091862; x=1697696662;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxamHIx1jUF9It77r6uwgfS9ZFGoD4IN9k99wcYK8j0=;
        b=EFdX8lpaSv5XkFdymlLXFSPTOr64AUl6eCDECKalXA/6IQE4/iU2Pj50JlGTADHUpS
         7O0JAND3FqYDjKNZiQoCX2U/xgzHJ0HVUb3X4VZwTvp9so1kVEJMlVlPJ9EmdmnyPDZ0
         XwWZpk77cJ/Elku2GCli8UvP0kb7fhuL/DweQeoEoUguPcg4UOt7ytCv5l6Ypfy/7ISS
         09A81gnKd0fe7hSF7d0psdqNkVPo/IYpq+mrQd28QayRKGFl/L/QQrOBEpAHh9HQ9JMN
         lYlMaka/76qwnaZL+p13T6O40P94d5m+mLfOgHx6hMURfvNX5wXgoMqThFP8CQlf0+AF
         kqJQ==
X-Gm-Message-State: AOJu0Yzbq6lFiimj9uL0sABhuL2SLhK3NzH0uHQaSNd+TrWklXNzuE0H
	Cn0dwfYM9F2+M9WKn+TstduV0OyJAKkf
X-Google-Smtp-Source: AGHT+IE/eUJnz42kO/fUpS6hXWaVScY5hJ9buhoaZlkpd0GNy4W8iO9rsgfsQ9bAqH6d9MbHu49KGMGedEuX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:f609:0:b0:d7e:78db:d264 with SMTP id
 t9-20020a25f609000000b00d7e78dbd264mr424647ybd.5.1697091862195; Wed, 11 Oct
 2023 23:24:22 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:53 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 07/13] perf callchain: Make brtype_stat in callchain_list optional
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

struct callchain_list is 352bytes in size, 232 of which are
brtype_stat. brtype_stat is only used for certain callchain_list
items so make it optional, allocating when necessary. So that
printing doesn't need to deal with an optional brtype_stat, pass
an empty/zero version.

Before:
```
struct callchain_list {
        u64                        ip;                   /*     0     8 */
        struct map_symbol          ms;                   /*     8    24 */
        struct {
                _Bool              unfolded;             /*    32     1 */
                _Bool              has_children;         /*    33     1 */
        };                                               /*    32     2 */

        /* XXX 6 bytes hole, try to pack */

        u64                        branch_count;         /*    40     8 */
        u64                        from_count;           /*    48     8 */
        u64                        predicted_count;      /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        abort_count;          /*    64     8 */
        u64                        cycles_count;         /*    72     8 */
        u64                        iter_count;           /*    80     8 */
        u64                        iter_cycles;          /*    88     8 */
        struct branch_type_stat    brtype_stat;          /*    96   232 */
        /* --- cacheline 5 boundary (320 bytes) was 8 bytes ago --- */
        const char  *              srcline;              /*   328     8 */
        struct list_head           list;                 /*   336    16 */

        /* size: 352, cachelines: 6, members: 13 */
        /* sum members: 346, holes: 1, sum holes: 6 */
        /* last cacheline: 32 bytes */
};
```

After:
```
struct callchain_list {
        u64                        ip;                   /*     0     8 */
        struct map_symbol          ms;                   /*     8    24 */
        struct {
                _Bool              unfolded;             /*    32     1 */
                _Bool              has_children;         /*    33     1 */
        };                                               /*    32     2 */

        /* XXX 6 bytes hole, try to pack */

        u64                        branch_count;         /*    40     8 */
        u64                        from_count;           /*    48     8 */
        u64                        predicted_count;      /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        abort_count;          /*    64     8 */
        u64                        cycles_count;         /*    72     8 */
        u64                        iter_count;           /*    80     8 */
        u64                        iter_cycles;          /*    88     8 */
        struct branch_type_stat *  brtype_stat;          /*    96     8 */
        const char  *              srcline;              /*   104     8 */
        struct list_head           list;                 /*   112    16 */

        /* size: 128, cachelines: 2, members: 13 */
        /* sum members: 122, holes: 1, sum holes: 6 */
};
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/callchain.c | 41 +++++++++++++++++++++++++++++--------
 tools/perf/util/callchain.h |  2 +-
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 229cedee1e68..0a7919c2af91 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -586,7 +586,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 		call = zalloc(sizeof(*call));
 		if (!call) {
 			perror("not enough memory for the code path tree");
-			return -1;
+			return -ENOMEM;
 		}
 		call->ip = cursor_node->ip;
 		call->ms = cursor_node->ms;
@@ -602,7 +602,15 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 				 * branch_from is set with value somewhere else
 				 * to imply it's "to" of a branch.
 				 */
-				call->brtype_stat.branch_to = true;
+				if (!call->brtype_stat) {
+					call->brtype_stat = zalloc(sizeof(*call->brtype_stat));
+					if (!call->brtype_stat) {
+						perror("not enough memory for the code path branch statisitcs");
+						free(call->brtype_stat);
+						return -ENOMEM;
+					}
+				}
+				call->brtype_stat->branch_to = true;
 
 				if (cursor_node->branch_flags.predicted)
 					call->predicted_count = 1;
@@ -610,7 +618,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 				if (cursor_node->branch_flags.abort)
 					call->abort_count = 1;
 
-				branch_type_count(&call->brtype_stat,
+				branch_type_count(call->brtype_stat,
 						  &cursor_node->branch_flags,
 						  cursor_node->branch_from,
 						  cursor_node->ip);
@@ -618,7 +626,8 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 				/*
 				 * It's "from" of a branch
 				 */
-				call->brtype_stat.branch_to = false;
+				if (call->brtype_stat && call->brtype_stat->branch_to)
+					call->brtype_stat->branch_to = false;
 				call->cycles_count =
 					cursor_node->branch_flags.cycles;
 				call->iter_count = cursor_node->nr_loop_iter;
@@ -652,6 +661,7 @@ add_child(struct callchain_node *parent,
 			list_del_init(&call->list);
 			map__zput(call->ms.map);
 			maps__zput(call->ms.maps);
+			zfree(&call->brtype_stat);
 			free(call);
 		}
 		free(new);
@@ -762,7 +772,14 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			/*
 			 * It's "to" of a branch
 			 */
-			cnode->brtype_stat.branch_to = true;
+			if (!cnode->brtype_stat) {
+				cnode->brtype_stat = zalloc(sizeof(*cnode->brtype_stat));
+				if (!cnode->brtype_stat) {
+					perror("not enough memory for the code path branch statisitcs");
+					return MATCH_ERROR;
+				}
+			}
+			cnode->brtype_stat->branch_to = true;
 
 			if (node->branch_flags.predicted)
 				cnode->predicted_count++;
@@ -770,7 +787,7 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			if (node->branch_flags.abort)
 				cnode->abort_count++;
 
-			branch_type_count(&cnode->brtype_stat,
+			branch_type_count(cnode->brtype_stat,
 					  &node->branch_flags,
 					  node->branch_from,
 					  node->ip);
@@ -778,7 +795,8 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			/*
 			 * It's "from" of a branch
 			 */
-			cnode->brtype_stat.branch_to = false;
+			if (cnode->brtype_stat && cnode->brtype_stat->branch_to)
+				cnode->brtype_stat->branch_to = false;
 			cnode->cycles_count += node->branch_flags.cycles;
 			cnode->iter_count += node->nr_loop_iter;
 			cnode->iter_cycles += node->iter_cycles;
@@ -1026,6 +1044,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 		maps__zput(ms.maps);
 		map__zput(list->ms.map);
 		maps__zput(list->ms.maps);
+		zfree(&list->brtype_stat);
 		free(list);
 	}
 
@@ -1447,11 +1466,14 @@ static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 int callchain_list_counts__printf_value(struct callchain_list *clist,
 					FILE *fp, char *bf, int bfsize)
 {
+	static const struct branch_type_stat empty_brtype_stat = {};
+	const struct branch_type_stat *brtype_stat;
 	u64 branch_count, predicted_count;
 	u64 abort_count, cycles_count;
 	u64 iter_count, iter_cycles;
 	u64 from_count;
 
+	brtype_stat = clist->brtype_stat ?: &empty_brtype_stat;
 	branch_count = clist->branch_count;
 	predicted_count = clist->predicted_count;
 	abort_count = clist->abort_count;
@@ -1463,7 +1485,7 @@ int callchain_list_counts__printf_value(struct callchain_list *clist,
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
 				       cycles_count, iter_count, iter_cycles,
-				       from_count, &clist->brtype_stat);
+				       from_count, brtype_stat);
 }
 
 static void free_callchain_node(struct callchain_node *node)
@@ -1476,6 +1498,7 @@ static void free_callchain_node(struct callchain_node *node)
 		list_del_init(&list->list);
 		map__zput(list->ms.map);
 		maps__zput(list->ms.maps);
+		zfree(&list->brtype_stat);
 		free(list);
 	}
 
@@ -1483,6 +1506,7 @@ static void free_callchain_node(struct callchain_node *node)
 		list_del_init(&list->list);
 		map__zput(list->ms.map);
 		maps__zput(list->ms.maps);
+		zfree(&list->brtype_stat);
 		free(list);
 	}
 
@@ -1569,6 +1593,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 		list_del_init(&chain->list);
 		map__zput(chain->ms.map);
 		maps__zput(chain->ms.maps);
+		zfree(&chain->brtype_stat);
 		free(chain);
 	}
 	return -ENOMEM;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index d2618a47deca..86e8a9e81456 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -129,7 +129,7 @@ struct callchain_list {
 	u64			cycles_count;
 	u64			iter_count;
 	u64			iter_cycles;
-	struct branch_type_stat brtype_stat;
+	struct branch_type_stat *brtype_stat;
 	const char		*srcline;
 	struct list_head	list;
 };
-- 
2.42.0.609.gbb76f46606-goog


