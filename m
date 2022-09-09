Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4455B34EE
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIIKNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIIKNk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:13:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EEB32D98
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 03:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55FBFB8247B
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 10:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796D8C433D6;
        Fri,  9 Sep 2022 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662718416;
        bh=IyABfRG606Y1RpZ1RqpiBYvacFHO9x+vvjdkKYi5Pf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rz6fF9NVPh21FpZilkzIjWWYlDVNyaP5cr6ryxypELSfHLjkn09WxfoeAeM1Uxl6r
         NKGTCT0O44T96rBUaIo3TM9zc62wUGAqIopUFDljcI/q9UVGYWk6TOcQ1d30bVOaP6
         TINAuM+m/1v2224UoWb/vdh2Ltjc/LcthMFvHuszLIirMAOYc2qvM4HLtM10ondIBJ
         hQoWg+GMhNIBoNiZGAzu8YpNa1TLZ0HTCAP2Vm7atgqpT2XPQjXe/euULpsDMm5EGo
         BnUVK+XQHQ/+OotOgyx5q8fXjoRfud79ebYJWf8kOMCAWFCkBrZ4y3sldKQJ7TYjE0
         0hm9HVPbxTRgg==
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
Subject: [PATCHv3 bpf-next 4/6] bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
Date:   Fri,  9 Sep 2022 12:12:43 +0200
Message-Id: <20220909101245.347173-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909101245.347173-1-jolsa@kernel.org>
References: <20220909101245.347173-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.3

