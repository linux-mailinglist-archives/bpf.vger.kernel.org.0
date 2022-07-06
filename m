Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC03A5695D8
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiGFX0N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiGFX0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 19:26:11 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5772C644
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 16:26:10 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id B34CCE977FC4; Wed,  6 Jul 2022 16:25:56 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1] bpf: Add flags arg to bpf_dynptr_read and bpf_dynptr_write APIs
Date:   Wed,  6 Jul 2022 16:25:47 -0700
Message-Id: <20220706232547.4016651-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
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

Commit 13bbbfbea759 ("bpf: Add bpf_dynptr_read and bpf_dynptr_write")
added the bpf_dynptr_write and bpf_dynptr_read APIs.

However, it will be useful for some dynptr types to pass in flags as
well (eg when writing to a skb, the user may like to invalidate the
hash or recompute the checksum).

This patch adds a "u64 flags" arg to the bpf_dynptr_read and
bpf_dynptr_write APIs.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 13bbbfbea759 ("bpf: Add bpf_dynptr_read and bpf_dynptr_write")
---
 include/uapi/linux/bpf.h                           | 11 +++++++----
 kernel/bpf/helpers.c                               | 12 ++++++++----
 tools/include/uapi/linux/bpf.h                     | 11 +++++++----
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 10 +++++-----
 tools/testing/selftests/bpf/progs/dynptr_success.c |  4 ++--
 5 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 379e68fb866f..3dd13fe738b9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5226,22 +5226,25 @@ union bpf_attr {
  *	Return
  *		Nothing. Always succeeds.
  *
- * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 =
offset)
+ * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 =
offset, u64 flags)
  *	Description
  *		Read *len* bytes from *src* into *dst*, starting from *offset*
  *		into *src*.
+ *		*flags* is currently unused.
  *	Return
  *		0 on success, -E2BIG if *offset* + *len* exceeds the length
- *		of *src*'s data, -EINVAL if *src* is an invalid dynptr.
+ *		of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
+ *		*flags* is not 0.
  *
- * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, =
u32 len)
+ * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, =
u32 len, u64 flags)
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
+ *		*flags* is currently unused.
  *	Return
  *		0 on success, -E2BIG if *offset* + *len* exceeds the length
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
- *		is a read-only dynptr.
+ *		is a read-only dynptr or if *flags* is not 0.
  *
  * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
  *	Description
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a1c84d256f83..1f961f9982d2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1497,11 +1497,12 @@ static const struct bpf_func_proto bpf_dynptr_fro=
m_mem_proto =3D {
 	.arg4_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
 };
=20
-BPF_CALL_4(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_ker=
n *, src, u32, offset)
+BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_ker=
n *, src,
+	   u32, offset, u64, flags)
 {
 	int err;
=20
-	if (!src->data)
+	if (!src->data || flags)
 		return -EINVAL;
=20
 	err =3D bpf_dynptr_check_off_len(src, offset, len);
@@ -1521,13 +1522,15 @@ static const struct bpf_func_proto bpf_dynptr_rea=
d_proto =3D {
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_PTR_TO_DYNPTR,
 	.arg4_type	=3D ARG_ANYTHING,
+	.arg5_type	=3D ARG_ANYTHING,
 };
=20
-BPF_CALL_4(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset,=
 void *, src, u32, len)
+BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset,=
 void *, src,
+	   u32, len, u64, flags)
 {
 	int err;
=20
-	if (!dst->data || bpf_dynptr_is_rdonly(dst))
+	if (!dst->data || flags || bpf_dynptr_is_rdonly(dst))
 		return -EINVAL;
=20
 	err =3D bpf_dynptr_check_off_len(dst, offset, len);
@@ -1547,6 +1550,7 @@ static const struct bpf_func_proto bpf_dynptr_write=
_proto =3D {
 	.arg2_type	=3D ARG_ANYTHING,
 	.arg3_type	=3D ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	=3D ARG_ANYTHING,
 };
=20
 BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, =
u32, len)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 379e68fb866f..3dd13fe738b9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5226,22 +5226,25 @@ union bpf_attr {
  *	Return
  *		Nothing. Always succeeds.
  *
- * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 =
offset)
+ * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 =
offset, u64 flags)
  *	Description
  *		Read *len* bytes from *src* into *dst*, starting from *offset*
  *		into *src*.
+ *		*flags* is currently unused.
  *	Return
  *		0 on success, -E2BIG if *offset* + *len* exceeds the length
- *		of *src*'s data, -EINVAL if *src* is an invalid dynptr.
+ *		of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
+ *		*flags* is not 0.
  *
- * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, =
u32 len)
+ * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, =
u32 len, u64 flags)
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
+ *		*flags* is currently unused.
  *	Return
  *		0 on success, -E2BIG if *offset* + *len* exceeds the length
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
- *		is a read-only dynptr.
+ *		is a read-only dynptr or if *flags* is not 0.
  *
  * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
  *	Description
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
index d811cff73597..0a26c243e6e9 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -140,12 +140,12 @@ int use_after_invalid(void *ctx)
=20
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(read_data), 0, &ptr);
=20
-	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0, 0);
=20
 	bpf_ringbuf_submit_dynptr(&ptr, 0);
=20
 	/* this should fail */
-	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0, 0);
=20
 	return 0;
 }
@@ -338,7 +338,7 @@ int invalid_helper2(void *ctx)
 	get_map_val_dynptr(&ptr);
=20
 	/* this should fail */
-	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 8, 0);
+	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 8, 0, 0);
=20
 	return 0;
 }
@@ -377,7 +377,7 @@ int invalid_write2(void *ctx)
 	memcpy((void *)&ptr + 8, &x, sizeof(x));
=20
 	/* this should fail */
-	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0, 0);
=20
 	bpf_ringbuf_submit_dynptr(&ptr, 0);
=20
@@ -473,7 +473,7 @@ int invalid_read2(void *ctx)
 	get_map_val_dynptr(&ptr);
=20
 	/* this should fail */
-	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 1, 0);
+	bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 1, 0, 0);
=20
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
index d67be48df4b2..a3a6103c8569 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -43,10 +43,10 @@ int test_read_write(void *ctx)
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
=20
 	/* Write data into the dynptr */
-	err =3D err ?: bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data)=
);
+	err =3D bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
=20
 	/* Read the data that was written into the dynptr */
-	err =3D err ?: bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0);
+	err =3D err ?: bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0, 0=
);
=20
 	/* Ensure the data we read matches the data we wrote */
 	for (i =3D 0; i < sizeof(read_data); i++) {
--=20
2.30.2

