Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E51601D87
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 01:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJQXZL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 19:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiJQXZK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 19:25:10 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9038A2F
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 16:25:02 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 34E8C240027
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 01:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666049101; bh=SPerXmaJUdXvp5h4hkMdfJRzPkvBpXVuW+HWJhbtFzM=;
        h=From:To:Cc:Subject:Date:From;
        b=H+7+zYQe1JOyWNwPZJxcMyNWiV8B1htL/yqzdoPMyPn+mHxGBev4cPiHd4AdbvdaA
         /kqWftMjrifFCpTWTBABDL5zdyH2fzTuts6Dl70bvjGj8gjO6Vp5Ip8Q1phYMqVkSo
         V2wp5oZpz3WPNZmZY9okHaHNU03Nb6CbVc1t7bBMs5HKH+KnRUvpBNQP3gxH3dO+9E
         nmjBUFDSpuNzYs1Pqo96jS3yWp8SIiSuDdi1/foZP3P/SiAZWGZa7yz0uq5h24QCuD
         4s0Lva7OTx2RwBdRdKSPskXJd6U8zTLdk38Cks6FaAeTJxmpYszY0JAkladk7CQknQ
         V3WSWtznVzyYQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MrtPm22B7z6tm4;
        Tue, 18 Oct 2022 01:25:00 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Cc:     deso@posteo.net
Subject: [PATCH bpf-next] bpf/docs: Update README for most recent vmtest.sh
Date:   Mon, 17 Oct 2022 23:24:58 +0000
Message-Id: <20221017232458.1272762-1-deso@posteo.net>
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

Since commit 40b09653b197 ("selftests/bpf: Adjust vmtest.sh to use local
kernel configuration") the vmtest.sh script no longer downloads a kernel
configuration but uses the local, in-repository one.
This change updates the README, which still mentions the old behavior.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/README.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index d3c6b3d..822548 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -14,10 +14,11 @@ It's now possible to run the selftests using ``tools/testing/selftests/bpf/vmtes
 The script tries to ensure that the tests are run with the same environment as they
 would be run post-submit in the CI used by the Maintainers.
 
-This script downloads a suitable Kconfig and VM userspace image from the system used by
-the CI. It builds the kernel (without overwriting your existing Kconfig), recompiles the
-bpf selftests, runs them (by default ``tools/testing/selftests/bpf/test_progs``) and
-saves the resulting output (by default in ``~/.bpf_selftests``).
+This script uses the in-tree kernel configuration and downloads a VM userspace
+image from the system used by the CI. It builds the kernel (without overwriting
+your existing Kconfig), recompiles the bpf selftests, runs them (by default
+``tools/testing/selftests/bpf/test_progs``) and saves the resulting output (by
+default in ``~/.bpf_selftests``).
 
 Script dependencies:
 - clang (preferably built from sources, https://github.com/llvm/llvm-project);
@@ -26,7 +27,7 @@ Script dependencies:
 - docutils (for ``rst2man``);
 - libcap-devel.
 
-For more information on about using the script, run:
+For more information about using the script, run:
 
 .. code-block:: console
 
-- 
2.30.2

