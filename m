Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245A621ED4
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 23:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKHWH3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 17:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKHWH1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 17:07:27 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C2222B02
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 14:07:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so76016wmi.3
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 14:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1mUjdZ54+QPDalwWmDM1Wvlv8fynQMUFliQp99sevY=;
        b=DsnZuAFkKsFG/k0XFoVa0QhxTrnFR/6PDOazsno3rWhBr9RbasUUkMX/4W4RMSzkoZ
         MUqIVQhN4MoTOH5vCcc/SC3oR/XrCZIxZmgM9Df0zRhV51OQDmEJ8a0VgntNrbDBbZN+
         nErB64G+SwmjyB6P/RYhrlWgbfO6xxVIAPZGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1mUjdZ54+QPDalwWmDM1Wvlv8fynQMUFliQp99sevY=;
        b=G7kTvf80ZZ+XdZHeoM6wocHAO4l/aMzlfalK2QtCxSE3J7Hm//1DXqjBhgwoQToVAG
         25x/KtvVwgzgUZvK9phNNSQ69MhubWq7AXHo65gEZoTA7WTeGti1+J0Phr12uQeSRgF7
         K73Y40O0acivdF1V186eJpxdzJNETGodRrNmHdhe2p7qM0gDRvCP7nm5IqDMquYY2P+b
         ScjYMp+ujj6Tax+6niDVenHMrIEroK71hF6yFiTjewVKbepeXB/trGFvaxofbDUE9vwB
         SA5lO/6dSWcwdnlfLx2kZiuA7v0mbsltSuk0RxfukhVL1EhcEj8QQrRL/xsO8CDjFRxm
         R0Zw==
X-Gm-Message-State: ACrzQf17+i6Mn16GG6Xyg7CxXfq6XyI1YiGloXNt4BQ6bDOhNFRVDkkY
        UX7g8KhZxNPYkdIifyqFLNE4JgMGRfDkLQ==
X-Google-Smtp-Source: AMsMyM6/OcGc43TWZBRenL/KnoQ7WKuZraiisgP0GI/mhCqRe4YyA/Xq8S+fGnkMu1XI58gymPwvEw==
X-Received: by 2002:a7b:c303:0:b0:3b4:6e89:e5d5 with SMTP id k3-20020a7bc303000000b003b46e89e5d5mr38995760wmj.111.1667945244325;
        Tue, 08 Nov 2022 14:07:24 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:8b01:3c16:212f:91df])
        by smtp.gmail.com with ESMTPSA id bw9-20020a0560001f8900b00236c1f2cecesm14001004wrb.81.2022.11.08.14.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:07:23 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, markowsky@google.com,
        mark.rutland@arm.com, mhiramat@kernel.org, rostedt@goodmis.org,
        xukuohai@huawei.com, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [RFC 1/1] bpf: Invoke tracing progs using fprobe on archs without direct call
Date:   Tue,  8 Nov 2022 23:06:51 +0100
Message-Id: <20221108220651.24492-2-revest@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221108220651.24492-1-revest@chromium.org>
References: <20221108220651.24492-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some architectures may not support ftrace direct calls and can not jump
directly to a BPF trampoline. This provides a fallback built on fprobe
(itself built on a ftrace ops and rethook) so that BPF tracing programs
can still be called on these architectures.

The behavior of the entry and exit hooks somewhat mirrors JITted
trampolines but it has a few implementation differences. First of all,
the code is not JITed. Arguments are converted from a ftrace_regs
structure to a BPF context instead of being read from registers
directly. And arguments for fexit are saved in the rethook nodes pool
rather than in a stack frame below the traced function.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h     |   5 ++
 kernel/bpf/trampoline.c | 120 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..8f11b8255440 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/percpu.h>
 #include <linux/err.h>
+#include <linux/fprobe.h>
 #include <linux/rbtree_latch.h>
 #include <linux/numa.h>
 #include <linux/mm_types.h>
