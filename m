Return-Path: <bpf+bounces-76013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27329CA235A
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 03:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98FAA301B109
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 02:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260C83164D3;
	Thu,  4 Dec 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzLEcSQH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BB31327F
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816629; cv=none; b=gCI4zAShwlnu0KpmSjUXg+zw17aQWe5PdKj42qF+2ylfZ/19zyy/ObqZ9N9k1LL1bpLV0FSMTgz0hhsylK5NrH0p2KE7l3BhN0JRBdfU1GpBKQD4QXBBAJufxUj5TuwsUVFlhiS4ll/926LgZB8axw5eGYh7h1A5yWRtfCFQWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816629; c=relaxed/simple;
	bh=68DTt/GuOSLKGluBcJnffa2coBM4bFiaelurtvz3SlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lqSkjoTEDd6Acw3O4+jpcEP0TFHu22DQ5XfLGx4pNv7k7GjM+UggFywajxHMNQx38cv469WdXpd+prPQ+N0cf9Qe+jAeRZgKV+v0lb6PrRHVz0yayC7aNpm2M5E5gAyNHkcpV/85Xpa7DGJpRH0hvHfnH9g07a/HwAAOlQDP+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzLEcSQH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b609c0f6522so691750a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 18:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764816617; x=1765421417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GxvGZcQ0kz+qaUDRrIQhWZRD2UKUVtV4j+gmBLCpxM=;
        b=AzLEcSQH0Hv+q+qVuL8p6Lek307BO1Yy8gEiqRmm2R/BMn30rJfqw4AyzSMWoXso1V
         Zwny+oAOlr/kkWiNYM8SYrFtNlC8NWtEomHdvhLF6Z3s2K9f1T82/xmu621LyfppwjRo
         nl1pt4k64yHkpsOzCsZSL0u+pQwpT9TRqBLy/rWykCa0muhdyEFPPl1U/2IJ5YX977Bw
         W2Ss9Vb1wA2LnxKM/j0WZapN4T7IczKtWHm7iEvHs7ZMNrqBAgHwLvLzDYut5VT4/l7I
         E7kwG/EKcj1WLE47xOWW1ZDyb5heAjUPJxucB7ngyayDMx2ilQ7v7eRU/qJXxBo/YhF1
         qzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816617; x=1765421417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GxvGZcQ0kz+qaUDRrIQhWZRD2UKUVtV4j+gmBLCpxM=;
        b=du48rg8pA8cYKs6f1ooTpreJ9KJVocHFvGZ5e2VAkhA/KGDe5LL8lQizKjoiLx4frk
         2m+h7H26Sdd61xWBC43nvOQiCSJBQcDk+8G4xO8AuBpODLCSEbmw/vXFwb0StWIliB1Q
         bnHk7vS8A0sXFtwal2gh8zdl0GbxYcgsX0gUvyJiVKNp+h2EqST59HmiBPqVsHe/PhHr
         iLC4j+rqv+170WRUTcwBaVOCyxlzGfZ8uWRfyk8Cy6e7yIKnB9yA1e3m3ssxoJYPKIan
         oLtHqQGvLKd184+5XObuWnv6zQBbJXevizO3qkE0QecuKnLpaeyJU8tK9R3PCITgojeO
         DNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1m/IODCY4+QfSUeocDAK3hy5WFshPnz0cMIRyo9kuBr/m+ucAjz2Rar/jOP4pgHC4xRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp48Bq8gu+a5wVOZhztS6T2M/Qp0Qli2dS1NcVTVTYP4ObxK4F
	G35IboC44/KVzEgFW5z6PQa4A1B/8PV+kLWBWKt9ayRkiNrDdls83y1RSTDlOcfqx1whhfWqybV
	ZYW0a2wo6KN9LVw==
X-Google-Smtp-Source: AGHT+IE2CnqpFT/04i/szjW02kaHfA3Zxl8mMBN7I5h+3K1cCj1sU8buNLgR9vr2JBGK5UyjM8V8NxSOFXaAtA==
X-Received: from dydd3.prod.google.com ([2002:a05:693c:61c3:b0:2a4:6ae0:3502])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:cc9c:b0:2a4:3644:4be3 with SMTP id 5a478bee46e88-2ab92ee527fmr2994505eec.27.1764816617047;
 Wed, 03 Dec 2025 18:50:17 -0800 (PST)
