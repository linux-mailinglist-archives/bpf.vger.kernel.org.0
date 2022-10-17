Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFCD601D7F
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 01:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJQXT5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 19:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJQXT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 19:19:56 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCE27B29
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 16:19:53 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 30B6F240028
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 01:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666048792; bh=hbtOAc3oPSt/sDRjjbLw3oCvrYOcNKMFOlU7aZ7j3Js=;
        h=From:To:Cc:Subject:Date:From;
        b=GUcwl+M4+aZ3VwldzRXpTzskyRj4XwpnBJSm+U1d+kAt1OVFtXYiJi5d6maMhhI9K
         GyTFZdLlpI77LBC9hSWSZdI+WHQVz7oMhIL2ul1TOd5Gn3/oqIUSAM2+oqHQHzQqSq
         W2TuzERV/WyiXMwH6fHEXbQLwE1d7uqrMTPeYIF3hI3R4zPNweszOGI72bJPu+ungf
         iCckKUPWitVHM7m3aRifU2WXrIkUaICJOPxUL3EkRolq+pqlLICh2o70faIDfokYXd
         U8CDFrQZqMOPkOFNgU/kLcOEiklc6kQ1aTv/MnDL/6DOsvwKFyOtlqUAxhlId5cBTy
         k53GbEwAk/1JQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MrtHq1RYRz6tmT;
        Tue, 18 Oct 2022 01:19:51 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Cc:     deso@posteo.net
Subject: [PATCH bpf-next] bpf/docs: Summarize CI system and deny lists
Date:   Mon, 17 Oct 2022 23:19:48 +0000
Message-Id: <20221017231948.1246272-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change adds a brief summary of the BPF continuous integration (CI)
to the BPF selftest documentation. The summary focuses not so much on
actual workings of the CI, as it is maintained outside of the
repository, but aims to document the few bits of it that are sourced
from this repisitory and that developers may want to adjust as part of
patch submissions: the BPF kernel configuration and the deny list
file(s).

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/README.rst | 42 +++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index d3c6b3d..d1d7e9 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -6,13 +6,53 @@ General instructions on running selftests can be found in
 
 __ /Documentation/bpf/bpf_devel_QA.rst#q-how-to-run-bpf-selftests
 
+=============
+BPF CI System
+=============
+
+BPF employs a continuous integration (CI) system to check patch submission in an
+automated fashion. The system runs selftests for each patch in a series. Results
+are propagated to patchwork, where failures are highlighted similar to
+violations of other checks (such as additional warnings being emitted or a
+``scripts/checkpatch.pl`` reported deficiency):
+
+  https://patchwork.kernel.org/project/netdevbpf/list/?delegate=121173
+
+The CI system executes tests on multiple architectures. It uses a kernel
+configuration derived from both the generic and architecture specific config
+file fragments below ``tools/testing/selftests/bpf/`` (e.g., ``config`` and
+``config.x86_64``).
+
+Denylisting Tests
+=================
+
+It is possible for some architectures to not have support for all BPF features.
+In such a case tests in CI may fail. An example of such a shortcoming is BPF
+trampoline support on IBM's s390 architecture. For cases like this, an in-tree
+deny list file, located at ``tools/testing/selftests/bpf/DENYLIST.<arch>``, can
+be used to prevent the test from running on such an architecture.
+
+In addition to that, the generic ``tools/testing/selftests/bpf/DENYLIST`` is
+honored on every architecture running tests.
+
+These files are organized in three columns. The first column lists the test in
+question. This can be the name of a test suite or of an individual test. The
+remaining two columns provide additional meta data that helps identify and
+classify the entry: column two is a copy and paste of the error being reported
+when running the test in the setting in question. The third column, if
+available, summarizes the underlying problem. A value of ``trampoline``, for
+example, indicates that lack of trampoline support is causing the test to fail.
+This last entry helps identify tests that can be re-enabled once such support is
+added.
+
 =========================
 Running Selftests in a VM
 =========================
 
 It's now possible to run the selftests using ``tools/testing/selftests/bpf/vmtest.sh``.
 The script tries to ensure that the tests are run with the same environment as they
-would be run post-submit in the CI used by the Maintainers.
+would be run post-submit in the CI used by the Maintainers, with the exception
+that deny lists are not automatically honored.
 
 This script downloads a suitable Kconfig and VM userspace image from the system used by
 the CI. It builds the kernel (without overwriting your existing Kconfig), recompiles the
-- 
2.30.2

