Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE145B57ED
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiILKLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILKLT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 06:11:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71511D0E2
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 03:11:17 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C3RxiE004812
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 03:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=GrI7o9/3/ri+nmbxzBpOB+4deChuDQZ8KLaqT3tZW5U=;
 b=HR65RM3hZ6GPgowYA94UJTK6IDmphIQuNfuVuToPu5oQtzWCll9/Ac3vZ/80nocMzO2N
 XFoyK6rFj0E5L+EJU5CrLrwdD8aFNDt3Mk7p1S684iFdwg7qXLOWDQiPGOlyMrqlwE/+
 Kt3qbIdDgiyHMEMkvW8du0ii5GNCy15SV8o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jgsw48asy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 03:11:17 -0700
Received: from twshared1781.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 03:11:16 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id BD3E9D59737A; Mon, 12 Sep 2022 03:11:08 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Liam Wisehart <liamwisehart@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: Allow ringbuf memory to be used as map key
Date:   Mon, 12 Sep 2022 03:11:05 -0700
Message-ID: <20220912101106.2765921-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KW7PPUN8Gl0N2vX9ZIHgHcZRcKqA-_6Y
X-Proofpoint-GUID: KW7PPUN8Gl0N2vX9ZIHgHcZRcKqA-_6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_06,2022-09-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds support for the following pattern:

  struct some_data *data =3D bpf_ringbuf_reserve(&ringbuf, sizeof(struct =
some_data, 0));
  bpf_map_lookup_elem(&another_map, &data->some_field);
  bpf_ringbuf_submit(data);

Currently the verifier does not consider bpf_ringbuf_reserve's
PTR_TO_MEM ret type a valid key input to bpf_map_lookup_elem. Since
PTR_TO_MEM is by definition a valid region of memory, it is safe to use
it as a key for lookups.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c                         |  2 +
 tools/testing/selftests/bpf/Makefile          |  8 ++-
 .../selftests/bpf/prog_tests/ringbuf.c        | 10 +++
 .../bpf/progs/test_ringbuf_map_key.c          | 69 +++++++++++++++++++
 4 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_ke=
y.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c259d734f863..d093618aed99 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5626,6 +5626,8 @@ static const struct bpf_reg_types map_key_value_typ=
es =3D {
 		PTR_TO_PACKET_META,
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
+		PTR_TO_MEM,
+		PTR_TO_MEM | MEM_ALLOC,
 	},
 };
=20
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 6cd327f1f216..231d9c1364c9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -351,9 +351,11 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_f=
uncs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h
=20
-LSKELS :=3D fentry_test.c fexit_test.c fexit_sleep.c \
-	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
-	map_ptr_kern.c core_kern.c core_kern_overflow.c
+LSKELS :=3D fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
+	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
+	core_kern.c core_kern_overflow.c test_ringbuf.c			\
+	test_ringbuf_map_key.c
+
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
 	kfunc_call_test_subprog.c
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
index 9a80fe8a6427..1cf458d1a179 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
 #include "test_ringbuf.lskel.h"
+#include "test_ringbuf_map_key.lskel.h"
=20
 #define EDONE 7777
=20
@@ -297,3 +298,12 @@ void test_ringbuf(void)
 	ring_buffer__free(ringbuf);
 	test_ringbuf_lskel__destroy(skel);
 }
+
+void test_ringbuf_map_key(void)
+{
+	struct test_ringbuf_map_key_lskel *skel_map_key;
+
+	skel_map_key =3D test_ringbuf_map_key_lskel__open_and_load();
+	ASSERT_OK_PTR(skel_map_key, "test_ringbuf_map_key_lskel__open_and_load =
failed");
+	test_ringbuf_map_key_lskel__destroy(skel_map_key);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/t=
ools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
new file mode 100644
index 000000000000..96a791a9762e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+struct sample {
+	int pid;
+	int seq;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1000);
+	__type(key, struct sample);
+	__type(value, int);
+} hash_map SEC(".maps");
+
+/* inputs */
+int pid =3D 0;
+long value =3D 0;
+long flags =3D 0;
+
+/* outputs */
+long total =3D 0;
+long dropped =3D 0;
+
+/* inner state */
+long seq =3D 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_mem_map_key(void *ctx)
+{
+	int cur_pid =3D bpf_get_current_pid_tgid() >> 32;
+	struct sample *sample;
+	int *lookup_val;
+	int zero =3D 0;
+
+	if (cur_pid !=3D pid)
+		return 0;
+
+	sample =3D bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
+	if (!sample) {
+		__sync_fetch_and_add(&dropped, 1);
+		return 0;
+	}
+
+	sample->pid =3D pid;
+	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
+	sample->value =3D value;
+	sample->seq =3D seq++;
+
+	/* This prog is never run, successful load w/ below use of sample mem
+	 * as map key is considered success
+	 */
+	lookup_val =3D (int *)bpf_map_lookup_elem(&hash_map, sample);
+	bpf_ringbuf_submit(sample, 0);
+	return 0;
+}
--=20
2.30.2