Date: Wed,  3 Dec 2025 18:49:58 -0800
In-Reply-To: <20251204025003.3162056-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204025003.3162056-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251204025003.3162056-2-wusamuel@google.com>
Subject: [PATCH v1 1/4] bpf: Add wakeup_source iterator
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: rafael.j.wysocki@intel.com, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a BPF iterator for traversing through wakeup_sources.

Setup iterators to traverse through a SRCUs of wakeup_sources. This is a
more elegant and efficient traversal than going through the options
today, such as at /sys/class/wakeup, or through debugfs.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/bpf/Makefile             |   1 +
 kernel/bpf/wakeup_source_iter.c | 103 ++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 kernel/bpf/wakeup_source_iter.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 232cbc97434d..6a479982469a 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+obj-$(CONFIG_BPF_SYSCALL) += wakeup_source_iter.o
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
new file mode 100644
index 000000000000..b8719f47428e
--- /dev/null
+++ b/kernel/bpf/wakeup_source_iter.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Google LLC */
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/kernel.h>
+#include <linux/pm_wakeup.h>
+#include <linux/seq_file.h>
+
+struct bpf_iter__wakeup_source {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct wakeup_source *, wakeup_source);
+};
+
+static void *wakeup_source_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	int *srcuidx = seq->private;
+	struct wakeup_source *ws;
+	loff_t i;
+
+	*srcuidx = wakeup_sources_read_lock();
+
+	ws = wakeup_sources_walk_start();
+	for (i = 0; ws && i < *pos; i++)
+		ws = wakeup_sources_walk_next(ws);
+
+	return ws;
+}
+
+static void *wakeup_source_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct wakeup_source *ws = v;
+
+	++*pos;
+
+	return wakeup_sources_walk_next(ws);
+}
+
+static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	int *srcuidx = seq->private;
+
+	if (*srcuidx >= 0)
+		wakeup_sources_read_unlock(*srcuidx);
+	*srcuidx = -1;
+}
+
+static int __wakeup_source_seq_show(struct seq_file *seq, void *v, bool in_stop)
+{
+	struct bpf_iter_meta meta = {
+		.seq = seq,
+	};
+	struct bpf_iter__wakeup_source ctx = {
+		.meta = &meta,
+		.wakeup_source = v,
+	};
+	struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
+
+	if (prog)
+		return bpf_iter_run_prog(prog, &ctx);
+
+	return 0;
+}
+
+static int wakeup_source_iter_seq_show(struct seq_file *seq, void *v)
+{
+	return __wakeup_source_seq_show(seq, v, false);
+}
+
+static const struct seq_operations wakeup_source_iter_seq_ops = {
+	.start	= wakeup_source_iter_seq_start,
+	.next	= wakeup_source_iter_seq_next,
+	.stop	= wakeup_source_iter_seq_stop,
+	.show	= wakeup_source_iter_seq_show,
+};
+
+static const struct bpf_iter_seq_info wakeup_source_iter_seq_info = {
+	.seq_ops		= &wakeup_source_iter_seq_ops,
+	.seq_priv_size		= sizeof(int),
+};
+
+static struct bpf_iter_reg bpf_wakeup_source_reg_info = {
+	.target			= "wakeup_source",
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{
+			offsetof(struct bpf_iter__wakeup_source, wakeup_source),
+			PTR_TO_BTF_ID_OR_NULL
+		},
+	},
+	.seq_info		= &wakeup_source_iter_seq_info,
+};
+
+DEFINE_BPF_ITER_FUNC(wakeup_source, struct bpf_iter_meta *meta,
+		     struct wakeup_source *wakeup_source)
+BTF_ID_LIST_SINGLE(bpf_wakeup_source_btf_id, struct, wakeup_source)
+
+static int __init wakeup_source_iter_init(void)
+{
+	bpf_wakeup_source_reg_info.ctx_arg_info[0].btf_id = bpf_wakeup_source_btf_id[0];
+	return bpf_iter_reg_target(&bpf_wakeup_source_reg_info);
+}
+
+late_initcall(wakeup_source_iter_init);
-- 
2.52.0.177.g9f829587af-goog


