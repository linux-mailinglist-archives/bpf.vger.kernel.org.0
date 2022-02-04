Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0CB4A987B
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 12:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358437AbiBDLgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 06:36:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1358414AbiBDLgY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 06:36:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214BPSKP015707;
        Fri, 4 Feb 2022 11:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xU9nOuOSWri9VBiP81SyQeFYR4/LUgl9e2HP/UVbJxo=;
 b=Or19wumxNzKugOgBptq+vBxxEuBWGht4MlL42lwC+gMPDhsvSJfWUniMWVCabZaHQhBg
 HPJpJgmnvcn38DAdiFZsIeeDo933LDFhUwn+T6RZpKukbJc36X1ZgkfwI6JI2D6v4X/M
 B/fHhR7nKJOvAQUqGdAvxUL5UPYRqC8Gh4WD/8c20waLj9Gs8dYGBs1hJ7P/mqlKJB5t
 yiuWpw0BUmCi7q+IvSG1cl3R5w8PmTuKmFe6pRLo3Bt+66urPAZqrpg0hFtS7henXGLz
 mS1q6Vh273CimjeaX1NU1slWjsJWTg7Ewg5t3d1+X60U2VYNwgSyIS5gEVJ/5rZUrPBF 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0yu5bu2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:08 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214BFmjG007826;
        Fri, 4 Feb 2022 11:36:07 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0yu5bu1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:07 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214BXGFY001063;
        Fri, 4 Feb 2022 11:36:05 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3e0r0v3wvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214Ba02M32965054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 11:36:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCFB311C04A;
        Fri,  4 Feb 2022 11:36:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8820911C054;
        Fri,  4 Feb 2022 11:35:58 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.69.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 11:35:58 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Fix tests to use arch-dependent syscall entry points
Date:   Fri,  4 Feb 2022 17:05:20 +0530
Message-Id: <e35f7051f03e269b623a68b139d8ed131325f7b7.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zAFysPaOddVtaOm_OZmsmO9tRrn8j7vr
X-Proofpoint-GUID: h5qmYLTIMU5HiEoy0P7YxhwozAB9cBj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040063
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some of the tests are using x86_64 ABI-specific syscall entry points
(such as __x64_sys_nanosleep and __x64_sys_getpgid). Update them to use
architecture-dependent syscall entry names.

Also update fexit_sleep test to not use BPF_PROG() so that it is clear
that the syscall parameters aren't being accessed in the bpf prog.

Note that none of the bpf progs in these tests are actually accessing
any of the syscall parameters. The only exception is perfbuf_bench, which
passes on the bpf prog context into bpf_perf_event_output() as a pointer
to pt_regs, but that looks to be mostly ignored.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/bpf/progs/bloom_filter_bench.c | 7 ++++---
 tools/testing/selftests/bpf/progs/bloom_filter_map.c   | 5 +++--
 tools/testing/selftests/bpf/progs/bpf_loop.c           | 9 +++++----
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c     | 3 ++-
 tools/testing/selftests/bpf/progs/fexit_sleep.c        | 9 +++++----
 tools/testing/selftests/bpf/progs/perfbuf_bench.c      | 3 ++-
 tools/testing/selftests/bpf/progs/ringbuf_bench.c      | 3 ++-
 tools/testing/selftests/bpf/progs/test_ringbuf.c       | 3 ++-
 tools/testing/selftests/bpf/progs/trace_printk.c       | 3 ++-
 tools/testing/selftests/bpf/progs/trace_vprintk.c      | 3 ++-
 tools/testing/selftests/bpf/progs/trigger_bench.c      | 9 +++++----
 11 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_bench.c b/tools/testing/selftests/bpf/progs/bloom_filter_bench.c
