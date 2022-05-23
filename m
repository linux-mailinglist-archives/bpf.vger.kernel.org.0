Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84D531D61
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiEWVHv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 17:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiEWVHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:07:48 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB87982E
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:07:46 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 07D88CC66258; Mon, 23 May 2022 14:07:35 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v6 6/6] selftests/bpf: Dynptr tests
Date:   Mon, 23 May 2022 14:07:12 -0700
Message-Id: <20220523210712.3641569-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220523210712.3641569-1-joannelkoong@gmail.com>
References: <20220523210712.3641569-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests for dynptrs, which include cases that the
verifier needs to reject (for example, a bpf_ringbuf_reserve_dynptr
without a corresponding bpf_ringbuf_submit/discard_dynptr) as well
as cases that should successfully pass.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 137 ++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 588 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 164 +++++
 3 files changed, 889 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
new file mode 100644
index 000000000000..3c7aa82b98e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <test_progs.h>
+#include "dynptr_fail.skel.h"
+#include "dynptr_success.skel.h"
+
+static size_t log_buf_sz =3D 1048576; /* 1 MB */
+static char obj_log_buf[1048576];
+
+static struct {
+	const char *prog_name;
+	const char *expected_err_msg;
+} dynptr_tests[] =3D {
+	/* failure cases */
+	{"ringbuf_missing_release1", "Unreleased reference id=3D1"},
+	{"ringbuf_missing_release2", "Unreleased reference id=3D2"},
+	{"ringbuf_missing_release_callback", "Unreleased reference id"},
+	{"use_after_invalid", "Expected an initialized dynptr as arg #3"},
+	{"ringbuf_invalid_api", "type=3Dmem expected=3Dalloc_mem"},
+	{"add_dynptr_to_map1", "invalid indirect read from stack"},
+	{"add_dynptr_to_map2", "invalid indirect read from stack"},
+	{"data_slice_out_of_bounds_ringbuf", "value is outside of the allowed m=
emory range"},
+	{"data_slice_out_of_bounds_map_value", "value is outside of the allowed=
 memory range"},
+	{"data_slice_use_after_release", "invalid mem access 'scalar'"},
+	{"data_slice_missing_null_check1", "invalid mem access 'mem_or_null'"},
+	{"data_slice_missing_null_check2", "invalid mem access 'mem_or_null'"},
+	{"invalid_helper1", "invalid indirect read from stack"},
+	{"invalid_helper2", "Expected an initialized dynptr as arg #3"},
+	{"invalid_write1", "Expected an initialized dynptr as arg #1"},
+	{"invalid_write2", "Expected an initialized dynptr as arg #3"},
+	{"invalid_write3", "Expected an initialized ringbuf dynptr as arg #1"},
+	{"invalid_write4", "arg 1 is an unacquired reference"},
+	{"invalid_read1", "invalid read from stack"},
+	{"invalid_read2", "cannot pass in dynptr at an offset"},
+	{"invalid_read3", "invalid read from stack"},
+	{"invalid_read4", "invalid read from stack"},
+	{"invalid_offset", "invalid write to stack"},
+	{"global", "type=3Dmap_value expected=3Dfp"},
+	{"release_twice", "arg 1 is an unacquired reference"},
+	{"release_twice_callback", "arg 1 is an unacquired reference"},
+	{"dynptr_from_mem_invalid_api",
+		"Unsupported reg type fp for bpf_dynptr_from_mem data"},
+
+	/* success cases */
+	{"test_read_write", NULL},
+	{"test_data_slice", NULL},
+	{"test_ringbuf", NULL},
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
+	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
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
+	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
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
+			verify_fail(dynptr_tests[i].prog_name,
+				    dynptr_tests[i].expected_err_msg);
+		else
+			verify_success(dynptr_tests[i].prog_name);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
new file mode 100644
index 000000000000..d811cff73597
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -0,0 +1,588 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <errno.h>
+#include <string.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+struct test_info {
+	int x;
+	struct bpf_dynptr ptr;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct bpf_dynptr);
+} array_map1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct test_info);
+} array_map2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} array_map3 SEC(".maps");
+
+struct sample {
+	int pid;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+int err, val;
+
+static int get_map_val_dynptr(struct bpf_dynptr *ptr)
+{
+	__u32 key =3D 0, *map_val;
+
+	bpf_map_update_elem(&array_map3, &key, &val, 0);
+
+	map_val =3D bpf_map_lookup_elem(&array_map3, &key);
+	if (!map_val)
+		return -ENOENT;
+
+	bpf_dynptr_from_mem(map_val, sizeof(*map_val), 0, ptr);
+
+	return 0;
+}
+
+/* Every bpf_ringbuf_reserve_dynptr call must have a corresponding
+ * bpf_ringbuf_submit/discard_dynptr call
+ */
+SEC("?raw_tp/sys_nanosleep")
+int ringbuf_missing_release1(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	/* missing a call to bpf_ringbuf_discard/submit_dynptr */
+
+	return 0;
+}
+
+SEC("?raw_tp/sys_nanosleep")
+int ringbuf_missing_release2(void *ctx)
+{
+	struct bpf_dynptr ptr1, ptr2;
+	struct sample *sample;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr1);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
+
+	sample =3D bpf_dynptr_data(&ptr1, 0, sizeof(*sample));
+	if (!sample) {
+		bpf_ringbuf_discard_dynptr(&ptr1, 0);
+		bpf_ringbuf_discard_dynptr(&ptr2, 0);
+		return 0;
+	}
+
+	bpf_ringbuf_submit_dynptr(&ptr1, 0);
+
+	/* missing a call to bpf_ringbuf_discard/submit_dynptr on ptr2 */
+
+	return 0;
+}
+
+static int missing_release_callback_fn(__u32 index, void *data)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	/* missing a call to bpf_ringbuf_discard/submit_dynptr */
+
+	return 0;
+}
+
+/* Any dynptr initialized within a callback must have bpf_dynptr_put cal=
led */
+SEC("?raw_tp/sys_nanosleep")
+int ringbuf_missing_release_callback(void *ctx)
+{
+	bpf_loop(10, missing_release_callback_fn, NULL, 0);
+	return 0;
+}
+
+/* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dyn=
ptr */
+SEC("?raw_tp/sys_nanosleep")
+int ringbuf_release_uninit_dynptr(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/* A dynptr can't be used after it has been invalidated */
+SEC("?raw_tp/sys_nanosleep")
+int use_after_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	char read_data[64];
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(read_data), 0, &ptr);
+
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
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
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
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
+/* Can't add a dynptr to a map */
+SEC("?raw_tp/sys_nanosleep")
+int add_dynptr_to_map1(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int key =3D 0;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	/* this should fail */
+	bpf_map_update_elem(&array_map1, &key, &ptr, 0);
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/* Can't add a struct with an embedded dynptr to a map */
+SEC("?raw_tp/sys_nanosleep")
+int add_dynptr_to_map2(void *ctx)
+{
+	struct test_info x;
+	int key =3D 0;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &x.ptr);
+
+	/* this should fail */
+	bpf_map_update_elem(&array_map2, &key, &x, 0);
+
+	bpf_ringbuf_submit_dynptr(&x.ptr, 0);
+
+	return 0;
+}
+
+/* A data slice can't be accessed out of bounds */
+SEC("?raw_tp/sys_nanosleep")
+int data_slice_out_of_bounds_ringbuf(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &ptr);
+
+	data  =3D bpf_dynptr_data(&ptr, 0, 8);
+	if (!data)
+		goto done;
+
+	/* can't index out of bounds of the data slice */
+	val =3D *((char *)data + 8);
+
+done:
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("?raw_tp/sys_nanosleep")
+int data_slice_out_of_bounds_map_value(void *ctx)
+{
+	__u32 key =3D 0, map_val;
+	struct bpf_dynptr ptr;
+	void *data;
+
+	get_map_val_dynptr(&ptr);
+
+	data  =3D bpf_dynptr_data(&ptr, 0, sizeof(map_val));
+	if (!data)
+		return 0;
+
+	/* can't index out of bounds of the data slice */
+	val =3D *((char *)data + (sizeof(map_val) + 1));
+
+	return 0;
+}
+
+/* A data slice can't be used after it has been released */
+SEC("?raw_tp/sys_nanosleep")
+int data_slice_use_after_release(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct sample *sample;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
+	sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
+	if (!sample)
+		goto done;
+
+	sample->pid =3D 123;
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	/* this should fail */
+	val =3D sample->pid;
+
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* A data slice must be first checked for NULL */
+SEC("?raw_tp/sys_nanosleep")
+int data_slice_missing_null_check1(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &ptr);
+
+	data  =3D bpf_dynptr_data(&ptr, 0, 8);
+
+	/* missing if (!data) check */
+
+	/* this should fail */
+	*(__u8 *)data =3D 3;
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* A data slice can't be dereferenced if it wasn't checked for null */
+SEC("?raw_tp/sys_nanosleep")
+int data_slice_missing_null_check2(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data1, *data2;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 16, 0, &ptr);
+
+	data1 =3D bpf_dynptr_data(&ptr, 0, 8);
+	data2 =3D bpf_dynptr_data(&ptr, 0, 8);
+	if (data1)
+		/* this should fail */
+		*data2 =3D 3;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
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
+	struct bpf_dynptr ptr;
+
+	get_map_val_dynptr(&ptr);
+
+	/* this should fail */
+	bpf_strncmp((const char *)&ptr, sizeof(ptr), "hello!");
+
+	return 0;
+}
+
+/* A dynptr can't be passed into a helper function at a non-zero offset =
*/
+SEC("?raw_tp/sys_nanosleep")
+int invalid_helper2(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	char read_data[64];
+
+	get_map_val_dynptr(&ptr);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 8, 0);
+
+	return 0;
+}
+
+/* A bpf_dynptr is invalidated if it's been written into */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_write1(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+	__u8 x =3D 0;
+
+	get_map_val_dynptr(&ptr);
+
+	memcpy(&ptr, &x, sizeof(x));
+
+	/* this should fail */
+	data =3D bpf_dynptr_data(&ptr, 0, 1);
+
+	return 0;
+}
+
+/*
+ * A bpf_dynptr can't be used as a dynptr if it has been written into at=
 a fixed
+ * offset
+ */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_write2(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	char read_data[64];
+	__u8 x =3D 0;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+
+	memcpy((void *)&ptr + 8, &x, sizeof(x));
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/*
+ * A bpf_dynptr can't be used as a dynptr if it has been written into at=
 a
+ * non-const offset
+ */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_write3(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	char stack_buf[16];
+	unsigned long len;
+	__u8 x =3D 0;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &ptr);
+
+	memcpy(stack_buf, &val, sizeof(val));
+	len =3D stack_buf[0] & 0xf;
+
+	memcpy((void *)&ptr + len, &x, sizeof(x));
+
+	/* this should fail */
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
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
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+
+	bpf_loop(10, invalid_write4_callback, &ptr, 0);
+
+	/* this should fail */
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
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
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 16, 0, &global_dynptr);
+
+	bpf_ringbuf_discard_dynptr(&global_dynptr, 0);
+
+	return 0;
+}
+
+/* A direct read should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_read1(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+
+	/* this should fail */
+	val =3D *(int *)&ptr;
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/* A direct read at an offset should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_read2(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	char read_data[64];
+
+	get_map_val_dynptr(&ptr);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 1, 0);
+
+	return 0;
+}
+
+/* A direct read at an offset into the lower stack slot should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_read3(void *ctx)
+{
+	struct bpf_dynptr ptr1, ptr2;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 16, 0, &ptr1);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 16, 0, &ptr2);
+
+	/* this should fail */
+	memcpy(&val, (void *)&ptr1 + 8, sizeof(val));
+
+	bpf_ringbuf_discard_dynptr(&ptr1, 0);
+	bpf_ringbuf_discard_dynptr(&ptr2, 0);
+
+	return 0;
+}
+
+static int invalid_read4_callback(__u32 index, void *data)
+{
+	/* this should fail */
+	val =3D *(__u32 *)data;
+
+	return 0;
+}
+
+/* A direct read within a callback function should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_read4(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+
+	bpf_loop(10, invalid_read4_callback, &ptr, 0);
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/* Initializing a dynptr on an offset should fail */
+SEC("?raw_tp/sys_nanosleep")
+int invalid_offset(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr + 1);
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/* Can't release a dynptr twice */
+SEC("?raw_tp/sys_nanosleep")
+int release_twice(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 16, 0, &ptr);
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+
+	/* this second release should fail */
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+static int release_twice_callback_fn(__u32 index, void *data)
+{
+	/* this should fail */
+	bpf_ringbuf_discard_dynptr(data, 0);
+
+	return 0;
+}
+
+/* Test that releasing a dynptr twice, where one of the releases happens
+ * within a calback function, fails
+ */
+SEC("?raw_tp/sys_nanosleep")
+int release_twice_callback(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 32, 0, &ptr);
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+
+	bpf_loop(10, release_twice_callback_fn, &ptr, 0);
+
+	return 0;
+}
+
+/* Reject unsupported local mem types for dynptr_from_mem API */
+SEC("?raw_tp/sys_nanosleep")
+int dynptr_from_mem_invalid_api(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int x =3D 0;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(&x, sizeof(x), 0, &ptr);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
new file mode 100644
index 000000000000..d67be48df4b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -0,0 +1,164 @@
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
+int pid, err, val;
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
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} array_map SEC(".maps");
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_read_write(void *ctx)
+{
+	char write_data[64] =3D "hello there, world!!";
+	char read_data[64] =3D {}, buf[64] =3D {};
+	struct bpf_dynptr ptr;
+	int i;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
+
+	/* Write data into the dynptr */
+	err =3D err ?: bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data)=
);
+
+	/* Read the data that was written into the dynptr */
+	err =3D err ?: bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+
+	/* Ensure the data we read matches the data we wrote */
+	for (i =3D 0; i < sizeof(read_data); i++) {
+		if (read_data[i] !=3D write_data[i]) {
+			err =3D 1;
+			break;
+		}
+	}
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_data_slice(void *ctx)
+{
+	__u32 key =3D 0, val =3D 235, *map_val;
+	struct bpf_dynptr ptr;
+	__u32 map_val_size;
+	void *data;
+
+	map_val_size =3D sizeof(*map_val);
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	bpf_map_update_elem(&array_map, &key, &val, 0);
+
+	map_val =3D bpf_map_lookup_elem(&array_map, &key);
+	if (!map_val) {
+		err =3D 1;
+		return 0;
+	}
+
+	bpf_dynptr_from_mem(map_val, map_val_size, 0, &ptr);
+
+	/* Try getting a data slice that is out of range */
+	data =3D bpf_dynptr_data(&ptr, map_val_size + 1, 1);
+	if (data) {
+		err =3D 2;
+		return 0;
+	}
+
+	/* Try getting more bytes than available */
+	data =3D bpf_dynptr_data(&ptr, 0, map_val_size + 1);
+	if (data) {
+		err =3D 3;
+		return 0;
+	}
+
+	data =3D bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!data) {
+		err =3D 4;
+		return 0;
+	}
+
+	*(__u32 *)data =3D 999;
+
+	err =3D bpf_probe_read_kernel(&val, sizeof(val), data);
+	if (err)
+		return 0;
+
+	if (val !=3D *(int *)data)
+		err =3D 5;
+
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
+		err =3D 2;
+	else
+		sample->pid +=3D index;
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
+
+	sample =3D err ? NULL : bpf_dynptr_data(&ptr, 0, sizeof(*sample));
+	if (!sample) {
+		err =3D 1;
+		goto done;
+	}
+
+	sample->pid =3D 10;
+
+	/* Can pass dynptr to callback functions */
+	bpf_loop(10, ringbuf_callback, &ptr, 0);
+
+	if (sample->pid !=3D 55)
+		err =3D 2;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
--=20
2.30.2

