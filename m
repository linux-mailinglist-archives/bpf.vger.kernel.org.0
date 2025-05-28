Return-Path: <bpf+bounces-59106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E4AC6069
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DE13B4211
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F51F3BAB;
	Wed, 28 May 2025 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRVPTMrS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10C21C9F6;
	Wed, 28 May 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404216; cv=none; b=h4JDecmsd4szLk1Zgy8hg9b+OXoWZ7PNIaKHS/mp+G5FBp/K0lbAvZUl9l7iyUHzE/WhGZzkMCESUyaALuh8iWRA49DJdA1cZ/ywwrUP7rjRAgYZgLz3I2Sr8ADtcZBG+p/PttqiWHJg2p5hJfhrp9ARaYGO7dR88DTk4Wo2bO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404216; c=relaxed/simple;
	bh=aApBRpTSVGFJFyeFt0SJiX2fLyAA1yK3SMrzMhlMm/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdYdYn2WrOg82XXVkTdOjE/8/5pPWox50TlRZa4ay/bBtKalxXUVpiCxuFZBWkLMTTAY2Jrp3eVEhPvJDmPEHcc9PmUMkUDlzJ6WfiY9X9UX5fIWvFzDEU7iybvXvFUe/qvQc6Mm4VgURcpUcqlhkdH4/Q1S7PobSyCUDDx3TfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRVPTMrS; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-234b440afa7so8923315ad.0;
        Tue, 27 May 2025 20:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404213; x=1749009013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMw9XBLwB3ktFFUUL8YNkGDIrwciXTJUnDt5CzTt340=;
        b=aRVPTMrSZkwiXEi/tfYZ8W0LHXmHsnN/3TGh8Z7H7Ra3tAhYN1zgPnSqAvErcTpOX9
         erGi4wwiYJyJQgOQLbnB1YIPL5Cl5LsoZkmfmkHqENeKlGKYF+c1YABXc0guqB5uzQrt
         A+68mWUQQae2TkFfa8kCUNZs4Oc7mJhaJJ1iOEtoUXQER9C57MpcQl+3Hvq5R1XDF1zN
         2TdcpTF25tgv0Vukdmvpa1MaJ6YT+GYXr56dDP8rMsjD8Il7lpe22Y0R9Y/M9kXZEJwJ
         HHUr3sk1rEkZQWCXHUPxGxLyBuwbi2qEMLirf81vlU8ly2NkncR0nHqSvcVnzxm722k4
         GAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404213; x=1749009013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMw9XBLwB3ktFFUUL8YNkGDIrwciXTJUnDt5CzTt340=;
        b=ulzJw9sxLXHMGDywAo2hkTYtC0fzL5D8VlMW3zve6oi0fwwaYpLc/nQ7dPC+4j/3dL
         hBptNuC04Ln9W+O4t1tkSvNELt57Frjp3aJOQsDtTD+zmSq04t4pRv/udlqd7i0bJ7eo
         XCmFgiSNWoWePCPw54NWLtaY9PvKSYPlk+z07MkD/13jjHGVOdmZHKCKxGwIfhjO2eat
         BD+Shi5SI4a4XIW3/r8fHpioRO5VndZPy6xF0CBS3A3/OceEhnslcZusrqDyRVlKc7Ej
         aopEvB8iXjyiL6MlBNPA0cUvMUHCJHSuhJuQDGs5nB9/8lrwOuoj8qPuuy4Hk4eVWQ/h
         qe7g==
X-Forwarded-Encrypted: i=1; AJvYcCV2QLR/VVbRJuwnrJNWVtTB9SPQEv6+T5neqx4tja43zxepeDHv5CbupRN9g50k6wRtJ4RDbvFD/cSnTP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyanT+roGAYA7aIdPzqyIYDZVbGBHrB/QF7v8uFtOiCF/yzuM2F
	lvoy4DkZdFD3479dk9CRcQDz3A9Zc5uwFVse2EQBE5OfrTrJVJPhokUyCwQLLfk2
