Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F157F72D
	for <lists+bpf@lfdr.de>; Sun, 24 Jul 2022 23:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiGXVWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jul 2022 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGXVWs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jul 2022 17:22:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A93DE90
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 14:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40C91B80D90
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 21:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E65BC3411E;
        Sun, 24 Jul 2022 21:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658697765;
        bh=y72XdUI/sjSXjaw9WSqjzwHIIFgTvSXemkRNtZGBq5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrdVZuyBRmLQI20rTB+wT6febv1tylNulNhLzG5I3mrlw8XQd4ZQDf+kHUa/fot25
         nAyxvUXLhVMP3ZQOvOa3QstsXvK1lALKeAqhAAggyATzGR5QiwrbmLF77whq6+wdKJ
         zs+auC7AsBji417k2/eICJ9jqcy2v5hyt6PC/ryYJHs4tNzTD8fYPo8e35V8FIiS+c
         fPaZzOIQhtbQOVwY40vFo+ICA0nl8kvul3ZbpMn/UmtC/hlSrGqApy1yz74bqMiKgS
         ixBLZIkMdtCv6eY+gglk6J2uw9bx9SsEQHSlJOXfFirXZGoWa0KS2oS7jDMOs7KR9E
         PlMCWm6YnIH9g==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next 4/5] selftests/bpf: Disable kprobe attach test with offset for CONFIG_X86_KERNEL_IBT
Date:   Sun, 24 Jul 2022 23:21:45 +0200
Message-Id: <20220724212146.383680-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220724212146.383680-1-jolsa@kernel.org>
References: <20220724212146.383680-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Attach like 'kprobe/bpf_fentry_test6+0x5' will fail to attach
when CONFIG_X86_KERNEL_IBT option is enabled because of the
endbr instruction at the function entry.

We would need to do manual attach with offset calculation based
on the CONFIG_X86_KERNEL_IBT option, which does not seem worth
the effort to me.

Disabling these test when CONFIG_X86_KERNEL_IBT is enabled.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/get_func_ip_test.c         | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index 938dbd4d7c2f..cb0b78fb29df 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -2,6 +2,24 @@
 #include <test_progs.h>
 #include "get_func_ip_test.skel.h"
 
+/* assume IBT is enabled when kernel configs are not available */
+#ifdef HAVE_GENHDR
+# include "autoconf.h"
+#else
+#  define CONFIG_X86_KERNEL_IBT 1
+#endif
+
+/* test6 and test7 are x86_64 specific because of the instruction
+ * offset, disabling it for all other archs
+ *
+ * CONFIG_X86_KERNEL_IBT adds endbr instruction at function entry,
+ * so disabling test6 and test7, because the offset is hardcoded
+ * in program section
+ */
+#if !defined(__x86_64__) || defined(CONFIG_X86_KERNEL_IBT)
+#define DISABLE_OFFSET_ATTACH 1
+#endif
+
 void test_get_func_ip_test(void)
 {
 	struct get_func_ip_test *skel = NULL;
@@ -12,10 +30,7 @@ void test_get_func_ip_test(void)
 	if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
 		return;
 
-	/* test6 is x86_64 specifc because of the instruction
-	 * offset, disabling it for all other archs
-	 */
-#ifndef __x86_64__
+#if defined(DISABLE_OFFSET_ATTACH)
 	bpf_program__set_autoload(skel->progs.test6, false);
 	bpf_program__set_autoload(skel->progs.test7, false);
 #endif
@@ -43,7 +58,7 @@ void test_get_func_ip_test(void)
 	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
-#ifdef __x86_64__
+#if !defined(DISABLE_OFFSET_ATTACH)
 	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 #endif
-- 
2.35.3

