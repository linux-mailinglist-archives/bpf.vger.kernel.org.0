Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C143A4EFDE4
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 04:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiDBCBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 22:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiDBCBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 22:01:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38871103D93
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 18:59:59 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C0FT010120
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 18:59:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bMPEPSZC9kKKobXHn71TCuXp2CK6GtDte21yBnhStUs=;
 b=jINyv9HYCLOUef86iSbs+4qQd4inl1wxx76qJIdaiN16MW+7pV6FpJi3SZ7IXYzRVwvr
 w5bnLGMe/lGczhGiIQipEzwBSxwhNMenqVGo9d1/NWZm85V8xrWF/sQlNF2uH6+N5x9L
 LWq+WVkO3+qTel3NotMP4x+cqYdOSggJs00= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f69yn8w4v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 18:59:58 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 18:59:55 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 33270A790681; Fri,  1 Apr 2022 18:59:44 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 7/7] bpf: Dynptr tests
Date:   Fri, 1 Apr 2022 18:58:26 -0700
Message-ID: <20220402015826.3941317-8-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402015826.3941317-1-joannekoong@fb.com>
References: <20220402015826.3941317-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cZxDQjBlpt5TiDs2X33dj5jNDDg5hcNS
X-Proofpoint-ORIG-GUID: cZxDQjBlpt5TiDs2X33dj5jNDDg5hcNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

This patch adds tests for dynptrs. These include scenarios that the
verifier needs to reject, as well as some successful use cases of
dynptrs that should pass.

Some of the failure scenarios include checking against invalid bpf_frees,
invalid writes, invalid reads, and invalid ringbuf API usages.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 303 ++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 527 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 147 +++++
 3 files changed, 977 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
