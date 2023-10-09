Return-Path: <bpf+bounces-11766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C347BE9E5
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DFC2827E4
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2638DE5;
	Mon,  9 Oct 2023 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsxlfECd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3D37C8C
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:40:26 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE7A10D7
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:40:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f4f2a9ef0so77108567b3.2
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876811; x=1697481611; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfL4FLU++s9CKjil59t6XdpqiER2jatUC+zl7nbhx6Q=;
        b=YsxlfECdt177X4UMflQL0j0/eiiJ163V49F/TKWFkTlFW+aY45ZLUbU8f6NDVQQigD
         BtRPIKXxexi76R+oVTm1GCgmpGzx9NSFdWZVepRouWnYHynBJuF78cTALiIizRVnr+Ug
         7DFkxBdCvyLYUU6dzWqKmIrjj1k+Bj7M8v5yM7GLYQWHwV6LBCjZEKYGsV6hdXaTETYY
         73ANscnYgCjASWj7H2Mpu5TlecYA/5dlHkVSVO57N1VHBI2ObMLd0xYloJy6U6+Dv642
         Dg3ao67NHSRXvIcx6F+FW5mpUs9l6giCn1/D4ppTJh+jBkCv8ZEb5aaEJYWUejPZuVk0
         o5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876811; x=1697481611;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfL4FLU++s9CKjil59t6XdpqiER2jatUC+zl7nbhx6Q=;
        b=qYpNGyirIfVpcC1F3pdB1zfr24xvwRqbAe+IndaZ+o0lcHk/2yC3QnIL5NT1kG3gy+
         rXdRwq+lS0uuQZFZRNV/sJMz0TwRfZN6df2sthkIEOSN3tVSGLe6Y+ntoNmFDU3rILza
         gGvTbKACoTnPqv/lEPiC/bNYYZ8s4kB4/gxhGBTx+Rp8uCzyQpKK9ohaQ+nE4QXFGhiS
         tbPWOP91/lF05ZlpP3pBAG+bb1gKfGqq48s6V17+Hqu5xTDYcImGnEBEEzh0X3uz3iIP
         x4bVkiMfv61ziqPnK5SQagDH23RpbTWiGUFP1POPwj2WgKqr1yDVO5VmtISwV0l94lL4
         3aAg==
X-Gm-Message-State: AOJu0YwKuZKGp8Bh/6UDr8/c6evIzqHCRRsqN8zD66GjR4EJohADgTkK
	TC41wvHxNkZvPEXyhcRGQC1MCA2myhW6
X-Google-Smtp-Source: AGHT+IEgB0ixdKNlygdhv4h59H76SFd7CewMHkUz7uO+EUvepYTGPVZ0JlyDFpg5Eeb38pxoje/eR8ZZskOD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:e74f:0:b0:d9a:43eb:4391 with SMTP id
 e76-20020a25e74f000000b00d9a43eb4391mr17704ybh.9.1696876810948; Mon, 09 Oct
 2023 11:40:10 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:20 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 18/18] perf bpf_counter: Fix a few memory leaks
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Memory leaks were detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 6732cbbcf9b3..7f9b0e46e008 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -104,7 +104,7 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
 	struct bpf_prog_profiler_bpf *skel;
 	struct bpf_counter *counter;
 	struct bpf_program *prog;
-	char *prog_name;
+	char *prog_name = NULL;
 	int prog_fd;
 	int err;
 
@@ -155,10 +155,12 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
 	assert(skel != NULL);
 	counter->skel = skel;
 	list_add(&counter->list, &evsel->bpf_counter_list);
+	free(prog_name);
 	close(prog_fd);
 	return 0;
 err_out:
 	bpf_prog_profiler_bpf__destroy(skel);
+	free(prog_name);
 	free(counter);
 	close(prog_fd);
 	return -1;
@@ -180,6 +182,7 @@ static int bpf_program_profiler__load(struct evsel *evsel, struct target *target
 		    (*p != '\0' && *p != ',')) {
 			pr_err("Failed to parse bpf prog ids %s\n",
 			       target->bpf_str);
+			free(bpf_str_);
 			return -1;
 		}
 
-- 
2.42.0.609.gbb76f46606-goog