@@ -952,7 +953,11 @@ struct bpf_tramp_image {
 struct bpf_trampoline {
 	/* hlist for trampoline_table */
 	struct hlist_node hlist;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	struct ftrace_ops *fops;
+#elif defined(CONFIG_FPROBE)
+	struct fprobe probe;
+#endif
 	/* serializes access to fields of this trampoline */
 	struct mutex mutex;
 	refcount_t refcnt;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d6395215b849..c64a4805be24 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -103,6 +103,91 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd
 	mutex_unlock(&tr->mutex);
 	return ret;
 }
+#elif defined(CONFIG_FPROBE)
+static unsigned int call_bpf_prog(struct bpf_tramp_link *l,
+				  struct bpf_tramp_run_ctx *ctx, u64 *args)
+{
+	struct bpf_prog *p = l->link.prog;
+	bpf_trampoline_enter_t enter = bpf_trampoline_enter(p);
+	bpf_trampoline_exit_t exit = bpf_trampoline_exit(p);
+	unsigned int ret;
+	u64 start_time;
+
+	ctx->bpf_cookie = l->cookie;
+
+	start_time = enter(p, ctx);
+	if (!start_time)
+		return 0;
+
+	ret = p->bpf_func(args, p->insnsi);
+
+	exit(p, start_time, ctx);
+
+	return ret;
+}
+
+struct bpf_fprobe_call_context {
+	struct bpf_tramp_run_ctx ctx;
+	/* ip and args_cnt are expected to be located before args by helpers */
+	u64 ip;
+	u64 args_cnt;
+	u64 args[7];
+};
+
+static void bpf_fprobe_exit(struct fprobe *fp, unsigned long ip,
+			    unsigned long ret_ip, struct ftrace_regs *regs,
+			    void *private)
+{
+	struct bpf_trampoline *tr = container_of(fp, struct bpf_trampoline, probe);
+	struct bpf_fprobe_call_context *call_ctx = private;
+	struct hlist_head *fexit_links = &tr->progs_hlist[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_link *link;
+	struct hlist_node *tmp;
+
+	call_ctx->args[call_ctx->args_cnt] = ftrace_regs_get_return_value(regs);
+
+	hlist_for_each_entry_safe(link, tmp, fexit_links, tramp_hlist)
+		call_bpf_prog(link, &call_ctx->ctx, call_ctx->args);
+}
+
+static int bpf_fprobe_entry(struct fprobe *fp, unsigned long ip,
+			    unsigned long ret_ip, struct ftrace_regs *regs,
+			    void *private)
+{
+	struct bpf_trampoline *tr = container_of(fp, struct bpf_trampoline, probe);
+	struct bpf_fprobe_call_context *call_ctx = private;
+	struct hlist_head *fentry_links = &tr->progs_hlist[BPF_TRAMP_FENTRY],
+		*fmod_ret_links = &tr->progs_hlist[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_link *link;
+	struct hlist_node *tmp;
+	int i, ret;
+
+	memset(&call_ctx->ctx, 0, sizeof(call_ctx->ctx));
+	call_ctx->ip = (u64)tr->func.addr;
+	call_ctx->args_cnt = tr->func.model.nr_args;
+	for (i = 0; i < call_ctx->args_cnt; i++)
+		call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
+
+	hlist_for_each_entry_safe(link, tmp, fentry_links, tramp_hlist)
+		call_bpf_prog(link, &call_ctx->ctx, call_ctx->args);
+
+	call_ctx->args[call_ctx->args_cnt] = 0;
+	hlist_for_each_entry_safe(link, tmp, fmod_ret_links, tramp_hlist) {
+		ret = call_bpf_prog(link, &call_ctx->ctx, call_ctx->args);
+
+		if (ret) {
+			/* Skip the traced function */
+			ftrace_regs_set_return_value(regs, ret);
+			ftrace_override_function_with_return(regs);
+
+			/* Skip the return handler */
+			bpf_fprobe_exit(fp, ip, ret_ip, regs, private);
+			return 1;
+		}
+	}
+
+	return !tr->progs_cnt[BPF_TRAMP_FEXIT];
+}
 #endif
 
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
@@ -158,6 +243,10 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	}
 	tr->fops->private = tr;
 	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
+#elif defined(CONFIG_FPROBE)
+	tr->probe.entry_data_size = sizeof(struct bpf_fprobe_call_context);
+	tr->probe.entry_handler = &bpf_fprobe_entry;
+	tr->probe.exit_handler = &bpf_fprobe_exit;
 #endif
 
 	tr->key = key;
@@ -172,6 +261,7 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	return tr;
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_module_get(struct bpf_trampoline *tr)
 {
 	struct module *mod;
@@ -455,12 +545,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (ip_arg)
 		tr->flags |= BPF_TRAMP_F_IP_ARG;
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 again:
 	if ((tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) &&
 	    (tr->flags & BPF_TRAMP_F_CALL_ORIG))
 		tr->flags |= BPF_TRAMP_F_ORIG_STACK;
-#endif
 
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZE,
 					  &tr->func.model, tr->flags, tlinks,
@@ -480,7 +568,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		/* first time registering */
 		err = register_fentry(tr, im->image);
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	if (err == -EAGAIN) {
 		/* -EAGAIN from bpf_tramp_ftrace_ops_func. Now
 		 * BPF_TRAMP_F_SHARE_IPMODIFY is set, we can generate the
@@ -491,7 +578,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->fops->trampoline = 0;
 		goto again;
 	}
-#endif
 	if (err)
 		goto out;
 
@@ -506,6 +592,30 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	kfree(tlinks);
 	return err;
 }
+#elif defined(CONFIG_FPROBE)
+static int bpf_trampoline_update(struct bpf_trampoline *tr,
+				 bool lock_direct_mutex)
+{
+	int total = 0, err = 0, kind;
+
+	for (kind = 0; kind < BPF_TRAMP_MAX; kind++)
+		total += tr->progs_cnt[kind];
+
+	if (total == 0)
+		err = unregister_fprobe(&tr->probe);
+	else if (!fprobe_is_registered(&tr->probe))
+		err = register_fprobe_ips(&tr->probe,
+					  (unsigned long *)(&tr->func.addr), 1);
+
+	return err;
+}
+#else
+static int bpf_trampoline_update(struct bpf_trampoline *tr,
+				 bool lock_direct_mutex)
+{
+	return -ENODEV;
+}
+#endif
 
 static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
@@ -829,10 +939,12 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 * multiple rcu callbacks.
 	 */
 	hlist_del(&tr->hlist);
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	if (tr->fops) {
 		ftrace_free_filter(tr->fops);
 		kfree(tr->fops);
 	}
+#endif
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
-- 
2.38.1.431.g37b22c650d-goog

