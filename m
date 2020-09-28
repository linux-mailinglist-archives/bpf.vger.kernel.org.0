Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97E327ACE6
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1LfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 07:35:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgI1LfA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 07:35:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SBSx2b088943;
        Mon, 28 Sep 2020 11:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=gxWK9jPtu08Ovgl3UtIyOEeMIJTkAKlFdQx70NGDyIM=;
 b=XpT69atz9Wds76E+BAkBxoPt+aG7kNPTlx80QO0l/aHSX9ZCy2AR7f+u3yTweIj0ibl9
 989aIYQlEnTSF9+75M46OMfxtKTpKYX+ho8MM0AcKMsAK5BJ/5OC1Wkdm2bm/vTDz2mC
 sEGUlHB9f/9kHXNK8mVDfokNd50Em+6x7bSCB37uJR7C9+ZPxhsoWfVGJd7D+CWmVABJ
 gCCELqwAXf1gRGpozG0ELfCcxSNZqvC/YzTPi5BobKKN3vRFhHheZuDSIUwZnutPhV1F
 hnxCGSUMkIXgCeqUag0ClrH0H2ns8Tvx7TlNm0SctZBQiIV8g6vX11tjN5ojJisVGqx3 Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33sx9mvd40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 11:33:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SBULBt057342;
        Mon, 28 Sep 2020 11:33:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33tfhw57pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Sep 2020 11:33:03 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08SBX0kL029629;
        Mon, 28 Sep 2020 11:33:01 GMT
Received: from localhost.uk.oracle.com (/10.175.167.231)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Sep 2020 04:32:59 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com, yhs@fb.com
Cc:     linux@rasmusvillemoes.dk, andriy.shevchenko@linux.intel.com,
        pmladek@suse.com, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, shuah@kernel.org,
        rdna@fb.com, scott.branden@broadcom.com, quentin@isovalent.com,
        cneirabustos@gmail.com, jakub@cloudflare.com, mingo@redhat.com,
        rostedt@goodmis.org, acme@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 4/8] selftests/bpf: add bpf_snprintf_btf helper tests
