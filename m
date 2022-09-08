Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAB5B10C6
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIHAHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIHAHp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:07:45 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEF1B9414
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:07:41 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 040C411703B5B; Wed,  7 Sep 2022 17:07:38 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 8/8] selftests/bpf: Tests for dynptr convenience helpers
Date:   Wed,  7 Sep 2022 17:02:54 -0700
Message-Id: <20220908000254.3079129-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908000254.3079129-1-joannelkoong@gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
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

Test dynptr convenience helpers in the following way:

1) bpf_dynptr_data_rdonly
    * "data_slice_rdonly" tests that writes into read-only slices
      are rejected.
    * "skb_invalid_data_slice_rdonly{1,2}" tests that read-only
      slices for skb-type dynptrs get invalidated whenever packet data
      may change.

2) bpf_dynptr_trim and bpf_dynptr_advance
    * "test_advance_trim" tests that dynptr offset and size get adjusted
      correctly.
    * "test_advance_trim_err" tests that advances beyond dynptr size and
      trims larger than dynptr size are rejected.
    * "test_zero_size_dynptr" tests that a zero-size dynptr (after
      advancing or trimming) can only read and write 0 bytes.

3) bpf_dynptr_is_null
    * "dynptr_is_null_invalid" tests that only initialized dynptrs can
      be passed in.
    * "test_dynptr_is_null" tests that null dynptrs return true and
      non-null dynptrs return false.

4) bpf_dynptr_is_rdonly
    * "dynptr_is_rdonly_invalid" tests that only initialized dynptrs can
      be passed in.
    * "test_dynptr_is_rdonly" tests that rdonly dynptrs return true and
      non-rdonly or invalid dynptrs return false.

5) bpf_dynptr_get_size
    * "dynptr_get_size_invalid" tests that only initialized dynptrs can
      be passed in.
    * Additional functionality is tested as a by-product in
      "test_advance_trim"

6) bpf_dynptr_get_offset
    * "dynptr_get_offset_invalid" tests that only initialized dynptrs can
      be passed in.
    * Additional functionality is tested as a by-product in
      "test_advance_trim"

7) bpf_dynptr_clone
    * "clone_invalidate_{1..6}" tests that invalidating a dynptr
      invalidates all instances and invalidating a dynptr's data slices
      invalidates all data slices for all instances.
    * "clone_skb_packet_data" tests that data slices of skb dynptr instan=
ces
      are invalidated when packet data changes.
    * "clone_xdp_packet_data" tests that data slices of xdp dynptr instan=
ces
      are invalidated when packet data changes.
    * "clone_invalid1" tests that only initialized dynptrs can be
      cloned.
    * "clone_invalid2" tests that only uninitialized dynptrs can be
      a clone.
    * "test_dynptr_clone" tests that the views from the same dynptr insta=
nces
      are independent (advancing or trimming a dynptr doesn't affect othe=
r
      instances), and that a clone will return a dynptr with the same
      type, offset, size, and rd-only property.

8) bpf_dynptr_iterator
    * "iterator_invalid1" tests that any dynptr requiring a release
      that gets acquired in an iterator callback must also be released
      within the callback
    * "iterator_invalid2" tests that bpf_dynptr_iterator can't be called
      on an uninitialized dynptr
    * "iterator_invalid3" tests that an already-initialized dynptr can't
      be initialized again in the iterator callback function
    * "iterator_invalid4" tests that the dynptr that's iterating
      can't be released in the callback function
    * "iterator_invalid5" tests that the dynptr can't be passed as a
      callback ctx and released within the callback
    * "test_dynptr_iterator" tests basic functionality of the iterator
    * "iterator_parse_strings" tests parsing strings as values

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  30 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 462 +++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 551 +++++++++++++++++-
 3 files changed, 1041 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
index f3bdec4a595c..de084ba980a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -53,15 +53,45 @@ static struct {
 		"Unsupported reg type fp for bpf_dynptr_from_mem data"},
 	{"skb_invalid_data_slice1", "invalid mem access 'scalar'"},
 	{"skb_invalid_data_slice2", "invalid mem access 'scalar'"},
