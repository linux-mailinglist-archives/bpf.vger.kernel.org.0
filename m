Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD958AEB3
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 19:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiHERO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 13:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiHERO2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 13:14:28 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5918379
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 10:14:26 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 4F035FFDF4B9; Fri,  5 Aug 2022 10:14:13 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1] selftests/bpf: Clean up sys_nanosleep uses
Date:   Fri,  5 Aug 2022 10:14:05 -0700
Message-Id: <20220805171405.2272103-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch cleans up a few things:

  * dynptr_fail.c:
    There is no sys_nanosleep tracepoint. dynptr_fail only tests
    that the prog load fails, so just SEC("?raw_tp") suffices here.

  * test_bpf_cookie:
    There is no sys_nanosleep kprobe. The prog is loaded in
    userspace through bpf_program__attach_kprobe_opts passing in
    SYS_NANOSLEEP_KPROBE_NAME, so just SEC("k{ret}probe") suffices here.

  * test_helper_restricted:
    There is no sys_nanosleep kprobe. test_helper_restricted only tests
    that the prog load fails, so just SEC("?kprobe")( suffices here.

There are no functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 56 +++++++++----------
 .../selftests/bpf/progs/test_bpf_cookie.c     |  4 +-
 .../bpf/progs/test_helper_restricted.c        |  4 +-
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
index 0a26c243e6e9..b5e0a87f0a36 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -65,7 +65,7 @@ static int get_map_val_dynptr(struct bpf_dynptr *ptr)
 /* Every bpf_ringbuf_reserve_dynptr call must have a corresponding
  * bpf_ringbuf_submit/discard_dynptr call
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int ringbuf_missing_release1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -77,7 +77,7 @@ int ringbuf_missing_release1(void *ctx)
 	return 0;
 }
=20
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int ringbuf_missing_release2(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
@@ -112,7 +112,7 @@ static int missing_release_callback_fn(__u32 index, v=
oid *data)
 }
=20
 /* Any dynptr initialized within a callback must have bpf_dynptr_put cal=
led */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int ringbuf_missing_release_callback(void *ctx)
 {
 	bpf_loop(10, missing_release_callback_fn, NULL, 0);
@@ -120,7 +120,7 @@ int ringbuf_missing_release_callback(void *ctx)
 }
=20
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dyn=
ptr */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -132,7 +132,7 @@ int ringbuf_release_uninit_dynptr(void *ctx)
 }
=20
 /* A dynptr can't be used after it has been invalidated */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int use_after_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -151,7 +151,7 @@ int use_after_invalid(void *ctx)
 }
=20
 /* Can't call non-dynptr ringbuf APIs on a dynptr ringbuf sample */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int ringbuf_invalid_api(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -173,7 +173,7 @@ int ringbuf_invalid_api(void *ctx)
 }
=20
 /* Can't add a dynptr to a map */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int add_dynptr_to_map1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -190,7 +190,7 @@ int add_dynptr_to_map1(void *ctx)
 }
=20
 /* Can't add a struct with an embedded dynptr to a map */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int add_dynptr_to_map2(void *ctx)
 {
 	struct test_info x;
@@ -207,7 +207,7 @@ int add_dynptr_to_map2(void *ctx)
 }
=20
 /* A data slice can't be accessed out of bounds */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int data_slice_out_of_bounds_ringbuf(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -227,7 +227,7 @@ int data_slice_out_of_bounds_ringbuf(void *ctx)
 	return 0;
 }
=20
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int data_slice_out_of_bounds_map_value(void *ctx)
 {
 	__u32 key =3D 0, map_val;
@@ -247,7 +247,7 @@ int data_slice_out_of_bounds_map_value(void *ctx)
 }
=20
 /* A data slice can't be used after it has been released */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int data_slice_use_after_release(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -273,7 +273,7 @@ int data_slice_use_after_release(void *ctx)
 }
=20
 /* A data slice must be first checked for NULL */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int data_slice_missing_null_check1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -293,7 +293,7 @@ int data_slice_missing_null_check1(void *ctx)
 }