Date:   Mon, 28 Sep 2020 12:31:06 +0100
Message-Id: <1601292670-1616-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601292670-1616-1-git-send-email-alan.maguire@oracle.com>
References: <1601292670-1616-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9757 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9757 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280093
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tests verifying snprintf()ing of various data structures,
flags combinations using a tp_btf program. Tests are skipped
if __builtin_btf_type_id is not available to retrieve BTF
type ids.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/snprintf_btf.c        |  60 +++++
 .../selftests/bpf/progs/netif_receive_skb.c        | 249 +++++++++++++++++++++
 2 files changed, 309 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/netif_receive_skb.c

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c b/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
new file mode 100644
index 0000000..3a8ecf8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <linux/btf.h>
+#include "netif_receive_skb.skel.h"
+
+/* Demonstrate that bpf_snprintf_btf succeeds and that various data types
+ * are formatted correctly.
+ */
+void test_snprintf_btf(void)
+{
+	struct netif_receive_skb *skel;
+	struct netif_receive_skb__bss *bss;
+	int err, duration = 0;
+
+	skel = netif_receive_skb__open();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+
+	err = netif_receive_skb__load(skel);
+	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
+		goto cleanup;
+
+	bss = skel->bss;
+
+	err = netif_receive_skb__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	/* generate receive event */
+	system("ping -c 1 127.0.0.1 > /dev/null");
+
+	if (bss->skip) {
+		printf("%s:SKIP:no __builtin_btf_type_id\n", __func__);
+		test__skip();
+		goto cleanup;
+	}
+
+	/*
+	 * Make sure netif_receive_skb program was triggered
+	 * and it set expected return values from bpf_trace_printk()s
+	 * and all tests ran.
+	 */
+	if (CHECK(bss->ret <= 0,
+		  "bpf_snprintf_btf: got return value",
+		  "ret <= 0 %ld test %d\n", bss->ret, bss->ran_subtests))
+		goto cleanup;
+
+	if (CHECK(bss->ran_subtests == 0, "check if subtests ran",
+		  "no subtests ran, did BPF program run?"))
+		goto cleanup;
+
+	if (CHECK(bss->num_subtests != bss->ran_subtests,
+		  "check all subtests ran",
+		  "only ran %d of %d tests\n", bss->num_subtests,
+		  bss->ran_subtests))
+		goto cleanup;
+
+cleanup:
+	netif_receive_skb__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
new file mode 100644
index 0000000..b873d80
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Oracle and/or its affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#include <errno.h>
+
+long ret = 0;
+int num_subtests = 0;
+int ran_subtests = 0;
+bool skip = false;
+
+#define STRSIZE			2048
+#define EXPECTED_STRSIZE	256
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, char[STRSIZE]);
+} strdata SEC(".maps");
+
+static int __strncmp(const void *m1, const void *m2, size_t len)
+{
+	const unsigned char *s1 = m1;
+	const unsigned char *s2 = m2;
+	int i, delta = 0;
+
+	for (i = 0; i < len; i++) {
+		delta = s1[i] - s2[i];
+		if (delta || s1[i] == 0 || s2[i] == 0)
+			break;
+	}
+	return delta;
+}
+
+#if __has_builtin(__builtin_btf_type_id)
+#define	TEST_BTF(_str, _type, _flags, _expected, ...)			\
+	do {								\
+		static const char _expectedval[EXPECTED_STRSIZE] =	\
+							_expected;	\
+		static const char _ptrtype[64] = #_type;		\
+		__u64 _hflags = _flags | BTF_F_COMPACT;			\
+		static _type _ptrdata = __VA_ARGS__;			\
+		static struct btf_ptr _ptr = { };			\
+		int _cmp;						\
+									\
+		++num_subtests;						\
+		if (ret < 0)						\
+			break;						\
+		++ran_subtests;						\
+		_ptr.ptr = &_ptrdata;					\
+		_ptr.type_id = bpf_core_type_id_kernel(_type);		\
+		if (_ptr.type_id <= 0) {				\
+			ret = -EINVAL;					\
+			break;						\
+		}							\
+		ret = bpf_snprintf_btf(_str, STRSIZE,			\
+				       &_ptr, sizeof(_ptr), _hflags);	\
+		if (ret)						\
+			break;						\
+		_cmp = __strncmp(_str, _expectedval, EXPECTED_STRSIZE);	\
+		if (_cmp != 0) {					\
+			bpf_printk("(%d) got %s", _cmp, _str);		\
+			bpf_printk("(%d) expected %s", _cmp,		\
+				   _expectedval);			\
+			ret = -EBADMSG;					\
+			break;						\
+		}							\
+	} while (0)
+#endif
+
+/* Use where expected data string matches its stringified declaration */
+#define TEST_BTF_C(_str, _type, _flags, ...)				\
+	TEST_BTF(_str, _type, _flags, "(" #_type ")" #__VA_ARGS__,	\
+		 __VA_ARGS__)
+
+/* TRACE_EVENT(netif_receive_skb,
+ *	TP_PROTO(struct sk_buff *skb),
+ */
+SEC("tp_btf/netif_receive_skb")
+int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
+{
+	static __u64 flags[] = { 0, BTF_F_COMPACT, BTF_F_ZERO, BTF_F_PTR_RAW,
+				 BTF_F_NONAME, BTF_F_COMPACT | BTF_F_ZERO |
+				 BTF_F_PTR_RAW | BTF_F_NONAME };
+	static struct btf_ptr p = { };
+	__u32 key = 0;
+	int i, __ret;
+	char *str;
+
+#if __has_builtin(__builtin_btf_type_id)
+	str = bpf_map_lookup_elem(&strdata, &key);
+	if (!str)
+		return 0;
+
+	/* Ensure we can write skb string representation */
+	p.type_id = bpf_core_type_id_kernel(struct sk_buff);
+	p.ptr = skb;
+	for (i = 0; i < ARRAY_SIZE(flags); i++) {
+		++num_subtests;
+		ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
+		if (ret < 0)
+			bpf_printk("returned %d when writing skb", ret);
+		++ran_subtests;
+	}
+
+	/* Check invalid ptr value */
+	p.ptr = 0;
+	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
+	if (__ret >= 0) {
+		bpf_printk("printing NULL should generate error, got (%d)",
+			   __ret);
+		ret = -ERANGE;
+	}
+
+	/* Verify type display for various types. */
+
+	/* simple int */
+	TEST_BTF_C(str, int, 0, 1234);
+	TEST_BTF(str, int, BTF_F_NONAME, "1234", 1234);
+	/* zero value should be printed at toplevel */
+	TEST_BTF(str, int, 0, "(int)0", 0);
+	TEST_BTF(str, int, BTF_F_NONAME, "0", 0);
+	TEST_BTF(str, int, BTF_F_ZERO, "(int)0", 0);
+	TEST_BTF(str, int, BTF_F_NONAME | BTF_F_ZERO, "0", 0);
+	TEST_BTF_C(str, int, 0, -4567);
+	TEST_BTF(str, int, BTF_F_NONAME, "-4567", -4567);
+
+	/* simple char */
+	TEST_BTF_C(str, char, 0, 100);
+	TEST_BTF(str, char, BTF_F_NONAME, "100", 100);
+	/* zero value should be printed at toplevel */
+	TEST_BTF(str, char, 0, "(char)0", 0);
+	TEST_BTF(str, char, BTF_F_NONAME, "0", 0);
+	TEST_BTF(str, char, BTF_F_ZERO, "(char)0", 0);
+	TEST_BTF(str, char, BTF_F_NONAME | BTF_F_ZERO, "0", 0);
+
+	/* simple typedef */
+	TEST_BTF_C(str, uint64_t, 0, 100);
+	TEST_BTF(str, u64, BTF_F_NONAME, "1", 1);
+	/* zero value should be printed at toplevel */
+	TEST_BTF(str, u64, 0, "(u64)0", 0);
+	TEST_BTF(str, u64, BTF_F_NONAME, "0", 0);
+	TEST_BTF(str, u64, BTF_F_ZERO, "(u64)0", 0);
+	TEST_BTF(str, u64, BTF_F_NONAME|BTF_F_ZERO, "0", 0);
+
+	/* typedef struct */
+	TEST_BTF_C(str, atomic_t, 0, {.counter = (int)1,});
+	TEST_BTF(str, atomic_t, BTF_F_NONAME, "{1,}", {.counter = 1,});
+	/* typedef with 0 value should be printed at toplevel */
+	TEST_BTF(str, atomic_t, 0, "(atomic_t){}", {.counter = 0,});
+	TEST_BTF(str, atomic_t, BTF_F_NONAME, "{}", {.counter = 0,});
+	TEST_BTF(str, atomic_t, BTF_F_ZERO, "(atomic_t){.counter = (int)0,}",
+		 {.counter = 0,});
+	TEST_BTF(str, atomic_t, BTF_F_NONAME|BTF_F_ZERO,
+		 "{0,}", {.counter = 0,});
+
+	/* enum where enum value does (and does not) exist */
+	TEST_BTF_C(str, enum bpf_cmd, 0, BPF_MAP_CREATE);
+	TEST_BTF(str, enum bpf_cmd, 0, "(enum bpf_cmd)BPF_MAP_CREATE", 0);
+	TEST_BTF(str, enum bpf_cmd, BTF_F_NONAME, "BPF_MAP_CREATE",
+		 BPF_MAP_CREATE);
+	TEST_BTF(str, enum bpf_cmd, BTF_F_NONAME|BTF_F_ZERO,
+		 "BPF_MAP_CREATE", 0);
+
+	TEST_BTF(str, enum bpf_cmd, BTF_F_ZERO, "(enum bpf_cmd)BPF_MAP_CREATE",
+		 BPF_MAP_CREATE);
+	TEST_BTF(str, enum bpf_cmd, BTF_F_NONAME|BTF_F_ZERO,
+		 "BPF_MAP_CREATE", BPF_MAP_CREATE);
+	TEST_BTF_C(str, enum bpf_cmd, 0, 2000);
+	TEST_BTF(str, enum bpf_cmd, BTF_F_NONAME, "2000", 2000);
+
+	/* simple struct */
+	TEST_BTF_C(str, struct btf_enum, 0,
+		   {.name_off = (__u32)3,.val = (__s32)-1,});
+	TEST_BTF(str, struct btf_enum, BTF_F_NONAME, "{3,-1,}",
+		 { .name_off = 3, .val = -1,});
+	TEST_BTF(str, struct btf_enum, BTF_F_NONAME, "{-1,}",
+		 { .name_off = 0, .val = -1,});
+	TEST_BTF(str, struct btf_enum, BTF_F_NONAME|BTF_F_ZERO, "{0,-1,}",
+		 { .name_off = 0, .val = -1,});
+	/* empty struct should be printed */
+	TEST_BTF(str, struct btf_enum, 0, "(struct btf_enum){}",
+		 { .name_off = 0, .val = 0,});
+	TEST_BTF(str, struct btf_enum, BTF_F_NONAME, "{}",
+		 { .name_off = 0, .val = 0,});
+	TEST_BTF(str, struct btf_enum, BTF_F_ZERO,
+		 "(struct btf_enum){.name_off = (__u32)0,.val = (__s32)0,}",
+		 { .name_off = 0, .val = 0,});
+
+	/* struct with pointers */
+	TEST_BTF(str, struct list_head, BTF_F_PTR_RAW,
+		 "(struct list_head){.next = (struct list_head *)0x0000000000000001,}",
+		 { .next = (struct list_head *)1 });
+	/* NULL pointer should not be displayed */
+	TEST_BTF(str, struct list_head, BTF_F_PTR_RAW,
+		 "(struct list_head){}",
+		 { .next = (struct list_head *)0 });
+
+	/* struct with char array */
+	TEST_BTF(str, struct bpf_prog_info, 0,
+		 "(struct bpf_prog_info){.name = (char[])['f','o','o',],}",
+		 { .name = "foo",});
+	TEST_BTF(str, struct bpf_prog_info, BTF_F_NONAME,
+		 "{['f','o','o',],}",
+		 {.name = "foo",});
+	/* leading null char means do not display string */
+	TEST_BTF(str, struct bpf_prog_info, 0,
+		 "(struct bpf_prog_info){}",
+		 {.name = {'\0', 'f', 'o', 'o'}});
+	/* handle non-printable characters */
+	TEST_BTF(str, struct bpf_prog_info, 0,
+		 "(struct bpf_prog_info){.name = (char[])[1,2,3,],}",
+		 { .name = {1, 2, 3, 0}});
+
+	/* struct with non-char array */
+	TEST_BTF(str, struct __sk_buff, 0,
+		 "(struct __sk_buff){.cb = (__u32[])[1,2,3,4,5,],}",
+		 { .cb = {1, 2, 3, 4, 5,},});
+	TEST_BTF(str, struct __sk_buff, BTF_F_NONAME,
+		 "{[1,2,3,4,5,],}",
+		 { .cb = { 1, 2, 3, 4, 5},});
+	/* For non-char, arrays, show non-zero values only */
+	TEST_BTF(str, struct __sk_buff, 0,
+		 "(struct __sk_buff){.cb = (__u32[])[1,],}",
+		 { .cb = { 0, 0, 1, 0, 0},});
+
+	/* struct with bitfields */
+	TEST_BTF_C(str, struct bpf_insn, 0,
+		   {.code = (__u8)1,.dst_reg = (__u8)0x2,.src_reg = (__u8)0x3,.off = (__s16)4,.imm = (__s32)5,});
+	TEST_BTF(str, struct bpf_insn, BTF_F_NONAME, "{1,0x2,0x3,4,5,}",
+		 {.code = 1, .dst_reg = 0x2, .src_reg = 0x3, .off = 4,
+		  .imm = 5,});
+#else
+	skip = true;
+#endif
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1