new file mode 100644
index 000000000000..7107ebee3427
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <test_progs.h>
+#include "dynptr_fail.skel.h"
+#include "dynptr_success.skel.h"
+
+size_t log_buf_sz =3D 1024 * 1024;
+
+enum fail_case {
+	MISSING_FREE,
+	MISSING_FREE_CALLBACK,
+	INVALID_FREE1,
+	INVALID_FREE2,
+	USE_AFTER_FREE,
+	MALLOC_TWICE,
+	INVALID_MAP_CALL1,
+	INVALID_MAP_CALL2,
+	RINGBUF_INVALID_ACCESS,
+	RINGBUF_INVALID_API,
+	RINGBUF_OUT_OF_BOUNDS,
+	DATA_SLICE_OUT_OF_BOUNDS,
+	DATA_SLICE_USE_AFTER_FREE,
+	INVALID_HELPER1,
+	INVALID_HELPER2,
+	INVALID_WRITE1,
+	INVALID_WRITE2,
+	INVALID_WRITE3,
+	INVALID_WRITE4,
+	INVALID_READ1,
+	INVALID_READ2,
+	INVALID_READ3,
+	INVALID_OFFSET,
+	GLOBAL,
+	FREE_TWICE,
+	FREE_TWICE_CALLBACK,
+};
+
+static void verify_fail(enum fail_case fail, char *obj_log_buf,  char *e=
rr_msg)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct bpf_program *prog;
+	struct dynptr_fail *skel;
+	int err;
+
+	opts.kernel_log_buf =3D obj_log_buf;
+	opts.kernel_log_size =3D log_buf_sz;
+	opts.kernel_log_level =3D 1;
+
+	skel =3D dynptr_fail__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, false);
+
+	/* these programs should all be rejected by the verifier */
+	switch (fail) {
+	case MISSING_FREE:
+		prog =3D skel->progs.missing_free;
+		break;
+	case MISSING_FREE_CALLBACK:
+		prog =3D skel->progs.missing_free_callback;
+		break;
+	case INVALID_FREE1:
+		prog =3D skel->progs.invalid_free1;
+		break;
+	case INVALID_FREE2:
+		prog =3D skel->progs.invalid_free2;
+		break;
+	case USE_AFTER_FREE:
+		prog =3D skel->progs.use_after_free;
+		break;
+	case MALLOC_TWICE:
+		prog =3D skel->progs.malloc_twice;
+		break;
+	case INVALID_MAP_CALL1:
+		prog =3D skel->progs.invalid_map_call1;
+		break;
+	case INVALID_MAP_CALL2:
+		prog =3D skel->progs.invalid_map_call2;
+		break;
+	case RINGBUF_INVALID_ACCESS:
+		prog =3D skel->progs.ringbuf_invalid_access;
+		break;
+	case RINGBUF_INVALID_API:
+		prog =3D skel->progs.ringbuf_invalid_api;
+		break;
+	case RINGBUF_OUT_OF_BOUNDS:
+		prog =3D skel->progs.ringbuf_out_of_bounds;
+		break;
+	case DATA_SLICE_OUT_OF_BOUNDS:
+		prog =3D skel->progs.data_slice_out_of_bounds;
+		break;
+	case DATA_SLICE_USE_AFTER_FREE:
+		prog =3D skel->progs.data_slice_use_after_free;
+		break;
+	case INVALID_HELPER1:
+		prog =3D skel->progs.invalid_helper1;
+		break;
+	case INVALID_HELPER2:
+		prog =3D skel->progs.invalid_helper2;
+		break;
+	case INVALID_WRITE1:
+		prog =3D skel->progs.invalid_write1;
+		break;
+	case INVALID_WRITE2:
+		prog =3D skel->progs.invalid_write2;
+		break;
+	case INVALID_WRITE3:
+		prog =3D skel->progs.invalid_write3;
+		break;
+	case INVALID_WRITE4:
+		prog =3D skel->progs.invalid_write4;
+		break;
+	case INVALID_READ1:
+		prog =3D skel->progs.invalid_read1;
+		break;
+	case INVALID_READ2:
+		prog =3D skel->progs.invalid_read2;
+		break;
+	case INVALID_READ3:
+		prog =3D skel->progs.invalid_read3;
+		break;
+	case INVALID_OFFSET:
+		prog =3D skel->progs.invalid_offset;
+		break;
+	case GLOBAL:
+		prog =3D skel->progs.global;
+		break;
+	case FREE_TWICE:
+		prog =3D skel->progs.free_twice;
+		break;
+	case FREE_TWICE_CALLBACK:
+		prog =3D skel->progs.free_twice_callback;
+		break;
+	default:
+		fprintf(stderr, "unknown fail_case\n");
+		return;
+	}
+
+	bpf_program__set_autoload(prog, true);
+
+	err =3D dynptr_fail__load(skel);
+
+	ASSERT_OK_PTR(strstr(obj_log_buf, err_msg), "err_msg not found");
+
+	ASSERT_ERR(err, "unexpected load success");
+
+	dynptr_fail__destroy(skel);
+}
+
+static void run_prog(struct dynptr_success *skel, struct bpf_program *pr=
og)
+{
+	struct bpf_link *link;
+
+	link =3D bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf program attach"))
+		return;
+
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->err, 0, "err");
+
+	bpf_link__destroy(link);
+}
+
+static void verify_success(void)
+{
+	struct dynptr_success *skel;
+
+	skel =3D dynptr_success__open();
+
+	skel->bss->pid =3D getpid();
+
+	dynptr_success__load(skel);
+	if (!ASSERT_OK_PTR(skel, "dynptr__open_and_load"))
+		return;
+
+	run_prog(skel, skel->progs.prog_success);
+	run_prog(skel, skel->progs.prog_success_data_slice);
+	run_prog(skel, skel->progs.prog_success_ringbuf);
+
+	dynptr_success__destroy(skel);
+}
+
+void test_dynptr(void)
+{
+	char *obj_log_buf;
+
+	obj_log_buf =3D malloc(3 * log_buf_sz);
+	if (!ASSERT_OK_PTR(obj_log_buf, "obj_log_buf"))
+		return;
+	obj_log_buf[0] =3D '\0';
+
+	if (test__start_subtest("missing_free"))
+		verify_fail(MISSING_FREE, obj_log_buf,
+			    "spi=3D0 is an unreleased dynptr");
+
+	if (test__start_subtest("missing_free_callback"))
+		verify_fail(MISSING_FREE_CALLBACK, obj_log_buf,
+			    "spi=3D0 is an unreleased dynptr");
+
+	if (test__start_subtest("invalid_free1"))
+		verify_fail(INVALID_FREE1, obj_log_buf,
+			    "arg #1 is an unacquired reference and hence cannot be released")=
;
+
+	if (test__start_subtest("invalid_free2"))
+		verify_fail(INVALID_FREE2, obj_log_buf, "type=3Dalloc_mem_or_null expe=
cted=3Dfp");
+
+	if (test__start_subtest("use_after_free"))
+		verify_fail(USE_AFTER_FREE, obj_log_buf,
+			    "Expected an initialized dynptr as arg #3");
+
+	if (test__start_subtest("malloc_twice"))
+		verify_fail(MALLOC_TWICE, obj_log_buf,
+			    "Arg #2 dynptr cannot be an initialized dynptr");
+
+	if (test__start_subtest("invalid_map_call1"))
+		verify_fail(INVALID_MAP_CALL1, obj_log_buf,
+			    "invalid indirect read from stack");
+
+	if (test__start_subtest("invalid_map_call2"))
+		verify_fail(INVALID_MAP_CALL2, obj_log_buf,
+			    "invalid indirect read from stack");
+
+	if (test__start_subtest("invalid_helper1"))
+		verify_fail(INVALID_HELPER1, obj_log_buf,
+			    "invalid indirect read from stack");
+
+	if (test__start_subtest("ringbuf_invalid_access"))
+		verify_fail(RINGBUF_INVALID_ACCESS, obj_log_buf,
+			    "invalid mem access 'scalar'");
+
+	if (test__start_subtest("ringbuf_invalid_api"))
+		verify_fail(RINGBUF_INVALID_API, obj_log_buf,
+			    "func bpf_ringbuf_submit#132 reference has not been acquired befo=
re");
+
+	if (test__start_subtest("ringbuf_out_of_bounds"))
+		verify_fail(RINGBUF_OUT_OF_BOUNDS, obj_log_buf,
+			    "value is outside of the allowed memory range");
+
+	if (test__start_subtest("data_slice_out_of_bounds"))
+		verify_fail(DATA_SLICE_OUT_OF_BOUNDS, obj_log_buf,
+			    "value is outside of the allowed memory range");
+
+	if (test__start_subtest("data_slice_use_after_free"))
+		verify_fail(DATA_SLICE_USE_AFTER_FREE, obj_log_buf,
+			    "invalid mem access 'scalar'");
+
+	if (test__start_subtest("invalid_helper2"))
+		verify_fail(INVALID_HELPER2, obj_log_buf,
+			    "Expected an initialized dynptr as arg #3");
+
+	if (test__start_subtest("invalid_write1"))
+		verify_fail(INVALID_WRITE1, obj_log_buf,
+			    "direct write into dynptr is not permitted");
+
+	if (test__start_subtest("invalid_write2"))
+		verify_fail(INVALID_WRITE2, obj_log_buf,
+			    "direct write into dynptr is not permitted");
+
+	if (test__start_subtest("invalid_write3"))
+		verify_fail(INVALID_WRITE3, obj_log_buf,
+			    "direct write into dynptr is not permitted");
+
+	if (test__start_subtest("invalid_write4"))
+		verify_fail(INVALID_WRITE4, obj_log_buf,
+			    "direct write into dynptr is not permitted");
+
+	if (test__start_subtest("invalid_read1"))
+		verify_fail(INVALID_READ1, obj_log_buf,
+			    "invalid read from stack");
+
+	if (test__start_subtest("invalid_read2"))
+		verify_fail(INVALID_READ2, obj_log_buf,
+			    "Expected an initialized dynptr as arg #3");
+
+	if (test__start_subtest("invalid_read3"))
+		verify_fail(INVALID_READ3, obj_log_buf,
+			    "invalid read from stack");
+
+	if (test__start_subtest("invalid_offset"))
+		verify_fail(INVALID_OFFSET, obj_log_buf,
+			    "invalid indirect access to stack");
+
+	if (test__start_subtest("global"))
+		verify_fail(GLOBAL, obj_log_buf,
+			    "R2 type=3Dmap_value expected=3Dfp");
+
+	if (test__start_subtest("free_twice"))
+		verify_fail(FREE_TWICE, obj_log_buf,
+			    "arg #1 is an unacquired reference and hence cannot be released")=
;
+
+	if (test__start_subtest("free_twice_callback"))
+		verify_fail(FREE_TWICE_CALLBACK, obj_log_buf,
+			    "arg #1 is an unacquired reference and hence cannot be released")=
;
+
+	if (test__start_subtest("success"))
+		verify_success();
+
+	free(obj_log_buf);
+}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
new file mode 100644
index 000000000000..0b19eeb83e36
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -0,0 +1,527 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <string.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct bpf_dynptr);
+} array_map SEC(".maps");
+
+struct sample {
+	int pid;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1 << 12);
+} ringbuf SEC(".maps");
+
+int err =3D 0;
+int val;
+
+/* A dynptr can't be used after bpf_free has been called on it */
+SEC("raw_tp/sys_nanosleep")
+int use_after_free(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char read_data[64] =3D {};
+
+	bpf_malloc(8, &ptr);
+
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	bpf_free(&ptr);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	return 0;
+}
+
+/* Every bpf_malloc call must have a corresponding bpf_free call */
+SEC("raw_tp/sys_nanosleep")
+int missing_free(void *ctx)
+{
+	struct bpf_dynptr mem;
+
+	bpf_malloc(8, &mem);
+
+	/* missing a call to bpf_free(&mem) */
+
+	return 0;
+}
+
+/* A non-malloc-ed dynptr can't be freed */
+SEC("raw_tp/sys_nanosleep")
+int invalid_free1(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u32 x =3D 0;
+
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
+
+	/* this should fail */
+	bpf_free(&ptr);
+
+	return 0;
+}
+
+/* A data slice from a dynptr can't be freed */
+SEC("raw_tp/sys_nanosleep")
+int invalid_free2(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	bpf_malloc(8, &ptr);
+
+	data =3D bpf_dynptr_data(&ptr, 0, 8);
+
+	/* this should fail */
+	bpf_free(data);
+
+	return 0;
+}
+
+/*
+ * Can't bpf_malloc an existing malloc-ed bpf_dynptr that hasn't been
+ * freed yet
+ */
+SEC("raw_tp/sys_nanosleep")
+int malloc_twice(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_malloc(8, &ptr);
+
+	/* this should fail */
+	bpf_malloc(2, &ptr);
+
+	bpf_free(&ptr);
+
+	return 0;
+}
+
+/*
+ * Can't access a ring buffer record after submit or discard has been ca=
lled
+ * on the dynptr
+ */
+SEC("raw_tp/sys_nanosleep")
+int ringbuf_invalid_access(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct sample *sample;
+
+	err =3D bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
+	sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
+	if (!sample)
+		goto done;
+
+	sample->pid =3D 123;
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	/* this should fail */
+	err =3D sample->pid;
+
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* Can't call non-dynptr ringbuf APIs on a dynptr ringbuf sample */
+SEC("raw_tp/sys_nanosleep")
+int ringbuf_invalid_api(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct sample *sample;
+
+	err =3D bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
+	sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
+	if (!sample)
+		goto done;
+
+	sample->pid =3D 123;
+
+	/* invalid API use. need to use dynptr API to submit/discard */
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* Can't access memory outside a ringbuf record range */
+SEC("raw_tp/sys_nanosleep")
+int ringbuf_out_of_bounds(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct sample *sample;
+
+	err =3D bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
+	sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
+	if (!sample)
+		goto done;
+
+	/* Can't access beyond sample range */
+	*(__u8 *)((void *)sample + sizeof(*sample)) =3D 123;
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* Can't add a dynptr to a map */
+SEC("raw_tp/sys_nanosleep")
+int invalid_map_call1(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char buf[64] =3D {};
+	int key =3D 0;
+
+	err =3D bpf_dynptr_from_mem(buf, sizeof(buf), &ptr);
+
+	/* this should fail */
+	bpf_map_update_elem(&array_map, &key, &ptr, 0);
+
+	return 0;
+}
+
+/* Can't add a struct with an embedded dynptr to a map */
+SEC("raw_tp/sys_nanosleep")
+int invalid_map_call2(void *ctx)
+{
+	struct info {
+		int x;
+		struct bpf_dynptr ptr;
+	};
+	struct info x;
+	int key =3D 0;
+
+	bpf_malloc(8, &x.ptr);
+
+	/* this should fail */
+	bpf_map_update_elem(&array_map, &key, &x, 0);
+
+	return 0;
+}
+
+/* Can't pass in a dynptr as an arg to a helper function that doesn't ta=
ke in a
+ * dynptr argument
+ */
+SEC("raw_tp/sys_nanosleep")
+int invalid_helper1(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+
+	bpf_malloc(8, &ptr);
+
+	/* this should fail */
+	bpf_strncmp((const char *)&ptr, sizeof(ptr), "hello!");
+
+	bpf_free(&ptr);
+
+	return 0;
+}
+
+/* A dynptr can't be passed into a helper function at a non-zero offset =
*/
+SEC("raw_tp/sys_nanosleep")
+int invalid_helper2(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char read_data[64] =3D {};
+	__u64 x =3D 0;
+
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 8, 0);
+
+	return 0;
+}
+
+/* A data slice can't be accessed out of bounds */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int data_slice_out_of_bounds(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	void *data;
+
+	bpf_malloc(8, &ptr);
+
+	data =3D bpf_dynptr_data(&ptr, 0, 8);
+	if (!data)
+		goto done;
+
+	/* can't index out of bounds of the data slice */
+	val =3D *((char *)data + 8);
+
+done:
+	bpf_free(&ptr);
+	return 0;
+}
+
+/* A data slice can't be used after it's freed */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int data_slice_use_after_free(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	void *data;
+
+	bpf_malloc(8, &ptr);
+
+	data =3D bpf_dynptr_data(&ptr, 0, 8);
+	if (!data)
+		goto done;
+
+	bpf_free(&ptr);
+
+	/* this should fail */
+	val =3D *(__u8 *)data;
+
+done:
+	bpf_free(&ptr);
+	return 0;
+}
+
+/*
+ * A bpf_dynptr can't be written directly to by the bpf program,
+ * only through dynptr helper functions
+ */
+SEC("raw_tp/sys_nanosleep")
+int invalid_write1(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	__u8 x =3D 0;
+
+	bpf_malloc(8, &ptr);
+
+	/* this should fail */
+	memcpy(&ptr, &x, sizeof(x));
+
+	bpf_free(&ptr);
+
+	return 0;
+}
+
+/*
+ * A bpf_dynptr at a non-zero offset can't be written directly to by the=
 bpf program,
+ * only through dynptr helper functions
+ */
+SEC("raw_tp/sys_nanosleep")
+int invalid_write2(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char read_data[64] =3D {};
+	__u8 x =3D 0, y =3D 0;
+
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
+
+	/* this should fail */
+	memcpy((void *)&ptr, &y, sizeof(y));
+
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	return 0;
+}
+
+/* A non-const write into a dynptr is not permitted */
+SEC("raw_tp/sys_nanosleep")
+int invalid_write3(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char stack_buf[16];
+	unsigned long len;
+	__u8 x =3D 0;
+
+	bpf_malloc(8, &ptr);
+
+	memcpy(stack_buf, &val, sizeof(val));
+	len =3D stack_buf[0] & 0xf;
+
+	/* this should fail */
+	memcpy((void *)&ptr + len, &x, sizeof(x));
+
+	bpf_free(&ptr);
+
+	return 0;
+}
+
+static int invalid_write4_callback(__u32 index, void *data)
+{
+	/* this should fail */
+	*(__u32 *)data =3D 123;
+
+	bpf_free(data);
+
+	return 0;
+}
+
+/* An invalid write can't occur in a callback function */
+SEC("raw_tp/sys_nanosleep")
+int invalid_write4(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u64 x =3D 0;
+
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
+
+	bpf_loop(10, invalid_write4_callback, &ptr, 0);
+
+	return 0;
+}
+
+/* A globally-defined bpf_dynptr can't be used (it must reside as a stac=
k frame) */
+struct bpf_dynptr global_dynptr;
+SEC("raw_tp/sys_nanosleep")
+int global(void *ctx)
+{
+	/* this should fail */
+	bpf_malloc(4, &global_dynptr);
+
+	bpf_free(&global_dynptr);
+
+	return 0;
+}
+
+/* A direct read should fail */
+SEC("raw_tp/sys_nanosleep")
+int invalid_read1(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	__u32 x =3D 2;
+
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
+
+	/* this should fail */
+	val =3D *(int *)&ptr;
+
+	return 0;
+}
+
+/* A direct read at an offset should fail */
+SEC("raw_tp/sys_nanosleep")
+int invalid_read2(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char read_data[64] =3D {};
+	__u64 x =3D 0;
+
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 1, 0);
+
+	return 0;
+}
+
+/* A direct read at an offset into the lower stack slot should fail */
+SEC("raw_tp/sys_nanosleep")
+int invalid_read3(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	struct bpf_dynptr ptr2 =3D {};
+	__u32 x =3D 2;
+
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr2);
+
+	/* this should fail */
+	memcpy(&val, (void *)&ptr + 8, sizeof(val));
+
+	return 0;
+}
+
+/* Calling bpf_dynptr_from_mem on an offset should fail */
+SEC("raw_tp/sys_nanosleep")
+int invalid_offset(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	__u64 x =3D 0;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(&x, sizeof(x), &ptr + 1);
+
+	return 0;
+}
+
+/* A malloc can't be freed twice */
+SEC("raw_tp/sys_nanosleep")
+int free_twice(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_malloc(8, &ptr);
+
+	bpf_free(&ptr);
+
+	/* this second free should fail */
+	bpf_free(&ptr);
+
+	return 0;
+}
+
+static int free_twice_callback_fn(__u32 index, void *data)
+{
+	/* this should fail */
+	bpf_free(data);
+	val =3D index;
+	return 0;
+}
+
+/* Test that freeing a malloc twice, where the 2nd free happens within a
+ * calback function, fails
+ */
+SEC("raw_tp/sys_nanosleep")
+int free_twice_callback(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_malloc(8, &ptr);
+
+	bpf_free(&ptr);
+
+	bpf_loop(10, free_twice_callback_fn, &ptr, 0);
+
+	return 0;
+}
+
+static int missing_free_callback_fn(__u32 index, void *data)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_malloc(8, &ptr);
+
+	val =3D index;
+
+	/* missing bpf_free(&ptr) */
+
+	return 0;
+}
+
+/* Any dynptr initialized within a callback must be freed */
+SEC("raw_tp/sys_nanosleep")
+int missing_free_callback(void *ctx)
+{
+	bpf_loop(10, missing_free_callback_fn, NULL, 0);
+	return 0;
+}
+
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
new file mode 100644
index 000000000000..1b605bbc17f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <string.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+int pid =3D 0;
+int err =3D 0;
+int val;
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
+	__uint(max_entries, 1 << 12);
+} ringbuf SEC(".maps");
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int prog_success(void *ctx)
+{
+	char buf[64] =3D {};
+	char write_data[64] =3D "hello there, world!!";
+	struct bpf_dynptr ptr =3D {}, mem =3D {};
+	__u8 mem_allocated =3D 0;
+	char read_data[64] =3D {};
+	__u32 val =3D 0;
+	void *data;
+	int i;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	err =3D bpf_dynptr_from_mem(buf, sizeof(buf), &ptr);
+	if (err)
+		goto done;
+
+	/* Write data into the dynptr */
+	err =3D bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data));
+	if (err)
+		goto done;
+
+	/* Read the data that was written into the dynptr */
+	err =3D bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+	if (err)
+		goto done;
+
+	/* Ensure the data we read matches the data we wrote */
+	for (i =3D 0; i < sizeof(read_data); i++) {
+		if (read_data[i] !=3D write_data[i]) {
+			err =3D 1;
+			goto done;
+		}
+	}
+
+done:
+	if (mem_allocated)
+		bpf_free(&mem);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int prog_success_data_slice(void *ctx)
+{
+	struct bpf_dynptr mem;
+	void *data;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	err =3D bpf_malloc(16, &mem);
+	if (err)
+		goto done;
+
+	data =3D bpf_dynptr_data(&mem, 0, sizeof(__u32));
+	if (!data)
+		goto done;
+
+	*(__u32 *)data =3D 999;
+
+	err =3D bpf_probe_read_kernel(&val, sizeof(val), data);
+	if (err)
+		goto done;
+
+	if (val !=3D *(__u32 *)data)
+		err =3D 2;
+
+done:
+	bpf_free(&mem);
+	return 0;
+}
+
+static int ringbuf_callback(__u32 index, void *data)
+{
+	struct sample *sample;
+
+	struct bpf_dynptr *ptr =3D (struct bpf_dynptr *)data;
+
+	sample =3D bpf_dynptr_data(ptr, 0, sizeof(*sample));
+	if (!sample)
+		return 0;
+
+	sample->pid +=3D val;
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int prog_success_ringbuf(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+	struct sample *sample;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	/* check that you can reserve a dynamic size reservation */
+	err =3D bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	if (err)
+		goto done;
+
+	sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
+	if (!sample)
+		goto done;
+
+	sample->pid =3D 123;
+
+	/* Can pass dynptr to callback functions */
+	bpf_loop(10, ringbuf_callback, &ptr, 0);
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
--=20
2.30.2

