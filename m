Return-Path: <bpf+bounces-59264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E5AC7714
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 06:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA1DA250F5
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E724EAB1;
	Thu, 29 May 2025 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wm9dZLtB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F0EEAA
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 04:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492366; cv=none; b=R2dlK+1F96GIE/YehU0YSNARLD1q927+sSBIH34axtDmzV+pAR0wF+yjntq04egUWWMx9+vM0Ry1vMLVZpXhXxjSyCpxm2dn206CxT22P3jVyoKo91luDIf5GZY0ezKxfKLKuKjWEzqwBgwZ5w3yICuEv5BLpBcKJgQv5Xn9DXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492366; c=relaxed/simple;
	bh=1UNEpynHFgSv5UFL1m587D9A3kwHBOqumSFm94pzW2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azQHCF1xrBLOOAdZD6RFYMIsUWaOWUmWEUR4IBdo0cvnPOXq+fbaOdG2ZDaStcR4u8I6s5YvfhpKaYjcJ1VE2ZOH21tb6fyHjO3/JwZyMLFCTViCWeBViAkufdWCHOXTR8AEm32pA+wgoAJWZtthtCWpzkl2hG55fzV6HpwU1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wm9dZLtB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbMqCLbigtH8SYgz7AdYn6GOyuyyf11S46PIWrL2Yo4=;
	b=Wm9dZLtBc8BaItdsGAbFy4YvsSS5WJs67XyTbXF/HnouAyz1eEInmPLL1bVr2j350DbOq/
	A/d1KAwcr9uAOjd2bT8TKO6vSGstSexsJy64IXFE+WY+onfQYwEP8ZCr68xSPxNWRf2e0I
	kwcsciUr+/JYvGujsS+XCqAyum7ryRI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-_Y_3EDN0Mgye5xzjzC9SBA-1; Thu,
 29 May 2025 00:19:17 -0400
X-MC-Unique: _Y_3EDN0Mgye5xzjzC9SBA-1
X-Mimecast-MFC-AGG-ID: _Y_3EDN0Mgye5xzjzC9SBA_1748492354
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A34DD18001EA;
	Thu, 29 May 2025 04:19:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A643E18003FC;
	Thu, 29 May 2025 04:19:01 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: bpf@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCHv3 3/9] bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
Date: Thu, 29 May 2025 12:17:38 +0800
Message-ID: <20250529041744.16458-4-piliu@redhat.com>
In-Reply-To: <20250529041744.16458-1-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In the security kexec_file_load case, the buffer which holds the kernel
image is invisible to the userspace.

