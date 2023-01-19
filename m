Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E5A674102
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 19:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjASSbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 13:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjASSbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 13:31:31 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C0BB81
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 10:31:30 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x12-20020a17090abc8c00b00229f8cb27a5so489021pjr.1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g5ejasQrFsU/5gVpFRFubfv/+PZvkyzMvOtZ1k9Ls2g=;
        b=b0YxZwON3IV1/D404DMPS9jrW+M2J2WYkVE+iSbiN0STXINJePxujS9tiGUZi5i9G8
         C36lUwVPqY7JFPAiKBudcJbQsi9SVQPM2IydPaO1zAjdnmHDpPWOJQlbCBYhMa7b+PqT
         X+vVrtxMoiSRxQpfs1FeU6yXXymOIcr5cKECICCm1n5GJrdSUfHzAAK1Xdgn9njEa7e2
         AVyoCoEYej+TaYmBOLFNF7043pQxqtJjO0GbnE0Pec8l9KbB7gq7vJbXefZ5jIfs+/Px
         kIWoi5iZSo5VStr1tZ9lFx7c0/jR2Y2uzITBalGHkowv5JLcvJy1PWbvcdOVG7U7WH15
         OyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5ejasQrFsU/5gVpFRFubfv/+PZvkyzMvOtZ1k9Ls2g=;
        b=Br56k894ovSix9YO88k9BF7VrEtVKWya5okCTZqRz9ZQUGClL8GDbIVHT5Azh12XVf
         g8epraZ7oy4z1YV9rYTzQxjdcPDVXi53EGxDwgoJHNMOD3Y5OjaR3xSPH9fxHh2T6p4z
         7GeX/n1ySAIovGRKqGVcLVpJKwI9eErCZgGKaABfQuJvPLMJlyn1Bq0AnJC14u0QOtCU
         qLpntIQGMYurHMI8qJmk9h1iFHMbOgHstfVe+8xMJZ2X4dDMVkMXPYkUKyShI+FvSDbC
         ySLUaD/GHd7rMrCuHZkzW2JJGO99dmYStBBGH9cPf5DN00YwJATOnE126y2lJ+YCGFSI
         ffpg==
X-Gm-Message-State: AFqh2kq2qv5ccBgP3DeCOnHyqjNV1ZKRnH0/6PnFdQYMUhgYL4++qeIx
        Up+CaAemlMXKzEGl9oqh6MKmQX/pS4Ow
X-Google-Smtp-Source: AMrXdXsRZ1WORHapl+vRGimw/AuCvgzBAWX0gXnTXNVMG+s6DSp0/UCLa/EN1y6UP6olfWUfFA4BhUzyokOn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:93c6:b65e:5f33:bc6b])
 (user=irogers job=sendgmr) by 2002:a05:6a00:4c90:b0:58a:1e40:e474 with SMTP
 id eb16-20020a056a004c9000b0058a1e40e474mr1115087pfb.83.1674153089543; Thu,
 19 Jan 2023 10:31:29 -0800 (PST)
Date:   Thu, 19 Jan 2023 10:31:16 -0800
Message-Id: <20230119183118.126387-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3] perf script flamegraph: Avoid d3-flame-graph package dependency
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently flame graph generation requires a d3-flame-graph template to
be installed. Unfortunately this is hard to come by for things like
Debian [1]. If the template isn't installed then ask if it should be
downloaded from jsdelivr CDN. The downloaded HTML file is validated
against an md5sum. If the download fails, generate a minimal flame
graph with the javascript coming from links to jsdelivr CDN.

v3. Adds a warning message and quits before download in live mode.
v2. Change the warning to a prompt about downloading and add the
    --allow-download command line flag. Add an md5sum check for the
    downloaded HTML.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/scripts/python/flamegraph.py | 107 +++++++++++++++++++-----
 1 file changed, 85 insertions(+), 22 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index b6af1dd5f816..cf7ce8229a6c 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -19,12 +19,34 @@
 # pylint: disable=missing-function-docstring
 
 from __future__ import print_function
-import sys
-import os
-import io
 import argparse
+import hashlib
+import io
 import json
