Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6867F2CC6F1
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgLBTrx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 14:47:53 -0500
Received: from mx.der-flo.net ([193.160.39.236]:38384 "EHLO mx.der-flo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgLBTrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 14:47:53 -0500
Received: by mx.der-flo.net (Postfix, from userid 110)
        id EC8AA44560; Wed,  2 Dec 2020 20:46:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.der-flo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2a02:1203:ecb0:3930:1751:4157:4d75:a5e2])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 66C5E44553;
        Wed,  2 Dec 2020 20:46:52 +0100 (CET)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com,
        Florian Lehner <dev@der-flo.net>,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [PATCH 2/2] selftests/bpf: Avoid errno clobbering
Date:   Wed,  2 Dec 2020 20:45:32 +0100
Message-Id: <20201202194532.12879-3-dev@der-flo.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201202194532.12879-1-dev@der-flo.net>
References: <20201202194532.12879-1-dev@der-flo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Print a message when the returned error is about a program type being
not supported or because of permission problems.
These messages are expected if the program to test was actually
executed.

Cc: Krzesimir Nowak <krzesimir@kinvolk.io>
Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 tools/testing/selftests/bpf/test_verifier.c | 26 +++++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index ceea9409639e..86ef28dd9919 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -875,19 +875,35 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 	__u8 tmp[TEST_DATA_LEN << 2];
 	__u32 size_tmp = sizeof(tmp);
 	uint32_t retval;
-	int err;
+	int err, saved_errno;

 	if (unpriv)
 		set_admin(true);
 	err = bpf_prog_test_run(fd_prog, 1, data, size_data,
 				tmp, &size_tmp, &retval, NULL);
+	saved_errno = errno;
+
 	if (unpriv)
 		set_admin(false);
-	if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
-		printf("Unexpected bpf_prog_test_run error ");
-		return err;
+
+	if (err) {
+		switch (saved_errno) {
+		case 524/*ENOTSUPP*/:
+			printf("Did not run the program (not supported) ");
+			return 0;
+		case EPERM:
+			if (unpriv) {
+				printf("Did not run the program (no permission) ");
+				return 0;
+			}
+		default:
+			printf("FAIL: Unexpected bpf_prog_test_run error (%s) ",
+				strerror(saved_errno));
+			return err;
+		}
 	}
-	if (!err && retval != expected_val &&
+
+	if (retval != expected_val &&
 	    expected_val != POINTER_VALUE) {
 		printf("FAIL retval %d != %d ", retval, expected_val);
 		return 1;
--
2.28.0