X-Gm-Gg: ASbGncvo7wLb+8PtKRyGgqHkDsAcaZr4voA/5F5LAETCJ743f5UON527ESUZHmnpFq3
	5NM0LW/qQWsgEnp/MEp1tFV8P0WRw1RWbe3V/SORSJA/pOJGIZpriu+IBRjm8oYcP6Rb/7KwC54
	+S7PweCSOJDOvdccTdufQoYxdtcxb3hgo8VB8BPipKs5dv+FEaieEo5ox1lyFjIXe6KKjRHlYmI
	1JOShiiAH1k8uGPI/JXLTVoCX9r/Z3W5x3kVwERu5hzac36Sb9y7fRWC5fhNb4Oe8NTIBxiGxZw
	bD4rGn1Nrvv4xjfAoiDFwEmA363n/Wtbt+2pD05sv52vYewoKJLPUZKVsijzH3uWDgZ3
X-Google-Smtp-Source: AGHT+IEhvXf0piOAs0CO8nTX0yvduSmqoZK1c/X1qcWFu8WrWXKrIACVSBz3ph9fBjE8NSK62i9qGA==
X-Received: by 2002:a17:902:cccb:b0:231:ecd5:e719 with SMTP id d9443c01a7336-23414fb5561mr294497265ad.24.1748404213253;
        Tue, 27 May 2025 20:50:13 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 17/25] bpf: make trampoline compatible with global trampoline
Date: Wed, 28 May 2025 11:47:04 +0800
Message-Id: <20250528034712.138701-18-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the bpf global trampoline can't work together with trampoline.
For example, we will fail on attaching the FENTRY_MULTI to the functions
that FENTRY exists, and FENTRY will also fail if FENTRY_MULTI exists.

We make the global trampoline work together with trampoline in this
commit.

It is not easy. The most difficult part is synchronization between
bpf_gtrampoline_link_prog and bpf_trampoline_link_prog, and we use a
rw_semaphore here, which is quite ugly. We hold the write lock in
bpf_gtrampoline_link_prog and read lock in bpf_trampoline_link_prog.

We introduce the function bpf_gtrampoline_link_tramp() to make
bpf_gtramp_link fit bpf_trampoline, which will be called in
bpf_gtrampoline_link_prog(). If the bpf_trampoline of the function exist
in the kfunc_md or we find it with bpf_trampoline_lookup_exist(), it means
that we need do the fitting. The fitting is simple, we create a
bpf_shim_tramp_link for our prog and link it to the bpf_trampoline with
__bpf_trampoline_link_prog().

It's a little complex for the bpf_trampoline_link_prog() case. We create
bpf_shim_tramp_link for all the bpf progs in kfunc_md and add it to the
bpf_trampoline before we call __bpf_trampoline_link_prog() in
bpf_gtrampoline_replace(). And we will fallback in
bpf_gtrampoline_replace_finish() if error is returned by
__bpf_trampoline_link_prog().

In __bpf_gtrampoline_unlink_prog(), we will call bpf_gtrampoline_remove()
to release the bpf_shim_tramp_link, and the bpf prog will be unlinked if
it is ever linked successfully in bpf_link_free().

Another solution is to fit into the existing trampoline. For example, we
can add the bpf prog to the kfunc_md if tracing_multi bpf prog is attached
on the target function when we attach a tracing bpf prog. And we can also
update the tracing_multi prog to the trampoline if tracing prog exists
on the target function. I think this will make the compatibility much
easier.

The code in this part is very ugly and messy, and I think it will be a
liberation to split it out to another series :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h      |   6 +
 include/linux/kfunc_md.h |   2 +
 kernel/bpf/syscall.c     |   2 +-
 kernel/bpf/trampoline.c  | 291 +++++++++++++++++++++++++++++++++++++--
 kernel/trace/kfunc_md.c  |   9 +-
 5 files changed, 293 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7191ad25d519..0f4605be87fc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1173,6 +1173,11 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_INDIRECT		BIT(8)
 
