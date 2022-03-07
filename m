Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96C74D0015
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiCGNbv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 08:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCGNbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 08:31:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B4E7F6E9
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 05:30:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 667A3B8124E
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 13:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB81DC340E9;
        Mon,  7 Mar 2022 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646659854;
        bh=9VHhuaf85/q9hqMhhenNd31Adqm3rmCCuzKYZoPPwVU=;
        h=From:To:Cc:Subject:Date:From;
        b=KCSWYx6V3kC84Dc3XpoSxRFzD8+v9Ayjju8Qtn+tUaNqHmBDgQVI1pbTjwMfojcJv
         KOM4lfZvAXvfMnFtpnV76+GEcSU/PkLCOtiJBdJAx+d7LMxkg6wz0JUHxY1rpEL/QJ
         8m/hqR4JUhCTbXpAgcGG/8tcsy9D03/7wlX3T2V6Oe30hbGlyLadi5tmABL/WFoAq4
         UCBhpR820RssSoZosbLZpYW0qfyxM6PsZ5eJvK3rEm1frXPPwC+ysn/xcboKKeJl3G
         a6T8wBgi+Qr6GPMNg1+WB+7IaGXi6exQ9de34U+G+JLHzJ+H+O6R3iYab/EF1QOVHo
         ZAAYqfnYfGNww==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     "Geyslan G. Bem" <geyslan@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf/docs: Update vmtest docs for static linking
Date:   Mon,  7 Mar 2022 13:30:47 +0000
Message-Id: <20220307133048.1287644-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dynamic linking when compiling on the host can cause issues when the
libc version does not match the one in the VM image. Update the
docs to explain how to do this.

Before:
  ./vmtest.sh -- ./test_progs -t test_ima
  ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)

After:

  LDLIBS=-static ./vmtest.sh -- ./test_progs -t test_ima
  test_ima:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Reported-by: "Geyslan G. Bem" <geyslan@gmail.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/README.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index d099d91adc3b..f7fa74448492 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -32,6 +32,14 @@ For more information on about using the script, run:
 
   $ tools/testing/selftests/bpf/vmtest.sh -h
 
+Incase of linker errors when running selftests, try using static linking:
+
+.. code-block:: console
+
+  $ LDLIBS=-static vmtest.sh
+
+.. note:: Some distros may not support static linking.
+
 .. note:: The script uses pahole and clang based on host environment setting.
           If you want to change pahole and llvm, you can change `PATH` environment
           variable in the beginning of script.
-- 
2.35.1.616.g0bdcbb4464-goog

