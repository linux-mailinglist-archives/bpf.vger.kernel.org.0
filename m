Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF96160D71C
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJYW2y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiJYW2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849679E0F4
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so16566922ejn.3
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJcaGBfkjdWGPkwuuaxd3CxPiCHKa/iDfVgs/xqPdsY=;
        b=qfl1ZDtY8efvhv0piwxS+sZm69wrJtJRmY+cI6x/zsjtkjOPolKnUO2w/RN6PsqxWB
         dfu52r22Y5L4vXE1vjQyttWRBPBaCr8DKfRRp0/0+OelXClWcI+so6qGUzRYgWX+SLV1
         H6fOddqWYPak8TXpY7x7wOFX8WaqhPnmlX0hiffzZV0bgOdU2eXPV/3q0wBAghB/HIQQ
         VWVguxm7LSiySakXgk3Kwt8PEELhHgRQl8SEkwScGJIn7axKi4DoLLOa4torslSLIYBX
         pXB3oxVyb5rjFA2eI3VrMV7tFOFKi+dU+Xs4jSJUmtcHb/QFD9TyyUiQIIfGEb1lGUk7
         ZXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJcaGBfkjdWGPkwuuaxd3CxPiCHKa/iDfVgs/xqPdsY=;
        b=pBKlQkkgdBQle73N6pXAkXZoCmKZXL5RO4L7OUW7+xQhXldOCAO6MuMuNxcj5zycfB
         gLV5COn7XIohRu2sfr9WBivaI+bU8lflSVsTum5mD7iP4qctMQ89rOrSSofK35W8Jqpu
         nxHiplOZHt4IVnwuyJI7Zc9gN4iBXYdg2k6mlqTeyws4kaYiMR/pQ9klRD+G/GH2wb4G
         oQTLVXD1HpiVmYMSI4obebOUTrV1M+VENtkklnDAywU/YLC6pm5zAiyX+2LSbPTDrvLD
         egyVdJ/8lGxtT2kQBQPBsYkjWnIV4HN5Lm7GHcGJ8oK33YYFPXeQX8GMzkjHQ/rkLCEv
         Z7zQ==
X-Gm-Message-State: ACrzQf0S2rioqKG5Q6a08iOymEviGQEM3g44TzVYpxVyh7iDs/lxiUcn
        D9P45hT345KU9ou1IRHdRwl5kE7NhVC/Ltr6
X-Google-Smtp-Source: AMsMyM6BrEPcTDDS3VpM3LvnEKW9wkNcotNQobdJ3DqDIUHp+CqjNEM1oT8sDoFRh0I44xA+F2vS/w==
X-Received: by 2002:a17:907:c27:b0:791:81f2:f2b1 with SMTP id ga39-20020a1709070c2700b0079181f2f2b1mr34843934ejc.436.1666736928891;
        Tue, 25 Oct 2022 15:28:48 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:48 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 10/12] selftests/bpf: Script to verify uapi headers usage with vmlinux.h
Date:   Wed, 26 Oct 2022 01:27:59 +0300
Message-Id: <20221025222802.2295103-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A script to test header guards in vmlinux.h by compiling a simple C
snippet for a set of selected UAPI headers. The snippet being
compiled looks as follows:

  #include <some_uapi_header.h>
  #include "vmlinux.h"

  __attribute__((section("tc"), used))
  int syncookie_tc(struct __sk_buff *skb) { return 0; }

If header guards are placed correctly in vmlinux.h the snippet
should compile w/o errors.

The list of known good headers is supposed to be located in
`tools/testing/selftests/bpf/good_uapi_headers.txt` added as a
separate commit.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/test_uapi_headers.py        | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/test_uapi_headers.py

