Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B635C415E92
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhIWMm7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 08:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241135AbhIWMl0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 08:41:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D11961019;
        Thu, 23 Sep 2021 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632400795;
        bh=i/MlA+05kp1QHBGIQjfOz4c92wgg61yiJOjckwvYlOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W903lODKUlO0PoXIsIV2AFdPy9t4wAI79PWuze/4IwJjn7c+6f+4UvnUsQ9cqZqYP
         Er0rrlSf1LxmQHodzBL1YLKpCHchNA02xZtx/pSATMagOa+VfC6oChR8zP2ORqHgod
         nmYmq8X5ilb19DFcknbPsZB1u5FAFwmHNc6GPiGp4izZXytX0RIZ3MJ7W6L46tvogG
         +lanYLpi2WVfVEf2QrjdJYJ5MfwD1YCLJcz3haJhQ6PAutf7n2S2NsA7BvCSOG+L2U
         O4HlxkXq4juEH2XIRZaIJjGP7hXRFY4+6d80u+vJ60AJj0QhIDjrSBIyZ9T29h1ihh
         Wzw+VIWsbBG7g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] tracing/kprobe: Support $$args for function entry
Date:   Thu, 23 Sep 2021 21:39:52 +0900
Message-Id: <163240079198.34105.7585817231870405021.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163240078318.34105.12819521680435948398.stgit@devnote2>
References: <163240078318.34105.12819521680435948398.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support $$args fetch arg for function entry. This uses
BTF for finding the function argument. Thus it depends
on CONFIG_BPF_SYSCALL.

/sys/kernel/tracing # echo 'p vfs_read $$args' >> kprobe_events
/sys/kernel/tracing # cat kprobe_events
p:kprobes/p_vfs_read_0 vfs_read file=$arg1:x64 buf=$arg2:x64 count=$arg3:u64 pos=$arg4:x64

Note that $$args must be used without argument name.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   60 ++++++++++++++++++++++++-
 kernel/trace/trace_probe.c  |  105 +++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |    5 ++
 3 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3dd4fb719aa3..fe88ee8c8cd8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -712,6 +712,58 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+
