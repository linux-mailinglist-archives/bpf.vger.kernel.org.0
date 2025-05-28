Return-Path: <bpf+bounces-59089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C4AC6044
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1898316DFED
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E01EB9FA;
	Wed, 28 May 2025 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKSqJ2qw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D31195FE8;
	Wed, 28 May 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404182; cv=none; b=c2tze6T9z3d+wRYohi7V3ulY88YCO2IoaAqNlcD93iLiqNTK9CUg4Y4S/BfUCPefxy/4CBH/pN3/07vPN/9g7nj4uE4PaEv3u539k1jk5gYh5X/iwRPkVIuETR6a0yNrCDUIN1JSJ18Liu+Dr10tZJiQ6zTw8jUHp+qyu7pf6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404182; c=relaxed/simple;
	bh=T7NssPaqVeOHvj7JvgtrQS8i+xBkkBIwEC99uOHnS98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gM6VrjgARgZqiOD8qjow8Yf2Zx2kOgS+e33DgAWf1WG9PkkdqvWR8WI8OJdDzxKFsOJl8Z/gn3WRmfohg8JPQZSfOXLxGEsO+XynRL9SZwPWf9/yJsC4v5eF1BQEhwhhUTxZj1rAkWfbW/ZtY1E2/0rlgyTXRIGNWL6eG5Sb/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKSqJ2qw; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2347012f81fso30641275ad.2;
        Tue, 27 May 2025 20:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404179; x=1749008979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTmlP++5ctATzqFYw3YvfkZEdLmcOEH5s5X3SK2U8so=;
        b=YKSqJ2qw5JXi4oD2RhLnIgA2IQIcjEGC3jOzVttmrhWEjZM8MUWTi/blVtLewzDBNx
         pyg5HN+kD7il0JVtNVcQQmj0W99x0FvkqH1Hy+Oue6K/Jkixo19Rl3JSNaPmIKBJt+wv
         gMNlfSsWMCdjps1pCN8TWQpzKug2D9KQnHE7id8DlunHY0OiukgbfpRfrKe93Xoe7Nd1
         VVobEYZ3srwrsnpYizMstc4YGy1SLmsHXtqwe0/TkTlK1MHbcVb021DTDTGyqHCnVFMb
         CAwMDckv9y9rs3kerYa9Ww1bxi73hNMcPMYS8G95n493kKFw6Ei42bnWe7LbCYN0uptz
         7bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404179; x=1749008979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTmlP++5ctATzqFYw3YvfkZEdLmcOEH5s5X3SK2U8so=;
        b=rzasdIqwYga+vdqFFuN3kNXV/43j6qABfVdKRorYBOncFF8dSC2dqDhVfYJj8scKMu
         f2n0aaZNi0zRkaGjuxajcpsZPy5msVDcr0UhHrDVboImbhGRrS24FEjQuMjz1wALqRgV
         /P4t8TiJ55hkomh6uiG94wQ6xp6rH0UL9Jc+HHsmW/bpFpr/4nqhVFrL6vWCjq6bgQUv
         Ni2E5g+wFgQ9Ur0jmPEyMl6OdxB7lV2+hzqZudlwuqKi3lVl0FpJnBaJ7gKnYANWG8ah
         9Aegg372xKci4fXL/9uzB/C5NTLdnqGIp9O6YSR5p78CEjkbt0ArxZYI672Llb/UMK7w
         CBYA==
X-Forwarded-Encrypted: i=1; AJvYcCWhyAVyGfouwoKnoloyyQ45Ju4YpvxtU0gY8ZjT0ZYdARYaSFmNUxSZ+q6Bb1iLPcJ0soKX05Bd/MrU6Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFPj97DMXrHZCcdm0LUaVIA5sKrUyZOUm7I+1/OHYUcFC+VJg
	XTMV8d0krd5Q3zR2LxUdowpf6hMxlrrgCTdG8w8yoSdWnf24xU0fgRWL
