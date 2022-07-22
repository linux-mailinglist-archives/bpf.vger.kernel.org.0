Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6657E0A6
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 13:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiGVLIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 07:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiGVLI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 07:08:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61244BE9DF
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 04:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 192F7B827CF
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35BFC341C6;
        Fri, 22 Jul 2022 11:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658488098;
        bh=dsfRWLLMR4+ptEj3SyuQFRFYHxAyM4SviO1lBe1wUNM=;
        h=From:To:Cc:Subject:Date:From;
        b=FLaVfjfyNt5MPe5RmLdvNZVNd53m3EatesLoFmBSc24+wYySNtxOx32ao/ZkrAOuG
         dDQYPygQuEiz97/7QdkXLc41DD3uTbSXCHsqMp67jXwXFZugP8OHaotvNe/xf8LDMp
         IAhKtLg52hYDSmdlvij/XAL3PuqfGjZrvp7vdNHx1CNJf7jBo0sGaOVqb50LsJO4+L
         lfPkN4502avo4UigPEwLLJLqwyNdYdcsvkhmJilF3Qj4ysh+QYfrqqop/7c0HtMgRK
         ks7KAfL19az3nUjyI2FDxKWOxAtYTYFvcvOyNHfmuWVilRxiApn6jGZXHefvoRbi/G
         TO/Xr40mdI8hA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC] ftrace: Add support to keep some functions out of ftrace
Date:   Fri, 22 Jul 2022 13:08:11 +0200
Message-Id: <20220722110811.124515-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
we recently hit bug where ftrace update raced with bpf_dispatcher_update
that calls directly bpf_arch_text_poke [1].

The bpf_dispatcher_update creates special trampoline and attaches it to
designated bpf_dispatcher_xdp_func function, which is run for xdp bpf
programs from several places.

After discussion with Alexei we'd rather keep this code update out of
ftrace, because it's already slow and had troubles with CI because of
that.

This patch is presenting the idea to allow some functions not to be
managed by ftrace by marking them with NOFTRACE_SYMBOL macro and
such symbols will not be added to ftrace_pages on the kernel start.

Please note it's RFC so I did not bother with some fast search for
is_noftrace_function function.

Perhaps we could use existing NOKPROBE_SYMBOL for this? but I'm not
sure you can (or want) to run function trace on such symbols.

thoughts? thanks
jirka


[1] https://lore.kernel.org/bpf/20220714082316.479181-1-jolsa@kernel.org/
---
 include/asm-generic/vmlinux.lds.h | 10 ++++++
 include/linux/bpf.h               |  2 ++
 include/linux/ftrace.h            | 10 ++++++
 kernel/trace/ftrace.c             | 53 +++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7515a465ec03..94c3cbe82ffd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -210,6 +210,15 @@
 #define KPROBE_BLACKLIST()
 #endif
 
+#ifdef CONFIG_FTRACE
+#define NOFTRACE()	. = ALIGN(8);			      \
+			__start_noftrace = .;		      \
+			KEEP(*(_no_ftrace))		      \
+			__stop_noftrace = .;
+#else
+#define NOFTRACE()
+#endif
+
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 #define ERROR_INJECT_WHITELIST()	STRUCT_ALIGN();			      \
 			__start_error_injection_whitelist = .;		      \
@@ -705,6 +714,7 @@
 	FTRACE_EVENTS()							\
 	TRACE_SYSCALLS()						\
 	KPROBE_BLACKLIST()						\
+	NOFTRACE()							\
 	ERROR_INJECT_WHITELIST()					\
 	MEM_DISCARD(init.rodata)					\
 	CLK_OF_TABLES()							\
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5bf00649995..1330b84eb20f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -27,6 +27,7 @@
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/ftrace.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -919,6 +920,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 		return bpf_func(ctx, insnsi);				\
 	}								\
 	EXPORT_SYMBOL(bpf_dispatcher_##name##_func);			\
+	NOFTRACE_SYMBOL(bpf_dispatcher_##name##_func);			\
 	struct bpf_dispatcher bpf_dispatcher_##name =			\
 		BPF_DISPATCHER_INIT(bpf_dispatcher_##name);
 #define DECLARE_BPF_DISPATCHER(name)					\
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 979f6bfa2c25..cde80cd57f2f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1141,4 +1141,14 @@ unsigned long arch_syscall_addr(int nr);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
+#ifdef CONFIG_FUNCTION_TRACER
+#define __NOFTRACE_SYMBOL(fname)				\
+static unsigned long __used					\
+	__section("_no_ftrace")					\
+	_noftrace_addr_##fname = (unsigned long)fname;
+#define NOFTRACE_SYMBOL(fname) __NOFTRACE_SYMBOL(fname)
+#else
+#define NOFTRACE_SYMBOL(fname)
+#endif /* CONFIG_FUNCTION_TRACER */
+
 #endif /* _LINUX_FTRACE_H */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 601ccf1b2f09..e0ebd71135b4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6575,6 +6575,51 @@ static void test_is_sorted(unsigned long *start, unsigned long count)
 }
 #endif
 
+struct noftrace_entry {
+	struct list_head list;
+	unsigned long addr;
+};
+
+static LIST_HEAD(noftrace);
+
+static int __init noftrace_add(unsigned long addr)
+{
+	struct noftrace_entry *ent;
+
+	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return -ENOMEM;
+	ent->addr = addr;
+	INIT_LIST_HEAD(&ent->list);
+	list_add_tail(&ent->list, &noftrace);
+	return 0;
+}
+
+static int __init noftrace_init(void)
+{
+	extern unsigned long __start_noftrace[];
+	extern unsigned long __stop_noftrace[];
+	unsigned long *iter, entry;
+
+	for (iter = __start_noftrace; iter < __stop_noftrace; iter++) {
+		entry = (unsigned long) dereference_symbol_descriptor((void *)*iter);
+		if (noftrace_add(entry))
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static bool is_noftrace_function(unsigned long addr)
+{
+	struct noftrace_entry *ent;
+
+	list_for_each_entry(ent, &noftrace, list) {
+		if (ent->addr == addr)
+			return true;
+	}
+	return false;
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -6646,6 +6691,9 @@ static int ftrace_process_locs(struct module *mod,
 		 */
 		if (!addr)
 			continue;
+		/* applies only for kernel for now */
+		if (!mod && is_noftrace_function(addr))
+			continue;
 
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
@@ -7300,6 +7348,11 @@ void __init ftrace_init(void)
 	pr_info("ftrace: allocating %ld entries in %ld pages\n",
 		count, count / ENTRIES_PER_PAGE + 1);
 
+	if (noftrace_init()) {
+		pr_warn("ftrace: failed to allocate noftrace list\n");
+		goto failed;
+	}
+
 	ret = ftrace_process_locs(NULL,
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
-- 
2.35.3

