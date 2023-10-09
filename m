Return-Path: <bpf+bounces-11751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDEB7BE9CB
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9140628211C
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D9331A86;
	Mon,  9 Oct 2023 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbgOyqyv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F81F951
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:38 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD2E6
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so1330727b3.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876776; x=1697481576; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=husYgJZI8HkXIeEAlVmrxb2HP2ESjHLdcuso9o2l4OQ=;
        b=pbgOyqyvlD011FRFCZ/wnDOEV5NneFzPc1aVqQOX6e9vd71ycHrFTGtTrzsDZpbS51
         bRy1bc23HNVBTWBUNkbaWEyH0I0zxun1ux+KOKqJdfWvCiDaZO9S4CbXOwftQbK1Fbew
         G23hRCOPe+DEonYi44XWLaeZ1p+gdsUNgOChZUfpNqKZLan1DooqYNIvPUDMJDMFqB1V
         jMgQk0o1Ileg0vhoIrVvllaRXwzBaEhJAiwIAP5sWVw9AmMJ7KRmvOcrEaf4nZ0e0AIA
         ENkf4UU409d3SGJ6YzaCbgQqFvY63FzZkGo6S/PQ5g8GIpqgku46+K3o655OJ3C/qArk
         IqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876776; x=1697481576;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=husYgJZI8HkXIeEAlVmrxb2HP2ESjHLdcuso9o2l4OQ=;
        b=ZS1/6BXmzMvbbEEIh11A1DMZTUmpA8pvcwr3HpgHHKQiYRZhW7ckbQje4r6t1gY6AN
         33Blq2Ky2gbEiJY44A9hXF3VrGx9EIFr1xKDDyftGrTW39iT1mss97JD8HxzbpzVRABF
         C7T5/0cXf02Rs3I8V8eK+qJJZMJd/G44rvbR56ooVwzhfaLdOo2c45j+J7m5HXUUgkVC
         qc5se9dj8cqnT62LSND3Y2h0Duny+RFQCc+Y/ZQWB+pNm70eo30i+91Nodzu0IWrPcNu
         SKwD0PTIv25yWU/fVEd6BdQWKYtPTab/or1bs41HsISQ0TFf2mnMpIySOrbiInm2q0b/
         Ew0Q==
X-Gm-Message-State: AOJu0YxoUU/ZPTh2/IieS3uOcNvo8XyjAVmIVTqaNJo/r1rcZmEPtE09
	2MUr1lqjk1KRxzSLoCUDodPlXn97JFLz
X-Google-Smtp-Source: AGHT+IEmIpves+ngQa/FnxLG2CDSAz+zgDHCABHfkgCw1xRVBQfEO08K/FXFPnYfqQ71+Ihm3xsKsmi3qj2I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a05:690c:c90:b0:59b:b0b1:d75a with SMTP id
 cm16-20020a05690c0c9000b0059bb0b1d75amr262884ywb.4.1696876775752; Mon, 09 Oct
 2023 11:39:35 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:05 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 03/18] run-clang-tools: Add pass through checks and
 header-filter arguments
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

Add a -checks argument to allow the checks passed to the clang-tool to
be set on the command line.

Add a pass through -header-filter option.

Don't run analysis on non-C or CPP files.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
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