X-Gm-Gg: ASbGnct1YkKOswQF4s95Wf7w1l26NFIuc5ITcuVm5P0SQWefJ2xQPDCXSxqWO5yxaVj
	oQQVSjlsJdctRMU00lLKOyGbVmkqd/z6EV5a0Kf3TQVfMdrk7ZtTCVGX5AhRUr/0Ne3gfQQ5o+f
	lnrH1YXYqPbeN7bctDAkizqvg1pWB3TPFe61I8TPjf/rJtK8ECTX8XRehhjvF62FDvZB5SD+N94
	lWwvIyNii3Qc7s/yy3T4Ljic0ZAw/1zzGxIGHJjdqYFx3YEt1vUBeTUa7NlPtTy6H+skoGxzAer
	3De3sdN66dPVT4RXPxb3ANL+nD5dVuVcZLhtgGW9tM1/vR3JPxaekN7Jocd6KPuEHbNn
X-Google-Smtp-Source: AGHT+IF8gNtZfMhjGeixcimdN3aY3HBVzUm76AiS8MOrlteDo7Y0hyQxCu0Qwd0OXbZ2LWMAbnqR/Q==
X-Received: by 2002:a17:903:2283:b0:234:9092:9dda with SMTP id d9443c01a7336-23490929e16mr112651645ad.24.1748404178596;
        Tue, 27 May 2025 20:49:38 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:38 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 01/25] add per-function metadata storage support
Date: Wed, 28 May 2025 11:46:48 +0800
Message-Id: <20250528034712.138701-2-dongml2@chinatelecom.cn>
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

For now, there isn't a way to set and get per-function metadata with
a low overhead, which is not convenient for some situations. Take
BPF trampoline for example, we need to create a trampoline for each
kernel function, as we have to store some information of the function
to the trampoline, such as BPF progs, function arg count, etc. The
performance overhead and memory consumption can be higher to create
these trampolines. With the supporting of per-function metadata storage,
we can store these information to the metadata, and create a global BPF
trampoline for all the kernel functions. In the global trampoline, we
get the information that we need from the function metadata through the
ip (function address) with almost no overhead.

Another beneficiary can be fprobe. For now, fprobe will add all the
functions that it hooks into a hash table. And in fprobe_entry(), it will
lookup all the handlers of the function in the hash table. The performance
can suffer from the hash table lookup. We can optimize it by adding the
handler to the function metadata instead.

Support per-function metadata storage in the function padding, and
previous discussion can be found in [1]. Generally speaking, we have two
way to implement this feature:

1. Create a function metadata array, and prepend a insn which can hold
the index of the function metadata in the array. And store the insn to
the function padding.

2. Allocate the function metadata with kmalloc(), and prepend a insn which
hold the pointer of the metadata. And store the insn to the function
padding.

Compared with way 2, way 1 consume less space, but we need to do more work
on the global function metadata array. And we implement this function in
the way 1.

Link: https://lore.kernel.org/bpf/CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com/ [1]
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/kfunc_md.h |  44 +++
 kernel/trace/Makefile    |   1 +
 kernel/trace/kfunc_md.c  | 566 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 611 insertions(+)
 create mode 100644 include/linux/kfunc_md.h
 create mode 100644 kernel/trace/kfunc_md.c

