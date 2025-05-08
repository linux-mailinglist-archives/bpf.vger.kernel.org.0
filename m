Return-Path: <bpf+bounces-57787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1DAB0290
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CBC3A9358
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6A727991C;
	Thu,  8 May 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1n+vbyT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36341287515
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728451; cv=none; b=e3PKa3POZDhM7yXxm0k5YoOxZHC3uCzDvAVtLb2Ou69qOcSVPOMTfMVygYd1WcTwODzeYEV7lKIhZz80toltBhSPu1H3YqLUQnFtaNmF7TWV7o6VL8FTjdECyziTKu1yyWSQZ3Q84RynxD1fM+S5ZFDY8HfW7oy0GXE7YuqtUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728451; c=relaxed/simple;
	bh=G4Bp8rmmBCJZpq/CqbSj8tXBk9iylrzbkK0ZxAIXcMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L2+TZ3OOKdsjHeBMOB8QH2SFssb4asCjioHLMr2bfyFDfIXDZ8XwaXZPTcYiVmdgwTEil9FfkKuzb1FRfCC1HjuO7BqUGVDXy+a5hdoAEfqvhW7+rbhSYSmx850DhPPRY+x5GmYGsn1wBB1LeiuI71Jhw0cZof69KcFMWWLmcJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1n+vbyT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ad1e374e2so1363313a91.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746728449; x=1747333249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8rRBHMHk3l955gP5RCSBGHdN9fy4o3Irn9EK1cQXJU=;
        b=G1n+vbyT7kMzR6WwihhetnHj21rss6jVaAWgq0UqwXerRWtQOdF1N8WyzrXczmPFe9
         4quqBx+2cllFGO4RpOJYX3QDx2Rl8Y8+tJeglL3rDlLHbuB/VEnLYU1ZgshohieX98VS
         k+dqKp4LA5gJRQBSY9YqrvR3EeiWzaujWm+pZ2L+aRVM0HCAgOWT1/nngP/aKrYnYjOH
         fyusnmoeRv276stnGJ5Bw6eDZ5gMi6FAlO3NR8hkjc40tr9BiXJgAnWZxTNWzDENZdl1
         j0wmMSviO1s5LrBYJx22uQsoyH9MEvZxJhq53p3eM9VyxozdN/1hM+57CGnnYYVW3/ry
         0T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728449; x=1747333249;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j8rRBHMHk3l955gP5RCSBGHdN9fy4o3Irn9EK1cQXJU=;
        b=afUkIRlqgK6uB0wl3KTxEPSXX6SrDLmXABHpd/tOozJncMSNV9eTT1r/hPRNRWSnVa
         8YZ/d2XmZ0oB4FOpjCach0oVighO4rDZfVvP+Ern1XXa9KkGgybq9ZmlyGt83aYYfESe
         qprSL02C8/F9/Ko5gLJODPazMPMyjI/w8FjSZaJCtNz7thJt+tFv/kYLPcsb2vi97myL
         pFaFZiqDS0vHg+CAy33E2ezal2P+Y3eyLHrJ6s/WRI7bgT7V3IKVQl+1Ybb0tbJquXtI
         AYD7GPTGyd/Lu2Uycq8saj+r0bVbcWEAKQq31dsCvnWvvkPG8qAObLyElpcE8BjvoHhB
         5woQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtBbOGMCnTVSTGM3R1pKe99ZpXVUV8t6nfCsFx8cVYEWj8Van/VxYbGEUCO6rgQDbsz9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLhWqaE/s7exkSSMQdkGUoVskUb3hLkQBGOWU4dcJu7lyJwyW
	qhkxfkiYLQOk7B0zYaMvJVtx0vKTLiMvb9vPBCz1wstf6/RHmm1/pyHCPeQ2ikUIfClFv3ATdaa
	QRx92H7Ui3Cy+Sg==