+/* Indicate that bpf global trampoline is also used on this function and
+ * the trampoline is replacing it.
+ */
+#define BPF_TRAMP_F_REPLACE		BIT(9)
+
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.
  */
@@ -2554,6 +2559,7 @@ void bpf_link_put(struct bpf_link *link);
 int bpf_link_new_fd(struct bpf_link *link);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
+void bpf_link_free(struct bpf_link *link);
 
 void bpf_token_inc(struct bpf_token *token);
 void bpf_token_put(struct bpf_token *token);
diff --git a/include/linux/kfunc_md.h b/include/linux/kfunc_md.h
index f1b1012eeab2..956e16f96d82 100644
--- a/include/linux/kfunc_md.h
+++ b/include/linux/kfunc_md.h
@@ -29,6 +29,8 @@ struct kfunc_md {
 #endif
 	unsigned long func;
 	struct kfunc_md_tramp_prog *bpf_progs[BPF_TRAMP_MAX];
+	/* fallback case, there is already a trampoline on this function */
+	struct bpf_trampoline *tramp;
 #ifdef CONFIG_FUNCTION_METADATA
 	/* the array is used for the fast mode */
 	struct kfunc_md_array *array;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0cd989381128..c1c92c2b2cfc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3184,7 +3184,7 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
 }
 
 /* bpf_link_free is guaranteed to be called from process context */
-static void bpf_link_free(struct bpf_link *link)
+void bpf_link_free(struct bpf_link *link)
 {
 	const struct bpf_link_ops *ops = link->ops;
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b92d1d4f1033..81b62aae9faf 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -14,6 +14,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
 #include <linux/kfunc_md.h>
+#include <linux/execmem.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -142,20 +143,44 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
 			   PAGE_SIZE, true, ksym->name);
 }
 
-static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
+static struct bpf_trampoline *__bpf_trampoline_lookup_exist(u64 key)
 {
 	struct bpf_trampoline *tr;
 	struct hlist_head *head;
-	int i;
 
-	mutex_lock(&trampoline_mutex);
 	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
 	hlist_for_each_entry(tr, head, hlist) {
 		if (tr->key == key) {
 			refcount_inc(&tr->refcnt);
-			goto out;
+			return tr;
 		}
 	}
+
+	return NULL;
+}
+
+static struct bpf_trampoline *bpf_trampoline_lookup_exist(u64 key)
+{
+	struct bpf_trampoline *tr;
+
+	mutex_lock(&trampoline_mutex);
+	tr = __bpf_trampoline_lookup_exist(key);
+	mutex_unlock(&trampoline_mutex);
+
+	return tr;
+}
+
+static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
+{
+	struct bpf_trampoline *tr;
+	struct hlist_head *head;
+	int i;
+
+	mutex_lock(&trampoline_mutex);
+	tr = __bpf_trampoline_lookup_exist(key);
+	if (tr)
+		goto out;
+
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
 		goto out;
@@ -172,6 +197,7 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 
 	tr->key = key;
 	INIT_HLIST_NODE(&tr->hlist);
+	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist, head);
 	refcount_set(&tr->refcnt, 1);
 	mutex_init(&tr->mutex);
@@ -228,7 +254,11 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 
 	if (tr->func.ftrace_managed) {
 		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
-		ret = register_ftrace_direct(tr->fops, (long)new_addr);
+		if (tr->flags & BPF_TRAMP_F_REPLACE)
+			ret = replace_ftrace_direct(tr->fops, global_tr.fops,
+						    (long)new_addr);
+		else
+			ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
 	}
@@ -236,6 +266,17 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	return ret;
 }
 
+static int
+bpf_trampoline_get_count(const struct bpf_trampoline *tr)
+{
+	int count = 0;
+
+	for (int kind = 0; kind < BPF_TRAMP_MAX; kind++)
+		count += tr->progs_cnt[kind];
+
+	return count;
+}
+
 static struct bpf_tramp_links *
 bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
 {
@@ -608,15 +649,173 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	return err;
 }
 