diff --git a/include/linux/kfunc_md.h b/include/linux/kfunc_md.h
new file mode 100644
index 000000000000..21c0b879cc03
--- /dev/null
+++ b/include/linux/kfunc_md.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KFUNC_MD_H
+#define _LINUX_KFUNC_MD_H
+
+#define KFUNC_MD_FL_DEAD		(1 << 0) /* the md shouldn't be reused */
+
+#ifndef __ASSEMBLER__
+
+#include <linux/kernel.h>
+#include <linux/bpf.h>
+
+struct kfunc_md_array;
+
+struct kfunc_md {
+#ifndef CONFIG_FUNCTION_METADATA_PADDING
+	/* this is used for the hash table mode */
+	struct hlist_node hash;
+	/* this is used for table mode */
+	struct rcu_head rcu;
+#endif
+	unsigned long func;
+#ifdef CONFIG_FUNCTION_METADATA
+	/* the array is used for the fast mode */
+	struct kfunc_md_array *array;
+#endif
+	struct percpu_ref pcref;
+	u32 flags;
+	u16 users;
+	u8 nr_args;
+};
+
+struct kfunc_md *kfunc_md_get(unsigned long ip);
+struct kfunc_md *kfunc_md_get_noref(unsigned long ip);
+struct kfunc_md *kfunc_md_create(unsigned long ip, int nr_args);
+void kfunc_md_put_entry(struct kfunc_md *meta);
+void kfunc_md_put(unsigned long ip);
+void kfunc_md_lock(void);
+void kfunc_md_unlock(void);
+void kfunc_md_exit(struct kfunc_md *md);
+void kfunc_md_enter(struct kfunc_md *md);
+bool kfunc_md_arch_support(int *insn, int *data);
+
+#endif
+#endif
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..d8c19ff1e55e 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_TRACING) += trace_seq.o
 obj-$(CONFIG_TRACING) += trace_stat.o
 obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING) += 	pid_list.o
