Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B51D57C271
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 04:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGUCtc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 22:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGUCtb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 22:49:31 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC54F1A6
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 19:49:30 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id F1697F3E6F95; Wed, 20 Jul 2022 19:49:17 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: add extra test for using dynptr data slice after release
Date:   Wed, 20 Jul 2022 19:48:21 -0700
Message-Id: <20220721024821.251231-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721024821.251231-1-joannelkoong@gmail.com>
References: <20220721024821.251231-1-joannelkoong@gmail.com>
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

Add an additional test, "data_slice_use_after_release2", for ensuring
that data slices are correctly invalidated by the verifier after the
dynptr whose ref obj id they track is released. In particular, this
tests data slice invalidation for dynptrs located at a non-zero offset
from the frame pointer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  3 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c | 32 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
index 3c7aa82b98e2..bcf80b9f7c27 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -22,7 +22,8 @@ static struct {
 	{"add_dynptr_to_map2", "invalid indirect read from stack"},
 	{"data_slice_out_of_bounds_ringbuf", "value is outside of the allowed m=
emory range"},
 	{"data_slice_out_of_bounds_map_value", "value is outside of the allowed=
 memory range"},
-	{"data_slice_use_after_release", "invalid mem access 'scalar'"},
+	{"data_slice_use_after_release1", "invalid mem access 'scalar'"},
+	{"data_slice_use_after_release2", "invalid mem access 'scalar'"},
 	{"data_slice_missing_null_check1", "invalid mem access 'mem_or_null'"},
 	{"data_slice_missing_null_check2", "invalid mem access 'mem_or_null'"},
 	{"invalid_helper1", "invalid indirect read from stack"},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
index d811cff73597..d8c4ed3ee146 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -248,7 +248,7 @@ int data_slice_out_of_bounds_map_value(void *ctx)
=20
 /* A data slice can't be used after it has been released */
 SEC("?raw_tp/sys_nanosleep")
-int data_slice_use_after_release(void *ctx)
+int data_slice_use_after_release1(void *ctx)
 {
 	struct bpf_dynptr ptr;
 	struct sample *sample;
@@ -272,6 +272,36 @@ int data_slice_use_after_release(void *ctx)
 	return 0;
 }
=20
+SEC("?raw_tp/sys_nanosleep")
+int data_slice_use_after_release2(void *ctx)
+{
+	struct bpf_dynptr ptr1, ptr2;
+	struct sample *sample;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
+
+	sample =3D bpf_dynptr_data(&ptr2, 0, sizeof(*sample));
+	if (!sample)
+		goto done;
+
+	sample->pid =3D 23;
+
+	bpf_ringbuf_submit_dynptr(&ptr2, 0);
+
+	/* this should fail */
+	sample->pid =3D 23;
+
+	bpf_ringbuf_submit_dynptr(&ptr1, 0);
+
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr2, 0);
+	bpf_ringbuf_discard_dynptr(&ptr1, 0);
+	return 0;
+}
+
 /* A data slice must be first checked for NULL */
 SEC("?raw_tp/sys_nanosleep")
 int data_slice_missing_null_check1(void *ctx)
--=20
2.30.2