+static int bpf_gtrampoline_get_link(struct bpf_trampoline *tr, struct bpf_prog *prog,
+				    u64 cookie, int kind,
+				    struct bpf_shim_tramp_link **link)
+{
+	struct bpf_shim_tramp_link *__link;
+
+	__link = kzalloc(sizeof(*__link), GFP_KERNEL);
+	if (!__link)
+		return -ENOMEM;
+
+	__link->link.cookie = cookie;
+
+	bpf_link_init(&__link->link.link, BPF_LINK_TYPE_UNSPEC,
+		      &bpf_shim_tramp_link_lops, prog);
+
+	/* the bpf_shim_tramp_link will hold a reference on the prog and tr */
+	refcount_inc(&tr->refcnt);
+	bpf_prog_inc(prog);
+	*link = __link;
+
+	return 0;
+}
+
+static struct bpf_tramp_link *
+bpf_gtrampoline_find_link(struct bpf_trampoline *tr, struct bpf_prog *prog)
+{
+	struct bpf_tramp_link *link;
+
+	for (int kind = 0; kind < BPF_TRAMP_MAX; kind++) {
+		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
+			if (link->link.prog == prog)
+				return link;
+		}
+	}
+
+	return NULL;
+}
+
+static int bpf_gtrampoline_remove(struct bpf_trampoline *tr, struct bpf_prog *prog,
+				  bool remove_list)
+{
+	struct bpf_shim_tramp_link *slink;
+	int kind;
+
+	slink = (struct bpf_shim_tramp_link *)bpf_gtrampoline_find_link(tr, prog);
+	if (WARN_ON_ONCE(!slink))
+		return -EINVAL;
+
+	if (!slink->trampoline && remove_list) {
+		kind = bpf_attach_type_to_tramp(prog);
+		hlist_del_init(&slink->link.tramp_hlist);
+		tr->progs_cnt[kind]--;
+	}
+	bpf_link_free(&slink->link.link);
+
+	return 0;
+}
+
+static int bpf_gtrampoline_replace(struct bpf_trampoline *tr)
+{
+	struct kfunc_md_tramp_prog *progs;
+	struct bpf_shim_tramp_link *link;
+	struct kfunc_md *md;
+	int err = 0, count;
+
+	kfunc_md_lock();
+	md = kfunc_md_get((unsigned long)tr->func.addr);
+	if (!md || md->tramp) {
+		kfunc_md_put_entry(md);
+		kfunc_md_unlock();
+		return 0;
+	}
+	kfunc_md_unlock();
+
+	rcu_read_lock();
+	md = kfunc_md_get_noref((unsigned long)tr->func.addr);
+	if (!md || md->tramp)
+		goto on_fail;
+
+	count = bpf_trampoline_get_count(tr);
+	/* we are attaching a new link, so +1 here */
+	count += md->bpf_prog_cnt + 1;
+	if (count > BPF_MAX_TRAMP_LINKS) {
+		err = -E2BIG;
+		goto on_fail;
+	}
+
+	for (int kind = 0; kind < BPF_TRAMP_MAX; kind++) {
+		progs = md->bpf_progs[kind];
+		while (progs) {
+			err = bpf_gtrampoline_get_link(tr, progs->prog, progs->cookie,
+						       kind, &link);
+			if (err)
+				goto on_fail;
+
+			hlist_add_head(&link->link.tramp_hlist, &tr->progs_hlist[kind]);
+			tr->progs_cnt[kind]++;
+			progs = progs->next;
+			link->trampoline = tr;
+		}
+	}
+
+	tr->flags |= BPF_TRAMP_F_REPLACE;
+	rcu_read_unlock();
+
+	return 0;
+
+on_fail:
+	kfunc_md_put_entry(md);
+	rcu_read_unlock();
+
+	return err;
+}
+
+static void bpf_gtrampoline_replace_finish(struct bpf_trampoline *tr, int err)
+{
+	struct kfunc_md_tramp_prog *progs;
+	struct kfunc_md *md;
+
+	if (!(tr->flags & BPF_TRAMP_F_REPLACE))
+		return;
+
+	kfunc_md_lock();
+	md = kfunc_md_get_noref((unsigned long)tr->func.addr);
+	/* this shouldn't happen, as the md->tramp can only be set with
+	 * global_tr_lock.
+	 */
+	if (WARN_ON_ONCE(!md || md->tramp))
+		return;
+
+	if (err) {
+		for (int kind = 0; kind < BPF_TRAMP_MAX; kind++) {
+			progs = md->bpf_progs[kind];
+			while (progs) {
+				/* the progs is already added to trampoline
+				 * and we need clean it on this case.
+				 */
+				bpf_gtrampoline_remove(tr, progs->prog, true);
+				progs = progs->next;
+			}
+		}
+	} else {
+		md->tramp = tr;
+	}
+
+	kfunc_md_put_entry(md);
+	kfunc_md_unlock();
+}
+
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 			     struct bpf_trampoline *tr,
 			     struct bpf_prog *tgt_prog)
 {
 	int err;
 
-	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_link_prog(link, tr, tgt_prog);
-	mutex_unlock(&tr->mutex);
+	down_read(&global_tr_lock);
+
+	err = bpf_gtrampoline_replace(tr);
+	if (!err) {
+		mutex_lock(&tr->mutex);
+		err = __bpf_trampoline_link_prog(link, tr, tgt_prog);
+		mutex_unlock(&tr->mutex);
+	}
+
+	bpf_gtrampoline_replace_finish(tr, err);
+	up_read(&global_tr_lock);
+
 	return err;
 }
 