+	{"skb_invalid_data_slice_rdonly1", "invalid mem access 'scalar'"},
+	{"skb_invalid_data_slice_rdonly2", "invalid mem access 'scalar'"},
 	{"xdp_invalid_data_slice", "invalid mem access 'scalar'"},
 	{"skb_invalid_ctx", "unknown func bpf_dynptr_from_skb"},
 	{"xdp_invalid_ctx", "unknown func bpf_dynptr_from_xdp"},
+	{"data_slice_rdonly", "cannot write into rdonly_mem"},
+	{"dynptr_is_null_invalid", "Expected an initialized dynptr as arg #1"},
+	{"dynptr_is_rdonly_invalid", "Expected an initialized dynptr as arg #1"=
},
+	{"dynptr_get_size_invalid", "Expected an initialized dynptr as arg #1"}=
,
+	{"dynptr_get_offset_invalid", "Expected an initialized dynptr as arg #1=
"},
+	{"clone_invalid1", "Expected an initialized dynptr as arg #1"},
+	{"clone_invalid2", "Dynptr has to be an uninitialized dynptr"},
+	{"clone_invalidate1", "Expected an initialized dynptr"},
+	{"clone_invalidate2", "Expected an initialized dynptr"},
+	{"clone_invalidate3", "Expected an initialized dynptr"},
+	{"clone_invalidate4", "invalid mem access 'scalar'"},
+	{"clone_invalidate5", "invalid mem access 'scalar'"},
+	{"clone_invalidate6", "invalid mem access 'scalar'"},
+	{"clone_skb_packet_data", "invalid mem access 'scalar'"},
+	{"clone_xdp_packet_data", "invalid mem access 'scalar'"},
+	{"iterator_invalid1", "Unreleased reference id=3D1"},
+	{"iterator_invalid2", "Expected an initialized dynptr as arg #1"},
+	{"iterator_invalid3", "Dynptr has to be an uninitialized dynptr"},
+	{"iterator_invalid4", "Unreleased reference"},
+	{"iterator_invalid5", "Unreleased reference"},
=20
 	/* these tests should be run and should succeed */
 	{"test_read_write", NULL, SETUP_SYSCALL_SLEEP},
 	{"test_data_slice", NULL, SETUP_SYSCALL_SLEEP},
 	{"test_ringbuf", NULL, SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", NULL, SETUP_SKB_PROG},
+	{"test_advance_trim", NULL, SETUP_SYSCALL_SLEEP},
+	{"test_advance_trim_err", NULL, SETUP_SYSCALL_SLEEP},
+	{"test_zero_size_dynptr", NULL, SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_is_null", NULL, SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_is_rdonly", NULL, SETUP_SKB_PROG},
+	{"test_dynptr_clone", NULL, SETUP_SKB_PROG},
+	{"test_dynptr_iterator", NULL, SETUP_SKB_PROG},
+	{"iterator_parse_strings", NULL, SETUP_SYSCALL_SLEEP},
 };
=20
 static void verify_fail(const char *prog_name, const char *expected_err_=
msg)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
index 2da6703d0caf..5a63389613c7 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -668,6 +668,51 @@ int skb_invalid_data_slice2(struct __sk_buff *skb)
 	return SK_PASS;
 }