X-Google-Smtp-Source: AGHT+IF5O4pJZUDV3dye2FVwuoW2YooMLe6xtghEG8PaiVjgBWnEqJZ6Bl2vHK9VOrtDqNZKp86YPAQrtLaPgWA=
X-Received: from pjbst8.prod.google.com ([2002:a17:90b:1fc8:b0:2ff:5344:b54])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b0f:b0:301:a0e9:66f with SMTP id 98e67ed59e1d1-30c3cff2d16mr859660a91.14.1746728449553;
 Thu, 08 May 2025 11:20:49 -0700 (PDT)
Date: Thu,  8 May 2025 18:20:21 +0000
In-Reply-To: <20250508182025.2961555-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508182025.2961555-3-tjmercier@google.com>
Subject: [PATCH bpf-next v4 2/5] bpf: Add dmabuf iterator
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The dmabuf iterator traverses the list of all DMA buffers.

DMA buffers are refcounted through their associated struct file. A
reference is taken on each buffer as the list is iterated to ensure each
buffer persists for the duration of the bpf program execution without
holding the list mutex.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c |  68 +++++++++++++++++++++++++
 include/linux/dma-buf.h   |   2 +
 kernel/bpf/Makefile       |   3 ++
 kernel/bpf/dmabuf_iter.c  | 102 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 kernel/bpf/dmabuf_iter.c

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8d151784e302..6b59506a1b94 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -19,7 +19,9 @@
 #include <linux/anon_inodes.h>
 #include <linux/export.h>
 #include <linux/debugfs.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/seq_file.h>
 #include <linux/sync_file.h>
 #include <linux/poll.h>
@@ -55,6 +57,72 @@ static void __dma_buf_list_del(struct dma_buf *dmabuf)
 	mutex_unlock(&dmabuf_list_mutex);
 }
=20
+/**
+ * dma_buf_iter_begin - begin iteration through global list of all DMA buf=
fers
+ *
+ * Returns the first buffer in the global list of DMA-bufs that's not in t=
he
+ * process of being destroyed. Increments that buffer's reference count to
+ * prevent buffer destruction. Callers must release the reference, either =
by
+ * continuing iteration with dma_buf_iter_next(), or with dma_buf_put().
+ *
+ * Return:
+ * * First buffer from global list, with refcount elevated
+ * * NULL if no active buffers are present
+ */
+struct dma_buf *dma_buf_iter_begin(void)
+{
+	struct dma_buf *ret =3D NULL, *dmabuf;
+
+	/*
+	 * The list mutex does not protect a dmabuf's refcount, so it can be
+	 * zeroed while we are iterating. We cannot call get_dma_buf() since the
+	 * caller may not already own a reference to the buffer.
+	 */
+	mutex_lock(&dmabuf_list_mutex);
+	list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
+		if (file_ref_get(&dmabuf->file->f_ref)) {
+			ret =3D dmabuf;
+			break;
+		}
+	}
+	mutex_unlock(&dmabuf_list_mutex);
+	return ret;
+}
+
+/**
+ * dma_buf_iter_next - continue iteration through global list of all DMA b=
uffers
+ * @dmabuf:	[in]	pointer to dma_buf
+ *
+ * Decrements the reference count on the provided buffer. Returns the next
+ * buffer from the remainder of the global list of DMA-bufs with its refer=
ence
+ * count incremented. Callers must release the reference, either by contin=
uing
+ * iteration with dma_buf_iter_next(), or with dma_buf_put().
+ *
+ * Return:
+ * * Next buffer from global list, with refcount elevated
+ * * NULL if no additional active buffers are present
+ */
+struct dma_buf *dma_buf_iter_next(struct dma_buf *dmabuf)
+{
+	struct dma_buf *ret =3D NULL;
+
+	/*
+	 * The list mutex does not protect a dmabuf's refcount, so it can be
+	 * zeroed while we are iterating. We cannot call get_dma_buf() since the
+	 * caller may not already own a reference to the buffer.
+	 */
+	mutex_lock(&dmabuf_list_mutex);
+	dma_buf_put(dmabuf);
+	list_for_each_entry_continue(dmabuf, &dmabuf_list, list_node) {
+		if (file_ref_get(&dmabuf->file->f_ref)) {
+			ret =3D dmabuf;
+			break;
+		}
+	}
+	mutex_unlock(&dmabuf_list_mutex);
+	return ret;
+}
+
 static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int bufle=
