Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28845A994A
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIANn5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 09:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiIANnJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 09:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB98A6EE
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 06:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8BAD61448
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 13:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67814C4314C;
        Thu,  1 Sep 2022 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662039743;
        bh=SEcv3AXtm1/6SPTbXqNrM239lC06cahdk1Yqe99EFMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IE5cV7dobJFPvGdZsC+KLGllHHikrxJFtja5DfNzzFIgCZSJVmMVbdnhQQn/JzYUJ
         eBMwzxfTzizv58EcIv7QLSAayWF93Gae+j7/jWl6hbn6nvVvhKfds1wTdn4ZoDE2Dr
         i3CEM29bEo1XhtcBP/uPq0Lyo65dK2H0p7Yjf5qlVLTSkWk/FCHI7h7gaWgtI0tMbL
         Z53HvDwBQXhWN2vqG5XgsfHJrDonsGkCxbIJuDJrnyeUL+u4gsppy/jWJMDK1J/X0U
         IrBUeyj2PKrT8swMlvfWLHGkA6Ir+uzufj1Nj0Du8Y2ema7pWyodmgTPu4EiVJn5cf
         fDdNVnKMi6Hfw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv2 bpf-next 2/2] bpf: Move bpf_dispatcher function out of ftrace locations
Date:   Thu,  1 Sep 2022 15:41:50 +0200
Message-Id: <20220901134150.418203-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901134150.418203-1-jolsa@kernel.org>
References: <20220901134150.418203-1-jolsa@kernel.org>
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

The dispatcher function is attached/detached to trampoline by
dispatcher update function. At the same time it's available as
ftrace attachable function.

After discussion [1] the proposed solution is to use compiler
attributes to alter bpf_dispatcher_##name##_func function:

  - remove it from being instrumented with __no_instrument_function__
    attribute, so ftrace has no track of it

  - but still generate 5 nop instructions with patchable_function_entry(5)
    attribute, which are expected by bpf_arch_text_poke used by
    dispatcher update function

Enabling HAVE_DYNAMIC_FTRACE_NO_PATCHABLE option for x86, so
__patchable_function_entries functions are not part of ftrace/mcount
locations.

Adding attributes to bpf_dispatcher_XXX function on x86_64 so it's
kept out of ftrace locations and has 5 byte nop generated at entry.

These attributes need to be arch specific as pointer out by Ilya
Leoshkevic in here [2].

The dispatcher image is generated only for x86_64 arch, so the
code can stay as is for other archs.

[1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
[2] https://lore.kernel.org/bpf/969a14281a7791c334d476825863ee449964dd0c.camel@linux.ibm.com/
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/Kconfig    | 1 +
 include/linux/bpf.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..089c20cefd2b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -284,6 +284,7 @@ config X86
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
+	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c1674973e03..4ab4b0a1beb8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -924,7 +924,15 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 	},							\
 }
 
+#ifdef CONFIG_X86_64
+#define BPF_DISPATCHER_ATTRIBUTES __attribute__((__no_instrument_function__)) \
+				   __attribute__((patchable_function_entry(5)))
+#else
+#define BPF_DISPATCHER_ATTRIBUTES
+#endif
+
 #define DEFINE_BPF_DISPATCHER(name)					\
+	BPF_DISPATCHER_ATTRIBUTES					\
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
-- 
2.37.2

