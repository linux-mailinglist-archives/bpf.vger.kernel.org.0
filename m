Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCEC5A994D
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiIANn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiIANnA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 09:43:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F6399E2
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 06:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64154B826E3
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 13:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0137BC433C1;
        Thu,  1 Sep 2022 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662039730;
        bh=MOCThZ+nzYei+M5m8s6y6e1bR5O/c33Xh2cxXEoLyHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UM6mIhooqPXg/pj8YshnTSaRhHxQo+x5koDskVcYl1PAY+RNkZ0HaebzwRgcb04si
         gyHQ3UOoCUQU1EArxcMqeSWefIFG2Vd6D68WRU9xfVgYdvZCAiDIO+05CAxzOVKBr+
         rhVXfLt2jnoyV/oc9JEubpVsruYDd7+wqH6Dr3afpG/iGNOqxBTHUVRncdwOdQZLA2
         WfmYtr6jg7r/UxzRDrMIoDse3NVWnVppwakX51oMb4muZomFrp0Y0LQ73yuGXtRG7z
         CfCsKVSWFzRz08ia2yyhAJ8DXp5/RKuf17JNdXfmaTTvZjzeEjpK0UYToNkJ6flbz5
         UHyOR5vQxztbQ==
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
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv2 bpf-next 1/2] ftrace: Add HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
Date:   Thu,  1 Sep 2022 15:41:49 +0200
Message-Id: <20220901134150.418203-2-jolsa@kernel.org>
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

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

x86 will shortly start using -fpatchable-function-entry for purposes
other than ftrace, make sure the __patchable_function_entry section
isn't merged in the mcount_loc section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
 kernel/trace/Kconfig              |  6 ++++++
 tools/objtool/check.c             |  3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7515a465ec03..13b197ef0d63 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -154,6 +154,14 @@
 #define MEM_DISCARD(sec) *(.mem##sec)
 #endif
 
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+#define KEEP_PATCHABLE		KEEP(*(__patchable_function_entries))
+#define PATCHABLE_DISCARDS
+#else
+#define KEEP_PATCHABLE
+#define PATCHABLE_DISCARDS	*(__patchable_function_entries)
+#endif
+
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 /*
  * The ftrace call sites are logged to a section whose name depends on the
@@ -172,7 +180,7 @@
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
-			KEEP(*(__patchable_function_entries))	\
+			KEEP_PATCHABLE				\
 			__stop_mcount_loc = .;			\
 			ftrace_stub_graph = ftrace_stub;	\
 			ftrace_ops_list_func = arch_ftrace_ops_list_func;
@@ -1024,6 +1032,7 @@
 
 #define COMMON_DISCARDS							\
 	SANITIZER_DISCARDS						\
+	PATCHABLE_DISCARDS						\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 1052126bdca2..e9e95c790b8e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -51,6 +51,12 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	 This allows for use of regs_get_kernel_argument() and
 	 kernel_stack_pointer().
 
+config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	bool
+	help
+	  If the architecture generates __patchable_function_entries sections
+	  but does not want them included in the ftrace locations.
+
 config HAVE_FTRACE_MCOUNT_RECORD
 	bool
 	help
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74da7ffe..f23e8d11f6d4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4110,7 +4110,8 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__mcount_loc"))
+		    !strcmp(sec->name, "__mcount_loc")			||
+		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
-- 
2.37.2