+static int trace_kprobe_parse_btf_args(struct trace_kprobe *tk, int i,
+				       const char *arg, unsigned int flags)
+{
+	struct trace_probe *tp = &tk->tp;
+	static struct btf *btf;
+	const struct btf_type *t;
+	const struct btf_param *args;
+	s32 id, nargs;
+	int ret;
+
+	if (!(flags & TPARG_FL_FENTRY))
+		return -EINVAL;
+	if (!tk->symbol)
+		return -EINVAL;
+
+	if (!btf)
+		btf = btf_parse_vmlinux();
+
+	id = btf_find_by_name_kind(btf, tk->symbol, BTF_KIND_FUNC);
+	if (id <= 0)
+		return -ENOENT;
+
+	/* Get BTF_KIND_FUNC type */
+	t = btf_type_by_id(btf, id);
+	if (!btf_type_is_func(t))
+		return -ENOENT;
+
+	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
+	t = btf_type_by_id(btf, t->type);
+	if (!btf_type_is_func_proto(t))
+		return -ENOENT;
+
+	args = (const struct btf_param *)(t + 1);
+	nargs = btf_type_vlen(t);
+	for (i = 0; i < nargs; i++) {
+		ret = traceprobe_parse_btf_arg(tp, i, btf, &args[i]);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+#else
+static int trace_kprobe_parse_btf_args(struct trace_kprobe *tk, int i,
+				       const char *arg, unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
 	.priority = 1	/* Invoked after kprobe module callback */
@@ -733,12 +785,13 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	 *  $stack	: fetch stack address
 	 *  $stackN	: fetch Nth of stack (N:0-)
 	 *  $comm       : fetch current task comm
+	 *  $$args	: fetch parameters using BTF
 	 *  @ADDR	: fetch memory at ADDR (ADDR should be in kernel)
 	 *  @SYM[+|-offs] : fetch memory at SYM +|- offs (SYM is a data symbol)
 	 *  %REG	: fetch register REG
 	 * Dereferencing memory fetch:
 	 *  +|-offs(ARG) : fetch memory at ARG +|- offs address.
-	 * Alias name of args:
+	 * Alias name of args (except for $$args) :
 	 *  NAME=FETCHARG : set NAME as alias of FETCHARG.
 	 * Type of args:
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
@@ -877,7 +930,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
 		trace_probe_log_set_index(i + 2);
-		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], flags);
+		if (strcmp(argv[i], "$$args") == 0)
+			ret = trace_kprobe_parse_btf_args(tk, i, argv[i], flags);
+		else
+			ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], flags);
 		if (ret)
 			goto error;	/* This can be -ENOMEM */
 	}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2fe104109525..bbac261b1688 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -765,6 +765,111 @@ static int traceprobe_conflict_field_name(const char *name,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+
+static u32 btf_type_int(const struct btf_type *t)
+{
+	return *(u32 *)(t + 1);
+}
+
+static const char *traceprobe_type_from_btf(struct btf *btf, s32 id)
+{
+	const struct btf_type *t;
+	u32 intdata;
+	s32 tid;
+
+	/* TODO: const char * could be converted as a string */
+	t = btf_type_skip_modifiers(btf, id, &tid);
+
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_ENUM:
+		/* enum is "int", so convert to "s32" */
+		return "s32";
+	case BTF_KIND_PTR:
+		/* pointer will be converted to "x??" */
+		if (IS_ENABLED(CONFIG_64BIT))
+			return "x64";
+		else
+			return "x32";
+	case BTF_KIND_INT:
+		intdata = btf_type_int(t);
+		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {
+			switch (BTF_INT_BITS(intdata)) {
+			case 8:
+				return "s8";
+			case 16:
+				return "s16";
+			case 32:
+				return "s32";
+			case 64:
+				return "s64";
+			}
+		} else {	/* unsigned */
+			switch (BTF_INT_BITS(intdata)) {
+			case 8:
+				return "u8";
+			case 16:
+				return "u16";
+			case 32:
+				return "u32";
+			case 64:
+				return "u64";
+			}
+		}
+	}
+
+	/* Default type */
+	if (IS_ENABLED(CONFIG_64BIT))
+		return "x64";
+	else
+		return "x32";
+}
+
+int traceprobe_parse_btf_arg(struct trace_probe *tp, int i, struct btf *btf,
+			     const struct btf_param *arg)
+{
+	struct probe_arg *parg = &tp->args[i];
+	const char *name, *tname;
+	char *body;
+	int ret;
+
+	tp->nr_args++;
+	name = btf_name_by_offset(btf, arg->name_off);
+	parg->name = kstrdup(name, GFP_KERNEL);
+	if (!parg->name)
+		return -ENOMEM;
+
+	if (!is_good_name(parg->name)) {
+		trace_probe_log_err(0, BAD_ARG_NAME);
+		return -EINVAL;
+	}
+	if (traceprobe_conflict_field_name(parg->name, tp->args, i)) {
+		trace_probe_log_err(0, USED_ARG_NAME);
+		return -EINVAL;
+	}
+
+	/*
+	 * Since probe event needs an appropriate command for dyn_event interface,
+	 * convert BTF type to corresponding fetch-type string.
+	 */
+	tname = traceprobe_type_from_btf(btf, arg->type);
+	if (tname)
+		body = kasprintf(GFP_KERNEL, "$arg%d:%s", i + 1, tname);
+	else
+		body = kasprintf(GFP_KERNEL, "$arg%d", i + 1);
+
+	if (!body)
+		return -ENOMEM;
+	/* Parse fetch argument */
+	ret = traceprobe_parse_probe_arg_body(body, &tp->size, parg,
+				TPARG_FL_KERNEL | TPARG_FL_FENTRY, 0);
+
+	kfree(body);
+
+	return ret;
+}
+#endif
+
 int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
 				unsigned int flags)
 {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 355c78a930f8..857b946afe29 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -23,6 +23,7 @@
 #include <linux/limits.h>
 #include <linux/uaccess.h>
 #include <linux/bitops.h>
+#include <linux/btf.h>
 #include <asm/bitsperlong.h>
 
 #include "trace.h"
@@ -359,6 +360,10 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				const char *argv, unsigned int flags);
+#ifdef CONFIG_BPF_SYSCALL
+int traceprobe_parse_btf_arg(struct trace_probe *tp, int i, struct btf *btf,
+			     const struct btf_param *arg);
+#endif
 
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);

