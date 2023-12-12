Return-Path: <bpf+bounces-17481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF880E1EB
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 03:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED83D1C21758
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 02:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988E7F5;
	Tue, 12 Dec 2023 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE07Pdcd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555722698
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 18:32:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-336121f93e3so1511158f8f.0
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 18:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348342; x=1702953142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDJhmzzuhJUDsa3iZIw/8V5aN0B8Hg7KTWSRn6k8TsY=;
        b=ZE07Pdcd50Uwa46SXflDkciy2xm/ZoFRNHWB3FvETErw+Y45eVB5ybncUUJOYoanPg
         gb/dHNi9epMNmO6ec5imGoagWuatRvtK9Uw58Ep+EcoJ/cjYvx3WfAyLDD3b34FXeayq
         AOt0cnDRP13PVC/i3OCsmRv3upjjEfJnZdiqkJGXvNw/e7BD/ULtj49zqmCK08ipC+il
         m5/XznVVDyTjof5ciFQnNZmh/EY9NDIWfs0TtCrff8D8/zjI6xpRlVFpfcD7/E3byNMM
         l/xr95jDLV1SNmitSaUk7tEwIwnAcrBmqw3uu5Z9rl0ra61VE8NHq8BVThfp0yGoamKB
         4ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348342; x=1702953142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDJhmzzuhJUDsa3iZIw/8V5aN0B8Hg7KTWSRn6k8TsY=;
        b=K0jIAie7r5asy7Jkv8fbB8sPehIQElSiww+cbZvI5h2C4WFY9tp5fZ3QC3vmPAirK8
         d4ZrX+rKBguRzM1qjRA/bL9B2RkP6qdIFAVpAxHf0QrcThQDAO98GHfoc6T8zDyg+bqI
         cwKRDX/wEH2B/XKWuXqmv/NKUwDiBzQ3tB10g/LPs1UVsToJayctmsa54eRDMxy74XQt
         tCMwYyb/v0GuHc/qvgDY6pNnSOHUQBajFOx1odx2r0ukA4+9Y4xBy5KdluKD0kjjPPSL
         6CEbRkO/GOlL4H84OyYxy+EgYEu7qou+ATORh6z8RoePWU2cZAy68uH6JyN1agFiT0OW
         +72w==
X-Gm-Message-State: AOJu0YxDw97a8Q82Gm+79Aryz43DWXzuLoamJzZnEo/vdDZyFp9+Hp77
	JI5T05ZRXQ4wmQUtZqX4g+YZfXyJaOY=
X-Google-Smtp-Source: AGHT+IHJOJX6bb1yFvJwMrB4D1BG7ibfbu4sI+jzuX7914ZDclfoBOjYsEupKCiMlnrY9W5B1xLYYg==
X-Received: by 2002:a5d:6351:0:b0:336:2a24:eb88 with SMTP id b17-20020a5d6351000000b003362a24eb88mr255854wrw.46.1702348342201;
        Mon, 11 Dec 2023 18:32:22 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e12-20020adfe38c000000b003332fa77a0fsm9659900wrm.21.2023.12.11.18.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:32:21 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC v2 3/3] selftests/bpf: verify bpftool emits preserve_static_offset
Date: Tue, 12 Dec 2023 04:31:36 +0200
Message-ID: <20231212023136.7021-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212023136.7021-1-eddyz87@gmail.com>
References: <20231212023136.7021-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend test_bpftool.py with following test cases:
- Load a small program that has some context types in it's BTF,
  verify that "bpftool btf dump file ... format c" emits
  preserve_static_offset attribute.
- Load a small program that has no context types in it's BTF,
  verify that "bpftool btf dump file ... format c" does not emit
  preserve_static_offset attribute.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/dummy_no_context_btf.c          | 12 ++++
 .../selftests/bpf/progs/dummy_sk_buff_user.c  | 14 +++++
 tools/testing/selftests/bpf/test_bpftool.py   | 61 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_no_context_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c

