Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB455258A6
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357401AbiELXol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 19:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358848AbiELXoX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 19:44:23 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100528BDC8
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 16:44:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 62E6724002A
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 01:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652399047; bh=dQfRFDEMwjSYxNf12nsB1JYZRpDQ3nsVSpnEM0nGvt0=;
        h=From:To:Subject:Date:From;
        b=AxAKk7pTHk1f8HyJBGeSWLEo7y0srnofociNbmaAAv+mgTDyLVKyatkx9R7aP+I4i
         V1h8DmfufWvhF3cQ6j11fRsbgIe7Oes3FwIAGizeaSoklaI2JW6SX70InKtP5KoOpk
         EeRushZ9qNFkV8MRxyA/YIbh4/sSIFsFlH0YxfysK9avKpUpcqjcZAULTuIBcJiDng
         qE2C9yE77Mb717nsLy3Cqu63WT9n39vROvlmm+jypC1SUO+lWmEy2aICy7tk5+Q2Yx
         x9/UKJZIFtmoXN22SpEAn5JdCTo/MsJTHppbcK05fGgzxug1BFkYUCy0imSnIAIvEA
         rO5wcjH4TY9Yw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4KzpJN0NZfz6tmH;
        Fri, 13 May 2022 01:43:47 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Hardcode /sys/kernel/btf/vmlinux in fewer places
Date:   Thu, 12 May 2022 23:43:32 +0000
Message-Id: <20220512234332.2852918-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two of the BPF selftests hardcode the path to /sys/kernel/btf/vmlinux.
The kernel image could potentially exist at a different location.
libbpf_find_kernel_btf(), as introduced by commit fb2426ad00b1 ("libbpf:
Expose bpf_find_kernel_btf as a LIBBPF_API"), knows about said
locations.

This change switches these two tests over to using this function
instead, making the tests more likely to be runnable when
/sys/kernel/btf/vmlinux may not be present and setting better precedent.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/prog_tests/libbpf_probes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 9f766dd..61c81a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -11,8 +11,8 @@ void test_libbpf_probe_prog_types(void)
 	const struct btf_enum *e;
 	int i, n, id;
 
-	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
-	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+	btf = libbpf_find_kernel_btf();
+	if (!ASSERT_OK_PTR(btf, "libbpf_find_kernel_btf"))
 		return;
 
 	/* find enum bpf_prog_type and enumerate each value */
@@ -49,8 +49,8 @@ void test_libbpf_probe_map_types(void)
 	const struct btf_enum *e;
 	int i, n, id;
 
-	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
-	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+	btf = libbpf_find_kernel_btf();
+	if (!ASSERT_OK_PTR(btf, "libbpf_find_kernel_btf"))
 		return;
 
 	/* find enum bpf_map_type and enumerate each value */
-- 
2.30.2

