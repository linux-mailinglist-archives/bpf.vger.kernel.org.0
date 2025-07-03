Return-Path: <bpf+bounces-62256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C4AF739B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C9540809
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA6A2E5417;
	Thu,  3 Jul 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUAgMN9n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083E2E424E;
	Thu,  3 Jul 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545037; cv=none; b=i3kPF4BykSpoxABCd+Hm6H1cBqGNAKYumNXSAEvyDB9SD7WQDcknU0rhKcm6qkcg4X01kjUf+nu8VhPLh1hP7rIk6zMIN08khDNDqvUV7Vi5Vauo34HgQiRnxESHC8w/vDbO0NEP/jSPvJ07DVoCCwQAVpMUBlKprPVkpLsNzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545037; c=relaxed/simple;
	bh=vnnqUf5qv6Tzr2Px9Bg0tFIjBBXXU7CSOQUU3YHbmWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tn32EVE1u5rqxdRQK1O8Oxr6El3H5srueopINFJx+GWrd7JV2zLQ4XB5h6z2AzUW7VUEa0eQEl7Ks6Fz5djeknJCRikcDmjxfgExyLUXTfsDoNkMZc64HiMMamjgPw9O/Xd1ZqoTGefTpTNuLGm5/Hy/qiTuhSfcGhQoUuVHC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUAgMN9n; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-748e81d37a7so5532281b3a.1;
        Thu, 03 Jul 2025 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545035; x=1752149835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWuHfC4u73RCpQlHsFKd/gTTGs8e+ph3vwAME8lxRN0=;
        b=LUAgMN9nVA4lBkiBh03KUsw+ounSFm8DUB+WEV73cpQSv0shQiiLUhoyRGP4KyCMsa
         QZhaJZanSjV1m5TRb/jbixMBu8s6HOF5xg6KxtmV4JcdInt7katdHbhcXRYXHZY3JnmJ
         Q1hSs9SRKMfgIjI26MdTAzKTyzTUbKm3rXPdo2LywKqf78PFXqNJienDzSH9uqivXMkp
         yVqOyll8aFxvyHOw/NuEOiBascT1i7AktpP1FKNxiUaJLB8eaK6j7bEOqd7zFlDi5+YT
         6eKqsQ6S3Yj8MOplR8RA4Baa8O836xoD6shRxBne8P34xlSUEbhNrdRa0cZJxAcSn0uP
         2s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545035; x=1752149835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWuHfC4u73RCpQlHsFKd/gTTGs8e+ph3vwAME8lxRN0=;
        b=UIAK4a/LZEdQoWiCgqzn8HWe8liZorE5xNF/2ggsIh/eXuVIqOKpUuq9oWFH11MpGG
         3W2NIfT3bkq0UqBIOov/+KDCLUhMnI3AKE43TpYHtB9KL25qeu31if3J7cIfDnYNL24u
         cx9sp4T4mhQOhy00FCUGg86W6Mquyzj1mPp8xICOTjpnvxrnsIFchRvJ2rl8WKZeDY4U
         9mVsZqtwF+K9p6cDvo15ieLSL5IE3xZil7ZU8fV2oDmyPFLzQKqNMDlD0Q4gnWrx6mRV
         MzGATyH1ppU9d3aluCOYtVrxSN/ZWWz+wCTSa3MFmCSRZFKXUABslxFKQsCsZ02YCDBg
         PzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNhrNFzO5I7jJUuWksMteev6QfpUMuMylfOfPOj3I59ylSuIMdxA1VbcBppwIrJZglN5Np6aTdsidqG3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3h0SVDdl7t+pnKcGwDmaeG6trtuYCBcOyHtIXHaYM0J5afjQ
	qsk029ZyntQkq/R8YOjapAWBHnnw10yvkdkXPm1n/iVMCIgUfXL6hMYk
X-Gm-Gg: ASbGncveJaqN9d4738a+zqw2hM0j5iRizJrfGr+JAgw7rtBXx5xiCYvksMykCNHN9Ji
	d+KTOPQRojIlyKc/+Y/HxJ6qIcnP9J+4TT7IMxWWw2n2KUNbtB+cs9iGKFMuVAwmXlXgNnA0qRO
	v1WD7qFnDLVlTq+OZtQdiPvMOXwIRxiF+O9opYEn0mvaqCnTJPynV4bqXnqUeWKTYC2NuxDka5g
	Rx7SRH0Ij6U+LSckfPFxNR7VyMZ63ANtBYHBYjdFiAk+cci2vNfQTmW26ojpHjRhrKZEp1DYx5A
	C6ICKMHPqVN2GJrlOtZyEOvm7VK0+qauepJM8qHwWDmkStNrsUjpPv7OdrDbzzK+we4oT2nHBWw
	HfPkIWTkKJ07RFg==