diff --git a/tools/testing/selftests/bpf/test_uapi_headers.py b/tools/testing/selftests/bpf/test_uapi_headers.py
new file mode 100755
index 000000000000..1740c4fe0625
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_uapi_headers.py
@@ -0,0 +1,197 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+# A script to test header guards in vmlinux.h by compiling a simple C
+# snippet for a set of selected UAPI headers. The snippet being
+# compiled looks as follows:
+#
+#   #include <some_uapi_header.h>
+#   #include "vmlinux.h"
+#
+#   __attribute__((section("tc"), used))
+#   int syncookie_tc(struct __sk_buff *skb) { return 0; }
+#
+# If header guards are placed correctly in vmlinux.h the snippet
+# should compile w/o errors.
+#
+# The script could be used in two modes:
+# - interactive BPF testing and CI;
+# - debug mode.
+#
+# * Interactive BPF testing and CI
+#
+# Run script as follows:
+#
+#   ./test_uapi_headers.py
+#
+# In this mode the following actions are performed:
+# - kernel headers are installed to a temporary directory;
+# - a list of known good uapi headers is read from ./good_uapi_headers.txt;
+# - the snippet above is compiled by clang using BPF target for each header;
+# - if shell is interactive the progress / ETA are reported during execution;
+# - pass / fail statistics is reported in the end;
+# - headers temporary directory is deleted;
+# - script exit code is 0 if snippet could be compiled for all headers.
+#
+# The vmlinux.h processing time is significant (~700ms using Intel i7-4710HQ),
+# thus the headers are processed in parallel.
+#
+# * Debug mode
+#
+# The following parameters are available for debugging:
+#
+#   test_uapi_headers.py \
+#            [-h] [--kheaders KHEADERS] [--vmlinuxh VMLINUXH] [--test TEST]
+#
+#   options:
+#     -h, --help           show this help message and exit
+#     --kheaders KHEADERS  path to exported kernel headers
+#     --vmlinuxh VMLINUXH  path to vmlinux.h
+#     --test TEST          name of the header -or-
+#                          file with header names -or-
+#                          special value '*'
+#
+# When --kheaders is specified the temporary directory is not created
+# and KHEADERS is used instead. It is assumed that headers are already
+# installed to KHEADERS.
+#
+# When TEST names a header (e.g. 'linux/tcp.h') it is the to test.
+# When TEST names a file this file should contain a list of
+# headers to test one per line.
+# When TEST is '*' all exported headers are tested.
+#
+# The simplest way to debug an issue with a single header is:
+#
+#   ./test_uapi_headers.py --test linux/tcp.h
+
+import subprocess
+import concurrent.futures
+import pathlib
+import time
+import os
+import sys
+import argparse
+import tempfile
+import shutil
+import atexit
+from dataclasses import dataclass
+
+@dataclass
+class Result:
+    header: pathlib.Path
+    returncode: int
+    stderr: str
+
+def run_one(header, kheaders, vmlinuxh):
+    code=f'''
+#include <{header}>
+#include "{vmlinuxh}"
+
+__attribute__((section("tc"), used))
+int syncookie_tc(struct __sk_buff *skb)
+{{
+    return 0;
+}}
+    '''
+    command = f'''
+{os.getenv('CLANG', 'clang')} \
+    -g -Werror -mlittle-endian \
+    -D__x86_64__ \
+    -Xclang -fwchar-type=short \
+    -Xclang -fno-signed-wchar \
+    -I{kheaders}/include/ \
+    -Wno-compare-distinct-pointer-types \
+    -mcpu=v3 \
+    -O2 \
+    -target bpf \
+    -x c \
+    -o /dev/null \
+    -fsyntax-only \
+    -
+'''
+    proc = subprocess.run(command, input=code, capture_output=True,
+                          shell=True, encoding='utf8')
+    return Result(header=header,
+                  returncode=proc.returncode,
+                  stderr=proc.stderr)
+
+def run_all(headers, kheaders, vmlinuxh):
+    start_time = time.time()
+    ok = 0
+    fail = 0
+    failures = []
+    remain = len(headers)
+    print_progress = sys.stdout.isatty()
+    print(f'Processing {remain} headers.')
+    with concurrent.futures.ThreadPoolExecutor(max_workers=os.cpu_count()) as executor:
+        for result in executor.map(lambda header: run_one(header, kheaders, vmlinuxh),
+                                   headers):
+            if result.returncode == 0:
+                print(f"{result.header:<60}   ok")
+                ok += 1
+            else:
+                print(f"{result.header:<60} fail")
+                fail += 1
+                failures.append(result)
+            remain -= 1
+            if print_progress:
+                elapsed = time.time() - start_time
+                processed = ok + fail
+                time_per_header = elapsed / processed
+                eta = int(remain * time_per_header)
+                # keep this shorter than header ok/fail line
+                line = f"Ok {ok: >4} Fail {fail: >4} Remain {remain: >4} ETA {eta: >4}s"
+                print(line, end="\r")
+    if print_progress:
+        print('')
+    elapsed = int(time.time() - start_time)
+    if fail == 0:
+        print(f"Done in {elapsed}s, all {len(headers)} ok.")
+    else:
+        print('----- Failure details -----')
+        for result in failures:
+            print(f'{result.header}: rc = {result.returncode}')
+            for line in result.stderr.split('\n'):
+                print(f"{result.header}: {line}")
+        print(f"Done in {elapsed}s, {fail} out of {len(headers)} failed.")
+    return fail == 0
+
+def main(argv):
+    bpf_test_dir = pathlib.Path(__file__).resolve().parent
+    default_vmlinuxh = bpf_test_dir / './tools/include/vmlinux.h'
+    parser = argparse.ArgumentParser()
+    parser.add_argument("--kheaders", type=str, help='path to exported kernel headers')
+    parser.add_argument("--vmlinuxh", type=str, default=default_vmlinuxh,
+                        help='path to vmlinux.h')
+    parser.add_argument("--test", type=str,
+                        default='./good_uapi_headers.txt',
+                        help="name of the header | file with header names | special value '*'")
+    args = parser.parse_args(argv)
+
+    if args.kheaders is None:
+        kheaders = tempfile.mkdtemp(prefix='kheaders')
+        atexit.register(lambda: shutil.rmtree(kheaders))
+        kernel_dir = bpf_test_dir / '../../../../'
+        # Capture both stdout and stderr as stdout to simplify CI logging
+        subprocess.run(f'make -C {kernel_dir} INSTALL_HDR_PATH={kheaders} headers_install',
+                       stdout=sys.stdout, stderr=sys.stdout,
+                       check=True, shell=True)
+    else:
+        kheaders = args.kheaders
+
+    if os.path.exists(args.test):
+        with open(args.test, 'r') as list_file:
+            headers = [line.strip() for line in list_file]
+    elif args.test == '*':
+        headers = [p.relative_to(f'{kheaders}/include').as_posix()
+                   for p in pathlib.Path(kheaders).rglob("*.h")]
+    else:
+        headers = [args.test]
+
+    if run_all(headers, kheaders, args.vmlinuxh):
+        sys.exit(0)
+    else:
+        sys.exit(1)
+
+if __name__ == '__main__':
+    main(sys.argv[1:])
-- 
2.34.1