diff --git a/tools/testing/selftests/bpf/progs/dummy_no_context_btf.c b/tools/testing/selftests/bpf/progs/dummy_no_context_btf.c
new file mode 100644
index 000000000000..5a1df4984dce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dummy_no_context_btf.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* A dummy program that does not reference context types in it's BTF */
+SEC("tc")
+__u32 dummy_prog(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c b/tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c
new file mode 100644
index 000000000000..f271881bcbd0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* A dummy program that references __sk_buff type in it's BTF,
+ * used by test_bpftool.py.
+ */
+SEC("tc")
+int sk_buff_user(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_bpftool.py b/tools/testing/selftests/bpf/test_bpftool.py
index 1c2408ee1f5d..3117f431dd92 100644
--- a/tools/testing/selftests/bpf/test_bpftool.py
+++ b/tools/testing/selftests/bpf/test_bpftool.py
@@ -8,6 +8,7 @@ import os
 import socket
 import subprocess
 import unittest
+import io
 
 
 # Add the source tree of bpftool and /usr/local/sbin to PATH
@@ -25,6 +26,10 @@ class UnprivilegedUserError(Exception):
     pass
 
 
+class MissingDependencyError(Exception):
+    pass
+
+
 def _bpftool(args, json=True):
     _args = ["bpftool"]
     if json:
@@ -63,12 +68,22 @@ DMESG_EMITTING_HELPERS = [
         "bpf_trace_vprintk",
     ]
 
+DUMMY_SK_BUFF_USER_OBJ = cur_dir + "/dummy_sk_buff_user.bpf.o"
+DUMMY_NO_CONTEXT_BTF_OBJ = cur_dir + "/dummy_no_context_btf.bpf.o"
+
 class TestBpftool(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         if os.getuid() != 0:
             raise UnprivilegedUserError(
                 "This test suite needs root privileges")
+        objs = [DUMMY_SK_BUFF_USER_OBJ,
+                DUMMY_NO_CONTEXT_BTF_OBJ]
+        for obj in objs:
+            if os.path.exists(obj):
+                continue
+            raise MissingDependencyError(
+                "File " + obj + " does not exist, make sure progs/*.c are compiled")
 
     @default_iface
     def test_feature_dev_json(self, iface):
@@ -172,3 +187,49 @@ class TestBpftool(unittest.TestCase):
         res = bpftool(["feature", "probe", "macros"])
         for pattern in expected_patterns:
             self.assertRegex(res, pattern)
+
+    def assertStringsPresent(self, text, patterns):
+        pos = 0
+        for i, pat in enumerate(patterns):
+            m = text.find(pat, pos)
+            if m == -1:
+                with io.StringIO() as msg:
+                    print("Can't find expected string:", file=msg)
+                    for s in patterns[0:i]:
+                        print("    MATCHED: " + s, file=msg)
+                    print("NOT MATCHED: " + pat, file=msg)
+                    print("", file=msg)
+                    print("Searching in:", file=msg)
+                    print(text, file=msg)
+                    self.fail(msg.getvalue())
+            pos += len(pat)
+
+    # Load a small program that has some context types in it's BTF,
+    # verify that "bpftool btf dump file ... format c" emits
+    # preserve_static_offset attribute.
+    def test_c_dump_preserve_static_offset_present(self):
+        res = bpftool(["btf", "dump", "file", DUMMY_SK_BUFF_USER_OBJ, "format", "c"])
+        self.assertStringsPresent(res, [
+            "#if !defined(BPF_NO_PRESERVE_STATIC_OFFSET) && " +
+              "__has_attribute(preserve_static_offset)",
+            "#pragma clang attribute push " +
+              "(__attribute__((preserve_static_offset)), apply_to = record)",
+            "struct __sk_buff;",
+            "struct bpf_sock;",
+            "#pragma clang attribute pop",
+            "#endif /* BPF_NO_PRESERVE_STATIC_OFFSET */",
+            "#pragma clang attribute push " +
+              "(__attribute__((preserve_access_index)), apply_to = record)",
+            "struct __sk_buff {",
+        ])
+
+    # Load a small program that has no context types in it's BTF,
+    # verify that "bpftool btf dump file ... format c" does not emit
+    # preserve_static_offset attribute.
+    def test_c_dump_no_preserve_static_offset(self):
+        res = bpftool(["btf", "dump", "file", DUMMY_NO_CONTEXT_BTF_OBJ, "format", "c"])
+        self.assertNotRegex(res, "preserve_static_offset")
+        self.assertStringsPresent(res, [
+            "preserve_access_index",
+            "typedef unsigned int __u32;"
+        ])
-- 
2.42.1