X-Google-Smtp-Source: AGHT+IEKoCZ7oVsEmEszHUFJm490W+S5p0y5tPhOJuYfPbMMBy5D0dqOAxNuy2+bGklv70UWmUC2QA==
X-Received: by 2002:a05:6a00:84d:b0:749:4fd7:3513 with SMTP id d2e1a72fcca58-74ca8494c91mr3782235b3a.16.1751545034628;
        Thu, 03 Jul 2025 05:17:14 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:14 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 01/18] bpf: add function hash table for tracing-multi
Date: Thu,  3 Jul 2025 20:15:04 +0800
Message-Id: <20250703121521.1874196-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a hash table to store the BPF progs and the function metadata.
The key of this hash table is the kernel function address, and following
data is stored in the hash value:

- The BPF progs, whose type is FENTRY, FEXIT or MODIFY_RETURN. The struct
  kfunc_md_tramp_prog is introduced to store the BPF prog and the cookie,
  and makes the BPF progs of the same type a list with the "next" field.
- The kernel function address
- The kernel function arguments count
- If origin call needed

The hlist is used, and we will grow the budgets when the entries count
greater than 90% of the budget count by making it double. Meanwhile, we
will shrink the budget when the entries count less than 30% of the budget
length.

We don't use rhashtable here, as the compiler is not clever enough and it
refused to inline the hash lookup for me, which bring in addition overhead
in the following BPF global trampoline.

The release of the metadata is controlled by the percpu ref and RCU
together, and have similar logic to the release of bpf trampoline image in
bpf_tramp_image_put().

The whole function will be used in the next patch.

Link: https://lore.kernel.org/bpf/CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAADnVQ+G+mQPJ+O1Oc9+UW=J17CGNC5B=usCmUDxBA-ze+gZGw@mail.gmail.com/
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- implement the function metadata with hash table, as Alexei advised
---
 include/linux/kfunc_md.h |  91 ++++++++++
 kernel/bpf/Makefile      |   1 +
 kernel/bpf/kfunc_md.c    | 352 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 444 insertions(+)
 create mode 100644 include/linux/kfunc_md.h
 create mode 100644 kernel/bpf/kfunc_md.c

diff --git a/include/linux/kfunc_md.h b/include/linux/kfunc_md.h
new file mode 100644
index 000000000000..1a766aa160f5
--- /dev/null
+++ b/include/linux/kfunc_md.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KFUNC_MD_H
+#define _LINUX_KFUNC_MD_H
+
+#include <linux/kernel.h>
+#include <linux/bpf.h>
+#include <linux/rhashtable.h>
+
+struct kfunc_md_tramp_prog {
+	struct kfunc_md_tramp_prog *next;
+	struct bpf_prog *prog;
+	u64 cookie;
+	struct rcu_head rcu;
+};
+
+struct kfunc_md {
+	struct hlist_node hash;
+	struct rcu_head rcu;
+	unsigned long func;
+	struct kfunc_md_tramp_prog *bpf_progs[BPF_TRAMP_MAX];
+	struct percpu_ref pcref;
+	u16 users;
+	bool bpf_origin_call;
+	u8 bpf_prog_cnt;
+	u8 nr_args;
+};
+
+struct kfunc_md_array {
+	atomic_t used;
+	struct rcu_head rcu;
+	int hash_bits;
+	struct hlist_head mds[];
+};
+
+extern struct kfunc_md_array __rcu *kfunc_mds;
+
+struct kfunc_md *kfunc_md_create(unsigned long ip, int nr_args);
+struct kfunc_md *kfunc_md_get(unsigned long ip);
+void kfunc_md_put(struct kfunc_md *meta);
+bool kfunc_md_arch_support(int *insn, int *data);
+
+int kfunc_md_bpf_ips(void ***ips, int nr_args);
+int kfunc_md_bpf_unlink(struct kfunc_md *md, struct bpf_prog *prog, int type);
+int kfunc_md_bpf_link(struct kfunc_md *md, struct bpf_prog *prog, int type,
+		      u64 cookie);
+
+static __always_inline notrace struct hlist_head *
+kfunc_md_hash_head(struct kfunc_md_array *mds, unsigned long ip)
+{
+	return &mds->mds[hash_ptr((void *)ip, mds->hash_bits)];
+}
+
+static __always_inline notrace struct kfunc_md *
+__kfunc_md_get(struct kfunc_md_array *mds, unsigned long ip)
+{
+	struct hlist_head *head;
+	struct kfunc_md *md;
+
+	head = kfunc_md_hash_head(mds, ip);
+	hlist_for_each_entry_rcu_notrace(md, head, hash) {
+		if (md->func == ip)
+			return md;
+	}
+
+	return NULL;
+}
+
+/* This function will be called in the bpf global trampoline, so it can't
+ * be traced, and the "notrace" is necessary.
+ */
+static __always_inline notrace struct kfunc_md *kfunc_md_get_rcu(unsigned long ip)
+{
+	return __kfunc_md_get(rcu_dereference_raw(kfunc_mds), ip);
+}
+
+static __always_inline notrace void kfunc_md_enter(struct kfunc_md *md)
+{
+	percpu_ref_get(&md->pcref);
+}
+
+static __always_inline notrace void kfunc_md_exit(struct kfunc_md *md)
+{
+	percpu_ref_put(&md->pcref);
+}
+
+static inline void kfunc_md_put_ip(unsigned long ip)
+{
+	kfunc_md_put(kfunc_md_get(ip));
+}
+
+#endif
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 3a335c50e6e3..a8a404e82e3d 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
+obj-$(CONFIG_BPF_JIT) += kfunc_md.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o
 ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
 obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
