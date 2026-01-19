Return-Path: <bpf+bounces-79403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7DAD39CC8
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 538D2301276B
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F444256C70;
	Mon, 19 Jan 2026 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOXgC20S"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84D258ED4
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793136; cv=none; b=eJY2nEjunx6MQAxiF8OKy3aKMxDTsRiLC7dLR1thfFGrbaFQPvRT1MWfK6770QMeiZEMg53QHk2bSXahtGoOC6jJ24DxlP13BupYruHGSMIs7ORt8QkrU1isB91wkrhOlRoxTFni7+bXGowKfhq4SHOUg5F0XU9H2U+D+55Su48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793136; c=relaxed/simple;
	bh=w61Zjy29wRsJz3cZu9F5CjXrYJPKyO7BCVnsWG/w14k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbeNG29D+D4RWNlcmXnj4GPQ4TCVMC71poK5rQaTtRQ6qi7L6aS2swKVW/YTWePd+ugd58YGVT6KdhvWyBhum4bR0bA/wjl0xCQjCEii7ahGqzQfCqcOWiTmrjT34cLG7HanSKqTKjGSJAdzA9fQGOObR6OOpXtm+n7jNzcYY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOXgC20S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5aAmHphuaCuElIjD1nSE+54sJuhoN+zFArjQztPTzw=;
	b=BOXgC20SLgekdmZ2hahraJM56Vth53BdDAD0O7PgSmHUVA6vb1Qh43mfttehxZPXm0ovym
	3G/B7guOhkx+SgkKF586XqoRwNYp79xObFJ0VXt+8O9Z1So2pVZU/seMcOY5O95a7a2bRd
	HGcDsB909SbKLqf+FrzpncgF+ng0wYk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-BmTL6VVUNSi1MjAC_BE4Zg-1; Sun,
 18 Jan 2026 22:25:29 -0500
X-MC-Unique: BmTL6VVUNSi1MjAC_BE4Zg-1
X-Mimecast-MFC-AGG-ID: BmTL6VVUNSi1MjAC_BE4Zg_1768793127
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE54C1954B0B;
	Mon, 19 Jan 2026 03:25:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 896FD195419F;
	Mon, 19 Jan 2026 03:25:12 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: bpf@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
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
	linux-kernel@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCHv6 01/13] bpf: Introduce kfuncs to parser buffer content
Date: Mon, 19 Jan 2026 11:24:12 +0800
Message-ID: <20260119032424.10781-2-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In the security kexec_file_load case, the buffer holding the kernel
image should not be accessible from userspace.

Typically, BPF data flow occurs between user space and kernel space in
either direction. However, the above case presents a unique scenario
where the kernel, instead of a user task, reads data from a file, passes
it to a BPF program for parsing, and finally stores the parsed result.

This requires a mechanism to channel the intermediate data from the BPF
program directly to the kernel. BPF buffer parser kfuncs are introduced
to serve this purpose:

    BTF_ID_FLAGS(func, bpf_get_parser_context, KF_ACQUIRE | KF_RET_NULL)
    BTF_ID_FLAGS(func, bpf_put_parser_context, KF_RELEASE)
    BTF_ID_FLAGS(func, bpf_buffer_parser, KF_TRUSTED_ARGS | KF_SLEEPABLE)

