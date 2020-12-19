Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91B2DF07F
	for <lists+bpf@lfdr.de>; Sat, 19 Dec 2020 17:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgLSQhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Dec 2020 11:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgLSQhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Dec 2020 11:37:38 -0500
X-Greylist: delayed 114489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Dec 2020 08:36:58 PST
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E28C0613CF;
        Sat, 19 Dec 2020 08:36:58 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 661C711A001; Sat, 19 Dec 2020 16:36:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1608395812; bh=8RP5rz8CNGcuLtaMCpzX9Irg/Np97e3ADKyXle5srDA=;
        h=Date:From:To:Subject:From;
        b=IUoF2zitx8luLuM7Y99eRe26soWG6QtuJkngdfWPBqH/h381GxbMea4LLFQmGLsoZ
         RXZII5T9T2u49u/GYH6qvd6xaWigxu5gvb8Xij9o1oo5UiljlsSWwV0NujRdraKBcr
         PkXVghXAAmGmpqXNp+gs19Iswv18C2SIuO3rcdDkTedXHrS06ZlC/sKuuUY+m3eFFz
         0UFUtCnUvvRol7CcDgv4WNmUPnEvwwuswpSwILIBGxS56kpYlzxFdd9HtGLX+O81OI
         vfzLQROZFfpcG9HJlNVK4qkc33oAQF61yjWLUyDPf5kFkZOsS2YbhjqcRN1yqz21bn
         CsRB2UOYdwfcg==
Date:   Sat, 19 Dec 2020 16:36:52 +0000
From:   Sean Young <sean@mess.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2] btf: support ints larger than 128 bits
Message-ID: <20201219163652.GA22049@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

clang supports arbitrary length ints using the _ExtInt extension. This
can be useful to hold very large values, e.g. 256 bit or 512 bit types.

Larger types (e.g. 1024 bits) are possible but I am unaware of a use
case for these.

This requires the _ExtInt extension enabled in clang, which is under
review.

Link: https://clang.llvm.org/docs/LanguageExtensions.html#extended-integer-types
Link: https://reviews.llvm.org/D93103

Signed-off-by: Sean Young <sean@mess.org>
---
changes since v2:
 - added tests as suggested by Yonghong Song
 - added kernel pretty-printer

 Documentation/bpf/btf.rst                     |   4 +-
 include/uapi/linux/btf.h                      |   2 +-
 kernel/bpf/btf.c                              |  54 +-
 tools/bpf/bpftool/btf_dumper.c                |  40 ++
 tools/include/uapi/linux/btf.h                |   2 +-
 tools/lib/bpf/btf.c                           |   2 +-
 tools/testing/selftests/bpf/Makefile          |   3 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  |   3 +-
 .../selftests/bpf/progs/test_btf_extint.c     |  50 ++
 tools/testing/selftests/bpf/test_extint.py    | 535 ++++++++++++++++++
 10 files changed, 679 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_extint.c
 create mode 100755 tools/testing/selftests/bpf/test_extint.py

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 44dc789de2b4..784f1743dbc7 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -132,7 +132,7 @@ The following sections detail encoding of each kind.
 
   #define BTF_INT_ENCODING(VAL)   (((VAL) & 0x0f000000) >> 24)
   #define BTF_INT_OFFSET(VAL)     (((VAL) & 0x00ff0000) >> 16)
-  #define BTF_INT_BITS(VAL)       ((VAL)  & 0x000000ff)
+  #define BTF_INT_BITS(VAL)       ((VAL)  & 0x000003ff)
 
 The ``BTF_INT_ENCODING`` has the following attributes::
 
@@ -147,7 +147,7 @@ pretty print. At most one encoding can be specified for the int type.
 The ``BTF_INT_BITS()`` specifies the number of actual bits held by this int
 type. For example, a 4-bit bitfield encodes ``BTF_INT_BITS()`` equals to 4.
 The ``btf_type.size * 8`` must be equal to or greater than ``BTF_INT_BITS()``
