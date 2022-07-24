Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70CA57F72B
	for <lists+bpf@lfdr.de>; Sun, 24 Jul 2022 23:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiGXVWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jul 2022 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGXVWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jul 2022 17:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25BDE90
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 14:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16414611E0
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 21:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1FAC3411E;
        Sun, 24 Jul 2022 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658697741;
        bh=hGYR3tRHeDIzgYh6lXlMRmXLfv6bd1GGYX0W4wP+Mqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1gEYU+vr6fXZ8ti76uAcPSOAIUcF9EmHI7KW26UDK9Afod7Ggu65V8poM62lRfg2
         7d++V1lJh4v37Pnt4I4VHwgNEBtMBNoiTZMSYOuG958ecnMoFxaa78459NQe/+wWRx
         jSsyYqucmn+usSfu3YmhEYf70FsytvedJu6b8D0fqnizrI6pqNUUyWJFpzHk/pKxYM
         h5HSQ4xBEbMYN5wIpDKtqDx1ptaT8FzZtqlISttgmt3syxI+xqstPienEtnNKNqoGa
         vCLZDlegYbCLaFDRnvYfYFGxsdE+Q6XOqQ8WFTDMTuiWleRRzmXNlH+TRzeVpa9lz1
         DiBGYsuWqWRng==
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
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 2/5] bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
Date:   Sun, 24 Jul 2022 23:21:43 +0200
Message-Id: <20220724212146.383680-3-jolsa@kernel.org>
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

Martynas reported bpf_get_func_ip returning +4 address when
CONFIG_X86_KERNEL_IBT option is enabled.

When CONFIG_X86_KERNEL_IBT is enabled we'll have endbr instruction
at the function entry, which screws return value of bpf_get_func_ip()
helper that should return the function address.

There's short term workaround [1] for kprobe_multi bpf program made
by Alexei [1], but we need this fixup also for bpf_get_attach_cookie,
that returns cookie based on the entry_ip value.

Moving the fixup in the fprobe handler, so both bpf_get_func_ip
and bpf_get_attach_cookie get expected function address when
CONFIG_X86_KERNEL_IBT option is enabled.

Keeping the resolved 'addr' in kallsyms_callback, instead of taking
ftrace_location value, because we depend on symbol address in the
cookie related code. With CONFIG_X86_KERNEL_IBT option the
ftrace_location value differs from symbol address.

Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Martynas Pumputis <m@lambda.lt>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c                         | 4 ++++
 tools/testing/selftests/bpf/progs/kprobe_multi.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index 08f95a8155d1..f165615d0b78 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
@@ -44,7 +44,7 @@ static void kprobe_multi_check(void *ctx, bool is_return)
 		return;
 
 	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
-	__u64 addr = bpf_get_func_ip(ctx) - (CONFIG_X86_KERNEL_IBT ? 4 : 0);
+	__u64 addr = bpf_get_func_ip(ctx);
 
 #define SET(__var, __addr, __cookie) ({			\
 	if (((const void *) addr == __addr) &&		\
-- 
2.35.3

