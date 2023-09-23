Return-Path: <bpf+bounces-10667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957E37ABDDC
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 397BA2828A9
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5A4691;
	Sat, 23 Sep 2023 05:35:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E5525F
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:35:46 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B861A7
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e1154756so52512417b3.2
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447343; x=1696052143; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyfrmX8SYfxgP/g8BqVIBEEAppz8GcyEO0PbPfBBKMU=;
        b=Rrnxpz8b7CQsjl33ag4+KIJDZ44WsK45VgBlBkACcwOhC8koDh8HFTPvf+Al8zr1n0
         ipW1YoTNcxaGp3fLiuwk1MM3ckTgb90ORM6RxfqPzP1E1I3O6rIoDbLePu1eZKdUfRUs
         OaHr8MJsI9MScYjIRhcyY+vAMug4j5cFbOo2DAybSkxGW5ssUJ2Nq0D+rUdNOQz3ZlZw
         VMe/6mFap9k9iaXYH3eOGliEyvPLfzApttNoyf4YQkmjmIcukK7zY1I5Cf2i1VJezi9T
         gTj/vXHuJaXStealOy/tjzxXsXO5kfNsR83xrA203sFS1B1BdRjkdmkhpHwXHOZw7erp
         J7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447343; x=1696052143;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyfrmX8SYfxgP/g8BqVIBEEAppz8GcyEO0PbPfBBKMU=;
        b=eK7l1da1YZ67WghVFD6OKrVLSa3xl0RcRcybTWYW3JbPmhGN16JcQJv5XYURFlkAhw
         AsOplJIlLRdhL1+KW7kMui8YKxflg0bcpHsIptPVakwBMwxc6cqRyFGimo0/0otOlmCU
         iXFncH0azTPDyjWkrzBU1kgpOo18n/dVxITMj7q699HkeND/t2Cv/XoKm5ZXg1uxeTZE
         OyBDY+k9Qh+poatxjvhRJrFWWzgVsN8MEutfYv8Ov3ipqafE2ndivsKNdyMQOWDwhbbH
         sk7bJbA4JbTIAIcrq3sZ1Al03xOVsbaZdpsJo2daQiRqFQj66wFY0oZswtzdV8813C5Y
         BTuQ==
X-Gm-Message-State: AOJu0Yz0yIfF1iB+e7f33JjxQWe96NN8unKI3wphKbStxhz62vokrO1Q
	ekUh7+x9abpvwVOnVQQ+Cnq0kYAKjxPZ
X-Google-Smtp-Source: AGHT+IETS2wMpCT0fvXFeWRIoyxRh6J1rlFulgIYswN8qY/BztVcD0h804M/t46jW2XazPHnfi7jT5YN+Nc2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a81:c607:0:b0:59b:d9b8:9ae3 with SMTP id
 l7-20020a81c607000000b0059bd9b89ae3mr21091ywi.10.1695447343513; Fri, 22 Sep
 2023 22:35:43 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:00 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 03/18] run-clang-tools: Add pass through checks and and
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
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a -checks argument to allow the checks passed to the clang-tool to
be set on the command line.

Add a pass through -header-filter option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 scripts/clang-tools/run-clang-tools.py | 34 ++++++++++++++++++++------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index 3266708a8658..5dfe03852cb4 100755
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
 
 
@@ -45,14 +50,29 @@ def init(l, a):
 
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
+    pargs = ["clang-tidy", "-p", args.path]
+    if checks:
+        pargs.append("-checks=" + ",".join(checks))
+    if args.header_filter:
+        pargs.append("-header-filter=" + args.header_filter)
+    pargs.append(file)
+    p = subprocess.run(pargs,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT,
                        cwd=entry["directory"])
-- 
2.42.0.515.g380fc7ccd1-goog


