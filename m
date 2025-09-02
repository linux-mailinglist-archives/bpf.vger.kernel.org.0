Return-Path: <bpf+bounces-67213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84AB40CFC
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B465E06ED
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090834DCC7;
	Tue,  2 Sep 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xEmAy7zB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC834AAEF
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837077; cv=none; b=TwGD5qcyQ8yStXaZTRoV427hbPkXwj90eYy3jwwGzQLn9v9dsLcul9KLx4EdwPKCTMR5N/m+s3t3k0kKewOH6Epl0rCBMQOkEsHGhkVSHldVlT3w88pVVUnyFiyyatVFMH9sOvTdpoqeMyd5HZN0y8HaV3E6UGYefD6thC7Ayjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837077; c=relaxed/simple;
	bh=Y417faWxUdjMpY13VqIziiGZ5qRUWZrN43DhiAwSrlU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lszEJSo1+r1gcdebMt7j3cjVGlRXYPIc+CdugoCE5iz/Ukt9N8R48kcHrYo6ZAusiQWNKmqG7KO/rBEuo6wbfua2JSLjlXMbKWdXCMrPTWIy/QRKYIV/j5RUwKt6dWpGdmB7uZgjhy4lUGkaMRaZRv4feriyA2X2zczgCxLuzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xEmAy7zB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77243618babso3184710b3a.0
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756837075; x=1757441875; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/J1GNcMtAJTXoNioUBkgQFYPG0R3g234Hk0goUCKGI=;
        b=xEmAy7zBWFGbt14FqEvPeekYB3LiSh/R32Rm0tJPHAIi+1DjfHpUuKuLw9RqlZlK+K
         K5z09Ag2isIoC85boUX/vY4nytLaCEY1DSFo76uKm5RNUDRk0sKQ2Dp1rJZBjo6SHygR
         CwLvH1oL3cZ1S9EZizsECaGv1tfhP6yeadz7So0z/+peWjuBUui3MlybkMP+OqiveD8e
         FY3i7qHB4PsBcFVV/PC/JHN4i0Cfjyu7Y0Zm+i+U2lc5PGm9F6mK/q0D7nk+SXfFBAkf
         vwlj5x5Agbd9LvgjBkFbZgHE6Whey00fAmKgAbOdJuJcf6F2BxIqRIu9Mr+MXQ0OWO3z
         bRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837075; x=1757441875;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/J1GNcMtAJTXoNioUBkgQFYPG0R3g234Hk0goUCKGI=;
        b=eLYlnv4gb3/ouqiVBgveJlIR98YMB6Kt1dF70yLJFvEJSgp2iRrqVLXklC5BVaMBOG
         fnHfNVqvTF9++qT+8dR9U8hscQseWp77ZRLhRGW6LfACXVW6s+cne5MaDpq1UmethBq5
         NpEKTOoD61OCobLAJjP7JdHaNxkpIsWs5y1LzRpmkCWzAn9P0EWROiTlMurLSjQyoAWs
         jl7C0WELU87uevinaG0ZiidCfDQX/Qpb1mTftKts5lSmZeGq0Zk4z4SgFvzAPQW0T+Il
         Fq8DZUuwf9AJroupqCI4UQIyF250AVpc2vGaYjac2bm0XLSP78C6x3/aGQG7y4+MMmAo
         tqkg==
X-Forwarded-Encrypted: i=1; AJvYcCXq9V7Iz1AyEicIOtuOzlASgQzfhuazAgSt7jk9utj7XSlZwhQAAGa6ralRkgrNm/cRhNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4fp5EKKgAE1IQsjC4GOQlXdJyD5wAv3ge6d8Hsa2uO71LB/i
	iaWB/dBs4n65BlgZuD1Ktu9RyRBqp5uOnqMaibFbSaqBtnK8/K6OdoNeP9p31ZNuwGKwYCuaIts
	PvrU4FnjKCg==
X-Google-Smtp-Source: AGHT+IHxdObMrTQ2jlx0SwvK/uuzTbZa58P6MBTifkyUSqcIWeTIEok/hTK+8sVzhlfi1Ugp7eD1dabFwgpf
X-Received: from pfbih20.prod.google.com ([2002:a05:6a00:8c14:b0:771:f406:9f46])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b81:b0:772:301a:fbb6
 with SMTP id d2e1a72fcca58-7723e342758mr14698699b3a.19.1756837075293; Tue, 02
 Sep 2025 11:17:55 -0700 (PDT)
