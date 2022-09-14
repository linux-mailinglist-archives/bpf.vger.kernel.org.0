Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B005B885A
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 14:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiINMgY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiINMgU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 08:36:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3167C89
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 05:36:16 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E7TdA2001331
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 05:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=36D+RpFwUrMXXbS5Jin4BDgsluXCHxEkPX9+151A5Yo=;
 b=h4hrKIiAcVo2K5oKXkZfvcytyUBXh17h3QRAnB3Hen6EzQI4fwdYWQ/BfmSgh0D0XCIp
 C8nb11QHLSeCRyXy67ybILie6Q5L3us69Hpi9zz9VZwXNx7wpP/YBIETPGSru64evIcc
 Lxr18gUk2chWuLxtjCjyaxczRhjs7ieFzLI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jjy0ew76d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 05:36:15 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 05:36:14 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 89955D752C21; Wed, 14 Sep 2022 05:36:03 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add test verifying bpf_ringbuf_reserve retval use in map ops
Date:   Wed, 14 Sep 2022 05:36:00 -0700
Message-ID: <20220914123600.927632-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914123600.927632-1-davemarchevsky@fb.com>
References: <20220914123600.927632-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1ytu-HHCnLTscJbzAXBb78r6o2epsVyZ
X-Proofpoint-GUID: 1ytu-HHCnLTscJbzAXBb78r6o2epsVyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_05,2022-09-14_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test_ringbuf_map_key test prog, borrowing heavily from extant
test_ringbuf.c. The program tries to use the result of
bpf_ringbuf_reserve as map_key, which was not possible before previouis
commits in this series. The test runner added to prog_tests/ringbuf.c
verifies that the program loads and does basic sanity checks to confirm
that it runs as expected.

Also, refactor test_ringbuf such that runners for existing test_ringbuf
and newly-added test_ringbuf_map_key are subtests of 'ringbuf' top-level
test.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.co=
m

* Actually run the program instead of just loading (Yonghong)
* Add a bpf_map_update_elem call to the test (Yonghong)
* Refactor runner such that existing test and newly-added test are
  subtests of 'ringbuf' top-level test (Yonghong)
* Remove unused globals in test prog (Yonghong)

 tools/testing/selftests/bpf/Makefile          |  8 ++-
 .../selftests/bpf/prog_tests/ringbuf.c        | 63 ++++++++++++++++-
 .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
 3 files changed, 137 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_ke=
y.c

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
index 9a80fe8a6427..e0f8db69cb77 100644
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
@@ -58,6 +59,7 @@ static int process_sample(void *ctx, void *data, size_t=
 len)
 	}
 }
=20
+static struct test_ringbuf_map_key_lskel *skel_map_key;
 static struct test_ringbuf_lskel *skel;
 static struct ring_buffer *ringbuf;
=20
@@ -81,7 +83,7 @@ static void *poll_thread(void *input)
 	return (void *)(long)ring_buffer__poll(ringbuf, timeout);
 }
=20
-void test_ringbuf(void)
+void ringbuf_subtest(void)
 {
 	const size_t rec_sz =3D BPF_RINGBUF_HDR_SZ + sizeof(struct sample);
 	pthread_t thread;
@@ -297,3 +299,62 @@ void test_ringbuf(void)
 	ring_buffer__free(ringbuf);
 	test_ringbuf_lskel__destroy(skel);
 }
+
+static int process_map_key_sample(void *ctx, void *data, size_t len)
+{
+	struct sample *s;
+	int err, val;
+
+	s =3D data;
+	switch (s->seq) {
+	case 1:
+		ASSERT_EQ(s->value, 42, "sample_value");
+		err =3D bpf_map_lookup_elem(skel_map_key->maps.hash_map.map_fd,
+					  s, &val);
+		ASSERT_OK(err, "hash_map bpf_map_lookup_elem");
+		ASSERT_EQ(val, 1, "hash_map val");
+		return -EDONE;
+	default:
+		return 0;
+	}
+}
+
+void ringbuf_map_key_subtest(void)
+{
+	int err;
+
+	skel_map_key =3D test_ringbuf_map_key_lskel__open();
+	if (!ASSERT_OK_PTR(skel_map_key, "test_ringbuf_map_key_lskel__open"))
+		return;
+
+	skel_map_key->maps.ringbuf.max_entries =3D getpagesize();
+	skel_map_key->bss->pid =3D getpid();
+
+	err =3D test_ringbuf_map_key_lskel__load(skel_map_key);
+	if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__load"))
+		goto cleanup;
+
+	ringbuf =3D ring_buffer__new(skel_map_key->maps.ringbuf.map_fd,
+				   process_map_key_sample, NULL, NULL);
+
+	err =3D test_ringbuf_map_key_lskel__attach(skel_map_key);
+	if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__attach"))
+		goto cleanup_ringbuf;
+
+	syscall(__NR_getpgid);
+	ASSERT_EQ(skel_map_key->bss->seq, 1, "skel_map_key->bss->seq");
+	ring_buffer__poll(ringbuf, -1);
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup:
+	test_ringbuf_map_key_lskel__destroy(skel_map_key);
+}
+
+void test_ringbuf(void)
+{
+	if (test__start_subtest("ringbuf"))
+		ringbuf_subtest();
+	if (test__start_subtest("ringbuf_map_key"))
+		ringbuf_map_key_subtest();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/t=
ools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
new file mode 100644
index 000000000000..495f85c6e120
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
@@ -0,0 +1,70 @@
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
+
+/* inner state */
+long seq =3D 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_mem_map_key(void *ctx)
+{
+	int cur_pid =3D bpf_get_current_pid_tgid() >> 32;
+	struct sample *sample, sample_copy;
+	int *lookup_val;
+
+	if (cur_pid !=3D pid)
+		return 0;
+
+	sample =3D bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+
+	sample->pid =3D pid;
+	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
+	sample->seq =3D ++seq;
+	sample->value =3D 42;
+
+	/* test using 'sample' (PTR_TO_MEM | MEM_ALLOC) as map key arg
+	 */
+	lookup_val =3D (int *)bpf_map_lookup_elem(&hash_map, sample);
+
+	/* memcpy is necessary so that verifier doesn't complain with:
+	 *   verifier internal error: more than one arg with ref_obj_id R3
+	 * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->se=
q, BPF_ANY);
+	 *
+	 * Since bpf_map_lookup_elem above uses 'sample' as key, test using
+	 * sample field as value below
+	 */
+	__builtin_memcpy(&sample_copy, sample, sizeof(struct sample));
+	bpf_map_update_elem(&hash_map, &sample_copy, &sample->seq, BPF_ANY);
+
+	bpf_ringbuf_submit(sample, 0);
+	return 0;
+}
--=20
2.30.2