The common data flow in bpf scheme is from kernel to bpf-prog.  In the
case of kexec_file_load, the kexec component needs to buffer the parsed
result by bpf-prog (opposite the usual direction) to the next stage
parsing. bpf_kexec_carrier() makes the opposite data flow possible. A
bpf-prog can publish the parsed payload address to the kernel, and the
latter can copy them for future use.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
To: bpf@vger.kernel.org
---
 include/linux/bpf.h          |  23 +++++
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/helpers.c         |   2 +
 kernel/bpf/helpers_carrier.c | 194 +++++++++++++++++++++++++++++++++++
 4 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/helpers_carrier.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622c..104974a6d18cb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3568,4 +3568,27 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+struct mem_range_result {
+	struct kref ref;
+	struct rcu_head rcu;
+	char *buf;
+	uint32_t buf_sz;
+	uint32_t data_sz;
+	/* kmalloc-ed or vmalloc-ed */
+	bool kmalloc;
+	int status;
+	struct mem_cgroup *memcg;
+};
+int mem_range_result_put(struct mem_range_result *result);
+
+typedef int (*resource_handler)(const char *name, struct mem_range_result *r);
+
+struct carrier_listener {
+	char *name;
+	bool kmalloc;
+	resource_handler handler;
+};
+
+int register_carrier_listener(struct carrier_listener *listener);
+int unregister_carrier_listener(char *str);
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 70502f038b921..d1f1f50e23cc8 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o helpers_carrier.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e336..1f4284e58400b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3200,6 +3200,8 @@ BTF_KFUNCS_START(generic_btf_ids)
 #ifdef CONFIG_CRASH_DUMP
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
+BTF_ID_FLAGS(func, bpf_mem_range_result_put, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_copy_to_kernel, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
diff --git a/kernel/bpf/helpers_carrier.c b/kernel/bpf/helpers_carrier.c
new file mode 100644
index 0000000000000..c4e45fdf0ebb8
--- /dev/null
+++ b/kernel/bpf/helpers_carrier.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bpf.h>
+#include <linux/bpf-cgroup.h>
+#include <linux/cgroup.h>
+#include <linux/rcupdate.h>
+#include <linux/hashtable.h>
+#include <linux/jhash.h>
+#include <linux/mutex.h>
+#include <linux/kref.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+
+
+struct str_listener {
+	struct hlist_node node;
+	char *str;
+	resource_handler handler;
+	bool kmalloc;
+};
+
+DEFINE_STATIC_SRCU(srcu);
+static DEFINE_MUTEX(str_listeners_mutex);
+static DEFINE_HASHTABLE(str_listeners, 8);
+
+static struct str_listener *find_listener(const char *str)
+{
+	struct str_listener *item;
+	unsigned int hash = jhash(str, strlen(str), 0);
+
+	hash_for_each_possible(str_listeners, item, node, hash) {
+		if (strcmp(item->str, str) == 0)
+			return item;
+	}
+	return NULL;
+}
+
+static void __mem_range_result_free(struct rcu_head *rcu)
+{
+	struct mem_range_result *result = container_of(rcu, struct mem_range_result, rcu);
+	struct mem_cgroup *memcg, *old_memcg;
+
+	memcg = result->memcg;
+	old_memcg = set_active_memcg(memcg);
+	if (likely(!!result->buf)) {
+		if (result->kmalloc)
+			kfree(result->buf);
+		else
+			vfree(result->buf);
+	}
+	kfree(result);
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+}
+
+static void __mem_range_result_put(struct kref *kref)
+{
+	struct mem_range_result *result = container_of(kref, struct mem_range_result, ref);
+
+	call_srcu(&srcu, &result->rcu, __mem_range_result_free);
+}
+
+int mem_range_result_put(struct mem_range_result *result)
+{
+
+	if (!result) {
+		pr_err("%s, receive invalid range\n", __func__);
+		return -EINVAL;
+	}
+
+	kref_put(&result->ref, __mem_range_result_put);
+	return 0;
+}
+
+__bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
+{
+	return mem_range_result_put(result);
+}
+
+/*
+ * Cache the content in @buf into kernel
+ */
+__bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
+{
+	struct mem_range_result *range;
+	struct mem_cgroup *memcg, *old_memcg;
+	struct str_listener *item;
+	resource_handler handler;
+	bool kmalloc;
+	char *kbuf;
+	int id, ret = 0;
+
+	id = srcu_read_lock(&srcu);
+	item = find_listener(name);
+	if (!item) {
+		srcu_read_unlock(&srcu, id);
+		return -EINVAL;
+	}
+	kmalloc = item->kmalloc;
+	handler = item->handler;
+	srcu_read_unlock(&srcu, id);
+	memcg = get_mem_cgroup_from_current();
+	old_memcg = set_active_memcg(memcg);
+	range = kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
+	if (!range) {
+		pr_err("fail to allocate mem_range_result\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	kref_init(&range->ref);
+	if (item->kmalloc)
+		kbuf = kmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
+	else
+		kbuf = __vmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!kbuf) {
+		kfree(range);
+		ret = -ENOMEM;
+		goto err;
+	}
+	ret = copy_from_kernel_nofault(kbuf, buf, size);
+	if (unlikely(ret < 0)) {
+		kfree(range);
+		if (item->kmalloc)
+			kfree(kbuf);
+		else
+			vfree(kbuf);
+		ret = -EINVAL;
+		goto err;
+	}
+	range->kmalloc = item->kmalloc;
+	range->buf = kbuf;
+	range->buf_sz = size;
+	range->data_sz = size;
+	range->memcg = memcg;
+	mem_cgroup_tryget(memcg);
+	range->status = 0;
+	ret = handler(name, range);
+	mem_range_result_put(range);
+err:
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+	return ret;
+}
+
+int register_carrier_listener(struct carrier_listener *listener)
+{
+	struct str_listener *item;
+	unsigned int hash;
+	int ret;
+
+	if (!listener->name)
+		return -EINVAL;
+	item = kmalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		return -ENOMEM;
+	item->str = kstrdup(listener->name, GFP_KERNEL);
+	if (!item->str) {
+		kfree(item);
+		return -ENOMEM;
+	}
+	item->handler = listener->handler;
+	item->kmalloc = listener->kmalloc;
+	hash = jhash(item->str, strlen(item->str), 0);
+	mutex_lock(&str_listeners_mutex);
+	if (!find_listener(item->str)) {
+		hash_add(str_listeners, &item->node, hash);
+	} else {
+		kfree(item->str);
+		kfree(item);
+		ret = -EBUSY;
+	}
+	mutex_unlock(&str_listeners_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(register_carrier_listener);
+
+int unregister_carrier_listener(char *str)
+{
+	struct str_listener *item;
+	int ret = 0;
+
+	mutex_lock(&str_listeners_mutex);
+	item = find_listener(str);
+	if (!!item)
+		hash_del(&item->node);
+	else
+		ret = -EINVAL;
+	mutex_unlock(&str_listeners_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(unregister_carrier_listener);
+
-- 
2.49.0