where bpf_get_parser_context() and bpf_put_parser_context() manage the
trusted argument, and bpf_buffer_parser() forwards data to a callback
that processes the structured buffer constructed by the BPF program.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@davemloft.net>
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
 include/linux/bpf.h            |  19 ++++
 kernel/bpf/Makefile            |   3 +
 kernel/bpf/bpf_buffer_parser.c | 170 +++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 kernel/bpf/bpf_buffer_parser.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e5be698256d15..25bc1b6b8a600 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3843,4 +3843,23 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+struct bpf_parser_buf {
+	char *buf;
+	int size;
+};
+
+struct bpf_parser_context;
+typedef int (*bpf_parser_handler_t)(struct bpf_parser_context *ctx);
+
+struct bpf_parser_context {
+	struct kref ref;
+	struct hlist_node hash_node;
+	bpf_parser_handler_t func;
+	struct bpf_parser_buf *buf;
+	void *data;
+};
+
+struct bpf_parser_context *alloc_bpf_parser_context(bpf_parser_handler_t func,
+			void *data);
+void put_bpf_parser_context(struct bpf_parser_context *ctx);
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 232cbc97434db..309b905a81736 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -56,6 +56,9 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+ifeq ($(CONFIG_KEXEC_BPF),y)
+obj-$(CONFIG_BPF_SYSCALL) += bpf_buffer_parser.o
+endif
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/bpf_buffer_parser.c b/kernel/bpf/bpf_buffer_parser.c
new file mode 100644
index 0000000000000..6acb4b5da71b3
--- /dev/null
+++ b/kernel/bpf/bpf_buffer_parser.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/hashtable.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/vmalloc.h>
+#include <linux/bpf.h>
+
+#define BPF_CONTEXT_HASH_BITS 10
+
+static DEFINE_SPINLOCK(bpf_parser_context_lock);
+static DEFINE_HASHTABLE(bpf_parser_context_map, BPF_CONTEXT_HASH_BITS);
+
+/* Generate a simple hash key from pointer address */
+static inline unsigned int bpf_parser_context_hash_key(struct bpf_parser_context *ctx)
+{
+	return hash_ptr(ctx, BPF_CONTEXT_HASH_BITS);
+}
+
+static void release_bpf_parser_context(struct kref *kref)
+{
+	struct bpf_parser_context *ctx = container_of(kref, struct bpf_parser_context, ref);
+
+	if (!!ctx->buf) {
+		vfree(ctx->buf->buf);
+		kfree(ctx->buf);
+	}
+	spin_lock(&bpf_parser_context_lock);
+	hash_del(&ctx->hash_node);
+	spin_unlock(&bpf_parser_context_lock);
+	kfree(ctx);
+}
+
+struct bpf_parser_context *alloc_bpf_parser_context(bpf_parser_handler_t func,
+		void *data)
+{
+	struct bpf_parser_context *ctx;
+	unsigned int key;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+	ctx->func = func;
+	ctx->data = data;
+	kref_init(&ctx->ref);
+	key = bpf_parser_context_hash_key(ctx);
+	spin_lock(&bpf_parser_context_lock);
+	hash_add(bpf_parser_context_map, &ctx->hash_node, key);
+	spin_unlock(&bpf_parser_context_lock);
+
+	return ctx;
+}
+
+void put_bpf_parser_context(struct bpf_parser_context *ctx)
+{
+	if (!ctx)
+		return;
+	kref_put(&ctx->ref, release_bpf_parser_context);
+}
+
+static struct bpf_parser_context *find_bpf_parser_context(unsigned long id)
+{
+	struct bpf_parser_context *ctx;
+	unsigned int key;
+	int cnt;
+
+	key = bpf_parser_context_hash_key((struct bpf_parser_context *)id);
+	spin_lock(&bpf_parser_context_lock);
+	hash_for_each_possible(bpf_parser_context_map, ctx, hash_node, key) {
+		if (ctx == (struct bpf_parser_context *)id) {
+			cnt = kref_get_unless_zero(&ctx->ref);
+			if (!cnt)
+				ctx = NULL;
+			spin_unlock(&bpf_parser_context_lock);
+			return ctx;
+		}
+	}
+	spin_unlock(&bpf_parser_context_lock);
+
+	return NULL;
+}
+
+__bpf_kfunc_start_defs()
+
+__bpf_kfunc struct bpf_parser_context *bpf_get_parser_context(unsigned long id)
+{
+	struct bpf_parser_context *ctx;
+
+	ctx = find_bpf_parser_context(id);
+
+	return ctx;
+}
+
+__bpf_kfunc void bpf_put_parser_context(struct bpf_parser_context *ctx)
+{
+	put_bpf_parser_context(ctx);
+}
+
+__bpf_kfunc void bpf_parser_context_release_dtor(void *ctx)
+{
+	put_bpf_parser_context(ctx);
+}
+CFI_NOSEAL(bpf_parser_context_release_dtor);
+
+__bpf_kfunc int bpf_buffer_parser(char *buf, int buf_sz,
+		struct bpf_parser_context *context)
+{
+	struct bpf_parser_buf *parser_buf;
+	int ret;
+	char *b;
+
+	if (unlikely(context->func == NULL))
+		return -EINVAL;
+
+	b = __vmalloc(buf_sz, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!b)
+		return -ENOMEM;
+	ret = copy_from_kernel_nofault(b, buf, buf_sz);
+	if (!!ret) {
+		vfree(b);
+		return ret;
+	}
+
+	parser_buf = kmalloc(sizeof(struct bpf_parser_buf), GFP_KERNEL);
+	if (!parser_buf) {
+		vfree(b);
+		return -ENOMEM;
+	}
+	parser_buf->buf = b;
+	parser_buf->size = buf_sz;
+	context->buf = parser_buf;
+	ret = context->func(context);
+
+	return ret;
+}
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(buffer_parser_ids)
+BTF_ID_FLAGS(func, bpf_get_parser_context, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_parser_context, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_buffer_parser, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_KFUNCS_END(buffer_parser_ids)
+
+static const struct btf_kfunc_id_set buffer_parser_kfunc_set = {
+        .owner = THIS_MODULE,
+        .set   = &buffer_parser_ids,
+};
+
+
+BTF_ID_LIST(buffer_parser_dtor_ids)
+BTF_ID(struct, bpf_parser_context)
+BTF_ID(func, bpf_parser_context_release_dtor)
+
+static int __init buffer_parser_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc buffer_parser_dtors[] = {
+		{
+			.btf_id	      = buffer_parser_dtor_ids[0],
+			.kfunc_btf_id = buffer_parser_dtor_ids[1]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &buffer_parser_kfunc_set);
+	return  ret ?: register_btf_id_dtor_kfuncs(buffer_parser_dtors,
+						   ARRAY_SIZE(buffer_parser_dtors),
+						   THIS_MODULE);
+}
+
+late_initcall(buffer_parser_kfunc_init);
-- 
2.49.0


