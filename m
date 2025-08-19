Return-Path: <bpf+bounces-65940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFBEB2B5E8
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A52524B03
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E81DF75D;
	Tue, 19 Aug 2025 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejnlhSmh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86F1DF246
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566754; cv=none; b=HHiTib96Td8qjcyiAoIexKbaQNCsleKSzTbdrmmpE8O0s1/0mJfw5Xy6aBgvfMEtA6+wlRqdJjRN+NcRXM6f9V/4E0ew6Ki7G12RYKptneE1f3/y6yHHN00VYWkZDUhQJNLEsVP+t2560hJg3P/hBeu99rQpZwwu7W/MqdCrDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566754; c=relaxed/simple;
	bh=ODH0hWsRvv12Ip3N9aDYUPU7sPyMp68MwX9rcT1shqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJkuTQpMZU9Bboi4BJVmGB+i8gjiEzuB2Nq+9Q/Yvgfp7nN2zB+WNTthcgspmP+2iMSzP6nstomxdpGvzz1UnvpnjWYjVew9vI0LygrQjI8TuNKItPg13zHqzKDFImw+sUxub7QhORBccRquei7I7iO0y26NlATqVFd0CMZRoGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejnlhSmh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSO0Xq67KGWg4idRTafwaR1aMAr6lkb0NjyXADmxCKA=;
	b=ejnlhSmhbOEK8L2Gn5YH5cCu8XfrlGvbA9ZHPwhQV/XPvPg/hO5GnCsl4HOpFsOASdsYp1
	wE/oWS4Gry2U7jcgpHeQrtjv+bGuRgS/Swe+tFu+DDcpalbZHq8kjjkeCBUBy1YC8adpte
	QLTcqfb0MYu+0OpiUL1fdXONTEHzjXo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-Ls4Ggn7mMteRfNFw9SSeMQ-1; Mon,
 18 Aug 2025 21:25:46 -0400
X-MC-Unique: Ls4Ggn7mMteRfNFw9SSeMQ-1
X-Mimecast-MFC-AGG-ID: Ls4Ggn7mMteRfNFw9SSeMQ_1755566744
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67F4E180044F;
	Tue, 19 Aug 2025 01:25:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59BD6180028D;
	Tue, 19 Aug 2025 01:25:29 +0000 (UTC)
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
	systemd-devel@lists.freedesktop.org,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCHv5 03/12] bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
Date: Tue, 19 Aug 2025 09:24:19 +0800
Message-ID: <20250819012428.6217-4-piliu@redhat.com>
In-Reply-To: <20250819012428.6217-1-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In the security kexec_file_load case, the buffer which holds the kernel
image should not be accessible from the userspace.

Typically, BPF data flow occurs between user space and kernel space in
either direction.  However, kexec_file_load presents a unique case where
user-originated data must be parsed and then forwarded to the kernel for
subsequent parsing stages.  This necessitates a mechanism to channel the
intermedia data from the BPF program directly to the kernel.