=20
+/* The read-only data slice is invalidated whenever a helper changes pac=
ket data */
+SEC("?tc")
+int skb_invalid_data_slice_rdonly1(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	hdr =3D bpf_dynptr_data_rdonly(&ptr, 0, sizeof(*hdr));
+
+	if (!hdr)
+		return SK_DROP;
+
+	val =3D hdr->h_proto;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	val =3D hdr->h_proto;
+
+	return SK_PASS;
+}
+
+/* The read-only data slice is invalidated whenever bpf_dynptr_write() i=
s called */
+SEC("?tc")
+int skb_invalid_data_slice_rdonly2(struct __sk_buff *skb)
+{
+	char write_data[64] =3D "hello there, world!!";
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	hdr =3D bpf_dynptr_data_rdonly(&ptr, 0, sizeof(*hdr));
+	if (!hdr)
+		return SK_DROP;
+
+	bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
+
+	/* this should fail */
+	val =3D hdr->h_proto;
+
+	return SK_PASS;
+}
+
 /* The data slice is invalidated whenever a helper changes packet data *=
/
 SEC("?xdp")
 int xdp_invalid_data_slice(struct xdp_md *xdp)
@@ -714,3 +759,420 @@ int xdp_invalid_ctx(void *ctx)
=20
 	return 0;
 }
+
+/* Writing into a read-only data slice is not permitted */
+SEC("?raw_tp")
+int data_slice_rdonly(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+
+	data =3D bpf_dynptr_data_rdonly(&ptr, 0, 64);
+	if (data)
+		/* this should fail */
+		*data =3D 123;
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/* dynptr_is_null can only be called on initialized dynptrs */
+SEC("?raw_tp")
+int dynptr_is_null_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_is_null(&ptr);
+
+	return 0;
+}
+
+/* dynptr_is_rdonly can only be called on initialized dynptrs */
+SEC("?raw_tp")
+int dynptr_is_rdonly_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_is_rdonly(&ptr);
+
+	return 0;
+}
+
+/* dynptr_get_size can only be called on initialized dynptrs */
+SEC("?raw_tp")
+int dynptr_get_size_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_get_size(&ptr);
+
+	return 0;
+}
+
+/* dynptr_get_offset can only be called on initialized dynptrs */
+SEC("?raw_tp")
+int dynptr_get_offset_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_get_offset(&ptr);
+
+	return 0;
+}
+
+/* Only initialized dynptrs can be cloned */
+SEC("?raw_tp")
+int clone_invalid1(void *ctx)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+
+	/* this should fail */
+	bpf_dynptr_clone(&ptr1, &ptr2);
+
+	return 0;
+}
+
+/* Only uninitialized dynptrs can be clones */
+SEC("?xdp")
+int clone_invalid2(struct xdp_md *xdp)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr clone;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr1);
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &clone);
+
+	/* this should fail */
+	bpf_dynptr_clone(&ptr1, &clone);
+
+	bpf_ringbuf_submit_dynptr(&clone, 0);
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate its clones */
+SEC("?raw_tp")
+int clone_invalidate1(void *ctx)
+{
+	struct bpf_dynptr clone;
+	struct bpf_dynptr ptr;
+	char read_data[64];
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &clone, 0, 0);
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate its parent */
+SEC("?raw_tp")
+int clone_invalidate2(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone;
+	char read_data[64];
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	bpf_ringbuf_submit_dynptr(&clone, 0);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0, 0);
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate its siblings */
+SEC("?raw_tp")
+int clone_invalidate3(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone1;
+	struct bpf_dynptr clone2;
+	char read_data[64];
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone1);
+
+	bpf_dynptr_clone(&ptr, &clone2);
+
+	bpf_ringbuf_submit_dynptr(&clone2, 0);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &clone1, 0, 0);
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate any data slices
+ * of its clones
+ */
+SEC("?raw_tp")
+int clone_invalidate4(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone;
+	int *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+	data =3D bpf_dynptr_data(&clone, 0, sizeof(val));
+	if (!data)
+		return 0;
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	/* this should fail */
+	*data =3D 123;
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate any data slices
+ * of its parent
+ */
+SEC("?raw_tp")
+int clone_invalidate5(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone;
+	int *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	data =3D bpf_dynptr_data(&ptr, 0, sizeof(val));
+	if (!data)
+		return 0;
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	bpf_ringbuf_submit_dynptr(&clone, 0);
+
+	/* this should fail */
+	*data =3D 123;
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate any data slices
+ * of its sibling
+ */
+SEC("?raw_tp")
+int clone_invalidate6(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone1;
+	struct bpf_dynptr clone2;
+	int *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone1);
+
+	bpf_dynptr_clone(&ptr, &clone2);
+
+	data =3D bpf_dynptr_data(&clone1, 0, sizeof(val));
+	if (!data)
+		return 0;
+
+	bpf_ringbuf_submit_dynptr(&clone2, 0);
+
+	/* this should fail */
+	*data =3D 123;
+
+	return 0;
+}
+
+/* A skb clone's data slices should be invalid anytime packet data chang=
es */
+SEC("?tc")
+int clone_skb_packet_data(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone;
+	__u32 *data;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+	data =3D bpf_dynptr_data(&clone, 0, sizeof(*data));
+	if (!data)
+		return XDP_DROP;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	*data =3D 123;
+
+	return 0;
+}
+
+/* A xdp clone's data slices should be invalid anytime packet data chang=
es */
+SEC("?xdp")
+int clone_xdp_packet_data(struct xdp_md *xdp)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone;
+	struct ethhdr *hdr;
+	__u32 *data;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+	data =3D bpf_dynptr_data(&clone, 0, sizeof(*data));
+	if (!data)
+		return XDP_DROP;
+
+	if (bpf_xdp_adjust_head(xdp, 0 - (int)sizeof(*hdr)))
+		return XDP_DROP;
+
+	/* this should fail */
+	*data =3D 123;
+
+	return 0;
+}
+
+static int iterator_callback1(struct bpf_dynptr *ptr, void *ctx)
+{
+	struct bpf_dynptr local_ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &local_ptr);
+
+	/* missing a call to bpf_ringbuf_discard/submit_dynptr */
+
+	return 0;
+}
+
+/* If a dynptr requiring a release is initialized within the iterator ca=
llback
+ * function, then it must also be released within that function
+ */
+SEC("?xdp")
+int iterator_invalid1(struct xdp_md *xdp)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+
+	bpf_dynptr_iterator(&ptr, iterator_callback1, NULL, 0);
+
+	return 0;
+}
+
+/* bpf_dynptr_iterator can't be called on an uninitialized dynptr */
+SEC("?xdp")
+int iterator_invalid2(struct xdp_md *xdp)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_iterator(&ptr, iterator_callback1, NULL, 0);
+
+	return 0;
+}
+
+static int iterator_callback2(struct bpf_dynptr *ptr, void *ctx)
+{
+	/* this should fail */
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, ptr);
+
+	bpf_ringbuf_submit_dynptr(ptr, 0);
+
+	return 0;
+}
+
+/* An already-initialized dynptr can't be initialized again
+ * within an iterator callback function
+ */
+SEC("?raw_tp")
+int iterator_invalid3(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_iterator(&ptr, iterator_callback2, NULL, 0);
+
+	return 0;
+}
+
+static int iterator_callback3(struct bpf_dynptr *ptr, void *ctx)
+{
+	char write_data[64] =3D "hello there, world!!";
+
+	bpf_dynptr_write(ptr, 0, write_data, sizeof(write_data), 0);
+
+	bpf_ringbuf_submit_dynptr(ptr, 0);
+
+	return 0;
+}
+
+/* The dynptr that is being iterated on can't be released in an
+ * iterator callback.
+ *
+ * Currently, the verifier doesn't strictly check for this since
+ * it only runs the callback once when verifying. For now, we
+ * use the fact that the verifier doesn't mark the reference in
+ * the parent func state as released if it's released in the
+ * callback. This is what we currently lean on in bpf_loop() as
+ * well. This is a bit of a hack for now, and will need to be
+ * addressed more thoroughly in the future.
+ */
+SEC("?raw_tp")
+int iterator_invalid4(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_iterator(&ptr, iterator_callback3, NULL, 0);
+
+	return 0;
+}
+
+static int iterator_callback4(struct bpf_dynptr *ptr, void *ctx)
+{
+	bpf_ringbuf_submit_dynptr(ctx, 0);
+
+	return 0;
+}
+
+/* If a dynptr is passed in as the callback ctx, the dynptr
+ * can't be released.
+ *
+ * Currently, the verifier doesn't strictly check for this since
+ * it only runs the callback once when verifying. For now, we
+ * use the fact that the verifier doesn't mark the reference in
+ * the parent func state as released if it's released in the
+ * callback. This is what we currently lean on in bpf_loop() as
+ * well. This is a bit of a hack for now, and will need to be
+ * addressed more thoroughly in the future.
+ */
+SEC("?raw_tp")
+int iterator_invalid5(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_iterator(&ptr, iterator_callback4, &ptr, 0);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
index 8ed3ef201284..22164ad6df9d 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Facebook */
=20
+#include <errno.h>
 #include <string.h>
 #include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "errno.h"
+#include <bpf/bpf_helpers.h>
=20
 char _license[] SEC("license") =3D "GPL";
=20
@@ -29,6 +29,13 @@ struct {
 	__type(value, __u32);
 } array_map SEC(".maps");
=20
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__uint(value_size, 64);
+} array_map2 SEC(".maps");
+
 SEC("tp/syscalls/sys_enter_nanosleep")
 int test_read_write(void *ctx)
 {
@@ -194,3 +201,543 @@ int test_skb_readonly(struct __sk_buff *skb)
=20
 	return 0;
 }
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_advance_trim(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u32 bytes =3D 64;
+	__u32 off =3D 10;
+	__u32 trim =3D 5;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	err =3D bpf_ringbuf_reserve_dynptr(&ringbuf, bytes, 0, &ptr);
+	if (err) {
+		err =3D 1;
+		goto done;
+	}
+
+	if (bpf_dynptr_get_size(&ptr) !=3D bytes) {
+		err =3D 2;
+		goto done;
+	}
+
+	/* Advance the dynptr by off */
+	err =3D bpf_dynptr_advance(&ptr, off);
+	if (err) {
+		err =3D 3;
+		goto done;
+	}
+
+	/* Check that the dynptr off and size were adjusted correctly */
+	if (bpf_dynptr_get_offset(&ptr) !=3D off) {
+		err =3D 4;
+		goto done;
+	}
+	if (bpf_dynptr_get_size(&ptr) !=3D bytes - off) {
+		err =3D 5;
+		goto done;
+	}
+
+	/* Trim the dynptr */
+	err =3D bpf_dynptr_trim(&ptr, trim);
+	if (err) {
+		err =3D 6;
+		goto done;
+	}
+
+	/* Check that the off was unaffected */
+	if (bpf_dynptr_get_offset(&ptr) !=3D off) {
+		err =3D 7;
+		goto done;
+	}
+	/* Check that the size was adjusted correctly */
+	if (bpf_dynptr_get_size(&ptr) !=3D bytes - off - trim) {
+		err =3D 8;
+		goto done;
+	}
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_advance_trim_err(void *ctx)
+{
+	char write_data[45] =3D "hello there, world!!";
+	struct bpf_dynptr ptr;
+	__u32 trim_size =3D 10;
+	__u32 size =3D 64;
+	__u32 off =3D 10;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &ptr)) {
+		err =3D 1;
+		goto done;
+	}
+
+	/* Check that you can't advance beyond size of dynptr data */
+	if (bpf_dynptr_advance(&ptr, size + 1) !=3D -ERANGE) {
+		err =3D 2;
+		goto done;
+	}
+
+	if (bpf_dynptr_advance(&ptr, off)) {
+		err =3D 3;
+		goto done;
+	}
+
+	/* Check that you can't trim more than size of dynptr data */
+	if (bpf_dynptr_trim(&ptr, size - off + 1) !=3D -ERANGE) {
+		err =3D 4;
+		goto done;
+	}
+
+	/* Check that you can't write more bytes than available into the dynptr
+	 * after you've trimmed it
+	 */
+	if (bpf_dynptr_trim(&ptr, trim_size)) {
+		err =3D 5;
+		goto done;
+	}
+
+	if (bpf_dynptr_write(&ptr, 0, &write_data, sizeof(write_data), 0) !=3D =
-E2BIG) {
+		err =3D 6;
+		goto done;
+	}
+
+	/* Check that even after advancing / trimming, submitting/discarding
+	 * a ringbuf dynptr works
+	 */
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_zero_size_dynptr(void *ctx)
+{
+	char write_data =3D 'x', read_data;
+	struct bpf_dynptr ptr;
+	__u32 size =3D 64;
+	__u32 off =3D 10;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	/* check that you can reserve a dynamic size reservation */
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &ptr)) {
+		err =3D 1;
+		goto done;
+	}
+
+	/* After this, the dynptr has a size of 0 */
+	if (bpf_dynptr_advance(&ptr, size)) {
+		err =3D 2;
+		goto done;
+	}
+
+	/* Test that reading + writing non-zero bytes is not ok */
+	if (bpf_dynptr_read(&read_data, sizeof(read_data), &ptr, 0, 0) !=3D -E2=
BIG) {
+		err =3D 3;
+		goto done;
+	}
+
+	if (bpf_dynptr_write(&ptr, 0, &write_data, sizeof(write_data), 0) !=3D =
-E2BIG) {
+		err =3D 4;
+		goto done;
+	}
+
+	/* Test that reading + writing 0 bytes from a 0-size dynptr is ok */
+	if (bpf_dynptr_read(&read_data, 0, &ptr, 0, 0)) {
+		err =3D 5;
+		goto done;
+	}
+
+	if (bpf_dynptr_write(&ptr, 0, &write_data, 0, 0)) {
+		err =3D 6;
+		goto done;
+	}
+
+	err =3D 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_is_null(void *ctx)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	__u64 size =3D 4;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	/* Pass in invalid flags, get back an invalid dynptr */
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 123, &ptr1) !=3D -EINVAL=
) {
+		err =3D 1;
+		goto exit_early;
+	}
+
+	/* Test that the invalid dynptr is null */
+	if (!bpf_dynptr_is_null(&ptr1)) {
+		err =3D 2;
+		goto exit_early;
+	}
+
+	/* Get a valid dynptr */
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &ptr2)) {
+		err =3D 3;
+		goto exit;
+	}
+
+	/* Test that the valid dynptr is not null */
+	if (bpf_dynptr_is_null(&ptr2)) {
+		err =3D 4;
+		goto exit;
+	}
+
+exit:
+	bpf_ringbuf_discard_dynptr(&ptr2, 0);
+exit_early:
+	bpf_ringbuf_discard_dynptr(&ptr1, 0);
+	return 0;
+}
+
+SEC("cgroup_skb/egress")
+int test_dynptr_is_rdonly(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	struct bpf_dynptr ptr3;
+
+	/* Pass in invalid flags, get back an invalid dynptr */
+	if (bpf_dynptr_from_skb(skb, 123, &ptr1) !=3D -EINVAL) {
+		err =3D 1;
+		return 0;
+	}
+
+	/* Test that an invalid dynptr is_rdonly returns false */
+	if (bpf_dynptr_is_rdonly(&ptr1)) {
+		err =3D 2;
+		return 0;
+	}
+
+	/* Get a read-only dynptr */
+	if (bpf_dynptr_from_skb(skb, 0, &ptr2)) {
+		err =3D 3;
+		return 0;
+	}
+
+	/* Test that the dynptr is read-only */
+	if (!bpf_dynptr_is_rdonly(&ptr2)) {
+		err =3D 4;
+		return 0;
+	}
+
+	/* Get a read-writeable dynptr */
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr3)) {
+		err =3D 5;
+		goto done;
+	}
+
+	/* Test that the dynptr is read-only */
+	if (bpf_dynptr_is_rdonly(&ptr3)) {
+		err =3D 6;
+		goto done;
+	}
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr3, 0);
+	return 0;
+}
+
+SEC("cgroup_skb/egress")
+int test_dynptr_clone(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	__u32 off =3D 2, size;
+
+	/* Get a dynptr */
+	if (bpf_dynptr_from_skb(skb, 0, &ptr1)) {
+		err =3D 1;
+		return 0;
+	}
+
+	if (bpf_dynptr_advance(&ptr1, off)) {
+		err =3D 2;
+		return 0;
+	}
+
+	/* Clone the dynptr */
+	if (bpf_dynptr_clone(&ptr1, &ptr2)) {
+		err =3D 3;
+		return 0;
+	}
+
+	size =3D bpf_dynptr_get_size(&ptr1);
+
+	/* Check that the clone has the same offset, size, and rd-only */
+	if (bpf_dynptr_get_size(&ptr2) !=3D size) {
+		err =3D 4;
+		return 0;
+	}
+
+	if (bpf_dynptr_get_offset(&ptr2) !=3D off) {
+		err =3D 5;
+		return 0;
+	}
+
+	if (bpf_dynptr_is_rdonly(&ptr2) !=3D bpf_dynptr_is_rdonly(&ptr1)) {
+		err =3D 6;
+		return 0;
+	}
+
+	/* Advance and trim the original dynptr */
+	bpf_dynptr_advance(&ptr1, 50);
+	bpf_dynptr_trim(&ptr1, 50);
+
+	/* Check that only original dynptr was affected, and the clone wasn't *=
/
+	if (bpf_dynptr_get_offset(&ptr2) !=3D off) {
+		err =3D 7;
+		return 0;
+	}
+
+	if (bpf_dynptr_get_size(&ptr2) !=3D size) {
+		err =3D 8;
+		return 0;
+	}
+
+	return 0;
+}
+
+struct iter_ctx {
+	/* if set, this means try to iterate more bytes than available */
+	bool trigger_err_erange;
+	/* iteration index */
+	int index;
+	/* offset at the first iteration */
+	__u32 start_off;
+	/* if non-zero, this indicates the offset to stop at */
+	__u32 stop_off;
+	/* number of bytes to advance by each time */
+	__u32 iter_bytes;
+	/* total number of bytes iterated on */
+	__u32 total_bytes;
+};
+
+static int iter_callback(struct bpf_dynptr *ptr, struct iter_ctx *ctx)
+{
+	if (ctx->trigger_err_erange)
+		return bpf_dynptr_get_size(ptr) + 1;
+
+	if (ctx->index =3D=3D 0)
+		ctx->start_off =3D bpf_dynptr_get_offset(ptr);
+	else if (ctx->stop_off =3D=3D ctx->total_bytes)
+		return 0;
+
+	ctx->index++;
+	ctx->total_bytes +=3D ctx->iter_bytes;
+
+	if (bpf_dynptr_get_size(ptr) =3D=3D 0)
+		return 0;
+
+	return ctx->iter_bytes;
+}
+
+SEC("cgroup_skb/egress")
+int test_dynptr_iterator(struct __sk_buff *skb)
+{
+	struct iter_ctx ctx =3D { .iter_bytes =3D 1, };
+	struct bpf_dynptr ptr;
+	__u32 off =3D 1, size;
+
+	/* Get a dynptr */
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err =3D 1;
+		return 0;
+	}
+
+	if (bpf_dynptr_advance(&ptr, off)) {
+		err =3D 2;
+		return 0;
+	}
+
+	size =3D bpf_dynptr_get_size(&ptr);
+
+	/* Test the case where the callback tries to advance by more
+	 * bytes than available
+	 */
+	ctx.trigger_err_erange =3D true;
+	if (bpf_dynptr_iterator(&ptr, iter_callback, &ctx, 0) !=3D -ERANGE) {
+		err =3D 3;
+		return 0;
+	}
+	if (bpf_dynptr_get_size(&ptr) !=3D size) {
+		err =3D 4;
+		return 0;
+	}
+	if (bpf_dynptr_get_offset(&ptr) !=3D off) {
+		err =3D 5;
+		return 0;
+	}
+	ctx.trigger_err_erange =3D false;
+
+	/* Test the case where we stop after a certain number of bytes */
+	ctx.stop_off =3D 15;
+	if (bpf_dynptr_iterator(&ptr, iter_callback, &ctx, 0)) {
+		err =3D 6;
+		return 0;
+	}
+	if (bpf_dynptr_get_size(&ptr) !=3D size - ctx.stop_off) {
+		err =3D 7;
+		return 0;
+	}
+	if (bpf_dynptr_get_offset(&ptr) !=3D off + ctx.stop_off) {
+		err =3D 8;
+		return 0;
+	}
+
+	/* Test that the iteration started at the current offset of the dynptr =
*/
+	if (ctx.start_off !=3D off) {
+		err =3D 9;
+		return 0;
+	}
+
+	/* Test that we iterate to the end */
+	ctx.stop_off =3D 0;
+	if (bpf_dynptr_iterator(&ptr, iter_callback, &ctx, 0)) {
+		err =3D 10;
+		return 0;
+	}
+	if (bpf_dynptr_get_size(&ptr) !=3D 0) {
+		err =3D 11;
+		return 0;
+	}
+	if (bpf_dynptr_get_offset(&ptr) !=3D off + size) {
+		err =3D 12;
+		return 0;
+	}
+
+	return 0;
+}
+
+static char values[3][64] =3D {};
+
+#define MAX_STRINGS_LEN 10
+static int parse_strings_callback(struct bpf_dynptr *ptr, int *nr_values=
)
+{
+	__u32 size =3D bpf_dynptr_get_size(ptr);
+	char buf[MAX_STRINGS_LEN] =3D {};
+	char *data;
+	int i, j, k;
+	int err;
+
+	if (size < MAX_STRINGS_LEN) {
+		err =3D bpf_dynptr_read(buf, size, ptr, 0, 0);
+		if (err)
+			return err;
+		data =3D buf;
+	} else {
+		data =3D bpf_dynptr_data(ptr, 0, MAX_STRINGS_LEN);
+		if (!data)
+			return -ENOENT;
+		size =3D MAX_STRINGS_LEN;
+	}
+
+	for (i =3D 0; i < size; i++) {
+		if (data[i] !=3D '=3D')
+			continue;
+
+		for (j =3D i; j < size - i; j++) {
+			int index =3D 0;
+
+			if (data[j] !=3D '/')
+				continue;
+
+			for (k =3D i + 1; k < j; k++) {
+				values[*nr_values][index] =3D data[k];
+				index +=3D 1;
+			}
+
+			*nr_values +=3D 1;
+			return j;
+		}
+
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int iterator_parse_strings(void *ctx)
+{
+	char val[64] =3D "x=3Dfoo/y=3Dbar/z=3Dbaz/";
+	struct bpf_dynptr ptr;
+	__u32 map_val_size;
+	int nr_values =3D 0;
+	__u32 key =3D 0;
+	char *map_val;
+
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	map_val_size =3D sizeof(val);
+
+	if (bpf_map_update_elem(&array_map2, &key, &val, 0)) {
+		err =3D 1;
+		return 0;
+	}
+
+	map_val =3D bpf_map_lookup_elem(&array_map2, &key);
+	if (!map_val) {
+		err =3D 2;
+		return 0;
+	}
+
+	if (bpf_dynptr_from_mem(map_val, map_val_size, 0, &ptr)) {
+		err =3D 3;
+		return 0;
+	}
+
+	if (bpf_dynptr_iterator(&ptr, parse_strings_callback,
+				&nr_values, 0)) {
+		err =3D 4;
+		return 0;
+	}
+
+	if (nr_values !=3D 3) {
+		err =3D 8;
+		return 0;
+	}
+
+	if (memcmp(values[0], "foo", sizeof("foo"))) {
+		err =3D 5;
+		return 0;
+	}
+
+	if (memcmp(values[1], "bar", sizeof("bar"))) {
+		err =3D 6;
+		return 0;
+	}
+
+	if (memcmp(values[2], "baz", sizeof("baz"))) {
+		err =3D 7;
+		return 0;
+	}
+
+	return 0;
+}
--=20
2.30.2