=20
 /* A data slice can't be dereferenced if it wasn't checked for null */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int data_slice_missing_null_check2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -315,7 +315,7 @@ int data_slice_missing_null_check2(void *ctx)
 /* Can't pass in a dynptr as an arg to a helper function that doesn't ta=
ke in a
  * dynptr argument
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_helper1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -329,7 +329,7 @@ int invalid_helper1(void *ctx)
 }
=20
 /* A dynptr can't be passed into a helper function at a non-zero offset =
*/
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_helper2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -344,7 +344,7 @@ int invalid_helper2(void *ctx)
 }
=20
 /* A bpf_dynptr is invalidated if it's been written into */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_write1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -365,7 +365,7 @@ int invalid_write1(void *ctx)
  * A bpf_dynptr can't be used as a dynptr if it has been written into at=
 a fixed
  * offset
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_write2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -388,7 +388,7 @@ int invalid_write2(void *ctx)
  * A bpf_dynptr can't be used as a dynptr if it has been written into at=
 a
  * non-const offset
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_write3(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -419,7 +419,7 @@ static int invalid_write4_callback(__u32 index, void =
*data)
 /* If the dynptr is written into in a callback function, it should
  * be invalidated as a dynptr
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_write4(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -436,7 +436,7 @@ int invalid_write4(void *ctx)
=20
 /* A globally-defined bpf_dynptr can't be used (it must reside as a stac=
k frame) */
 struct bpf_dynptr global_dynptr;
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int global(void *ctx)
 {
 	/* this should fail */
@@ -448,7 +448,7 @@ int global(void *ctx)
 }
=20
 /* A direct read should fail */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_read1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -464,7 +464,7 @@ int invalid_read1(void *ctx)
 }
=20
 /* A direct read at an offset should fail */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_read2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -479,7 +479,7 @@ int invalid_read2(void *ctx)
 }
=20
 /* A direct read at an offset into the lower stack slot should fail */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_read3(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
@@ -505,7 +505,7 @@ static int invalid_read4_callback(__u32 index, void *=
data)
 }
=20
 /* A direct read within a callback function should fail */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_read4(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -520,7 +520,7 @@ int invalid_read4(void *ctx)
 }
=20
 /* Initializing a dynptr on an offset should fail */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int invalid_offset(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -534,7 +534,7 @@ int invalid_offset(void *ctx)
 }
=20
 /* Can't release a dynptr twice */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -560,7 +560,7 @@ static int release_twice_callback_fn(__u32 index, voi=
d *data)
 /* Test that releasing a dynptr twice, where one of the releases happens
  * within a calback function, fails
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int release_twice_callback(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -575,7 +575,7 @@ int release_twice_callback(void *ctx)
 }
=20
 /* Reject unsupported local mem types for dynptr_from_mem API */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp")
 int dynptr_from_mem_invalid_api(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/=
testing/selftests/bpf/progs/test_bpf_cookie.c
index 22d0ac8709b4..5a3a80f751c4 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
@@ -28,14 +28,14 @@ static void update(void *ctx, __u64 *res)
 	*res |=3D bpf_get_attach_cookie(ctx);
 }
=20
-SEC("kprobe/sys_nanosleep")
+SEC("kprobe")
 int handle_kprobe(struct pt_regs *ctx)
 {
 	update(ctx, &kprobe_res);
 	return 0;
 }
=20
-SEC("kretprobe/sys_nanosleep")
+SEC("kretprobe")
 int handle_kretprobe(struct pt_regs *ctx)
 {
 	update(ctx, &kretprobe_res);
diff --git a/tools/testing/selftests/bpf/progs/test_helper_restricted.c b=
/tools/testing/selftests/bpf/progs/test_helper_restricted.c
index 20ef9d433b97..5715c569ec03 100644
--- a/tools/testing/selftests/bpf/progs/test_helper_restricted.c
+++ b/tools/testing/selftests/bpf/progs/test_helper_restricted.c
@@ -72,7 +72,7 @@ int tp_timer(void *ctx)
 	return 0;
 }
=20
-SEC("?kprobe/sys_nanosleep")
+SEC("?kprobe")
 int kprobe_timer(void *ctx)
 {
 	timer_work();
@@ -104,7 +104,7 @@ int tp_spin_lock(void *ctx)
 	return 0;
 }
=20
-SEC("?kprobe/sys_nanosleep")
+SEC("?kprobe")
 int kprobe_spin_lock(void *ctx)
 {
 	spin_lock_work();
--=20
2.30.2

