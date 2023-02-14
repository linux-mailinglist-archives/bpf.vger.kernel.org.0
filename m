Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA9C69583F
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 06:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBNFOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 00:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBNFOQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 00:14:16 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E531BF2
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 21:14:16 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id A884465F5521; Mon, 13 Feb 2023 21:14:04 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Clean up dynptr prog_tests
Date:   Mon, 13 Feb 2023 21:13:32 -0800
Message-Id: <20230214051332.4007131-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214051332.4007131-1-joannelkoong@gmail.com>
References: <20230214051332.4007131-1-joannelkoong@gmail.com>
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

Clean up prog_tests/dynptr.c by removing the unneeded "expected_err_msg"
in the dynptr_tests struct, which is a remnant from converting the fail
tests cases to use the generic verification tester.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c  | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
index 7faaf6d9e0d4..b99264ec0d9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -5,14 +5,10 @@
 #include "dynptr_fail.skel.h"
 #include "dynptr_success.skel.h"
=20
-static struct {
-	const char *prog_name;
-	const char *expected_err_msg;
-} dynptr_tests[] =3D {
-	/* success cases */
-	{"test_read_write", NULL},
-	{"test_data_slice", NULL},
-	{"test_ringbuf", NULL},
+static const char * const success_tests[] =3D {
+	"test_read_write",
+	"test_data_slice",
+	"test_ringbuf",
 };
=20
 static void verify_success(const char *prog_name)
@@ -53,11 +49,11 @@ void test_dynptr(void)
 {
 	int i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(dynptr_tests); i++) {
-		if (!test__start_subtest(dynptr_tests[i].prog_name))
+	for (i =3D 0; i < ARRAY_SIZE(success_tests); i++) {
+		if (!test__start_subtest(success_tests[i]))
 			continue;
=20
-		verify_success(dynptr_tests[i].prog_name);
+		verify_success(success_tests[i]);
 	}
=20
 	RUN_TESTS(dynptr_fail);
--=20
2.30.2

