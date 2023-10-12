Return-Path: <bpf+bounces-12000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562137C6573
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CFA282830
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C24CD506;
	Thu, 12 Oct 2023 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXoEglfz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4BD2FD
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:20 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FEB101
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a21c283542so10195407b3.3
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091857; x=1697696657; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n22HctTeNabjvu+detFMoBE23ee2ZNJEYKUzOJUpCFY=;
        b=HXoEglfzw+KwzhCEAFNDf4mqZlbE8tAGIMFRp7swMbFlWFhUHWTJDA1+Fbeo1kW3U5
         kVOVtIBUXXtIpZs+Tdib7mDnhulG2AyUdxFCFUeHLvtf5SrxhYwBN6nQb8k+yq3IW2Au
         J5PvYGoww0AgGz0cVoQQFlNsneoJ8L2W1MEG0/km7lMezsb/6nD+7K4DbeamiUXnnbJx
         F5mQk08VtBjjfIJb19lvS0QkMObyiLZ1rkG9/ppT/L07aNxl5aNfmgWwrhXb7woiN785
         iW4D9oWg5eoPPuZYDAk6ddTsOkEIZESU6MBdwlD0KgDd5mQnAf8ilcFIighszbsuZcSe
         W1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091857; x=1697696657;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n22HctTeNabjvu+detFMoBE23ee2ZNJEYKUzOJUpCFY=;
        b=rxHWem2ExpK0Y2sJPrl2hm/DgCeIxAOA9fSMWlkYzOhxP8AxhnbihUf9wqTQfVx/C3
         q81S/V4vQItPCZr3xcSTKncIL8sEl88crAFMr7HiS1x9U2RbJEZZZZDtJNaTYhvtU2oO
         77pW3nLD0948iHqJtlE/43o7v8hvFDjG/a4SLOt0mS6lpMVeafjyOGzJ2Lso9nTb2kr0
         ebejawPAnqDFzOA2P25nYZeIQg2xJjhDmS/351vrCPt4tgmCIfqy8eJR8JqsNWioHSqK
         7jwZndp8698dUbCxKC2sQLLZIF40q4U22EIfREGqG4SBTyOsappLjNwU9cWCFHuOvfBa
         gl8g==
X-Gm-Message-State: AOJu0Yw6Y5rdN5utav9zFObLsgEwb88CvthVU3o9n3Lr8FDkS79MCSvV
	Qg9/CizMURcH/f+E68GYKusREsAnfTFl
X-Google-Smtp-Source: AGHT+IG/18zLXHA3wgR1PYyBUsgstJKB/GDiTcsayNrXCC9eMZZGNYjTQA68IsiN6zxDEk1bGSJuRu2Y5J5N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a81:a8c8:0:b0:592:7bc7:b304 with SMTP id
 f191-20020a81a8c8000000b005927bc7b304mr446341ywh.8.1697091856969; Wed, 11 Oct
 2023 23:24:16 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:51 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 05/13] perf offcpu: Add missed btf_free
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

Caught by address/leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 21f4d9ba023d..6af36142dc5a 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -98,22 +98,22 @@ static void off_cpu_finish(void *arg __maybe_unused)
 /* v5.18 kernel added prev_state arg, so it needs to check the signature */
 static void check_sched_switch_args(void)
 {
-	const struct btf *btf = btf__load_vmlinux_btf();
+	struct btf *btf = btf__load_vmlinux_btf();
 	const struct btf_type *t1, *t2, *t3;
 	u32 type_id;
 
 	type_id = btf__find_by_name_kind(btf, "btf_trace_sched_switch",
 					 BTF_KIND_TYPEDEF);
 	if ((s32)type_id < 0)
-		return;
+		goto cleanup;
 
 	t1 = btf__type_by_id(btf, type_id);
 	if (t1 == NULL)
-		return;
+		goto cleanup;
 
 	t2 = btf__type_by_id(btf, t1->type);
 	if (t2 == NULL || !btf_is_ptr(t2))
-		return;
+		goto cleanup;
 
 	t3 = btf__type_by_id(btf, t2->type);
 	/* btf_trace func proto has one more argument for the context */
@@ -121,6 +121,8 @@ static void check_sched_switch_args(void)
 		/* new format: pass prev_state as 4th arg */
 		skel->rodata->has_prev_state = true;
 	}
+cleanup:
+	btf__free(btf);
 }
 
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
-- 
2.42.0.609.gbb76f46606-goog