+import os
 import subprocess
+import sys
+import urllib.request
+
+minimal_html = """<head>
+  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
+</head>
+<body>
+  <div id="chart"></div>
+  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
+  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
+  <script type="text/javascript">
+  const stacks = [/** @flamegraph_json **/];
+  // Note, options is unused.
+  const options = [/** @options_json **/];
+
+  var chart = flamegraph();
+  d3.select("#chart")
+        .datum(stacks[0])
+        .call(chart);
+  </script>
+</body>
+"""
 
 # pylint: disable=too-few-public-methods
 class Node:
@@ -50,16 +72,6 @@ class FlameGraphCLI:
         self.args = args
         self.stack = Node("all", "root")
 
-        if self.args.format == "html" and \
-                not os.path.isfile(self.args.template):
-            print("Flame Graph template {} does not exist. Please install "
-                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
-                  "package, specify an existing flame graph template "
-                  "(--template PATH) or another output format "
-                  "(--format FORMAT).".format(self.args.template),
-                  file=sys.stderr)
-            sys.exit(1)
-
     @staticmethod
     def get_libtype_from_dso(dso):
         """
@@ -128,16 +140,63 @@ class FlameGraphCLI:
             }
             options_json = json.dumps(options)
 
+            template_md5sum = None
+            if self.args.format == "html":
+                if os.path.isfile(self.args.template):
+                    template = f"file://{self.args.template}"
+                else:
+                    if not self.args.allow_download:
+                        print(f"""Warning: Flame Graph template '{self.args.template}'
+does not exist. To avoid this please install a package such as the
+js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
+graph template (--template PATH) or use another output format (--format
+FORMAT).""",
+                              file=sys.stderr)
+                        if self.args.input == "-":
+                            print("""Not attempting to download Flame Graph template as script command line
+input is disabled due to using live mode. If you want to download the
+template retry without live mode. For example, use 'perf record -a -g
+-F 99 sleep 60' and 'perf script report flamegraph'. Alternatively,
+download the template from:
+https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html
+and place it at:
+/usr/share/d3-flame-graph/d3-flamegraph-base.html""",
+                                  file=sys.stderr)
+                            quit()
+                        s = None
+                        while s != "y" and s != "n":
+                            s = input("Do you wish to download a template from cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) [yn] ").lower()
+                        if s == "n":
+                            quit()
+                    template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
+                    template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
+
             try:
-                with io.open(self.args.template, encoding="utf-8") as template:
-                    output_str = (
-                        template.read()
-                        .replace("/** @options_json **/", options_json)
-                        .replace("/** @flamegraph_json **/", stacks_json)
-                    )
-            except IOError as err:
-                print("Error reading template file: {}".format(err), file=sys.stderr)
-                sys.exit(1)
+                with urllib.request.urlopen(template) as template:
+                    output_str = "".join([
+                        l.decode("utf-8") for l in template.readlines()
+                    ])
+            except Exception as err:
+                print(f"Error reading template {template}: {err}\n"
+                      "a minimal flame graph will be generated", file=sys.stderr)
+                output_str = minimal_html
+                template_md5sum = None
+
+            if template_md5sum:
+                download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
+                if download_md5sum != template_md5sum:
+                    s = None
+                    while s != "y" and s != "n":
+                        s = input(f"""Unexpected template md5sum.
+{download_md5sum} != {template_md5sum}, for:
+{output_str}
+continue?[yn] """).lower()
+                    if s == "n":
+                        quit()
+
+            output_str = output_str.replace("/** @options_json **/", options_json)
+            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
+
             output_fn = self.args.output or "flamegraph.html"
         else:
             output_str = stacks_json
@@ -172,6 +231,10 @@ if __name__ == "__main__":
                         choices=["blue-green", "orange"])
     parser.add_argument("-i", "--input",
                         help=argparse.SUPPRESS)
+    parser.add_argument("--allow-download",
+                        default=False,
+                        action="store_true",
+                        help="allow unprompted downloading of HTML template")
 
     cli_args = parser.parse_args()
     cli = FlameGraphCLI(cli_args)
-- 
2.39.0.314.g84b9a713c41-goog