index d9a88dd1ea6562..7efcbdbe772d9d 100644
--- a/tools/testing/selftests/bpf/progs/bloom_filter_bench.c
+++ b/tools/testing/selftests/bpf/progs/bloom_filter_bench.c
@@ -5,6 +5,7 @@
 #include <linux/bpf.h>
 #include <stdbool.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -87,7 +88,7 @@ bloom_callback(struct bpf_map *map, __u32 *key, void *val,
 	return 0;
 }
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bloom_lookup(void *ctx)
 {
 	struct callback_ctx data;
@@ -100,7 +101,7 @@ int bloom_lookup(void *ctx)
 	return 0;
 }
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bloom_update(void *ctx)
 {
 	struct callback_ctx data;
@@ -113,7 +114,7 @@ int bloom_update(void *ctx)
 	return 0;
 }
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bloom_hashmap_lookup(void *ctx)
 {
 	__u64 *result;
diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
index 1316f3db79d99c..f245fcfe0c61ca 100644
--- a/tools/testing/selftests/bpf/progs/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -51,7 +52,7 @@ check_elem(struct bpf_map *map, __u32 *key, __u32 *val,
 	return 0;
 }
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int inner_map(void *ctx)
 {
 	struct bpf_map *inner_map;
@@ -70,7 +71,7 @@ int inner_map(void *ctx)
 	return 0;
 }
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int check_bloom(void *ctx)
 {
 	struct callback_ctx data;
diff --git a/tools/testing/selftests/bpf/progs/bpf_loop.c b/tools/testing/selftests/bpf/progs/bpf_loop.c
index 12349e4601e8ee..e08565282759c6 100644
--- a/tools/testing/selftests/bpf/progs/bpf_loop.c
+++ b/tools/testing/selftests/bpf/progs/bpf_loop.c
@@ -3,6 +3,7 @@
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -53,7 +54,7 @@ static int nested_callback1(__u32 index, void *data)
 	return 0;
 }
 
-SEC("fentry/__x64_sys_nanosleep")
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int test_prog(void *ctx)
 {
 	struct callback_ctx data = {};
@@ -71,7 +72,7 @@ int test_prog(void *ctx)
 	return 0;
 }
 
-SEC("fentry/__x64_sys_nanosleep")
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int prog_null_ctx(void *ctx)
 {
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
@@ -82,7 +83,7 @@ int prog_null_ctx(void *ctx)
 	return 0;
 }
 
-SEC("fentry/__x64_sys_nanosleep")
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int prog_invalid_flags(void *ctx)
 {
 	struct callback_ctx data = {};
@@ -95,7 +96,7 @@ int prog_invalid_flags(void *ctx)
 	return 0;
 }
 
-SEC("fentry/__x64_sys_nanosleep")
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int prog_nested_calls(void *ctx)
 {
 	struct callback_ctx data = {};
diff --git a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c b/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
index 9dafdc2444626f..4ce76eb064c41c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
+++ b/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
@@ -3,6 +3,7 @@
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -14,7 +15,7 @@ static int empty_callback(__u32 index, void *data)
 	return 0;
 }
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int benchmark(void *ctx)
 {
 	for (int i = 0; i < 1000; i++) {
diff --git a/tools/testing/selftests/bpf/progs/fexit_sleep.c b/tools/testing/selftests/bpf/progs/fexit_sleep.c
index bca92c9bd29a17..106dc75efcc499 100644
--- a/tools/testing/selftests/bpf/progs/fexit_sleep.c
+++ b/tools/testing/selftests/bpf/progs/fexit_sleep.c
@@ -3,6 +3,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 char LICENSE[] SEC("license") = "GPL";
 
@@ -10,8 +11,8 @@ int pid = 0;
 int fentry_cnt = 0;
 int fexit_cnt = 0;
 
-SEC("fentry/__x64_sys_nanosleep")
-int BPF_PROG(nanosleep_fentry, const struct pt_regs *regs)
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int nanosleep_fentry(void *ctx)
 {
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 0;
@@ -20,8 +21,8 @@ int BPF_PROG(nanosleep_fentry, const struct pt_regs *regs)
 	return 0;
 }
 
-SEC("fexit/__x64_sys_nanosleep")
-int BPF_PROG(nanosleep_fexit, const struct pt_regs *regs, int ret)
+SEC("fexit/" SYS_PREFIX "sys_nanosleep")
+int nanosleep_fexit(void *ctx)
 {
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/perfbuf_bench.c b/tools/testing/selftests/bpf/progs/perfbuf_bench.c
index e5ab4836a6415d..45204fe0c570bf 100644
--- a/tools/testing/selftests/bpf/progs/perfbuf_bench.c
+++ b/tools/testing/selftests/bpf/progs/perfbuf_bench.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <stdint.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -18,7 +19,7 @@ const volatile int batch_cnt = 0;
 long sample_val = 42;
 long dropped __attribute__((aligned(128))) = 0;
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bench_perfbuf(void *ctx)
 {
 	__u64 *sample;
diff --git a/tools/testing/selftests/bpf/progs/ringbuf_bench.c b/tools/testing/selftests/bpf/progs/ringbuf_bench.c
index 123607d314d665..6a468496f53911 100644
--- a/tools/testing/selftests/bpf/progs/ringbuf_bench.c
+++ b/tools/testing/selftests/bpf/progs/ringbuf_bench.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <stdint.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -30,7 +31,7 @@ static __always_inline long get_flags()
 	return sz >= wakeup_data_size ? BPF_RB_FORCE_WAKEUP : BPF_RB_NO_WAKEUP;
 }
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bench_ringbuf(void *ctx)
 {
 	long *sample, flags;
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf.c b/tools/testing/selftests/bpf/progs/test_ringbuf.c
index eaa7d9dba0befa..5bdc0d38efc058 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -35,7 +36,7 @@ long prod_pos = 0;
 /* inner state */
 long seq = 0;
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int test_ringbuf(void *ctx)
 {
 	int cur_pid = bpf_get_current_pid_tgid() >> 32;
diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
index 119582aa105a82..6695478c2b2501 100644
--- a/tools/testing/selftests/bpf/progs/trace_printk.c
+++ b/tools/testing/selftests/bpf/progs/trace_printk.c
@@ -4,6 +4,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -12,7 +13,7 @@ int trace_printk_ran = 0;
 
 const char fmt[] = "Testing,testing %d\n";
 
-SEC("fentry/__x64_sys_nanosleep")
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int sys_enter(void *ctx)
 {
 	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
diff --git a/tools/testing/selftests/bpf/progs/trace_vprintk.c b/tools/testing/selftests/bpf/progs/trace_vprintk.c
index d327241ba04754..969306cd4f3368 100644
--- a/tools/testing/selftests/bpf/progs/trace_vprintk.c
+++ b/tools/testing/selftests/bpf/progs/trace_vprintk.c
@@ -4,6 +4,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -11,7 +12,7 @@ int null_data_vprintk_ret = 0;
 int trace_vprintk_ret = 0;
 int trace_vprintk_ran = 0;
 
-SEC("fentry/__x64_sys_nanosleep")
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int sys_enter(void *ctx)
 {
 	static const char one[] = "1";
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 2098f3f27f1860..2ab049b54d6cee 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -5,6 +5,7 @@
 #include <asm/unistd.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -25,28 +26,28 @@ int BPF_PROG(bench_trigger_raw_tp, struct pt_regs *regs, long id)
 	return 0;
 }
 
-SEC("kprobe/__x64_sys_getpgid")
+SEC("kprobe/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_kprobe(void *ctx)
 {
 	__sync_add_and_fetch(&hits, 1);
 	return 0;
 }
 
-SEC("fentry/__x64_sys_getpgid")
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fentry(void *ctx)
 {
 	__sync_add_and_fetch(&hits, 1);
 	return 0;
 }
 
-SEC("fentry.s/__x64_sys_getpgid")
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fentry_sleep(void *ctx)
 {
 	__sync_add_and_fetch(&hits, 1);
 	return 0;
 }
 
-SEC("fmod_ret/__x64_sys_getpgid")
+SEC("fmod_ret/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fmodret(void *ctx)
 {
 	__sync_add_and_fetch(&hits, 1);
-- 
2.34.1

