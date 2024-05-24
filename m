Return-Path: <bpf+bounces-30530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DDB8CEB86
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF961F221E5
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC1812FF9B;
	Fri, 24 May 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0LgooAL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522412F36D
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583971; cv=none; b=Oh3U7n+/NwXGvtypAWI3fKBtxRsXRmfHnuE+8jCjM3L5E95yw8Pvy1jweFWeHHFE5ekNbJVXV9qvujNS5BXb25atB5qUR3RBxB4cKqB2qFJH0uGmlOe9qLTgXbsuu8v+0Tc0LtlFYdXBAgoXVW4AEjC7lcuKlNjSTM/vqWPpQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583971; c=relaxed/simple;
	bh=3L8J4mFnFcR04GC0s7Reyzu6OTdUhfWKdzrb2tiRPSg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=umFVMarSM6jrLFGcYMcYvVZMe0KYsqdlAHlUFBtIVL+aEOi715ULucCzkHb2LuIv7IbZmUnV4u4PZpMW9ADeL8CKTGsk4chQetYrGKol16BH2Adt/Q7XXV14BAhGLshumqNjRYwwRVTVzb0Wdn/y9weSQfzZlz9KjcX3ENmNw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0LgooAL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df789a425d3so71324276.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716583969; x=1717188769; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oawNFUCmaLFxsRTNXlYLk/GWjHdQloVnoR4MnORxCVI=;
        b=S0LgooALtT5RGWwR7kLw5Z6kKhN7I3O4pUJjcqpAC32gJseFHVkOmkxEdDni6Fy+0U
         oYWM8BExpJhPOayn4AlbqSV0eFZlpMK6bhO+Owc00XLiYUsZI8aTFkL8Wsnbf69UhaOD
         5+WL4YNJsxb/rDw+kWF+wgSwEJrgyLrACg0LwaDTS751fdcbz/OJtnHQeI7Y5ibv1e/1
         f5YWk5PUKvstW6TLcReG5julW1a9OQr9bUUMQG6seWj+bh0VxG/I89S3D6i/mWn2ETAt
         PI/JOhAqySIMh2IZsT0aJ4JWziRw8xteeEx9/JIPourJhO4F2bRaBrHurFy/ABX5f5mo
         unQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583969; x=1717188769;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oawNFUCmaLFxsRTNXlYLk/GWjHdQloVnoR4MnORxCVI=;
        b=nZvP4AFj2Ah/WB+FPvVGY7I8tS/ZNr2paPqRKJETd6YXGRZlwCP6XaXWfmuS1zaVw/
         RoV3JnkWjecBnRBNsA+EHZpgNCCOosgDQBX6uFEhUg+9uEav3HUOBhi6iQ5Vt42vEGJC
         vH5PCAigDxjnifQSHgAF19FOT/UFGnwDkx458URKAHmMKTeN1976D2SHTZ3VpOsH9Pw4
         tx7jAiysmnkSnoWUtxPnWzLzRuFyqWQ6HZzFUnOPpmD8CDjgU9ikRJMc5pZGb3A4L0/k
         SNSgKByONz+brL16tYM7zuZsV8zMjIUjy+OhTlmZLWF/Y13eGKJtEfSjnD+kvXJDOWxb
         mEOA==
X-Forwarded-Encrypted: i=1; AJvYcCU8g0ojShS7q8gcoKf0ZR9tB7jlT7q2TTnKcjXkJuuoY54BlEVorOHWkVJpapIFr0/ArSdpW6W0tf1k4BWKMv+CM9Lc
X-Gm-Message-State: AOJu0YxzPo/Saxv9A+mRNsG5fQbrWVTvuZL2iwXM/gzr/Z2M4SY2SapF
	x7lFQPJi4xd3qPpDlhAlzaNarQYprcwIxj8EZjPzZP7nGigjqS7XN856ps2nUoJImT1Yfjg8viN
	HXupIIg==
X-Google-Smtp-Source: AGHT+IES7alsV8CTFubgKW7F0VC21+2tqxk/lsfmVJ2jpfd8sYjUyxOgUugdmJbt3HBXiw8jnaMBgjM7yMLB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:6902:c0d:b0:de5:5304:3206 with SMTP id
 3f1490d57ef6-df77223c631mr324959276.11.1716583969292; Fri, 24 May 2024
 13:52:49 -0700 (PDT)
Date: Fri, 24 May 2024 13:52:26 -0700
In-Reply-To: <20240524205227.244375-1-irogers@google.com>
Message-Id: <20240524205227.244375-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524205227.244375-1-irogers@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v3 2/3] perf bpf filter: Add uid and gid terms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the BPF filter to use the uid and gid terms determined by the
bpf_get_current_uid_gid BPF helper. For example, the following will
record the cpu-clock event system wide discarding samples that don't
belong to the current user.

$ perf record -e cpu-clock --filter "uid == $(id -u)" -a sleep 0.1

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     | 2 +-
 tools/perf/util/bpf-filter.c                 | 5 +++++
 tools/perf/util/bpf-filter.l                 | 2 ++
 tools/perf/util/bpf_skel/sample-filter.h     | 3 +++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..059bc40c5ee1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -200,7 +200,7 @@ OPTIONS
 	  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
 	  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
 	  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
-	  mem_dtlb, mem_blk, mem_hops
+	  mem_dtlb, mem_blk, mem_hops, uid, gid
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index f10148623a8e..04f98b6bb291 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -63,6 +63,11 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
 		return 0;
 
+	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID) {
+		/* Not dependent on the sample_type as computed from a BPF helper. */
+		return 0;
+	}
+
 	if (expr->op == PBF_OP_GROUP_BEGIN) {
 		struct perf_bpf_filter_expr *group;
 
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 62c959813466..2a7c839f3fae 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -95,6 +95,8 @@ mem_lock	{ return sample_part(PBF_TERM_DATA_SRC, 5); }
 mem_dtlb	{ return sample_part(PBF_TERM_DATA_SRC, 6); }
 mem_blk		{ return sample_part(PBF_TERM_DATA_SRC, 7); }
 mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
+uid		{ return sample(PBF_TERM_UID); }
+gid		{ return sample(PBF_TERM_GID); }
 
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 25f780022951..350efa121026 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -47,6 +47,9 @@ enum perf_bpf_filter_term {
 	PBF_TERM_CODE_PAGE_SIZE	= PBF_TERM_SAMPLE_START + 23, /* SAMPLE_CODE_PAGE_SIZE = 1U << 23 */
 	PBF_TERM_WEIGHT_STRUCT	= PBF_TERM_SAMPLE_START + 24, /* SAMPLE_WEIGHT_STRUCT = 1U << 24 */
 	PBF_TERM_SAMPLE_END	= PBF_TERM_WEIGHT_STRUCT,
+	/* Terms computed from BPF helpers. */
+	PBF_TERM_UID,
+	PBF_TERM_GID,
 };
 
 /* BPF map entry for filtering */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 5ac1778ff66e..f59985101973 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -140,6 +140,10 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		}
 		/* return the whole word */
 		return kctx->data->data_src.val;
+	case PBF_TERM_UID:
+		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
+	case PBF_TERM_GID:
+		return bpf_get_current_uid_gid() >> 32;
 	case PBF_TERM_NONE:
 	case __PBF_UNUSED_TERM4:
 	case __PBF_UNUSED_TERM5:
-- 
2.45.1.288.g0e0cd299f1-goog


