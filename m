Return-Path: <bpf+bounces-11489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F71B7BAF09
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CA9B72825DA
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDD436B7;
	Thu,  5 Oct 2023 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZVuZXdw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945C43695
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:10 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B8B132
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f6902dc8bso22774597b3.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547344; x=1697152144; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVKoLuc5a7LEHlQh90vyaH3VbvcXZG1OCxjaJSmoY8k=;
        b=uZVuZXdwF+UaQzN+j5ci/zOPDWqvXBGviotmMlC1ioE/3wiNDwWySHYd75Gm8qezlH
         0uQX1dMtw1/zgS3ZA3Y73XsCeReO6sN8AWcnZXRh+scinxEslZZydX/du0KVM/evNW4O
         5pNMkqYqfEGXrRaV2A0W6Zp+V8dKCPcF2hn6ZkSRC9k7tkgTu5YlHwb1e1N6GuzqH75f
         GP6nx3NHo7LwHIK49uZd1YGkFk9W7CYnD3IXwj2n3mJBZLriaMbnUjtd90i/ClVZtljJ
         +/OXre5yLaaBZAts79ki+gWCPQVWR33Dzvzm5yqmZZOK6/taF7TA34YLkqJEsAP0IgMj
         88DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547344; x=1697152144;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVKoLuc5a7LEHlQh90vyaH3VbvcXZG1OCxjaJSmoY8k=;
        b=p6N8yIJvDIZKrDxIOg1DL8qqfy4d0FOid4QM/BwsqjEV4XFxbunaH3sZyN38+OWL8H
         ql9T/IbzQW+5DAXMr5wmz4kjKt9070XFBKYBzhsmdyp9+Vr7eAro2iaclZ9OkG91TR/e
         O+UzAa93K52hZkGUgZuK/EPWyAzw9dSPj9nqjqATwMULHXX0fN3dDaBhIh+trr/K5IXq
         YDujYOoBOPnrNVE0I2e5Q4CJpUk6824Nijrus6H2XY4mMp7GdJB+CS4aEiHn+Qam7Bk3
         /OOtcGxxl463N3u08hlXd75uy5HuKxRvOXSDtQ2vUl7GLD2SvnNIZYNqgB2uqVT8V3it
         D0mw==
X-Gm-Message-State: AOJu0YxMnq1VYBooVOJ5eiPJE0hhcE7UXrXGWF1xaxikucqetCrErLQz
	SQh1IDLByL2gAe8ikYzBr8gNidLpTSyT
X-Google-Smtp-Source: AGHT+IHo6U+kJASF6nCohpjFiAn0CLPcx5Qb6otqZC+Kpf+MOzGXa7HHf6AdITUGY7vbn2be8G5F1c0EEIDU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:d4d1:0:b0:d81:7d48:a459 with SMTP id
 m200-20020a25d4d1000000b00d817d48a459mr114013ybf.8.1696547344121; Thu, 05 Oct
 2023 16:09:04 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:36 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 03/18] run-clang-tools: Add pass through checks and and
 header-filter arguments
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a -checks argument to allow the checks passed to the clang-tool to
be set on the command line.

Add a pass through -header-filter option.

Don't run analysis on non-C or CPP files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 scripts/clang-tools/run-clang-tools.py | 32 ++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index 3266708a8658..f31ffd09e1ea 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -33,6 +33,11 @@ def parse_arguments():
     path_help = "Path to the compilation database to parse"
     parser.add_argument("path", type=str, help=path_help)
 
+    checks_help = "Checks to pass to the analysis"
+    parser.add_argument("-checks", type=str, default=None, help=checks_help)
+    header_filter_help = "Pass the -header-filter value to the tool"
+    parser.add_argument("-header-filter", type=str, default=None, help=header_filter_help)
+
     return parser.parse_args()
 
 
@@ -45,14 +50,27 @@ def init(l, a):
 
 def run_analysis(entry):
     # Disable all checks, then re-enable the ones we want
-    checks = []
-    checks.append("-checks=-*")
-    if args.type == "clang-tidy":
-        checks.append("linuxkernel-*")
+    global args
+    checks = None
+    if args.checks:
+        checks = args.checks.split(',')
     else:
-        checks.append("clang-analyzer-*")
-        checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
-    p = subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks), entry["file"]],
+        checks = ["-*"]
+        if args.type == "clang-tidy":
+            checks.append("linuxkernel-*")
+        else:
+            checks.append("clang-analyzer-*")
+            checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
+    file = entry["file"]
+    if not file.endswith(".c") and not file.endswith(".cpp"):
+        with lock:
+            print(f"Skipping non-C file: '{file}'", file=sys.stderr)
+        return
+    pargs = ["clang-tidy", "-p", args.path, "-checks=" + ",".join(checks)]
+    if args.header_filter:
+        pargs.append("-header-filter=" + args.header_filter)
+    pargs.append(file)
+    p = subprocess.run(pargs,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT,
                        cwd=entry["directory"])
-- 
2.42.0.609.gbb76f46606-goog