@@ -745,7 +944,7 @@ int bpf_gtrampoline_unlink_prog(struct bpf_gtramp_link *link)
 	kfunc_md_lock();
 	for (int i = 0; i < link->entry_cnt; i++) {
 		md = kfunc_md_get_noref((long)link->entries[i].addr);
-		if (WARN_ON_ONCE(!md))
+		if (WARN_ON_ONCE(!md) || md->tramp)
 			continue;
 
 		md->flags |= KFUNC_MD_FL_BPF_REMOVING;
@@ -761,13 +960,65 @@ int bpf_gtrampoline_unlink_prog(struct bpf_gtramp_link *link)
 	return err;
 }
 
+static int bpf_gtrampoline_link_tramp(struct bpf_gtramp_link_entry *entry,
+				      struct bpf_prog *prog)
+{
+	struct bpf_trampoline *tr, *new_tr = NULL;
+	struct bpf_shim_tramp_link *slink = NULL;
+	struct kfunc_md *md;
+	int err, kind;
+	u64 key;
+
+	kfunc_md_lock();
+	md = kfunc_md_get_noref((long)entry->addr);
+	kind = bpf_attach_type_to_tramp(prog);
+	if (!md->tramp) {
+		key = bpf_trampoline_compute_key(NULL, entry->attach_btf,
+						 entry->btf_id);
+		new_tr = bpf_trampoline_lookup_exist(key);
+		md->tramp = new_tr;
+	}
+
+	/* check if we need to be replaced by trampoline */
+	tr = md->tramp;
+	kfunc_md_unlock();
+	if (!tr)
+		return 0;
+
+	mutex_lock(&tr->mutex);
+	err = bpf_gtrampoline_get_link(tr, prog, entry->cookie, kind, &slink);
+	if (err)
+		goto err_out;
+
+	err = __bpf_trampoline_link_prog(&slink->link, tr, NULL);
+	if (err)
+		goto err_out;
+	mutex_unlock(&tr->mutex);
+
+	bpf_trampoline_put(new_tr);
+	/* this can only be set on the link success */
+	slink->trampoline = tr;
+	tr->flags |= BPF_TRAMP_F_REPLACE;
+
+	return 0;
+err_out:
+	mutex_unlock(&tr->mutex);
+
+	bpf_trampoline_put(new_tr);
+	if (slink) {
+		bpf_trampoline_put(tr);
+		bpf_link_free(&slink->link.link);
+	}
+	return err;
+}
+
 int bpf_gtrampoline_link_prog(struct bpf_gtramp_link *link)
 {
 	struct bpf_gtramp_link_entry *entry;
 	enum bpf_tramp_prog_type kind;
 	struct bpf_prog *prog;
 	struct kfunc_md *md;
-	bool update = false;
+	bool update = false, linked;
 	int err = 0, i;
 
 	prog = link->link.prog;
@@ -785,6 +1036,7 @@ int bpf_gtrampoline_link_prog(struct bpf_gtramp_link *link)
 		 * lock instead.
 		 */
 		kfunc_md_lock();
+		linked = false;
 		md = kfunc_md_create((long)entry->addr, entry->nr_args);
 		if (md) {
 			/* the function is not in the filter hash of gtr,
@@ -793,16 +1045,27 @@ int bpf_gtrampoline_link_prog(struct bpf_gtramp_link *link)
 			if (!md->bpf_prog_cnt)
 				update = true;
 			err = kfunc_md_bpf_link(md, prog, kind, entry->cookie);
+			if (!err)
+				linked = true;
 		} else {
 			err = -ENOMEM;
 		}
+		kfunc_md_unlock();
 
-		if (err) {
-			kfunc_md_put_entry(md);
-			kfunc_md_unlock();
-			goto on_fallback;
+		if (!err) {
+			err = bpf_gtrampoline_link_tramp(entry, prog);
+			if (!err)
+				continue;
 		}
+
+		/* on error case, fallback the md and previous */
+		kfunc_md_lock();
+		md = kfunc_md_get_noref((long)entry->addr);
+		if (linked)
+			kfunc_md_bpf_unlink(md, prog, kind);
+		kfunc_md_put_entry(md);
 		kfunc_md_unlock();
+		goto on_fallback;
 	}
 
 	if (update) {
diff --git a/kernel/trace/kfunc_md.c b/kernel/trace/kfunc_md.c
index ebb4e46d482d..5d61a8be3768 100644
--- a/kernel/trace/kfunc_md.c
+++ b/kernel/trace/kfunc_md.c
@@ -141,7 +141,8 @@ static int kfunc_md_hash_bpf_ips(void **ips)
 	for (i = 0; i < (1 << KFUNC_MD_HASH_BITS); i++) {
 		head = &kfunc_md_table[i];
 		hlist_for_each_entry(md, head, hash) {
-			if (md->bpf_prog_cnt > !!(md->flags & KFUNC_MD_FL_BPF_REMOVING))
+			if (md->bpf_prog_cnt > !!(md->flags & KFUNC_MD_FL_BPF_REMOVING) &&
+			    !md->tramp)
 				ips[c++] = (void *)md->func;
 		}
 	}
@@ -472,7 +473,8 @@ static int kfunc_md_fast_bpf_ips(void **ips)
 
 	for (i = 0; i < kfunc_mds->kfunc_md_count; i++) {
 		md = &kfunc_mds->mds[i];
-		if (md->users && md->bpf_prog_cnt > !!(md->flags & KFUNC_MD_FL_BPF_REMOVING))
+		if (md->users && md->bpf_prog_cnt > !!(md->flags & KFUNC_MD_FL_BPF_REMOVING) &&
+		    !md->tramp)
 			ips[c++] = (void *)md->func;
 	}
 	return c;
@@ -662,6 +664,9 @@ int kfunc_md_bpf_unlink(struct kfunc_md *md, struct bpf_prog *prog, int type)
 	    !md->bpf_progs[BPF_TRAMP_MODIFY_RETURN])
 		md->flags &= ~KFUNC_MD_FL_TRACING_ORIGIN;
 
+	if (!md->bpf_prog_cnt)
+		md->tramp = NULL;
+
 	return 0;
 }
 
-- 
2.39.5


