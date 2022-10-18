Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D55602646
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 09:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJRH7o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJRH7m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 03:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60653178B6
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 00:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2632614AC
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E542C433D6;
        Tue, 18 Oct 2022 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666079979;
        bh=RMtlPFAudooIe825XrZ+akfgLyaNyWQmvJOkWj36GcY=;
        h=From:To:Cc:Subject:Date:From;
        b=LbYEjMgvbMOY/i3RwGnj9qFbw9Wlx/fpBcDVqP9+ekZmdb3bXVG9voJ15Ir8KaTKf
         mtyV5NdE+Yx+HFk2LUY/U9a9Bb4WXkOccV5y6OJqxFwKuALltb+2RsEq9iNHBkGv6b
         OsJtWWNLKM6YO8TgnA9UeVLKE1SphnWb0kJw0opLmkhPF+lWjycrkEJFhaRbl3TZtE
         yJZPuDI0H8ZDrI+PVHNyXlAQ6r0GzSJUeeycXwY6J7Skeaz7n8uSSHJxij6ubr0fcM
         hmfZrDfi/9+mW1ENuQF3JVADZPdq8NcIF0Twcc0KUKIlqlc0GYWRKP5ZjrfGDefOGU
         DfvyzW3SpU6jA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Fix dispatcher patchable function entry to 5 bytes nop
Date:   Tue, 18 Oct 2022 09:59:34 +0200
Message-Id: <20221018075934.574415-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The patchable_function_entry(5) might output 5 single nop
instructions (depends on toolchain), which will clash with
bpf_arch_text_poke check for 5 bytes nop instruction.

Adding early init call for dispatcher that checks and change
the patchable entry into expected 5 nop instruction if needed.

There's no need to take text_mutex, because we are using it
in early init call which is called at pre-smp time.

Fixes: ceea991a019c ("bpf: Move bpf_dispatcher function out of ftrace locations")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 13 +++++++++++++
 include/linux/bpf.h         | 14 +++++++++++++-
 kernel/bpf/dispatcher.c     |  6 ++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0abd082786e7..51afd6d0c05f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/init.h>
 #include <asm/extable.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
@@ -388,6 +389,18 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return ret;
 }
 
+int __init bpf_arch_init_dispatcher_early(void *ip)
+{
+	const u8 *nop_insn = x86_nops[5];
+
+	if (is_endbr(*(u32 *)ip))
+		ip += ENDBR_INSN_SIZE;
+
+	if (memcmp(ip, nop_insn, X86_PATCH_SIZE))
+		text_poke_early(ip, nop_insn, X86_PATCH_SIZE);
+	return 0;
+}
+
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *old_addr, void *new_addr)
 {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..0566705c1d4e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -27,6 +27,7 @@
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/init.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -970,6 +971,8 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
+int __init bpf_arch_init_dispatcher_early(void *ip);
+
 #define BPF_DISPATCHER_INIT(_name) {				\
 	.mutex = __MUTEX_INITIALIZER(_name.mutex),		\
 	.func = &_name##_func,					\
@@ -983,6 +986,13 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 	},							\
 }
 
+#define BPF_DISPATCHER_INIT_CALL(_name)					\
+	static int __init _name##_init(void)				\
+	{								\
+		return bpf_arch_init_dispatcher_early(_name##_func);	\
+	}								\
+	early_initcall(_name##_init)
+
 #ifdef CONFIG_X86_64
 #define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5)))
 #else
@@ -1000,7 +1010,9 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 	}								\
 	EXPORT_SYMBOL(bpf_dispatcher_##name##_func);			\
 	struct bpf_dispatcher bpf_dispatcher_##name =			\
-		BPF_DISPATCHER_INIT(bpf_dispatcher_##name);
+		BPF_DISPATCHER_INIT(bpf_dispatcher_##name);		\
+	BPF_DISPATCHER_INIT_CALL(bpf_dispatcher_##name);
+
 #define DECLARE_BPF_DISPATCHER(name)					\
 	unsigned int bpf_dispatcher_##name##_func(			\
 		const void *ctx,					\
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index fa64b80b8bca..04f0a045dcaa 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -4,6 +4,7 @@
 #include <linux/hash.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/init.h>
 
 /* The BPF dispatcher is a multiway branch code generator. The
  * dispatcher is a mechanism to avoid the performance penalty of an
@@ -90,6 +91,11 @@ int __weak arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int n
 	return -ENOTSUPP;
 }
 
+int __weak __init bpf_arch_init_dispatcher_early(void *ip)
+{
+	return -ENOTSUPP;
+}
+
 static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image, void *buf)
 {
 	s64 ips[BPF_DISPATCHER_MAX] = {}, *ipsp = &ips[0];
-- 
2.37.3

