Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A758657F72E
	for <lists+bpf@lfdr.de>; Sun, 24 Jul 2022 23:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiGXVXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jul 2022 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGXVXA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jul 2022 17:23:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D0DE90
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 14:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A901CCE0FA7
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 21:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1537C3411E;
        Sun, 24 Jul 2022 21:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658697775;
        bh=W3eA1geUi+YV4d0T8w/+tOwQe0Ftku7vR7YDIhjsfSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSvQOX3iHdD7f8gZcqaPY3c2xEzLTMRnmG8qxWt7NhrolsuMXHJGETNvjjrn0kPnN
         Bzgbq3+bEczKgVT8NCYbDsfvhCSAKOxypE94XYAnwVpxYy3t6l1XhaZFdxIcifhivc
         rPb5toi56BXY2KgHmeV7N6tZuK4h+ydC+Wf2c0Gw29wce/ofuwtUQTPeqFLAK91Ags
         gHFCYr7ihoEPhTvhgyUAoNcU5c5riJjQ6FQOG+04GXx5YNcE1gKmFPEBj7TylzQG24
         5RtQZCkORNDvigFqld/SNnQBLPxYzqdrQlB5Uzr0flqVVA2gj2hysZk5Z3CkvyvfHy
         GLIroiU3kjr9w==
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
Subject: [PATCH bpf-next 5/5] selftests/bpf: Fix kprobe get_func_ip tests for CONFIG_X86_KERNEL_IBT
Date:   Sun, 24 Jul 2022 23:21:46 +0200
Message-Id: <20220724212146.383680-6-jolsa@kernel.org>
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

The kprobe can be placed anywhere and user must be aware
of the underlying instructions. Therefore fixing just
the bpf program to 'fix' the address to match the actual
function address when CONFIG_X86_KERNEL_IBT is enabled.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/progs/get_func_ip_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index a587aeca5ae0..220d56b7c1dc 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <stdbool.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -13,6 +14,8 @@ extern const void bpf_modify_return_test __ksym;
 extern const void bpf_fentry_test6 __ksym;
 extern const void bpf_fentry_test7 __ksym;
 
+extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
+
 __u64 test1_result = 0;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(test1, int a)
@@ -37,7 +40,7 @@ __u64 test3_result = 0;
 SEC("kprobe/bpf_fentry_test3")
 int test3(struct pt_regs *ctx)
 {
-	__u64 addr = bpf_get_func_ip(ctx);
+	__u64 addr = bpf_get_func_ip(ctx) - (CONFIG_X86_KERNEL_IBT ? 4 : 0);
 
 	test3_result = (const void *) addr == &bpf_fentry_test3;
 	return 0;
@@ -47,7 +50,7 @@ __u64 test4_result = 0;
 SEC("kretprobe/bpf_fentry_test4")
 int BPF_KRETPROBE(test4)
 {
-	__u64 addr = bpf_get_func_ip(ctx);
+	__u64 addr = bpf_get_func_ip(ctx) - (CONFIG_X86_KERNEL_IBT ? 4 : 0);
 
 	test4_result = (const void *) addr == &bpf_fentry_test4;
 	return 0;
-- 
2.35.3

