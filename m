Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7058F9DA
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 11:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiHKJQZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 05:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiHKJQY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 05:16:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D43DBCD
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 02:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 716D2B81FA5
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 09:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C33CC433C1;
        Thu, 11 Aug 2022 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660209381;
        bh=mz322GjNErX6dHPTyf+f6qmco0YZ68ZJPpUxXM/rcdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4TslXsmXQkb0BYzck5edtK3dcFhGHluWPEiM6Xq8NvFt79q1UiP8eUtPvDD6g7c9
         GZ1ueWP9ZSJGBA6ho+WfdIG8VPkpIDMUwj3q0Mf5NEwnLjjSEol+/OCK/HddXmsk/D
         sfGrsc4Ex0bwi3dRMm8b7hBqLGY+K3xJdNNa053ndjSCXGZ1mnPkaDNGrilxPZADsa
         FQAFjC+Ko9qan5pxXR27QCeDfi/x7SL9gHznaJZlsa9pUh6CT5jr44irD2R+i57foJ
         DhbrnsnDpXpAQXqGjBVov/84VcI1xdKfqS42GYkpn7f2ydsSwylIoGyr8ce1Qi8nUc
         PgajXkWkZEXMQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 4/6] bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
Date:   Thu, 11 Aug 2022 11:15:24 +0200
Message-Id: <20220811091526.172610-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811091526.172610-1-jolsa@kernel.org>
References: <20220811091526.172610-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martynas reported bpf_get_func_ip returning +4 address when
CONFIG_X86_KERNEL_IBT option is enabled.

When CONFIG_X86_KERNEL_IBT is enabled we'll have endbr instruction
at the function entry, which screws return value of bpf_get_func_ip()
helper that should return the function address.

There's short term workaround for kprobe_multi bpf program made by
Alexei [1], but we need this fixup also for bpf_get_attach_cookie,
that returns cookie based on the entry_ip value.

Moving the fixup in the fprobe handler, so both bpf_get_func_ip
and bpf_get_attach_cookie get expected function address when
CONFIG_X86_KERNEL_IBT option is enabled.

[1] commit 7f0059b58f02 ("selftests/bpf: Fix kprobe_multi test.")

Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Martynas Pumputis <m@lambda.lt>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c                         | 4 ++++
 tools/testing/selftests/bpf/progs/kprobe_multi.c | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..bcada91b0b3b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2419,6 +2419,10 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long entry_ip,
 {
 	struct bpf_kprobe_multi_link *link;
 
+#ifdef CONFIG_X86_KERNEL_IBT
+	if (is_endbr(*((u32 *) entry_ip - 1)))
+		entry_ip -= ENDBR_INSN_SIZE;
+#endif
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
 	kprobe_multi_link_prog_run(link, entry_ip, regs);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
index 08f95a8155d1..98c3399e15c0 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
@@ -36,15 +36,13 @@ __u64 kretprobe_test6_result = 0;
 __u64 kretprobe_test7_result = 0;
 __u64 kretprobe_test8_result = 0;
 
-extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
-
 static void kprobe_multi_check(void *ctx, bool is_return)
 {
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return;
 
 	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
-	__u64 addr = bpf_get_func_ip(ctx) - (CONFIG_X86_KERNEL_IBT ? 4 : 0);
+	__u64 addr = bpf_get_func_ip(ctx);
 
 #define SET(__var, __addr, __cookie) ({			\
 	if (((const void *) addr == __addr) &&		\
-- 
2.37.1