+obj-$(CONFIG_TRACING) += kfunc_md.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_SYNTH_EVENT_GEN_TEST) += synth_event_gen_test.o
diff --git a/kernel/trace/kfunc_md.c b/kernel/trace/kfunc_md.c
new file mode 100644
index 000000000000..9571081f6560
--- /dev/null
+++ b/kernel/trace/kfunc_md.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+
+#include <linux/slab.h>
+#include <linux/memory.h>
+#include <linux/rcupdate.h>
+#include <linux/ftrace.h>
+#include <linux/kfunc_md.h>
+
+#include <uapi/linux/bpf.h>
+
+#ifndef CONFIG_FUNCTION_METADATA_PADDING
+
+DEFINE_STATIC_KEY_TRUE(kfunc_md_use_padding);
+static int __insn_offset, __data_offset;
+#define insn_offset	__insn_offset
+#define data_offset	__data_offset
+
+#define KFUNC_MD_HASH_BITS	10
+static struct hlist_head kfunc_md_table[1 << KFUNC_MD_HASH_BITS];
+
+#else
+#define insn_offset	KFUNC_MD_INSN_OFFSET
+#define data_offset	KFUNC_MD_DATA_OFFSET
+#endif
+
+#define insn_size	KFUNC_MD_INSN_SIZE
+
+#define ENTRIES_PER_PAGE (PAGE_SIZE / sizeof(struct kfunc_md))
+
+#define KFUNC_MD_ARRAY_FL_DEAD 0
+
+struct kfunc_md_array {
+	struct kfunc_md *mds;
+	u32 kfunc_md_count;
+	unsigned long flags;
+	atomic_t kfunc_md_used;
+	union {
+		struct work_struct work;
+		struct rcu_head rcu;
+	};
+};
+
+static struct kfunc_md_array empty_array = {
+	.mds = NULL,
+	.kfunc_md_count = 0,
+};
+/* used for the padding-based function metadata */
+static struct kfunc_md_array __rcu *kfunc_mds = &empty_array;
+
+/* any function metadata write should hold this lock */
+static DEFINE_MUTEX(kfunc_md_mutex);
+
+
+#ifndef CONFIG_FUNCTION_METADATA_PADDING
+
+static struct hlist_head *kfunc_md_hash_head(unsigned long ip)
+{
+	return &kfunc_md_table[hash_ptr((void *)ip, KFUNC_MD_HASH_BITS)];
+}
+
+static struct kfunc_md *kfunc_md_hash_get(unsigned long ip)
+{
+	struct hlist_head *head;
+	struct kfunc_md *md;
+
+	head = kfunc_md_hash_head(ip);
+	hlist_for_each_entry_rcu_notrace(md, head, hash) {
+		if (md->func == ip)
+			return md;
+	}
+
+	return NULL;
+}
+
+static void kfunc_md_hash_release(struct percpu_ref *pcref)
+{
+	struct kfunc_md *md;
+
+	md = container_of(pcref, struct kfunc_md, pcref);
+	kfree_rcu(md, rcu);
+}
+
+static struct kfunc_md *kfunc_md_hash_create(unsigned long ip, int nr_args)
+{
+	struct kfunc_md *md = kfunc_md_hash_get(ip);
+	struct hlist_head *head;
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
+	err = percpu_ref_init(&md->pcref, kfunc_md_hash_release, 0, GFP_KERNEL);
+	if (err) {
+		kfree(md);
+		return NULL;
+	}
+
+	head = kfunc_md_hash_head(ip);
+	hlist_add_tail_rcu(&md->hash, head);
+	atomic_inc(&kfunc_mds->kfunc_md_used);
+
+	return md;
+}
+
+static void kfunc_md_hash_put(struct kfunc_md *md)
+{
+	if (WARN_ON_ONCE(md->users <= 0))
+		return;
+
+	md->users--;
+	if (md->users > 0)
+		return;
+
+	hlist_del_rcu(&md->hash);
+	percpu_ref_kill(&md->pcref);
+	atomic_dec(&kfunc_mds->kfunc_md_used);
+}
+
+static bool kfunc_md_fast(void)
+{
+	return static_branch_likely(&kfunc_md_use_padding);
+}
+#else
+
+static void kfunc_md_hash_put(struct kfunc_md *md)
+{
+}
+
+static struct kfunc_md *kfunc_md_hash_get(unsigned long ip)
+{
+	return NULL;
+}
+
+static struct kfunc_md *kfunc_md_hash_create(unsigned long ip, int nr_args)
+{
+	return NULL;
+}
+
+#define kfunc_md_fast() 1
+#endif /* CONFIG_FUNCTION_METADATA_PADDING */
+
+#ifdef CONFIG_FUNCTION_METADATA
+static void kfunc_md_release(struct percpu_ref *pcref);
+
+static __always_inline u32 kfunc_md_get_index(unsigned long ip)
+{
+	return *(u32 *)(ip - data_offset);
+}
+
+static struct kfunc_md_array *kfunc_md_array_alloc(struct kfunc_md_array *old)
+{
+	struct kfunc_md_array *new_mds;
+	int len = old->kfunc_md_count;
+	struct kfunc_md *md;
+	int err, i;
+
+	new_mds = kmalloc(sizeof(*new_mds), __GFP_ZERO | GFP_KERNEL);
+	if (!new_mds)
+		return NULL;
+
+	/* if the length of old kfunc md array is zero, we make ENTRIES_PER_PAGE
+	 * as the default size of the new kfunc md array.
+	 */
+	new_mds->kfunc_md_count = (len * 2) ?: ENTRIES_PER_PAGE;
+	new_mds->mds = kvmalloc_array(new_mds->kfunc_md_count, sizeof(*new_mds->mds),
+				      __GFP_ZERO | GFP_KERNEL);
+	if (!new_mds->mds) {
+		kfree(new_mds);
+		return NULL;
+	}
+
+	if (len) {
+		memcpy(new_mds->mds, old->mds, sizeof(*new_mds->mds) * len);
+		new_mds->kfunc_md_used = old->kfunc_md_used;
+	}
+
+	for (i = 0; i < new_mds->kfunc_md_count; i++) {
+		md = &new_mds->mds[i];
+
+		if (md->users) {
+			err = percpu_ref_init(&md->pcref, kfunc_md_release,
+					      0, GFP_KERNEL);
+			if (err)
+				goto pcref_fail;
+			md->array = new_mds;
+		}
+	}
+
+	return new_mds;
+
+pcref_fail:
+	for (int j = 0; j < i; j++) {
+		md = &new_mds->mds[j];
+		if (md->users)
+			percpu_ref_exit(&md->pcref);
+	}
+	kvfree(new_mds->mds);
+	kfree(new_mds);
+	return NULL;
+}
+
+static void kfunc_md_array_release_deferred(struct work_struct *work)
+{
+	struct kfunc_md_array *mds;
+
+	mds = container_of(work, struct kfunc_md_array, work);
+	/* the kfunc metadata array is not used anywhere, we can free it
+	 * directly.
+	 */
+	if (atomic_read(&mds->kfunc_md_used) == 0) {
+		for (int i = 0; i < mds->kfunc_md_count; i++) {
+			if (mds->mds[i].users)
+				percpu_ref_exit(&mds->mds[i].pcref);
+		}
+
+		kvfree(mds->mds);
+		kfree_rcu(mds, rcu);
+		return;
+	}
+
+	for (int i = 0; i < mds->kfunc_md_count; i++) {
+		if (mds->mds[i].users)
+			percpu_ref_kill(&mds->mds[i].pcref);
+	}
+}
+
+static void kfunc_md_array_release(struct rcu_head *rcu)
+{
+	struct kfunc_md_array *mds;
+
+	mds = container_of(rcu, struct kfunc_md_array, rcu);
+	if (mds == &empty_array)
+		return;
+
+	INIT_WORK(&mds->work, kfunc_md_array_release_deferred);
+	schedule_work(&mds->work);
+}
+
+static void kfunc_md_release(struct percpu_ref *pcref)
+{
+	struct kfunc_md *md;
+
+	md = container_of(pcref, struct kfunc_md, pcref);
+	if (test_bit(KFUNC_MD_ARRAY_FL_DEAD, &md->array->flags)) {
+		if (atomic_dec_and_test(&md->array->kfunc_md_used)) {
+			call_rcu_tasks(&md->array->rcu, kfunc_md_array_release);
+			return;
+		}
+	}
+	percpu_ref_exit(&md->pcref);
+	/* clear the flags, so it can be reused */
+	md->flags = 0;
+}
+
+static int kfunc_md_text_poke(unsigned long ip, void *insn, void *nop)
+{
+	void *target;
+	int ret = 0;
+	u8 *prog;
+
+	target = (void *)(ip - insn_offset);
+	mutex_lock(&text_mutex);
+	if (insn) {
+		if (!memcmp(target, insn, insn_size))
+			goto out;
+
+		if (memcmp(target, nop, insn_size)) {
+			ret = -EBUSY;
+			goto out;
+		}
+		prog = insn;
+	} else {
+		if (!memcmp(target, nop, insn_size))
+			goto out;
+		prog = nop;
+	}
+
+	ret = kfunc_md_arch_poke(target, prog, insn_offset);
+out:
+	mutex_unlock(&text_mutex);
+	return ret;
+}
+
+/* Get next usable function metadata. On success, return the usable
+ * kfunc_md and store the index of it to *index. If no usable kfunc_md is
+ * found in kfunc_mds, a larger array will be allocated.
+ */
+static struct kfunc_md *kfunc_md_fast_next(u32 *index)
+{
+	struct kfunc_md_array *mds, *new_mds;
+	struct kfunc_md *md;
+	u32 i;
+
+	mds = kfunc_mds;
+do_retry:
+	if (likely(atomic_read(&mds->kfunc_md_used) < mds->kfunc_md_count)) {
+		/* maybe we can manage the used function metadata entry
+		 * with a bit map ?
+		 */
+		for (i = 0; i < mds->kfunc_md_count; i++) {
+			md = &mds->mds[i];
+			if (!md->users && !(md->flags & KFUNC_MD_FL_DEAD)) {
+				atomic_inc(&mds->kfunc_md_used);
+				*index = i;
+				return md;
+			}
+		}
+	}
+
+	/* no available function metadata, so allocate a bigger function
+	 * metadata array.
+	 *
+	 * TODO: we increase the array length here, and we also need to
+	 * shrink it somewhere.
+	 */
+	new_mds = kfunc_md_array_alloc(mds);
+	if (!new_mds)
+		return NULL;
+
+	rcu_assign_pointer(kfunc_mds, new_mds);
+	/* release of the old kfunc metadata array.
+	 *
+	 * First step, set KFUNC_MD_ARRAY_FL_DEAD on it. The old mds will
+	 * not be accessed by anyone anymore from now on.
+	 *
+	 * Second step, call rcu to wakeup the work queue to call
+	 * kfunc_md_array_release_deferred() in kfunc_md_array_release.
+	 *
+	 * Third step, kill all the percpu ref of the mds in
+	 * kfunc_md_array_release_deferred().
+	 *
+	 * Fourth step, decrease the mds->kfunc_md_used in the callback of
+	 * the percpu ref. And the callback is kfunc_md_release().
+	 *
+	 * Fifth step, wakeup the work queue to call
+	 * kfunc_md_array_release_deferred() if old->kfunc_md_used is decreased
+	 * to 0, and the old mds will be freed.
+	 */
+	set_bit(KFUNC_MD_ARRAY_FL_DEAD, &mds->flags);
+	call_rcu_tasks(&mds->rcu, kfunc_md_array_release);
+	mds = new_mds;
+
+	goto do_retry;
+}
+
+static void kfunc_md_fast_put(struct kfunc_md *md)
+{
+	u8 nop_insn[insn_size];
+
+	if (WARN_ON_ONCE(md->users <= 0))
+		return;
+
+	md->users--;
+	if (md->users > 0)
+		return;
+
+	if (WARN_ON_ONCE(!kfunc_md_arch_exist(md->func, insn_offset)))
+		return;
+
+	atomic_dec(&md->array->kfunc_md_used);
+	kfunc_md_arch_nops(nop_insn);
+	/* release the metadata by recovering the function padding to NOPS */
+	kfunc_md_text_poke(md->func, NULL, nop_insn);
+	/* mark it as dead, so it will not be reused before we release it
+	 * fully in kfunc_md_release().
+	 */
+	md->flags |= KFUNC_MD_FL_DEAD;
+	percpu_ref_kill(&md->pcref);
+}
+
+/* Get a exist metadata by the function address, and NULL will be returned
+ * if not exist.
+ *
+ * NOTE: rcu lock or kfunc_md_lock should be held during reading the metadata,
+ * and kfunc_md_lock should be held if writing happens.
+ */
+static struct kfunc_md *kfunc_md_fast_get(unsigned long ip)
+{
+	struct kfunc_md *md;
+	u32 index;
+
+	if (kfunc_md_arch_exist(ip, insn_offset)) {
+		index = kfunc_md_get_index(ip);
+		md = READ_ONCE(kfunc_mds->mds) + index;
+		return md;
+	}
+	return NULL;
+}
+
+/* Get a exist metadata by the function address, and create one if not
+ * exist. Reference of the metadata will increase 1.
+ *
+ * NOTE: always call this function with kfunc_md_lock held, and all
+ * updating to metadata should also hold the kfunc_md_lock.
+ */
+static struct kfunc_md *kfunc_md_fast_create(unsigned long ip, int nr_args)
+{
+	u8 nop_insn[insn_size], insn[insn_size];
+	struct kfunc_md *md;
+	u32 index;
+	int err;
+
+	md = kfunc_md_fast_get(ip);
+	if (md) {
+		md->users++;
+		return md;
+	}
+
+	md = kfunc_md_fast_next(&index);
+	if (!md)
+		return NULL;
+
+	memset(md, 0, sizeof(*md));
+	err = percpu_ref_init(&md->pcref, kfunc_md_release, 0, GFP_KERNEL);
+	if (err)
+		return NULL;
+
+	kfunc_md_arch_pretend(insn, index);
+	kfunc_md_arch_nops(nop_insn);
+
+	if (kfunc_md_text_poke(ip, insn, nop_insn)) {
+		atomic_dec(&kfunc_mds->kfunc_md_used);
+		percpu_ref_exit(&md->pcref);
+		return NULL;
+	}
+
+	md->users = 1;
+	md->func = ip;
+	md->array = kfunc_mds;
+	md->nr_args = nr_args;
+
+	return md;
+}
+#else
+
+static void kfunc_md_fast_put(struct kfunc_md *md)
+{
+}
+
+static struct kfunc_md *kfunc_md_fast_get(unsigned long ip)
+{
+	return NULL;
+}
+
+static struct kfunc_md *kfunc_md_fast_create(unsigned long ip, int nr_args)
+{
+	return NULL;
+}
+
+#endif /* !CONFIG_FUNCTION_METADATA */
+
+void kfunc_md_enter(struct kfunc_md *md)
+{
+	percpu_ref_get(&md->pcref);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_enter);
+
+void kfunc_md_exit(struct kfunc_md *md)
+{
+	percpu_ref_put(&md->pcref);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_exit);
+
+void kfunc_md_unlock(void)
+{
+	mutex_unlock(&kfunc_md_mutex);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_unlock);
+
+void kfunc_md_lock(void)
+{
+	mutex_lock(&kfunc_md_mutex);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_lock);
+
+#undef CALL
+#define CALL(fast, slow, type, ...) ({			\
+	type ___ret;					\
+	if (kfunc_md_fast())				\
+		___ret = fast(__VA_ARGS__);		\
+	else						\
+		___ret = slow(__VA_ARGS__);		\
+	___ret;						\
+})
+
+#undef CALL_VOID
+#define CALL_VOID(fast, slow, ...) do {			\
+	if (kfunc_md_fast())				\
+		fast(__VA_ARGS__);			\
+	else						\
+		slow(__VA_ARGS__);			\
+} while (0)
+
+struct kfunc_md *kfunc_md_get_noref(unsigned long ip)
+{
+	return CALL(kfunc_md_fast_get, kfunc_md_hash_get, struct kfunc_md *,
+		    ip);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_get_noref);
+
+struct kfunc_md *kfunc_md_get(unsigned long ip)
+{
+	struct kfunc_md *md;
+
+	md = CALL(kfunc_md_fast_get, kfunc_md_hash_get, struct kfunc_md *,
+		  ip);
+	if (md)
+		md->users++;
+	return md;
+}
+EXPORT_SYMBOL_GPL(kfunc_md_get);
+
+void kfunc_md_put(unsigned long ip)
+{
+	struct kfunc_md *md = kfunc_md_get_noref(ip);
+
+	if (md)
+		CALL_VOID(kfunc_md_fast_put, kfunc_md_hash_put, md);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_put);
+
+/* Decrease the reference of the md, release it if "md->users <= 0" */
+void kfunc_md_put_entry(struct kfunc_md *md)
+{
+	if (!md)
+		return;
+
+	CALL_VOID(kfunc_md_fast_put, kfunc_md_hash_put, md);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_put_entry);
+
+struct kfunc_md *kfunc_md_create(unsigned long ip, int nr_args)
+{
+	return CALL(kfunc_md_fast_create, kfunc_md_hash_create,
+		    struct kfunc_md *, ip, nr_args);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_create);
+
+bool __weak kfunc_md_arch_support(int *insn, int *data)
+{
+	return false;
+}
+
+static int __init kfunc_md_init_test(void)
+{
+#ifndef CONFIG_FUNCTION_METADATA_PADDING
+	/* When the CONFIG_FUNCTION_METADATA_PADDING is not available, try
+	 * to probe the usable function padding dynamically.
+	 */
+	if (!kfunc_md_arch_support(&__insn_offset, &__data_offset))
+		static_branch_disable(&kfunc_md_use_padding);
+#endif
+	return 0;
+}
+late_initcall(kfunc_md_init_test);
-- 
2.39.5


