Return-Path: <bpf+bounces-18383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E01819FDD
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700052859A8
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8C6364C0;
	Wed, 20 Dec 2023 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duvH+fN6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDC34571
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55333eb0312so3560727a12.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 05:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703079266; x=1703684066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3A/URYk/DG7Nbo2s4FISJ26H5RRuamlRT5uGABUpxw=;
        b=duvH+fN6/JpqfzK+rrN7ehQ8SkyZbb7NIbJqyEf9aXG9i3BrCZUFkBMxQ0wXE3K2XY
         vkZ3CT6SHcbKE7kHsY+mDxDmRL3AKB0FyIMySYUgB6d2vgjo5NZYZoEkoEzWuhe/V7KE
         JKrE5xAl//rhetgnoTf/trbSi7owwFo1vW757Lim8tSfQwWbRW+CJr5RrJn5Df24R9UV
         NEZXz74513IL9eWXDT90l2uYmLyM5hg4vRq3pWkJtqx020MZt7iwNbPQWCw1iovwuBGV
         4wi44ipdWC3QaO7glokLwn3U5f11fTjGHqc38q8CYjc85A8H3JJEsitnxjmLq6Uf+U2K
         w5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079266; x=1703684066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3A/URYk/DG7Nbo2s4FISJ26H5RRuamlRT5uGABUpxw=;
        b=WcT6rnOvCEqXPA3fzESqWh/QummsGnz1Df+CycgLAOJ8lmxoq/X5mexIVVzUvaGCH0
         mZYq8gtjWfElVV3TlqhpIsZxhhbzFDTv5NJXvY/wbRWZk1lg+rjKnDMNR5Xck9cxWkQS
         PruAweKzBENWaTn0SVV1DzGGNR2bOOHxXE5XHtOiCOZz4J8del1H7oTW/MDiCiUtWSb3
         89QwdqAPCQhdxSZ3zgQ7EYOPVgKn05+yecHePq2wQ1SrRJlFMeLbczbGfka9Vj7qsbBk
         fND91eNeAWtOSyPkypYXgo7iZ6edUKNw1ejc9C0sodzMeSyy6Ov7xVjNT+2Zf/IL+JYb
         7x1Q==
X-Gm-Message-State: AOJu0YzioX3reH16mpdBkPSxyVKrNZ2tHnJ9gTHdRJI4jva9WIjvN7Hu
	cBMF8QKQ1De/VA5z5MQd7sfoxHrPtEY=