-for the type. The maximum value of ``BTF_INT_BITS()`` is 128.
+for the type. The maximum value of ``BTF_INT_BITS()`` is 512.
 
 The ``BTF_INT_OFFSET()`` specifies the starting bit offset to calculate values
 for this int. For example, a bitfield struct member has:
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 5a667107ad2c..1696fd02b302 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -84,7 +84,7 @@ struct btf_type {
  */
 #define BTF_INT_ENCODING(VAL)	(((VAL) & 0x0f000000) >> 24)
 #define BTF_INT_OFFSET(VAL)	(((VAL) & 0x00ff0000) >> 16)
-#define BTF_INT_BITS(VAL)	((VAL)  & 0x000000ff)
+#define BTF_INT_BITS(VAL)	((VAL)  & 0x000003ff)
 
 /* Attributes stored in the BTF_INT_ENCODING */
 #define BTF_INT_SIGNED	(1 << 0)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8d6bdb4f4d61..44bc17207e9b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -166,7 +166,8 @@
  *
  */
 
-#define BITS_PER_U128 (sizeof(u64) * BITS_PER_BYTE * 2)
+#define BITS_PER_U128 128
+#define BITS_PER_U512 512
 #define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
 #define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
 #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
@@ -1907,9 +1908,9 @@ static int btf_int_check_member(struct btf_verifier_env *env,
 	nr_copy_bits = BTF_INT_BITS(int_data) +
 		BITS_PER_BYTE_MASKED(struct_bits_off);
 
-	if (nr_copy_bits > BITS_PER_U128) {
+	if (nr_copy_bits > BITS_PER_U512) {
 		btf_verifier_log_member(env, struct_type, member,
-					"nr_copy_bits exceeds 128");
+					"nr_copy_bits exceeds 512");
 		return -EINVAL;
 	}
 
@@ -1963,9 +1964,9 @@ static int btf_int_check_kflag_member(struct btf_verifier_env *env,
 
 	bytes_offset = BITS_ROUNDDOWN_BYTES(struct_bits_off);
 	nr_copy_bits = nr_bits + BITS_PER_BYTE_MASKED(struct_bits_off);
-	if (nr_copy_bits > BITS_PER_U128) {
+	if (nr_copy_bits > BITS_PER_U512) {
 		btf_verifier_log_member(env, struct_type, member,
-					"nr_copy_bits exceeds 128");
+					"nr_copy_bits exceeds 512");
 		return -EINVAL;
 	}
 
@@ -2012,9 +2013,9 @@ static s32 btf_int_check_meta(struct btf_verifier_env *env,
 
 	nr_bits = BTF_INT_BITS(int_data) + BTF_INT_OFFSET(int_data);
 
-	if (nr_bits > BITS_PER_U128) {
-		btf_verifier_log_type(env, t, "nr_bits exceeds %zu",
-				      BITS_PER_U128);
+	if (nr_bits > BITS_PER_U512) {
+		btf_verifier_log_type(env, t, "nr_bits exceeds %u",
+				      BITS_PER_U512);
 		return -EINVAL;
 	}
 
@@ -2080,6 +2081,37 @@ static void btf_int128_print(struct btf_show *show, void *data)
 				     lower_num);
 }
 
+static void btf_bigint_print(struct btf_show *show, void *data, u16 nr_bits)
+{
+	/* data points to 256 or 512 bit int type */
+	char buf[129];
+	int last_u64 = nr_bits / 64 - 1;
+	bool seen_nonzero = false;
+	int i;
+
+	for (i = 0; i <= last_u64; i++) {
+#ifdef __BIG_ENDIAN_BITFIELD
+		u64 v = ((u64 *)data)[i];
+#else
+		u64 v = ((u64 *)data)[last_u64 - i];
+#endif
+		if (!seen_nonzero) {
+			if (!v && i != last_u64)
+				continue;
+
+			snprintf(buf, sizeof(buf), "%llx", v);
+
+			seen_nonzero = true;
+		} else {
+			size_t off = strlen(buf);
+
+			snprintf(buf + off, sizeof(buf) - off, "%016llx", v);
+		}
+	}
+
+	btf_show_type_value(show, "0x%s", buf);
+}
+
 static void btf_int128_shift(u64 *print_num, u16 left_shift_bits,
 			     u16 right_shift_bits)
 {
@@ -2172,7 +2204,7 @@ static void btf_int_show(const struct btf *btf, const struct btf_type *t,
 	u32 int_data = btf_type_int(t);
 	u8 encoding = BTF_INT_ENCODING(int_data);
 	bool sign = encoding & BTF_INT_SIGNED;
-	u8 nr_bits = BTF_INT_BITS(int_data);
+	u16 nr_bits = BTF_INT_BITS(int_data);
 	void *safe_data;
 
 	safe_data = btf_show_start_type(show, t, type_id, data);
@@ -2186,6 +2218,10 @@ static void btf_int_show(const struct btf *btf, const struct btf_type *t,
 	}
 
 	switch (nr_bits) {
+	case 512:
+	case 256:
+		btf_bigint_print(show, safe_data, nr_bits);
+		break;
 	case 128:
 		btf_int128_print(show, safe_data);
 		break;
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 0e9310727281..8b5318ec5c26 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -271,6 +271,41 @@ static void btf_int128_print(json_writer_t *jw, const void *data,
 	}
 }
 
+static void btf_bigint_print(json_writer_t *jw, const void *data, int nr_bits,
+			     bool is_plain_text)
+{
+	char buf[nr_bits / 4 + 1];
+	int last_u64 = nr_bits / 64 - 1;
+	bool seen_nonzero = false;
+	int i;
+
+	for (i = 0; i <= last_u64; i++) {
+#ifdef __BIG_ENDIAN_BITFIELD
+		__u64 v = ((__u64 *)data)[i];
+#else
+		__u64 v = ((__u64 *)data)[last_u64 - i];
+#endif
+
+		if (!seen_nonzero) {
+			if (!v && i != last_u64)
+				continue;
+
+			snprintf(buf, sizeof(buf), "%llx", v);
+
+			seen_nonzero = true;
+		} else {
+			size_t off = strlen(buf);
+
+			snprintf(buf + off, sizeof(buf) - off, "%016llx", v);
+		}
+	}
+
+	if (is_plain_text)
+		jsonw_printf(jw, "0x%s", buf);
+	else
+		jsonw_printf(jw, "\"0x%s\"", buf);
+}
+
 static void btf_int128_shift(__u64 *print_num, __u16 left_shift_bits,
 			     __u16 right_shift_bits)
 {
@@ -373,6 +408,11 @@ static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
 		return 0;
 	}
 
+	if (nr_bits > 128) {
+		btf_bigint_print(jw, data, nr_bits, is_plain_text);
+		return 0;
+	}
+
 	if (nr_bits == 128) {
 		btf_int128_print(jw, data, is_plain_text);
 		return 0;
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 5a667107ad2c..1696fd02b302 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -84,7 +84,7 @@ struct btf_type {
  */
 #define BTF_INT_ENCODING(VAL)	(((VAL) & 0x0f000000) >> 24)
 #define BTF_INT_OFFSET(VAL)	(((VAL) & 0x00ff0000) >> 16)
-#define BTF_INT_BITS(VAL)	((VAL)  & 0x000000ff)
+#define BTF_INT_BITS(VAL)	((VAL)  & 0x000003ff)
 
 /* Attributes stored in the BTF_INT_ENCODING */
 #define BTF_INT_SIGNED	(1 << 0)
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3c3f2bc6c652..a676373f052b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1722,7 +1722,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
 	if (!name || !name[0])
 		return -EINVAL;
 	/* byte_sz must be power of 2 */
-	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
+	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 64)
 		return -EINVAL;
 	if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
 		return -EINVAL;
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8c33e999319a..436ad1aed3d9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -70,7 +70,8 @@ TEST_PROGS := test_kmod.sh \
 	test_bpftool_build.sh \
 	test_bpftool.sh \
 	test_bpftool_metadata.sh \
-	test_xsk.sh
+	test_xsk.sh \
+	test_extint.py
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8ae97e2a4b9d..96a93502cf27 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4073,6 +4073,7 @@ struct btf_file_test {
 static struct btf_file_test file_tests[] = {
 	{ .file = "test_btf_haskv.o", },
 	{ .file = "test_btf_newkv.o", },
+	{ .file = "test_btf_extint.o", },
 	{ .file = "test_btf_nokv.o", .btf_kv_notfound = true, },
 };
 
@@ -4414,7 +4415,7 @@ static struct btf_raw_test pprint_test_template[] = {
 	 * will have both int and enum types.
 	 */
 	.raw_types = {
-		/* unsighed char */			/* [1] */
+		/* unsigned char */			/* [1] */
 		BTF_TYPE_INT_ENC(NAME_TBD, 0, 0, 8, 1),
 		/* unsigned short */			/* [2] */
 		BTF_TYPE_INT_ENC(NAME_TBD, 0, 0, 16, 2),
diff --git a/tools/testing/selftests/bpf/progs/test_btf_extint.c b/tools/testing/selftests/bpf/progs/test_btf_extint.c
new file mode 100644
index 000000000000..b0fa9f130dda
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_btf_extint.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+struct extint {
+	_ExtInt(256) v256;
+	_ExtInt(512) v512;
+};
+
+struct bpf_map_def SEC("maps") btf_map = {
+	.type = BPF_MAP_TYPE_ARRAY,
+	.key_size = sizeof(int),
+	.value_size = sizeof(struct extint),
+	.max_entries = 1,
+};
+
+BPF_ANNOTATE_KV_PAIR(btf_map, int, struct extint);
+
+__attribute__((noinline))
+int test_long_fname_2(void)
+{
+	struct extint *bi;
+	int key = 0;
+
+	bi = bpf_map_lookup_elem(&btf_map, &key);
+	if (!bi)
+		return 0;
+
+	bi->v256 <<= 64;
+	bi->v256 += (_ExtInt(256))0xcafedead;
+	bi->v512 <<= 128;
+	bi->v512 += (_ExtInt(512))0xff00ff00ff00ffull;
+
+	return 0;
+}
+
+__attribute__((noinline))
+int test_long_fname_1(void)
+{
+	return test_long_fname_2();
+}
+
+SEC("dummy_tracepoint")
+int _dummy_tracepoint(void *arg)
+{
+	return test_long_fname_1();
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_extint.py b/tools/testing/selftests/bpf/test_extint.py
new file mode 100755
index 000000000000..86af815a0cf6
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_extint.py
@@ -0,0 +1,535 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+
+# Copyright (C) 2020 Sean Young <sean@mess.org>
+# Copyright (C) 2017 Netronome Systems, Inc.
+# Copyright (c) 2019 Mellanox Technologies. All rights reserved
+#
+# This software is licensed under the GNU General License Version 2,
+# June 1991 as shown in the file COPYING in the top-level directory of this
+# source tree.
+#
+# THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS"
+# WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING,
+# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+# FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE
+# OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME
+# THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
+
+from datetime import datetime
+import argparse
+import errno
+import json
+import os
+import pprint
+import random
+import re
+import stat
+import string
+import struct
+import subprocess
+import time
+import traceback
+
+logfile = None
+log_level = 1
+skip_extack = False
+bpf_test_dir = os.path.dirname(os.path.realpath(__file__))
+pp = pprint.PrettyPrinter()
+devs = [] # devices we created for clean up
+files = [] # files to be removed
+
+def log_get_sec(level=0):
+    return "*" * (log_level + level)
+
+def log_level_inc(add=1):
+    global log_level
+    log_level += add
+
+def log_level_dec(sub=1):
+    global log_level
+    log_level -= sub
+
+def log_level_set(level):
+    global log_level
+    log_level = level
+
+def log(header, data, level=None):
+    """
+    Output to an optional log.
+    """
+    if logfile is None:
+        return
+    if level is not None:
+        log_level_set(level)
+
+    if not isinstance(data, str):
+        data = pp.pformat(data)
+
+    if len(header):
+        logfile.write("\n" + log_get_sec() + " ")
+        logfile.write(header)
+    if len(header) and len(data.strip()):
+        logfile.write("\n")
+    logfile.write(data)
+
+def skip(cond, msg):
+    if not cond:
+        return
+    print("SKIP: " + msg)
+    log("SKIP: " + msg, "", level=1)
+    os.sys.exit(0)
+
+def fail(cond, msg):
+    if not cond:
+        return
+    print("FAIL: " + msg)
+    tb = "".join(traceback.extract_stack().format())
+    print(tb)
+    log("FAIL: " + msg, tb, level=1)
+    os.sys.exit(1)
+
+def start_test(msg):
+    log(msg, "", level=1)
+    log_level_inc()
+    print(msg)
+
+def cmd(cmd, shell=True, include_stderr=False, background=False, fail=True):
+    """
+    Run a command in subprocess and return tuple of (retval, stdout);
+    optionally return stderr as well as third value.
+    """
+    proc = subprocess.Popen(cmd, shell=shell, stdout=subprocess.PIPE,
+                            stderr=subprocess.PIPE)
+    if background:
+        msg = "%s START: %s" % (log_get_sec(1),
+                                datetime.now().strftime("%H:%M:%S.%f"))
+        log("BKG " + proc.args, msg)
+        return proc
+
+    return cmd_result(proc, include_stderr=include_stderr, fail=fail)
+
+def cmd_result(proc, include_stderr=False, fail=False):
+    stdout, stderr = proc.communicate()
+    stdout = stdout.decode("utf-8")
+    stderr = stderr.decode("utf-8")
+    proc.stdout.close()
+    proc.stderr.close()
+
+    stderr = "\n" + stderr
+    if stderr[-1] == "\n":
+        stderr = stderr[:-1]
+
+    sec = log_get_sec(1)
+    log("CMD " + proc.args,
+        "RETCODE: %d\n%s STDOUT:\n%s%s STDERR:%s\n%s END: %s" %
+        (proc.returncode, sec, stdout, sec, stderr,
+         sec, datetime.now().strftime("%H:%M:%S.%f")))
+
+    if proc.returncode != 0 and fail:
+        if len(stderr) > 0 and stderr[-1] == "\n":
+            stderr = stderr[:-1]
+        raise Exception("Command failed: %s\n%s" % (proc.args, stderr))
+
+    if include_stderr:
+        return proc.returncode, stdout, stderr
+    else:
+        return proc.returncode, stdout
+
+def rm(f):
+    cmd("rm -f %s" % (f))
+    if f in files:
+        files.remove(f)
+
+def tool(name, args, flags, JSON=True, ns="", fail=True, include_stderr=False):
+    params = ""
+    if JSON:
+        params += "%s " % (flags["json"])
+
+    if ns != "":
+        ns = "ip netns exec %s " % (ns)
+
+    if include_stderr:
+        ret, stdout, stderr = cmd(ns + name + " " + params + args,
+                                  fail=fail, include_stderr=True)
+    else:
+        ret, stdout = cmd(ns + name + " " + params + args,
+                          fail=fail, include_stderr=False)
+
+    if JSON and len(stdout.strip()) != 0:
+        out = json.loads(stdout)
+    else:
+        out = stdout
+
+    if include_stderr:
+        return ret, out, stderr
+    else:
+        return ret, out
+
+def bpftool(args, JSON=True, ns="", fail=True, include_stderr=False):
+    return tool("bpftool", args, {"json":"-p"}, JSON=JSON, ns=ns,
+                fail=fail, include_stderr=include_stderr)
+
+def bpftool_prog_list(expected=None, ns=""):
+    _, progs = bpftool("prog show", JSON=True, ns=ns, fail=True)
+    # Remove the base progs
+    for p in base_progs:
+        if p in progs:
+            progs.remove(p)
+    if expected is not None:
+        if len(progs) != expected:
+            fail(True, "%d BPF programs loaded, expected %d" %
+                 (len(progs), expected))
+    return progs
+
+def bpftool_map_list(expected=None, ns=""):
+    _, maps = bpftool("map show", JSON=True, ns=ns, fail=True)
+    # Remove the base maps
+    maps = [m for m in maps if m not in base_maps and m.get('name') not in base_map_names]
+    if expected is not None:
+        if len(maps) != expected:
+            fail(True, "%d BPF maps loaded, expected %d" %
+                 (len(maps), expected))
+    return maps
+
+def bpftool_prog_list_wait(expected=0, n_retry=20):
+    for i in range(n_retry):
+        nprogs = len(bpftool_prog_list())
+        if nprogs == expected:
+            return
+        time.sleep(0.05)
+    raise Exception("Time out waiting for program counts to stabilize want %d, have %d" % (expected, nprogs))
+
+def bpftool_map_list_wait(expected=0, n_retry=20):
+    for i in range(n_retry):
+        nmaps = len(bpftool_map_list())
+        if nmaps == expected:
+            return
+        time.sleep(0.05)
+    raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
+
+def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
+                      pinmaps=None, fail=True, include_stderr=False):
+    args = "prog load %s %s" % (os.path.join(bpf_test_dir, sample), file_name)
+    if prog_type is not None:
+        args += " type " + prog_type
+    if dev is not None:
+        args += " dev " + dev
+    if len(maps):
+        args += " map " + " map ".join(maps)
+    if pinmaps is not None:
+        args += " pinmaps " + pinmaps
+
+    res = bpftool(args, fail=fail, include_stderr=include_stderr)
+    if res[0] == 0:
+        files.append(file_name)
+    return res
+
+def ip(args, force=False, JSON=True, ns="", fail=True, include_stderr=False):
+    if force:
+        args = "-force " + args
+    return tool("ip", args, {"json":"-j"}, JSON=JSON, ns=ns,
+                fail=fail, include_stderr=include_stderr)
+
+def tc(args, JSON=True, ns="", fail=True, include_stderr=False):
+    return tool("tc", args, {"json":"-p"}, JSON=JSON, ns=ns,
+                fail=fail, include_stderr=include_stderr)
+
+def ethtool(dev, opt, args, fail=True):
+    return cmd("ethtool %s %s %s" % (opt, dev["ifname"], args), fail=fail)
+
+def bpf_obj(name, sec=".text", path=bpf_test_dir,):
+    return "obj %s sec %s" % (os.path.join(path, name), sec)
+
+def bpf_pinned(name):
+    return "pinned %s" % (name)
+
+def bpf_bytecode(bytecode):
+    return "bytecode \"%s\"" % (bytecode)
+
+def int2str(fmt, val):
+    ret = []
+    for b in struct.pack(fmt, val):
+        ret.append(int(b))
+    return " ".join(map(lambda x: str(x), ret))
+
+def str2int(strtab):
+    inttab = []
+    for i in strtab:
+        inttab.append(int(i, 16))
+    ba = bytearray(inttab)
+    if len(strtab) == 4:
+        fmt = "I"
+    elif len(strtab) == 8:
+        fmt = "Q"
+    else:
+        raise Exception("String array of len %d can't be unpacked to an int" %
+                        (len(strtab)))
+    return struct.unpack(fmt, ba)[0]
+
+################################################################################
+def clean_up():
+    global files, netns, devs
+    for f in files:
+        cmd("rm -rf %s" % (f))
+    files = []
+    netns = []
+
+def pin_prog(file_name, idx=0):
+    progs = bpftool_prog_list(expected=(idx + 1))
+    prog = progs[idx]
+    bpftool("prog pin id %d %s" % (prog["id"], file_name))
+    files.append(file_name)
+
+    return file_name, bpf_pinned(file_name)
+
+def pin_map(file_name, idx=0, expected=1):
+    maps = bpftool_map_list(expected=expected)
+    m = maps[idx]
+    bpftool("map pin id %d %s" % (m["id"], file_name))
+    files.append(file_name)
+
+    return file_name, bpf_pinned(file_name)
+
+def check_dev_info_removed(prog_file=None, map_file=None):
+    bpftool_prog_list(expected=0)
+    ret, err = bpftool("prog show pin %s" % (prog_file), fail=False)
+    fail(ret == 0, "Showing prog with removed device did not fail")
+    fail(err["error"].find("No such device") == -1,
+         "Showing prog with removed device expected ENODEV, error is %s" %
+         (err["error"]))
+
+    bpftool_map_list(expected=0)
+    ret, err = bpftool("map show pin %s" % (map_file), fail=False)
+    fail(ret == 0, "Showing map with removed device did not fail")
+    fail(err["error"].find("No such device") == -1,
+         "Showing map with removed device expected ENODEV, error is %s" %
+         (err["error"]))
+
+def check_dev_info(other_ns, ns, prog_file=None, map_file=None, removed=False):
+    progs = bpftool_prog_list(expected=1, ns=ns)
+    prog = progs[0]
+
+    fail("dev" not in prog.keys(), "Device parameters not reported")
+    dev = prog["dev"]
+    fail("ifindex" not in dev.keys(), "Device parameters not reported")
+    fail("ns_dev" not in dev.keys(), "Device parameters not reported")
+    fail("ns_inode" not in dev.keys(), "Device parameters not reported")
+
+    if not other_ns:
+        fail("ifname" not in dev.keys(), "Ifname not reported")
+        fail(dev["ifname"] != sim["ifname"],
+             "Ifname incorrect %s vs %s" % (dev["ifname"], sim["ifname"]))
+    else:
+        fail("ifname" in dev.keys(), "Ifname is reported for other ns")
+
+    maps = bpftool_map_list(expected=2, ns=ns)
+    for m in maps:
+        fail("dev" not in m.keys(), "Device parameters not reported")
+        fail(dev != m["dev"], "Map's device different than program's")
+
+def check_extack(output, reference, args):
+    if skip_extack:
+        return
+    lines = output.split("\n")
+    comp = len(lines) >= 2 and lines[1] == 'Error: ' + reference
+    fail(not comp, "Missing or incorrect netlink extack message")
+
+def check_extack_nsim(output, reference, args):
+    check_extack(output, "netdevsim: " + reference, args)
+
+def check_no_extack(res, needle):
+    fail((res[1] + res[2]).count(needle) or (res[1] + res[2]).count("Warning:"),
+         "Found '%s' in command output, leaky extack?" % (needle))
+
+def check_verifier_log(output, reference):
+    lines = output.split("\n")
+    for l in reversed(lines):
+        if l == reference:
+            return
+    fail(True, "Missing or incorrect message from netdevsim in verifier log")
+
+def check_multi_basic(two_xdps):
+    fail(two_xdps["mode"] != 4, "Bad mode reported with multiple programs")
+    fail("prog" in two_xdps, "Base program reported in multi program mode")
+    fail(len(two_xdps["attached"]) != 2,
+         "Wrong attached program count with two programs")
+    fail(two_xdps["attached"][0]["prog"]["id"] ==
+         two_xdps["attached"][1]["prog"]["id"],
+         "Offloaded and other programs have the same id")
+
+def test_spurios_extack(sim, obj, skip_hw, needle):
+    res = sim.cls_bpf_add_filter(obj, prio=1, handle=1, skip_hw=skip_hw,
+                                 include_stderr=True)
+    check_no_extack(res, needle)
+    res = sim.cls_bpf_add_filter(obj, op="replace", prio=1, handle=1,
+                                 skip_hw=skip_hw, include_stderr=True)
+    check_no_extack(res, needle)
+    res = sim.cls_filter_op(op="delete", prio=1, handle=1, cls="bpf",
+                            include_stderr=True)
+    check_no_extack(res, needle)
+
+def test_multi_prog(simdev, sim, obj, modename, modeid):
+    start_test("Test multi-attachment XDP - %s + offload..." %
+               (modename or "default", ))
+    sim.set_xdp(obj, "offload")
+    xdp = sim.ip_link_show(xdp=True)["xdp"]
+    offloaded = sim.dfs_read("bpf_offloaded_id")
+    fail("prog" not in xdp, "Base program not reported in single program mode")
+    fail(len(xdp["attached"]) != 1,
+         "Wrong attached program count with one program")
+
+    sim.set_xdp(obj, modename)
+    two_xdps = sim.ip_link_show(xdp=True)["xdp"]
+
+    fail(xdp["attached"][0] not in two_xdps["attached"],
+         "Offload program not reported after other activated")
+    check_multi_basic(two_xdps)
+
+    offloaded2 = sim.dfs_read("bpf_offloaded_id")
+    fail(offloaded != offloaded2,
+         "Offload ID changed after loading other program")
+
+    start_test("Test multi-attachment XDP - replace...")
+    ret, _, err = sim.set_xdp(obj, "offload", fail=False, include_stderr=True)
+    fail(ret == 0, "Replaced one of programs without -force")
+    check_extack(err, "XDP program already attached.", args)
+
+    start_test("Test multi-attachment XDP - remove without mode...")
+    ret, _, err = sim.unset_xdp("", force=True,
+                                fail=False, include_stderr=True)
+    fail(ret == 0, "Removed program without a mode flag")
+    check_extack(err, "More than one program loaded, unset mode is ambiguous.", args)
+
+    sim.unset_xdp("offload")
+    xdp = sim.ip_link_show(xdp=True)["xdp"]
+    offloaded = sim.dfs_read("bpf_offloaded_id")
+
+    fail(xdp["mode"] != modeid, "Bad mode reported after multiple programs")
+    fail("prog" not in xdp,
+         "Base program not reported after multi program mode")
+    fail(xdp["attached"][0] not in two_xdps["attached"],
+         "Offload program not reported after other activated")
+    fail(len(xdp["attached"]) != 1,
+         "Wrong attached program count with remaining programs")
+    fail(offloaded != "0", "Offload ID reported with only other program left")
+
+    start_test("Test multi-attachment XDP - reattach...")
+    sim.set_xdp(obj, "offload")
+    two_xdps = sim.ip_link_show(xdp=True)["xdp"]
+
+    fail(xdp["attached"][0] not in two_xdps["attached"],
+         "Other program not reported after offload activated")
+    check_multi_basic(two_xdps)
+
+    start_test("Test multi-attachment XDP - device remove...")
+    simdev.remove()
+
+    simdev = NetdevSimDev()
+    sim, = simdev.nsims
+    sim.set_ethtool_tc_offloads(True)
+    return [simdev, sim]
+
+# Parse command line
+parser = argparse.ArgumentParser()
+parser.add_argument("--log", help="output verbose log to given file")
+args = parser.parse_args()
+if args.log:
+    logfile = open(args.log, 'w+')
+    logfile.write("# -*-Org-*-")
+
+log("Prepare...", "", level=1)
+log_level_inc()
+
+# Check permissions
+skip(os.getuid() != 0, "test must be run as root")
+
+# Check tools
+ret, progs = bpftool("prog", fail=False)
+skip(ret != 0, "bpftool not installed")
+base_progs = progs
+_, base_maps = bpftool("map")
+base_map_names = [
+    'pid_iter.rodata' # created on each bpftool invocation
+]
+
+# Check bpffs
+_, out = cmd("mount")
+if out.find("/sys/fs/bpf type bpf") == -1:
+    cmd("mount -t bpf none /sys/fs/bpf")
+
+# Check samples are compiled
+samples = ["test_btf_extint.o"]
+for s in samples:
+    ret, out = cmd("ls %s/%s" % (bpf_test_dir, s), fail=False)
+    skip(ret != 0, "sample %s/%s not found, please compile it" %
+         (bpf_test_dir, s))
+
+try:
+    start_test("Test extint...")
+    bpftool_prog_load("test_btf_extint.o", "/sys/fs/bpf/extint", pinmaps='/sys/fs/bpf/extint_map')
+    files = [ '/sys/fs/bpf/extint', '/sys/fs/bpf/extint_map' ]
+
+    maps = bpftool_map_list()
+    map_id = maps[0]["id"]
+    def map_get():
+        _, entries = bpftool("map dump id %d" % (map_id))
+        return entries[0]['formatted']['value']
+
+    def map_get_kernel():
+        rd = open('/sys/fs/bpf/extint_map/btf_map', 'r')
+        res = ''
+        for line in rd.readlines():
+            if not line.startswith('#'):
+                res += line.strip()
+        rd.close()
+        return res
+
+    vals = map_get()
+
+    fail(vals['v256'] != '0x0', "expected %s, got %s" % ('0x0', vals['v256']))
+    fail(vals['v512'] != '0x0', "expected %s, got %s" % ('0x0', vals['v512']))
+
+    kvals = map_get_kernel()
+    fail(kvals != "0: {0x0,0x0,}", "got %s" % (kvals))
+
+    key = [0] * 4
+    value = [0] * 96
+
+    def map_update():
+        key_str = ' '.join(str(x) for x in key)
+        value_str = ' '.join(str(x) for x in value)
+        bpftool("map update id %d key %s value %s" % (map_id, key_str, value_str))
+
+    value[0] = 1;
+    value[32] = 2;
+
+    map_update()
+
+    vals = map_get()
+
+    fail(vals['v256'] != '0x1', "expected %s, got %s" % ('0x1', vals['v256']))
+    fail(vals['v512'] != '0x2', "expected %s, got %s" % ('0x2', vals['v512']))
+
+    kvals = map_get_kernel()
+    fail(kvals != "0: {0x1,0x2,}", "got %s" % (kvals))
+
+    value[31] = 0xfc;
+    value[95] = 0x8;
+
+    map_update()
+
+    vals = map_get()
+
+    fail(vals['v256'] != '0xfc00000000000000000000000000000000000000000000000000000000000001', "got %s" % (vals['v256']))
+    fail(vals['v512'] != '0x8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002', "got %s" % (vals['v512']))
+
+    kvals = map_get_kernel()
+    fail(kvals != "0: {0xfc00000000000000000000000000000000000000000000000000000000000001,0x8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002,}", "got %s" % (kvals))
+
+    print("%s: OK" % (os.path.basename(__file__)))
+
+finally:
+    log("Clean up...", "", level=1)
+    log_level_inc()
+    clean_up()
-- 
2.29.2