bpf_kexec_carrier() is introduced to serve that purpose.

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
 include/linux/bpf.h          |  42 +++++++
 kernel/bpf/Makefile          |   3 +
 kernel/bpf/helpers.c         |   4 +
 kernel/bpf/helpers_carrier.c | 215 +++++++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 kernel/bpf/helpers_carrier.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc700925b802f..f40e14eb63178 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3703,4 +3703,46 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+enum alloc_type {
+	TYPE_KALLOC,
+	TYPE_VMALLOC,
+	TYPE_VMAP,
+};
+
+struct mem_range_result {
+	struct kref ref;
+	char *buf;
+	uint32_t buf_sz;
+	uint32_t data_sz;
+	/* kmalloc-ed, vmalloc-ed, or vmap-ed */
+	enum alloc_type alloc_type;
+	/* Valid if vmap-ed */
+	struct page **pages;
+	unsigned int pg_cnt;
+	int status;
+	struct mem_cgroup *memcg;
+};
+
+struct mem_range_result *mem_range_result_alloc(void);
+void mem_range_result_get(struct mem_range_result *r);
+void mem_range_result_put(struct mem_range_result *r);
+
+__bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result);
+__bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size);
+
+typedef int (*resource_handler)(const char *name, struct mem_range_result *r);
+
+struct carrier_listener {
+	struct hlist_node node;
+	char *name;
+	resource_handler handler;
+	/*
+	 * bpf_copy_to_kernel() knows the size in advance, so vmap-ed is not
+	 * supported.
+	 */
+	enum alloc_type alloc_type;
+};
+
+int register_carrier_listener(struct carrier_listener *listener);
+int unregister_carrier_listener(char *str);
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 269c04a246640..3912ed4300472 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -56,6 +56,9 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+ifeq ($(CONFIG_KEXEC_PE_IMAGE),y)
+obj-$(CONFIG_BPF_SYSCALL) += helpers_carrier.o
+endif
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68c..bd83ec9a2b2a6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3709,6 +3709,10 @@ BTF_KFUNCS_START(generic_btf_ids)
 #ifdef CONFIG_CRASH_DUMP
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
+#ifdef CONFIG_KEXEC_PE_IMAGE
+BTF_ID_FLAGS(func, bpf_mem_range_result_put, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_to_kernel, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+#endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
diff --git a/kernel/bpf/helpers_carrier.c b/kernel/bpf/helpers_carrier.c
new file mode 100644
index 0000000000000..7af4ef07ce750
--- /dev/null
+++ b/kernel/bpf/helpers_carrier.c
@@ -0,0 +1,215 @@
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
+DEFINE_STATIC_SRCU(srcu);
+static DEFINE_MUTEX(carrier_listeners_mutex);
+static DEFINE_HASHTABLE(carrier_listeners, 8);
+
+static struct carrier_listener *find_listener(const char *str)
+{
+	struct carrier_listener *item;
+	unsigned int hash = jhash(str, strlen(str), 0);
+
+	hash_for_each_possible_rcu(carrier_listeners, item, node, hash) {
+		if (strcmp(item->name, str) == 0)
+			return item;
+	}
+	return NULL;
+}
+
+static void __mem_range_result_free(struct kref *kref)
+{
+	struct mem_range_result *result = container_of(kref, struct mem_range_result, ref);
+	struct mem_cgroup *memcg, *old_memcg;
+
+	/* vunmap() is blocking */
+	might_sleep();
+	memcg = result->memcg;
+	old_memcg = set_active_memcg(memcg);
+	if (likely(!!result->buf)) {
+		switch (result->alloc_type) {
+		case TYPE_KALLOC:
+			kfree(result->buf);
+			break;
+		case TYPE_VMALLOC:
+			vfree(result->buf);
+			break;
+		case TYPE_VMAP:
+			vunmap(result->buf);
+			for (unsigned int i = 0; i < result->pg_cnt; i++)
+				__free_pages(result->pages[i], 0);
+			vfree(result->pages);
+		}
+	}
+	kfree(result);
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+}
+
+struct mem_range_result *mem_range_result_alloc(void)
+{
+	struct mem_range_result *range;
+
+	range = kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
+	if (!range)
+		return NULL;
+	kref_init(&range->ref);
+	return range;
+}
+
+void mem_range_result_get(struct mem_range_result *r)
+{
+	if (!r)
+		return;
+	kref_get(&r->ref);
+}
+
+void mem_range_result_put(struct mem_range_result *r)
+{
+	might_sleep();
+	if (!r)
+		return;
+	kref_put(&r->ref, __mem_range_result_free);
+}
+
+__bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
+{
+	mem_range_result_put(result);
+	return 0;
+}
+
+/*
+ * Cache the content in @buf into kernel
+ */
+__bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
+{
+	struct mem_range_result *range;
+	struct mem_cgroup *memcg, *old_memcg;
+	struct carrier_listener *item;
+	resource_handler handler;
+	enum alloc_type alloc_type;
+	char *kbuf;
+	int id, ret = 0;
+
+	/*
+	 * This lock ensures no use of item after free and there is no in-flight
+	 * handler
+	 */
+	id = srcu_read_lock(&srcu);
+	item = find_listener(name);
+	if (!item) {
+		srcu_read_unlock(&srcu, id);
+		return -EINVAL;
+	}
+	alloc_type = item->alloc_type;
+	handler = item->handler;
+	memcg = get_mem_cgroup_from_current();
+	old_memcg = set_active_memcg(memcg);
+	range = mem_range_result_alloc();
+	if (!range) {
+		pr_err("fail to allocate mem_range_result\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	switch (alloc_type) {
+	case TYPE_KALLOC:
+		kbuf = kmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
+		break;
+	case TYPE_VMALLOC:
+		kbuf = __vmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
+		break;
+	default:
+		kfree(range);
+		ret = -EINVAL;
+		goto err;
+	}
+	if (!kbuf) {
+		kfree(range);
+		ret = -ENOMEM;
+		goto err;
+	}
+	ret = copy_from_kernel_nofault(kbuf, buf, size);
+	if (unlikely(ret < 0)) {
+		if (range->alloc_type == TYPE_KALLOC)
+			kfree(kbuf);
+		else
+			vfree(kbuf);
+		kfree(range);
+		ret = -EINVAL;
+		goto err;
+	}
+	range->buf = kbuf;
+	range->buf_sz = size;
+	range->data_sz = size;
+	range->memcg = memcg;
+	mem_cgroup_tryget(memcg);
+	range->status = 0;
+	range->alloc_type = alloc_type;
+	/* We exit the lock after the handler finishes */
+	ret = handler(name, range);
+	srcu_read_unlock(&srcu, id);
+	mem_range_result_put(range);
+err:
+	if (ret != 0)
+		srcu_read_unlock(&srcu, id);
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+	return ret;
+}
+
+int register_carrier_listener(struct carrier_listener *listener)
+{
+	unsigned int hash;
+	int ret = 0;
+	char *str = listener->name;
+
+	/* Not support vmap-ed */
+	if (listener->alloc_type > TYPE_VMALLOC)
+		return -EINVAL;
+	if (!str)
+		return -EINVAL;
+	hash = jhash(str, strlen(str), 0);
+	mutex_lock(&carrier_listeners_mutex);
+	if (!find_listener(str))
+		hash_add_rcu(carrier_listeners, &listener->node, hash);
+	else
+		ret = -EBUSY;
+	mutex_unlock(&carrier_listeners_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(register_carrier_listener);
+
+int unregister_carrier_listener(char *str)
+{
+	struct carrier_listener *item;
+	int ret = 0;
+
+	mutex_lock(&carrier_listeners_mutex);
+	item = find_listener(str);
+	if (!!item) {
+		hash_del_rcu(&item->node);
+		/*
+		 * It also waits on in-flight handler. Refer to note on the read
+		 * side
+		 */
+		synchronize_srcu(&srcu);
+	} else {
+		ret = -EINVAL;
+	}
+	mutex_unlock(&carrier_listeners_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(unregister_carrier_listener);
+
-- 
2.49.0