X-Google-Smtp-Source: AGHT+IHlsOOIMQ6illWNLSeMhgElrmpwGRDjOW2Fk6H1fH90XRmaik9e0+vylhGEtL8+h05d4Os06A==
X-Received: by 2002:a17:906:270a:b0:a23:54a3:696e with SMTP id z10-20020a170906270a00b00a2354a3696emr3110136ejc.13.1703079266198;
        Wed, 20 Dec 2023 05:34:26 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vs4-20020a170907a58400b00a22fb8901c4sm9951032ejc.12.2023.12.20.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:34:25 -0800 (PST)
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
Subject: [RFC v3 3/3] selftests/bpf: verify bpftool emits preserve_static_offset
Date: Wed, 20 Dec 2023 15:34:11 +0200
Message-ID: <20231220133411.22978-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220133411.22978-1-eddyz87@gmail.com>
References: <20231220133411.22978-1-eddyz87@gmail.com>
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
- Load a small program that uses a map,
  verify that "bpftool btf dump map pinned ... value format c"
  emit preserve_static_offset for expected types.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/dummy_no_context_btf.c          |  12 +++
 .../selftests/bpf/progs/dummy_prog_with_map.c |  65 ++++++++++++
 .../selftests/bpf/progs/dummy_sk_buff_user.c  |  29 +++++
 tools/testing/selftests/bpf/test_bpftool.py   | 100 ++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_no_context_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_prog_with_map.c
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
diff --git a/tools/testing/selftests/bpf/progs/dummy_prog_with_map.c b/tools/testing/selftests/bpf/progs/dummy_prog_with_map.c
new file mode 100644
index 000000000000..0268317494ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dummy_prog_with_map.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if __has_attribute(btf_decl_tag)
+#define __decl_tag_bpf_ctx __attribute__((btf_decl_tag(("preserve_static_offset"))))
+#endif
+
+struct test_struct_a {
+	int v;
+} __decl_tag_bpf_ctx;
+
+struct test_struct_b {
+	int v;
+} __decl_tag_bpf_ctx;
+
+struct test_struct_c {
+	int v;
+} __decl_tag_bpf_ctx;
+
+struct test_struct_d {
+	int v;
+} __decl_tag_bpf_ctx;
+
+struct test_struct_e {
+	int v;
+} __decl_tag_bpf_ctx;
+
+struct test_struct_f {
+	int v;
+} __decl_tag_bpf_ctx;
+
+typedef struct test_struct_c test_struct_c_td;
+
+struct map_value {
+	struct test_struct_a a;
+	struct test_struct_b b[2];
+	test_struct_c_td c;
+	const struct test_struct_d *(*d)(volatile struct test_struct_e *);
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, struct map_value);
+} test_map1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, struct test_struct_f);
+} test_map2 SEC(".maps");
+
+/* A dummy program that references map 'test_map', used by test_bpftool.py */
+SEC("tc")
+int dummy_prog_with_map(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c b/tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c
new file mode 100644
index 000000000000..8c10aebe8689
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* In linux/bpf.h __bpf_ctx macro is defined differently for BPF and
+ * non-BPF targets:
+ * - for BPF it is __attribute__((preserve_static_offset))
+ * - for non-BPF it is __attribute__((btf_decl_tag("preserve_static_offset")))
+ *
+ * bpftool uses decl tag as a signal to emit preserve_static_offset,
+ * thus additional declaration is needed in this test.
+ */
+#if __has_attribute(btf_decl_tag)
+#define __decl_tag_bpf_ctx __attribute__((btf_decl_tag(("preserve_static_offset"))))
+#endif
+
+struct __decl_tag_bpf_ctx __sk_buff;
+
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
index 1c2408ee1f5d..d3a8b71afcc1 100644
--- a/tools/testing/selftests/bpf/test_bpftool.py
+++ b/tools/testing/selftests/bpf/test_bpftool.py
@@ -3,10 +3,12 @@
 
 import collections
 import functools
+import io
 import json
 import os
 import socket
 import subprocess
+import tempfile
 import unittest
 
 
@@ -25,6 +27,10 @@ class UnprivilegedUserError(Exception):
     pass
 
 
+class MissingDependencyError(Exception):
+    pass
+
+
 def _bpftool(args, json=True):
     _args = ["bpftool"]
     if json:
@@ -63,12 +69,26 @@ DMESG_EMITTING_HELPERS = [
         "bpf_trace_vprintk",
     ]
 
+BPFFS_MOUNT = "/sys/fs/bpf/"
+
+DUMMY_SK_BUFF_USER_OBJ = cur_dir + "/dummy_sk_buff_user.bpf.o"
+DUMMY_NO_CONTEXT_BTF_OBJ = cur_dir + "/dummy_no_context_btf.bpf.o"
+DUMMY_PROG_WITH_MAP_OBJ = cur_dir + "/dummy_prog_with_map.bpf.o"
+
 class TestBpftool(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         if os.getuid() != 0:
             raise UnprivilegedUserError(
                 "This test suite needs root privileges")
+        objs = [DUMMY_SK_BUFF_USER_OBJ,
+                DUMMY_NO_CONTEXT_BTF_OBJ,
+                DUMMY_PROG_WITH_MAP_OBJ]
+        for obj in objs:
+            if os.path.exists(obj):
+                continue
+            raise MissingDependencyError(
+                "File " + obj + " does not exist, make sure progs/*.c are compiled")
 
     @default_iface
     def test_feature_dev_json(self, iface):
@@ -172,3 +192,83 @@ class TestBpftool(unittest.TestCase):
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
+    def assertPreserveStaticOffset(self, btf_dump, types):
+        self.assertStringsPresent(btf_dump, [
+            "#if !defined(BPF_NO_PRESERVE_STATIC_OFFSET) && " +
+              "__has_attribute(preserve_static_offset)",
+            "#pragma clang attribute push " +
+              "(__attribute__((preserve_static_offset)), apply_to = record)"
+        ] + ["struct " + t + ";" for t in types] + [
+            "#endif /* BPF_NO_PRESERVE_STATIC_OFFSET */"
+        ])
+
+    # Load a small program that has some context types in it's BTF,
+    # verify that "bpftool btf dump file ... format c" emits
+    # preserve_static_offset attribute.
+    def test_c_dump_preserve_static_offset_present(self):
+        res = bpftool(["btf", "dump", "file", DUMMY_SK_BUFF_USER_OBJ, "format", "c"])
+        self.assertPreserveStaticOffset(res, ["__sk_buff"])
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
+
+    # When BTF is dumped for maps bpftool follows a slightly different
+    # code path, that filters which BTF types would be printed.
+    # Test this code path here:
+    # - load a program that uses a map, value type of which references
+    #   a number of structs annotated with preserve_static_offset;
+    # - dump BTF for that map and check preserve_static_offset annotation
+    #   for expected structs.
+    def test_c_dump_preserve_static_offset_map(self):
+        prog_pin = tempfile.mktemp(prefix="dummy_prog_with_map", dir=BPFFS_MOUNT)
+        maps_dir = tempfile.mktemp(prefix="dummy_prog_with_map_maps", dir=BPFFS_MOUNT)
+        map_pin1 = maps_dir + "/test_map1"
+        map_pin2 = maps_dir + "/test_map2"
+
+        bpftool(["prog", "load", DUMMY_PROG_WITH_MAP_OBJ, prog_pin, "pinmaps", maps_dir])
+        try:
+            map1 = bpftool(["btf", "dump", "map", "pinned", map_pin1, "value", "format", "c"])
+            map2 = bpftool(["btf", "dump", "map", "pinned", map_pin2, "value", "format", "c"])
+        finally:
+            os.remove(prog_pin)
+            os.remove(map_pin1)
+            os.remove(map_pin2)
+            os.rmdir(maps_dir)
+
+        # test_map1 should have all types except struct test_struct_f
+        self.assertPreserveStaticOffset(map1, [
+            "test_struct_a", "test_struct_b", "test_struct_c",
+            "test_struct_d", "test_struct_e",
+        ])
+        self.assertNotRegex(map1, "test_struct_f")
+
+        # test_map2 should have only struct test_struct_f
+        self.assertPreserveStaticOffset(map2, [
+            "test_struct_f"
+        ])
+        self.assertNotRegex(map2, "struct test_struct_a")
-- 
2.42.1