Date: Tue,  2 Sep 2025 11:17:11 -0700
In-Reply-To: <20250902181713.309797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250902181713.309797-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250902181713.309797-2-irogers@google.com>
Subject: [PATCH v1 1/3] perf bpf-event: Fix use-after-free in synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Blake Jones <blakejones@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Howard Chu <howardchu95@gmail.com>, song@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Calls to perf_env__insert_bpf_prog_info may fail as a sideband thread
may already have inserted the bpf_prog_info. Such failures may yield
info_linear being freed which then causes use-after-free issues with
the internal bpf_prog_info info struct. Make it so that
perf_env__insert_bpf_prog_info trigger early non-error paths and fix
the use-after-free in perf_event__synthesize_one_bpf_prog. Add proper
return error handling to perf_env__add_bpf_info (that calls
perf_env__insert_bpf_prog_info) and propagate the return value in its
callers.

Closes: https://lore.kernel.org/lkml/CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com/
Fixes: 03edb7020bb9 ("perf bpf: Fix two memory leakages when calling perf_env__insert_bpf_prog_info()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.c | 39 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 5b6d3e899e11..2298cd396c42 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -657,9 +657,15 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		info_node->info_linear = info_linear;
 		info_node->metadata = NULL;
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
-			free(info_linear);
+			/*
+			 * Insert failed, likely because of a duplicate event
+			 * made by the sideband thread. Ignore synthesizing the
+			 * metadata.
+			 */
 			free(info_node);
+			goto out;
 		}
+		/* info_linear is now owned by info_node and shouldn't be freed below. */
 		info_linear = NULL;
 
 		/*
@@ -827,18 +833,18 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	return err;
 }
 
-static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
+static int perf_env__add_bpf_info(struct perf_env *env, u32 id)
 {
 	struct bpf_prog_info_node *info_node;
 	struct perf_bpil *info_linear;
 	struct btf *btf = NULL;
 	u64 arrays;
 	u32 btf_id;
-	int fd;
+	int fd, err = 0;
 
 	fd = bpf_prog_get_fd_by_id(id);
 	if (fd < 0)
-		return;
+		return -EINVAL;
 
 	arrays = 1UL << PERF_BPIL_JITED_KSYMS;
 	arrays |= 1UL << PERF_BPIL_JITED_FUNC_LENS;
@@ -852,6 +858,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	info_linear = get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
 		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
+		err = PTR_ERR(info_linear);
 		goto out;
 	}
 
@@ -862,38 +869,46 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 		info_node->info_linear = info_linear;
 		info_node->metadata = bpf_metadata_create(&info_linear->info);
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
+			pr_debug("%s: duplicate add bpf info request for id %u\n",
+				 __func__, btf_id);
 			free(info_linear);
 			free(info_node);
+			goto out;
 		}
-	} else
+	} else {
 		free(info_linear);
+		err = -ENOMEM;
+		goto out;
+	}
 
 	if (btf_id == 0)
 		goto out;
 
 	btf = btf__load_from_kernel_by_id(btf_id);
-	if (libbpf_get_error(btf)) {
-		pr_debug("%s: failed to get BTF of id %u, aborting\n",
-			 __func__, btf_id);
-		goto out;
+	if (!btf) {
+		err = -errno;
+		pr_debug("%s: failed to get BTF of id %u %d\n", __func__, btf_id, err);
+	} else {
+		perf_env__fetch_btf(env, btf_id, btf);
 	}
-	perf_env__fetch_btf(env, btf_id, btf);
 
 out:
 	btf__free(btf);
 	close(fd);
+	return err;
 }
 
 static int bpf_event__sb_cb(union perf_event *event, void *data)
 {
 	struct perf_env *env = data;
+	int ret = 0;
 
 	if (event->header.type != PERF_RECORD_BPF_EVENT)
 		return -1;
 
 	switch (event->bpf.type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
-		perf_env__add_bpf_info(env, event->bpf.id);
+		ret = perf_env__add_bpf_info(env, event->bpf.id);
 
 	case PERF_BPF_EVENT_PROG_UNLOAD:
 		/*
@@ -907,7 +922,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
-- 
2.51.0.355.g5224444f11-goog


