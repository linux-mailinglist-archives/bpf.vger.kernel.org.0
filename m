Return-Path: <bpf+bounces-11760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE887BE9DC
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380161C20C1D
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78FE37C8C;
	Mon,  9 Oct 2023 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dK8xBnOo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C637158
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:40:08 +0000 (UTC)
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C5125
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:57 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-57be2b0e95cso6575071eaf.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876797; x=1697481597; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49ZawQt+7SlBsoWKownV7zVOA634acLMIh7oRlSswNg=;
        b=dK8xBnOoIO9PY75AnOE4rIYgmL4p62wsbAdA7DfZFtY6H+eeCIfzfIyLtFSxZIgtTE
         fTYV70F1erQqiuylGJWheixlo8jAsHDTaaZz3ekJzfxnLhpbM438SCkyiwNrRpZYl+En
         BaZ+kYT1gip/D41srBrzQBjcQUx7wGqRxtPuXXKF5RKFeChmf/6wd2+JoL4TrVEgLLwm
         Wo0U08kEkCjWGbUXkkofAYrZKvJMNg5wUCosR+f4vHDDkXsqNhEH5PTvDiBhI2w3PZbY
         E/yZgTJVuHjnlVUgFb5g49pVkctTzfFk+eB7J2PYExNF52p4Ll2VA6pdBrjjaOFODJVO
         hKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876797; x=1697481597;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49ZawQt+7SlBsoWKownV7zVOA634acLMIh7oRlSswNg=;
        b=L9wSUgNXrnRjaP/pCWtiCiCvQST2x4B5gt1H8dV1bffWmyNinkbfdu4u1qdrWgoUmi
         oA3qucNllu6CzGcleeXG5TjQz2VUIjpGL83X+34X65avEWM022THwRv4Mpu375FHYhcj
         3hzwt+lLBfkEFmKk173WyB+m+Mw9zaJABEiqnnoYLfERcfQf6zlo0j8SBS3Wi+SOhRzH
         JAIBhOBVV+Ya6Dvcc3qbVJmmIdVJpzSjJXgVw+18+Bl6z8025FM1we1R5ZjAJs/ip+hI
         ZS/FdUoE56q2/Wu4XGfZwjl/kyBM10LhiHJVRbBy4HNHQhVEfdtgCTkPJCYYMVCbas8W
         WAOA==
X-Gm-Message-State: AOJu0YxaTmU3q8SdoADts3mG63ajGCLEG4Mi299XwTCRcJEUpI6xDYV+
	ILjxfiCIDHwHqCMN7pwc3fX8VL7r7hf7
X-Google-Smtp-Source: AGHT+IEQO/YSLvuW5lkkNTKqekhHTTuwM6kivSrFg1QMVwNQ4jbE84siI8dfYQbP2HOz0jg1yFaPHkpxB9tv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a05:6820:100d:b0:57f:10cb:516b with SMTP
 id v13-20020a056820100d00b0057f10cb516bmr3087810oor.0.1696876797162; Mon, 09
 Oct 2023 11:39:57 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:14 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 12/18] perf svghelper: Avoid memory leak
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On success path the sib_core and sib_thr values weren't being
freed. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/svghelper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 0e4dc31c6c9c..1892e9b6aa7f 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
 	int i, nr_cpus;
 	struct topology t;
 	char *sib_core, *sib_thr;
+	int ret = -1;
 
 	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
 
@@ -799,11 +800,11 @@ int svg_build_topology_map(struct perf_env *env)
 
 	scan_core_topology(topology_map, &t, nr_cpus);
 
-	return 0;
+	ret = 0;
 
 exit:
 	zfree(&t.sib_core);
 	zfree(&t.sib_thr);
 
-	return -1;
+	return ret;
 }
-- 
2.42.0.609.gbb76f46606-goog