n)
 {
 	struct dma_buf *dmabuf;
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 8ff4add71f88..7af2ea839f58 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -634,4 +634,6 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_m=
ap *map);
 void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
 int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
 void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map=
);
+struct dma_buf *dma_buf_iter_begin(void);
+struct dma_buf *dma_buf_iter_next(struct dma_buf *dmbuf);
 #endif /* __DMA_BUF_H__ */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 70502f038b92..3a335c50e6e3 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
+ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
+obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
+endif
=20
 CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
new file mode 100644
index 000000000000..96b4ba7f0b2c
--- /dev/null
+++ b/kernel/bpf/dmabuf_iter.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Google LLC */
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/dma-buf.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+
+BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
+DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf *d=
mabuf)
+
+static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos)
+		return NULL;
+
+	return dma_buf_iter_begin();
+}
+
+static void *dmabuf_iter_seq_next(struct seq_file *seq, void *v, loff_t *p=
os)
+{
+	struct dma_buf *dmabuf =3D v;
+
+	++*pos;
+
+	return dma_buf_iter_next(dmabuf);
+}
+
+struct bpf_iter__dmabuf {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct dma_buf *, dmabuf);
+};
+
+static int __dmabuf_seq_show(struct seq_file *seq, void *v, bool in_stop)
+{
+	struct bpf_iter_meta meta =3D {
+		.seq =3D seq,
+	};
+	struct bpf_iter__dmabuf ctx =3D {
+		.meta =3D &meta,
+		.dmabuf =3D v,
+	};
+	struct bpf_prog *prog =3D bpf_iter_get_info(&meta, in_stop);
+
+	if (prog)
+		return bpf_iter_run_prog(prog, &ctx);
+
+	return 0;
+}
+
+static int dmabuf_iter_seq_show(struct seq_file *seq, void *v)
+{
+	return __dmabuf_seq_show(seq, v, false);
+}
+
+static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	struct dma_buf *dmabuf =3D v;
+
+	if (dmabuf)
+		dma_buf_put(dmabuf);
+}
+
+static const struct seq_operations dmabuf_iter_seq_ops =3D {
+	.start	=3D dmabuf_iter_seq_start,
+	.next	=3D dmabuf_iter_seq_next,
+	.stop	=3D dmabuf_iter_seq_stop,
+	.show	=3D dmabuf_iter_seq_show,
+};
+
+static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_info *au=
x,
+					struct seq_file *seq)
+{
+	seq_puts(seq, "dmabuf iter\n");
+}
+
+static const struct bpf_iter_seq_info dmabuf_iter_seq_info =3D {
+	.seq_ops		=3D &dmabuf_iter_seq_ops,
+	.init_seq_private	=3D NULL,
+	.fini_seq_private	=3D NULL,
+	.seq_priv_size		=3D 0,
+};
+
+static struct bpf_iter_reg bpf_dmabuf_reg_info =3D {
+	.target			=3D "dmabuf",
+	.feature                =3D BPF_ITER_RESCHED,
+	.show_fdinfo		=3D bpf_iter_dmabuf_show_fdinfo,
+	.ctx_arg_info_size	=3D 1,
+	.ctx_arg_info		=3D {
+		{ offsetof(struct bpf_iter__dmabuf, dmabuf),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info		=3D &dmabuf_iter_seq_info,
+};
+
+static int __init dmabuf_iter_init(void)
+{
+	bpf_dmabuf_reg_info.ctx_arg_info[0].btf_id =3D bpf_dmabuf_btf_id[0];
+	return bpf_iter_reg_target(&bpf_dmabuf_reg_info);
+}
+
+late_initcall(dmabuf_iter_init);
--=20
2.49.0.1015.ga840276032-goog


