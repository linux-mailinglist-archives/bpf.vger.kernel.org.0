Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DB513D40
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 23:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352128AbiD1VPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352182AbiD1VPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 17:15:46 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6E82323
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:12:14 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 13BD9BAF4BD6; Thu, 28 Apr 2022 14:11:52 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v3 6/6] bpf: Dynptr tests
Date:   Thu, 28 Apr 2022 14:10:59 -0700
Message-Id: <20220428211059.4065379-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428211059.4065379-1-joannelkoong@gmail.com>
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests for dynptrs, which include cases that the
verifier needs to reject (for example, invalid bpf_dynptr_put usages
and  invalid writes/reads), as well as cases that should successfully
pass.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 132 ++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 574 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 218 +++++++
 3 files changed, 924 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
new file mode 100644
index 000000000000..0bed39fd8dac
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <test_progs.h>
+#include "dynptr_fail.skel.h"
+#include "dynptr_success.skel.h"
+
+size_t log_buf_sz =3D 1048576; /* 1 MB */
+static char obj_log_buf[1048576];
+
+struct {
+	const char *prog_name;
+	const char *expected_err_msg;
+} dynptr_tests[] =3D {
+	/* failure cases */
+	{"missing_put", "Unreleased reference id=3D1"},
+	{"missing_put_callback", "Unreleased reference id=3D1"},
+	{"put_nonalloc", "Expected an initialized malloc dynptr as arg #1"},
+	{"put_data_slice", "type=3Ddynptr_mem expected=3Dfp"},
+	{"put_uninit_dynptr", "arg 1 is an unacquired reference"},
+	{"use_after_put", "Expected an initialized dynptr as arg #3"},
+	{"alloc_twice", "Arg #3 dynptr has to be an uninitialized dynptr"},
+	{"add_dynptr_to_map1", "invalid indirect read from stack"},
+	{"add_dynptr_to_map2", "invalid indirect read from stack"},
+	{"ringbuf_invalid_access", "invalid mem access 'scalar'"},
+	{"ringbuf_invalid_api", "type=3Ddynptr_mem expected=3Dalloc_mem"},
+	{"ringbuf_out_of_bounds", "value is outside of the allowed memory range=
"},
+	{"data_slice_out_of_bounds", "value is outside of the allowed memory ra=
nge"},
+	{"data_slice_use_after_put", "invalid mem access 'scalar'"},
+	{"invalid_helper1", "invalid indirect read from stack"},
+	{"invalid_helper2", "Expected an initialized dynptr as arg #3"},
+	{"invalid_write1", "Expected an initialized malloc dynptr as arg #1"},
+	{"invalid_write2", "Expected an initialized dynptr as arg #3"},
+	{"invalid_write3", "Expected an initialized malloc dynptr as arg #1"},
+	{"invalid_write4", "arg 1 is an unacquired reference"},
+	{"invalid_read1", "invalid read from stack"},
+	{"invalid_read2", "cannot pass in non-zero dynptr offset"},
+	{"invalid_read3", "invalid read from stack"},
+	{"invalid_offset", "invalid write to stack"},
+	{"global", "R3 type=3Dmap_value expected=3Dfp"},
+	{"put_twice", "arg 1 is an unacquired reference"},
+	{"put_twice_callback", "arg 1 is an unacquired reference"},
+	{"zero_slice_access", "invalid access to memory, mem_size=3D0 off=3D0 s=
ize=3D1"},
+	/* success cases */
+	{"test_basic", NULL},
+	{"test_data_slice", NULL},
+	{"test_ringbuf", NULL},
+	{"test_alloc_zero_bytes", NULL},
+};
+
+static void verify_fail(const char *prog_name, const char *expected_err_=
msg)
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
+	if (!ASSERT_OK_PTR(skel, "dynptr_fail__open_opts"))
+		goto cleanup;
+
+	prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	bpf_program__set_autoload(prog, true);
+
+	err =3D dynptr_fail__load(skel);
+	if (!ASSERT_ERR(err, "unexpected load success"))
+		goto cleanup;
+
+	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err=
_msg")) {
+		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
+		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
+	}
+
+cleanup:
+	dynptr_fail__destroy(skel);
+}
+
+static void verify_success(const char *prog_name)
+{
+	struct dynptr_success *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+
+	skel =3D dynptr_success__open();
+	if (!ASSERT_OK_PTR(skel, "dynptr_success__open"))
+		return;
+
+	skel->bss->pid =3D getpid();
+
+	dynptr_success__load(skel);
+	if (!ASSERT_OK_PTR(skel, "dynptr_success__load"))
+		goto cleanup;
+
+	prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link =3D bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->err, 0, "err");
+
+	bpf_link__destroy(link);
+
+cleanup:
+	dynptr_success__destroy(skel);
+}
+
+void test_dynptr(void)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(dynptr_tests); i++) {
+		if (!test__start_subtest(dynptr_tests[i].prog_name))
+			continue;
+
+		if (dynptr_tests[i].expected_err_msg)
+			verify_fail(dynptr_tests[i].prog_name, dynptr_tests[i].expected_err_m=
sg);
+		else
+			verify_success(dynptr_tests[i].prog_name);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
new file mode 100644
index 000000000000..e4d5464e1865
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -0,0 +1,574 @@
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
+/* Every bpf_dynptr_alloc call must have a corresponding bpf_dynptr_put =
call */
+SEC("?raw_tp/sys_nanosleep")
+int missing_put(void *ctx)
+{
+	struct bpf_dynptr mem;
+
+	bpf_dynptr_alloc(8, 0, &mem);
+
+	/* missing a call to bpf_dynptr_put(&mem) */
+
+	return 0;
+}
+
+/* A non-alloc-ed dynptr can't be used by bpf_dynptr_put */
+SEC("?raw_tp/sys_nanosleep")
+int put_nonalloc(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	/* this should fail */
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* A data slice from a dynptr can't be used by bpf_dynptr_put */
+SEC("?raw_tp/sys_nanosleep")
+int put_data_slice(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	data =3D bpf_dynptr_data(&ptr, 0, 8);
+	if (!data)
+		goto done;
+
+	/* this should fail */
+	bpf_dynptr_put(data);
+
+done:
+	bpf_dynptr_put(&ptr);
+	return 0;
+}
+
+/* Can't call bpf_dynptr_put on a non-initialized dynptr */
+SEC("?raw_tp/sys_nanosleep")
+int put_uninit_dynptr(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* A dynptr can't be used after bpf_dynptr_put has been called on it */
+SEC("?raw_tp/sys_nanosleep")
+int use_after_put(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char read_data[64] =3D {};
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	bpf_dynptr_put(&ptr);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	return 0;
+}
+
+/*
+ * Can't bpf_dynptr_alloc an existing allocated bpf_dynptr that bpf_dynp=
tr_put
+ * hasn't been called on yet
+ */
+SEC("?raw_tp/sys_nanosleep")
+int alloc_twice(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	/* this should fail */
+	bpf_dynptr_alloc(2, 0, &ptr);
+
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/*
+ * Can't access a ring buffer record after submit or discard has been ca=
lled
+ * on the dynptr
+ */
+SEC("?raw_tp/sys_nanosleep")
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
+SEC("?raw_tp/sys_nanosleep")
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
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* Can't access memory outside a ringbuf record range */
+SEC("?raw_tp/sys_nanosleep")
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
+SEC("?raw_tp/sys_nanosleep")
+int add_dynptr_to_map1(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	int key =3D 0;
+
+	err =3D bpf_dynptr_alloc(sizeof(val), 0, &ptr);
+
+	/* this should fail */
+	bpf_map_update_elem(&array_map, &key, &ptr, 0);
+
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* Can't add a struct with an embedded dynptr to a map */
+SEC("?raw_tp/sys_nanosleep")
+int add_dynptr_to_map2(void *ctx)
+{
+	struct info {
+		int x;
+		struct bpf_dynptr ptr;
+	};
+	struct info x;
+	int key =3D 0;
+
+	bpf_dynptr_alloc(sizeof(val), 0, &x.ptr);
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
+SEC("?raw_tp/sys_nanosleep")
+int invalid_helper1(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	/* this should fail */
+	bpf_strncmp((const char *)&ptr, sizeof(ptr), "hello!");
+
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* A dynptr can't be passed into a helper function at a non-zero offset =
*/
+SEC("?raw_tp/sys_nanosleep")
+int invalid_helper2(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char read_data[64] =3D {};
+
+	bpf_dynptr_alloc(sizeof(val), 0, &ptr);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 8, 0);
+
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* A data slice can't be accessed out of bounds */
+SEC("?raw_tp/sys_nanosleep")
+int data_slice_out_of_bounds(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	void *data;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	data =3D bpf_dynptr_data(&ptr, 0, 8);
+	if (!data)
+		goto done;
+
+	/* can't index out of bounds of the data slice */
+	val =3D *((char *)data + 8);
+
+done:
+	bpf_dynptr_put(&ptr);
+	return 0;
+}
+
+/* A data slice can't be used after bpf_dynptr_put is called */
+SEC("?raw_tp/sys_nanosleep")
+int data_slice_use_after_put(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	void *data;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	data =3D bpf_dynptr_data(&ptr, 0, 8);
+	if (!data)
+		goto done;
+
+	bpf_dynptr_put(&ptr);
+
+	/* this should fail */
+	val =3D *(__u8 *)data;
+
+done:
+	bpf_dynptr_put(&ptr);
+	return 0;
+}
+
+/* A bpf_dynptr can't be used as a dynptr if it's been written into */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_write1(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	__u8 x =3D 0;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	memcpy(&ptr, &x, sizeof(x));
+
+	/* this should fail */
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/*
+ * A bpf_dynptr can't be used as a dynptr if an offset into it has been
+ * written into
+ */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_write2(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char read_data[64] =3D {};
+	__u8 x =3D 0, y =3D 0;
+
+	bpf_dynptr_alloc(sizeof(x), 0, &ptr);
+
+	memcpy((void *)&ptr + 8, &y, sizeof(y));
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/*
+ * A bpf_dynptr can't be used as a dynptr if a non-const offset into it
+ * has been written into
+ */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_write3(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char stack_buf[16];
+	unsigned long len;
+	__u8 x =3D 0;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	memcpy(stack_buf, &val, sizeof(val));
+	len =3D stack_buf[0] & 0xf;
+
+	memcpy((void *)&ptr + len, &x, sizeof(x));
+
+	/* this should fail */
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+static int invalid_write4_callback(__u32 index, void *data)
+{
+	*(__u32 *)data =3D 123;
+
+	return 0;
+}
+
+/* If the dynptr is written into in a callback function, it should
+ * be invalidated as a dynptr
+ */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_write4(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u64 x =3D 0;
+
+	bpf_dynptr_alloc(sizeof(x), 0, &ptr);
+
+	bpf_loop(10, invalid_write4_callback, &ptr, 0);
+
+	/* this should fail */
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* A globally-defined bpf_dynptr can't be used (it must reside as a stac=
k frame) */
+struct bpf_dynptr global_dynptr;
+SEC("?raw_tp/sys_nanosleep")
+int global(void *ctx)
+{
+	/* this should fail */
+	bpf_dynptr_alloc(4, 0, &global_dynptr);
+
+	bpf_dynptr_put(&global_dynptr);
+
+	return 0;
+}
+
+/* A direct read should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_read1(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	__u32 x =3D 2;
+
+	bpf_dynptr_alloc(sizeof(x), 0, &ptr);
+
+	/* this should fail */
+	val =3D *(int *)&ptr;
+
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* A direct read at an offset should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_read2(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+	char read_data[64] =3D {};
+	__u64 x =3D 0;
+
+	bpf_dynptr_alloc(sizeof(x), 0, &ptr);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 1, 0);
+
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* A direct read at an offset into the lower stack slot should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_read3(void *ctx)
+{
+	struct bpf_dynptr ptr1 =3D {};
+	struct bpf_dynptr ptr2 =3D {};
+
+	bpf_dynptr_alloc(sizeof(val), 0, &ptr1);
+	bpf_dynptr_alloc(sizeof(val), 0, &ptr2);
+
+	/* this should fail */
+	memcpy(&val, (void *)&ptr1 + 8, sizeof(val));
+
+	bpf_dynptr_put(&ptr1);
+	bpf_dynptr_put(&ptr2);
+
+	return 0;
+}
+
+/* Calling bpf_dynptr_alloc on an offset should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_offset(void *ctx)
+{
+	struct bpf_dynptr ptr =3D {};
+
+	/* this should fail */
+	bpf_dynptr_alloc(sizeof(val), 0, &ptr + 1);
+
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+/* Can't call bpf_dynptr_put twice */
+SEC("?raw_tp/sys_nanosleep")
+int put_twice(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	bpf_dynptr_put(&ptr);
+
+	/* this second put should fail */
+	bpf_dynptr_put(&ptr);
+
+	return 0;
+}
+
+static int put_twice_callback_fn(__u32 index, void *data)
+{
+	/* this should fail */
+	bpf_dynptr_put(data);
+	val =3D index;
+	return 0;
+}
+
+/* Test that calling bpf_dynptr_put twice, where the 2nd put happens wit=
hin a
+ * calback function, fails
+ */
+SEC("?raw_tp/sys_nanosleep")
+int put_twice_callback(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	bpf_dynptr_put(&ptr);
+
+	bpf_loop(10, put_twice_callback_fn, &ptr, 0);
+
+	return 0;
+}
+
+static int missing_put_callback_fn(__u32 index, void *data)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_alloc(8, 0, &ptr);
+
+	val =3D index;
+
+	/* missing bpf_dynptr_put(&ptr) */
+
+	return 0;
+}
+
+/* Any dynptr initialized within a callback must have bpf_dynptr_put cal=
led */
+SEC("?raw_tp/sys_nanosleep")
+int missing_put_callback(void *ctx)
+{
+	bpf_loop(10, missing_put_callback_fn, NULL, 0);
+	return 0;
+}
+
+/* Can't access memory in a zero-slice */
+SEC("?raw_tp/sys_nanosleep")
+int zero_slice_access(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	bpf_dynptr_alloc(0, 0, &ptr);
+
+	data =3D bpf_dynptr_data(&ptr, 0, 0);
+	if (!data)
+		goto done;
+
+	/* this should fail */
+	*(__u8 *)data =3D 23;
+
+	val =3D *(__u8 *)data;
+
+done:
+	bpf_dynptr_put(&ptr);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
new file mode 100644
index 000000000000..eff6272623c2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <string.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "errno.h"
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
+int test_basic(void *ctx)
+{
+	char write_data[64] =3D "hello there, world!!";
+	char read_data[64] =3D {}, buf[64] =3D {};
+	struct bpf_dynptr ptr =3D {};
+	int i;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	err =3D bpf_dynptr_alloc(sizeof(write_data), 0, &ptr);
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
+	bpf_dynptr_put(&ptr);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_data_slice(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u32 alloc_size =3D 16;
+	void *data;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	/* test passing in an invalid flag */
+	err =3D bpf_dynptr_alloc(alloc_size, 1, &ptr);
+	if (err !=3D -EINVAL) {
+		err =3D 1;
+		goto done;
+	}
+	bpf_dynptr_put(&ptr);
+
+	err =3D bpf_dynptr_alloc(alloc_size, 0, &ptr);
+	if (err)
+		goto done;
+
+	/* Try getting a data slice that is out of range */
+	data =3D bpf_dynptr_data(&ptr, alloc_size + 1, 1);
+	if (data) {
+		err =3D 2;
+		goto done;
+	}
+
+	/* Try getting more bytes than available */
+	data =3D bpf_dynptr_data(&ptr, 0, alloc_size + 1);
+	if (data) {
+		err =3D 3;
+		goto done;
+	}
+
+	data =3D bpf_dynptr_data(&ptr, 0, sizeof(int));
+	if (!data) {
+		err =3D 4;
+		goto done;
+	}
+
+	*(__u32 *)data =3D 999;
+
+	err =3D bpf_probe_read_kernel(&val, sizeof(val), data);
+	if (err)
+		goto done;
+
+	if (val !=3D *(int *)data)
+		err =3D 5;
+
+done:
+	bpf_dynptr_put(&ptr);
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
+	if (!sample) {
+		err =3D 2;
+		return 0;
+	}
+
+	sample->pid +=3D val;
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_ringbuf(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct sample *sample;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	val =3D 100;
+
+	/* check that you can reserve a dynamic size reservation */
+	err =3D bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	if (err)
+		goto done;
+
+	sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
+	if (!sample) {
+		err =3D 1;
+		goto done;
+	}
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
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_alloc_zero_bytes(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+	__u8 x =3D 0;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	err =3D bpf_dynptr_alloc(0, 0, &ptr);
+	if (err)
+		goto done;
+
+	err =3D bpf_dynptr_write(&ptr, 0, &x, sizeof(x));
+	if (err !=3D -EINVAL) {
+		err =3D 1;
+		goto done;
+	}
+
+	err =3D bpf_dynptr_read(&x, sizeof(x), &ptr, 0);
+	if (err !=3D -EINVAL) {
+		err =3D 2;
+		goto done;
+	}
+	err =3D 0;
+
+	/* try to access memory we don't have access to */
+	data =3D bpf_dynptr_data(&ptr, 0, 1);
+	if (data) {
+		err =3D 3;
+		goto done;
+	}
+
+	data =3D bpf_dynptr_data(&ptr, 0, 0);
+	if (!data) {
+		err =3D 4;
+		goto done;
+	}
+
+done:
+	bpf_dynptr_put(&ptr);
+	return 0;
+}
--=20
2.30.2