diff --git a/kernel/bpf/kfunc_md.c b/kernel/bpf/kfunc_md.c
new file mode 100644
index 000000000000..152d6741d06d
--- /dev/null
+++ b/kernel/bpf/kfunc_md.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+
+#include <linux/slab.h>
+#include <linux/memory.h>
+#include <linux/rcupdate.h>
+#include <linux/ftrace.h>
+#include <linux/rhashtable.h>
+#include <linux/kfunc_md.h>
+
+#include <uapi/linux/bpf.h>
+
+#define MIN_KFUNC_MD_ARRAY_BITS 4
+struct kfunc_md_array default_mds = {
+	.used = ATOMIC_INIT(0),
+	.hash_bits = MIN_KFUNC_MD_ARRAY_BITS,
+	.mds = {
+		[0 ... ((1 << MIN_KFUNC_MD_ARRAY_BITS) - 1)] = HLIST_HEAD_INIT,
+	},
+};
+struct kfunc_md_array __rcu *kfunc_mds = &default_mds;
+EXPORT_SYMBOL_GPL(kfunc_mds);
+
+static DEFINE_MUTEX(kfunc_md_mutex);
+
+static int kfunc_md_array_inc(void);
+
+static void kfunc_md_release_rcu(struct rcu_head *rcu)
+{
+	struct kfunc_md *md;
+
+	md = container_of(rcu, struct kfunc_md, rcu);
+	/* Step 4, free the md */
+	kfree(md);
+}
+
+static void kfunc_md_release_rcu_tasks(struct rcu_head *rcu)
+{
+	struct kfunc_md *md;
+
+	md = container_of(rcu, struct kfunc_md, rcu);
+	/* Step 3, wait for the nornal progs and bfp_global_caller to finish */
+	call_rcu_tasks(&md->rcu, kfunc_md_release_rcu);
+}
+
+static void kfunc_md_release(struct percpu_ref *pcref)
+{
+	struct kfunc_md *md;
+
+	md = container_of(pcref, struct kfunc_md, pcref);
+	percpu_ref_exit(&md->pcref);
+
+	/* Step 2, wait for sleepable progs to finish. */
+	call_rcu_tasks_trace(&md->rcu, kfunc_md_release_rcu_tasks);
+}
+
+struct kfunc_md *kfunc_md_get(unsigned long ip)
+{
+	struct kfunc_md_array *mds;
+	struct kfunc_md *md;
+
+	rcu_read_lock();
+	mds = rcu_dereference(kfunc_mds);
+	md = __kfunc_md_get(mds, ip);
+	rcu_read_unlock();
+
+	return md;
+}
+EXPORT_SYMBOL_GPL(kfunc_md_get);
+
+static struct kfunc_md *__kfunc_md_create(struct kfunc_md_array *mds, unsigned long ip,
+					  int nr_args)
+{
+	struct kfunc_md *md = __kfunc_md_get(mds, ip);
+	int err;
+
+	if (md) {
+		md->users++;
+		return md;
+	}
+
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return NULL;
+
+	md->users = 1;
+	md->func = ip;
+	md->nr_args = nr_args;
+
+	err = percpu_ref_init(&md->pcref, kfunc_md_release, 0, GFP_KERNEL);
+	if (err) {
+		kfree(md);
+		return NULL;
+	}
+
+	hlist_add_head_rcu(&md->hash, kfunc_md_hash_head(mds, ip));
+	atomic_inc(&mds->used);
+
+	return md;
+}
+
+struct kfunc_md *kfunc_md_create(unsigned long ip, int nr_args)
+{
+	struct kfunc_md *md = NULL;
+
+	mutex_lock(&kfunc_md_mutex);
+
+	if (kfunc_md_array_inc())
+		goto out;
+
+	md = __kfunc_md_create(kfunc_mds, ip, nr_args);
+out:
+	mutex_unlock(&kfunc_md_mutex);
+
+	return md;
+}
+EXPORT_SYMBOL_GPL(kfunc_md_create);
+
+static int kfunc_md_array_adjust(bool inc)
+{
+	struct kfunc_md_array *new_mds, *old_mds;
+	struct kfunc_md *md, *new_md;
+	struct hlist_node *n;
+	int size, hash_bits, i;
+
+	hash_bits = kfunc_mds->hash_bits;
+	hash_bits += inc ? 1 : -1;
+
+	size = sizeof(*new_mds) + sizeof(struct hlist_head) * (1 << hash_bits);
+	new_mds = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!new_mds)
+		return -ENOMEM;
+
+	new_mds->hash_bits = hash_bits;
+	for (i = 0; i < (1 << new_mds->hash_bits); i++)
+		INIT_HLIST_HEAD(&new_mds->mds[i]);
+
+	/* copy all the mds from kfunc_mds to new_mds */
+	for (i = 0; i < (1 << kfunc_mds->hash_bits); i++) {
+		hlist_for_each_entry(md, &kfunc_mds->mds[i], hash) {
+			new_md = __kfunc_md_create(new_mds, md->func, md->nr_args);
+			if (!new_md)
+				goto err_out;
+
+			new_md->bpf_prog_cnt = md->bpf_prog_cnt;
+			new_md->bpf_origin_call = md->bpf_origin_call;
+			new_md->users = md->users;
+
+			memcpy(new_md->bpf_progs, md->bpf_progs, sizeof(md->bpf_progs));
+		}
+	}
+
+	old_mds = kfunc_mds;
+	rcu_assign_pointer(kfunc_mds, new_mds);
+	synchronize_rcu();
+
+	/* free all the mds in the old_mds. See kfunc_md_put() for the
+	 * complete release process.
+	 */
+	for (i = 0; i < (1 << old_mds->hash_bits); i++) {
+		hlist_for_each_entry_safe(md, n, &old_mds->mds[i], hash) {
+			percpu_ref_kill(&md->pcref);
+			hlist_del(&md->hash);
+		}
+	}
+
+	if (old_mds != &default_mds)
+		kfree_rcu(old_mds, rcu);
+
+	return 0;
+
+err_out:
+	for (i = 0; i < (1 << new_mds->hash_bits); i++) {
+		hlist_for_each_entry_safe(md, n, &new_mds->mds[i], hash) {
+			percpu_ref_exit(&md->pcref);
+			hlist_del(&md->hash);
+			kfree(md);
+		}
+	}
+	return -ENOMEM;
+}
+
+static int kfunc_md_array_inc(void)
+{
+	/* increase the hash table if greater than 90% */
+	if (atomic_read(&kfunc_mds->used) * 10 < (1 << (kfunc_mds->hash_bits)) * 9)
+		return 0;
+	return kfunc_md_array_adjust(true);
+}
+
+static int kfunc_md_array_dec(void)
+{
+	/* decrease the hash table if less than 30%. */
+	if (atomic_read(&kfunc_mds->used) * 10 > (1 << (kfunc_mds->hash_bits)) * 3)
+		return 0;
+
+	if (kfunc_mds->hash_bits <= MIN_KFUNC_MD_ARRAY_BITS)
+		return 0;
+
+	return kfunc_md_array_adjust(false);
+}
+
+void kfunc_md_put(struct kfunc_md *md)
+{
+	if (!md || WARN_ON_ONCE(md->users <= 0))
+		return;
+
+	mutex_lock(&kfunc_md_mutex);
+	md->users--;
+	if (md->users > 0)
+		goto out_unlock;
+
+	hlist_del_rcu(&md->hash);
+	atomic_dec(&kfunc_mds->used);
+	/* Step 1, use percpu_ref_kill to wait for the origin function to
+	 * finish. See kfunc_md_release for step 2.
+	 */
+	percpu_ref_kill(&md->pcref);
+	kfunc_md_array_dec();
+
+out_unlock:
+	mutex_unlock(&kfunc_md_mutex);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_put);
+
+static bool kfunc_md_bpf_check(struct kfunc_md *md, int nr_args)
+{
+	return md->bpf_prog_cnt && md->nr_args == nr_args;
+}
+
+int kfunc_md_bpf_ips(void ***ips_ptr, int nr_args)
+{
+	struct kfunc_md *md;
+	int count, res = 0;
+	void **ips;
+
+	mutex_lock(&kfunc_md_mutex);
+	count = atomic_read(&kfunc_mds->used);
+	if (count <= 0)
+		goto out_unlock;
+
+	ips = kmalloc_array(count, sizeof(*ips), GFP_KERNEL);
+	if (!ips) {
+		res = -ENOMEM;
+		goto out_unlock;
+	}
+
+	for (int j = 0; j < (1 << kfunc_mds->hash_bits); j++) {
+		hlist_for_each_entry(md, &kfunc_mds->mds[j], hash) {
+			if (kfunc_md_bpf_check(md, nr_args))
+				ips[res++] = (void *)md->func;
+		}
+	}
+	*ips_ptr = ips;
+
+out_unlock:
+	mutex_unlock(&kfunc_md_mutex);
+
+	return res;
+}
+
+int kfunc_md_bpf_link(struct kfunc_md *md, struct bpf_prog *prog, int type,
+		      u64 cookie)
+{
+	struct kfunc_md_tramp_prog *tramp_prog, **last;
+	int err = 0;
+
+	mutex_lock(&kfunc_md_mutex);
+	tramp_prog = md->bpf_progs[type];
+	/* check if the prog is already linked */
+	while (tramp_prog) {
+		if (tramp_prog->prog == prog) {
+			err = -EEXIST;
+			goto out_unlock;
+		}
+		tramp_prog = tramp_prog->next;
+	}
+
+	tramp_prog = kmalloc(sizeof(*tramp_prog), GFP_KERNEL);
+	if (!tramp_prog) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	WRITE_ONCE(tramp_prog->prog, prog);
+	WRITE_ONCE(tramp_prog->cookie, cookie);
+	WRITE_ONCE(tramp_prog->next, NULL);
+
+	/* add the new prog to the list tail */
+	last = &md->bpf_progs[type];
+	while (*last)
+		last = &(*last)->next;
+
+	WRITE_ONCE(*last, tramp_prog);
+
+	md->bpf_prog_cnt++;
+	if (type == BPF_TRAMP_FEXIT || type == BPF_TRAMP_MODIFY_RETURN)
+		md->bpf_origin_call = true;
+
+out_unlock:
+	mutex_unlock(&kfunc_md_mutex);
+	return err;
+}
+
+static void link_free_rcu(struct rcu_head *rcu)
+{
+	struct kfunc_md_tramp_prog *tramp_prog;
+
+	tramp_prog = container_of(rcu, struct kfunc_md_tramp_prog, rcu);
+	/* Step 3, free the tramp_prog */
+	kfree(tramp_prog);
+}
+
+static void link_free_rcu_tasks(struct rcu_head *rcu)
+{
+	struct kfunc_md_tramp_prog *tramp_prog;
+
+	tramp_prog = container_of(rcu, struct kfunc_md_tramp_prog, rcu);
+	/* Step 2, wait for normal progs finish, which means all the progs
+	 * in the list finished.
+	 */
+	call_rcu_tasks(&tramp_prog->rcu, link_free_rcu);
+}
+
+int kfunc_md_bpf_unlink(struct kfunc_md *md, struct bpf_prog *prog, int type)
+{
+	struct kfunc_md_tramp_prog *cur, **prev, **progs;
+
+	mutex_lock(&kfunc_md_mutex);
+	progs = md->bpf_progs;
+	prev = progs + type;
+	while (*prev && (*prev)->prog != prog)
+		prev = &(*prev)->next;
+
+	cur = *prev;
+	if (!cur) {
+		mutex_unlock(&kfunc_md_mutex);
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(*prev, cur->next);
+	WRITE_ONCE(md->bpf_origin_call, progs[BPF_TRAMP_MODIFY_RETURN] ||
+					progs[BPF_TRAMP_FEXIT]);
+
+	md->bpf_prog_cnt--;
+
+	/* Step 1, wait for sleepable progs to finish. */
+	call_rcu_tasks_trace(&cur->rcu, link_free_rcu_tasks);
+	mutex_unlock(&kfunc_md_mutex);
+
+	return 0;
+}
-- 
2.39.5


