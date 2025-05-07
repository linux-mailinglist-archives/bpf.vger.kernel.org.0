Return-Path: <bpf+bounces-57675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA20AAE792
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4E1C01D69
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3428C5BA;
	Wed,  7 May 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPe/Vrub"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964871A0BF1
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638250; cv=none; b=H2Dh5F6tZ265GIJA32LrN2FbiguAw4aCd7M5+KzZ4JeuOFPv4I7+KAVB5mNnBgq0xBb68KCbDBcUdOjERrNFM9G0fMILouk/37kuxyraXqN9BnxTddeJpghpYrN9A5wepMjieGQpvm1QbtIFpk7dcvMDM4rAD2MYxehDASnKNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638250; c=relaxed/simple;
	bh=2uHYgkPFNNvCVyjJYxWZ+E5+hskJYKFwdoSv5v4H+n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN3LoDUPDyPXz7h93IdCRoMCPafpZOSqwSL3am97iCxwh641wNA/NAZdosPTgE4f9y0cAhymQZY3goa8Q9p2TsqD50DdSqG6eaTiT0ole/jKzN2M83tF2URMbu6EwnTa1CtA4cu+41Jp4/2A8OgTwMo/zp6O/YRVLutLFvwKz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPe/Vrub; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so1110685e9.3
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638245; x=1747243045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddqNTBeY66uDcnJAFeLdGYZ2JIAVslD4GKytd64NQSI=;
        b=nPe/Vrub0vX4OWJrUnza2ulV6sErbpUZCPSr7AeLEsMnNfBdfcdiNB2bgjJRDT/EpB
         vG9wELTgAZXGVjFSdLBgk3Bv9E2lRUOkELjdqOuaZG6vmNPgTs7oirZFc5HVcUvWEyUe
         ViQRxbJQSMlotuc5dN97B6JfPpHP287drIgxNzMqyfYCa8brDhLhUKEDm51nZ1Om3Tb5
         Va5kfrtQsnNs93FZf1yTmNofRwc3jWfQgS0TuE9Mu7Tt2ArA1gQcbTMfy39LAmKNbgpV
         CfttphQ9I3Dg03ax2R5iFXiAkzkYPtt7vxCkfZ4m1oPtDS5x25Ra66UWtzOXbeoCSd5d
         uRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638245; x=1747243045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddqNTBeY66uDcnJAFeLdGYZ2JIAVslD4GKytd64NQSI=;
        b=ewXgvqd1pe7LUsF5vOHOZ9Yl4r/OKd262PHSn3CDaGbcuubRvn+wCtrb0C0+wzZZP2
         MEalVKxA9SiElTqF4BCMffAPvEX5PjskCdQv1B1h9sUOPh6MROjyS1lu0oEjXob2nc4m
         YxEdWfGnmbYkVvHUXO4QpgdgQs35FH5h00CZMq7Xu1384DKNPWCfYaE+zDPnI2fDGFyH
         CuPgO7LZObCZG0dZwqm93G8+63+S3KNCqNCrx2Ep2mJE3porcUlEG+8U9NnItQbLB1x/
         i/EaiSvcmQeQw0qlUUExjk5FpHwEe1NIxTx5z3oa7VIoIQXGhz62S8WwJM1UxD6hSB8A
         4QTA==
X-Gm-Message-State: AOJu0Yx/ClRpsLjGa7z0Jq1lK0/ci2C9KS2aCufMJeUzE7xgkFsYDiZR
	xXHMCSlsYuhhEsKfcdB5a5hZYDPBv/vSfBjinVMmPNBRnye8y1LUZ1v/VLNKIII=
X-Gm-Gg: ASbGnctnNZIZ1uQdkr/ToHAejoKjVq9uR+eYbvv/PPAXmxtjnYpkUpMd2LcCy+BIMyP
	GJPiuJH4wkB2ax+6BduJTFI8M/EklSXra3oCDUeBHpcA1s/ANbHDYxWgIYr1WDq8l85Ef6faO+K
	ZHm/HP9SkMmh/s4pMf0xoH9ym+Zk4k1Xrhj4tvHLHExWln8vgRODlAei4ZZL946oRYEg1P6RrJ8
	FBd2dI66KojWdqTJBe/JVVDDKKve9XdRqZ+sSyZEm4HgaF3epNo5zOpQLyovOnnO1EwFT0lH3Va
	8qgqQ9d4Pk2uLuGIwUBNhmMFOLmYnkSmH8JHD3XyWg==
X-Google-Smtp-Source: AGHT+IGQEA7vdxaDnBu/Bz1i2+ungWsi+wW1ozu4xZDblfOTc8eAtnnfvwFw7j06Z1LTBhPjBntrWg==
X-Received: by 2002:a5d:5f95:0:b0:39c:dfa:d347 with SMTP id ffacd0b85a97d-3a0b4a05f30mr3446373f8f.2.1746638244874;
        Wed, 07 May 2025 10:17:24 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c5esm17213018f8f.1.2025.05.07.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/11] bpf: Introduce BPF standard streams
Date: Wed,  7 May 2025 10:17:11 -0700
Message-ID: <20250507171720.1958296-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=30586; h=from:subject; bh=2uHYgkPFNNvCVyjJYxWZ+E5+hskJYKFwdoSv5v4H+n8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WJvCLTOXwK1Zpv21z0/YMRZKXMMVlwUg8buddH tl2qFBmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuViQAKCRBM4MiGSL8RypKYEA CZTE0C5EoSH0cOkgOXSi53Q/FvylHQ1C5MW1YZS1zT7h2gYVdPJ2QzAG4pqVJU5B5eeZar9HTp+Hs7 yu7MAJlvoYlwJfTd1psj4SdhNNT4Y6A3KwATFyNiB5KknkDY3pTg0CyeHvUz1ipZkvD/Dt84RW9lus X3SQxxXGXplzwFl0Il1bWKkdfHR0w7CwlHERxRs3ApTqRncKtcJfFsEX2mrBy40lR8aYiI98yxUJWt F+kay26Od9bY1ddJ5+vaJG6BinDB1mxNy3ZpwSKsF/OZqm3SX2NYHTkCWv7aBM3QEwYt5y9aQqwOfX bMSnZObw2o96SbnQ40o+icNFeHrAO/qrJMK6SWRSbi714JxIop+4CUjTp6S7hxrRW/3NnPWYpaFcRt z8pwSr4UOXm5a3wh5OOnuQfVkh2fi/6akYx9ArWI36F9nr9Vm6lBRlnMazKBr4CnXoWLMZcz4y8/JA Wb5KtREnBbjq4I0lf6eh0Ql6gg0gU2+vLBGXuHdgRji7ffcrmzDDhy9IvQqCtaIfklsuW6A8mWUGPb +SmojWED/w9MTswleKY8+EdHsu+lW8+fakT3hUTvhv93Lpxbvl4HUVYa/+arS85nzmbQk3qmhD2YYT FkTJdhpZeDy2uImZwZhgkZD8t67lOvrF44YT0mok943ECi8cZb7RxTLke5nA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add support for a stream API to the kernel and expose related kfuncs to
BPF programs. Two streams are exposed, BPF_STDOUT and BPF_STDERR. These
can be used for printing messages that can be consumed from user space,
thus it's similar in spirit to existing trace_pipe interface.

The kernel will use the BPF_STDERR stream to notify the program of any
errors encountered at runtime. BPF programs themselves may use both
streams for writing debug messages. BPF library-like code may use
BPF_STDERR to print warnings or errors on misuse at runtime.

The implementation of a stream is as follows. Everytime a message is
emitted from the kernel (directly, or through a BPF program), a record
is allocated by bump allocating from per-cpu region backed by a page
obtained using try_alloc_pages. This ensures that we can allocate memory
from any context. The eventual plan is to discard this scheme in favor
of Alexei's kmalloc_nolock() [0].

This record is then locklessly inserted into a list (llist_add()) so
that the printing side doesn't require holding any locks, and works in
any context. Each stream has a maximum capacity of 4MB of text, and each
printed message is accounted against this limit.

Messages from a program are emitted using the bpf_stream_vprintk kfunc,
which takes a stream argument in addition to working otherwise similar
to bpf_trace_vprintk. The stream itself can be obtained using two
kfuncs, bpf_stream_get for the current program, and bpf_prog_stream_get
to obtain it for a target program ID.

The bprintf buffer helpers are extracted out to be reused for printing
the string into them before copying it into the stream, so that we can
(with the defined max limit) format a string and know its true length
before performing allocations of the stream element.

For consuming elements from a stream, bpf_stream_next_elem can be
called, which returns a bpf_stream_elem object that contains a
bpf_mem_slice struct representing the message contents. A dynptr can be
created from this memory slice object to access the contents of the
bpf_stream_elem.  Once consumed, the bpf_stream_free_elem can be used to
release the message back to the memory allocator.

The internals of bpf_stream_next_elem merit some discussion. First, the
lockless list bpf_stream::log is a LIFO stack. Elements obtained using a
llist_del_all() operation are in LIFO order, thus would break the
chronological ordering if printed directly. Hence, this batch of
messages is first reversed. Then, it is stashed into a separate list in
the stream, i.e. the backlog_log. The head of this list is the actual
message that should always be returned to the caller.

For this purpose, we hold a lock around bpf_stream_backlog_pop(), as
llist_del_first() (if we maintained a second lockless list for the
backlog) wouldn't be safe from multiple threads anyway. Then, if we
fail to find something in the backlog log, we splice out everything from
the lockless log, and place it in the backlog log, and then return the
head of the backlog. Next time we pop a message, we should visit the
remaining elements in the backlog log first. We use rqspinlock for
protecting the backlog log, to ensure we can invoke bpf_stream_next_elem
in any context.

With the exception of bpf_prog_stream_get, these kfuncs are available to
all program types. bpf_prog_stream_get takes a spin_lock_bh, thus is
susceptible to deadlocks if invoked in random kernel contexts. Hence, it
is restricted to BPF_PROG_TYPE_SYSCALL. In the future, if the need
arises, we can use rqspinlock to make it callable in any context.

From the kernel side, the writing into the stream will be a bit more
involved than the typical printk. First, the kernel typically may print
a collection of messages into the stream, and parallel writers into the
stream may suffer from interleaving of messages. To ensure each group of
messages is visible atomically, we can lift the advantage of using a
lockless list for pushing in messages.

To enable this, we add a bpf_stream_stage() macro, and require kernel
users to use bpf_stream_printk statements for the passed expression to
write into the stream. Underneath the macro, we have a message staging
API, where a bpf_stream_stage object on the stack accumulates the
messages being printed into a local llist_head, and then a commit
operation splices the whole batch into the stream's lockless log list.

This is especially pertinent for rqspinlock deadlock messages printed to
program streams. After this change, we see each deadlock invocation as a
non-interleaving contiguous message without any confusion on the
reader's part, improving their user experience in debugging the fault.

While programs cannot benefit from this staged stream writing API, they
could just as well hold an rqspinlock around their print statements to
serialize messages, hence this is kept kernel-internal for now.

Overall, this infrastructure provides NMI-safe any context printing of
messages to two dedicated streams.

Later patches will add support for printing splats in case of BPF arena
page faults, rqspinlock deadlocks, and cond_break timeouts, and
integration of this facility into bpftool for dumping messages to user
space.

  [0]: https://lore.kernel.org/bpf/20250501032718.65476-1-alexei.starovoitov@gmail.com

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  72 +++++-
 kernel/bpf/Makefile   |   2 +-
 kernel/bpf/core.c     |  12 +
 kernel/bpf/helpers.c  |  26 +--
 kernel/bpf/stream.c   | 499 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c  |   2 +-
 kernel/bpf/verifier.c |  15 +-
 7 files changed, 605 insertions(+), 23 deletions(-)
 create mode 100644 kernel/bpf/stream.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b0ea0b71df90..2c10ae62df2d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1524,6 +1524,40 @@ struct btf_mod_pair {
 
 struct bpf_kfunc_desc_tab;
 
+enum bpf_stream_id {
+	BPF_STDOUT = 1,
+	BPF_STDERR = 2,
+};
+
+struct bpf_stream_elem {
+	struct llist_node node;
+	struct bpf_mem_slice mem_slice;
+	char str[];
+};
+
+struct bpf_stream_elem_batch {
+	struct llist_node *node;
+};
+
+enum {
+	BPF_STREAM_MAX_CAPACITY = (4 * 1024U * 1024U),
+};
+
+struct bpf_stream {
+	enum bpf_stream_id stream_id;
+	atomic_t capacity;
+	struct llist_head log;
+
+	rqspinlock_t lock;
+	struct llist_node *backlog_head;
+	struct llist_node *backlog_tail;
+};
+
+struct bpf_stream_stage {
+	struct llist_head log;
+	int len;
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1632,6 +1666,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	struct bpf_stream stream[2];
 };
 
 struct bpf_prog {
@@ -2391,6 +2426,8 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
+
+struct page *__bpf_alloc_page(int nid);
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG
@@ -3529,6 +3566,16 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 #define MAX_BPRINTF_VARARGS		12
 #define MAX_BPRINTF_BUF			1024
 
+/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
+ * arguments representation.
+ */
+#define MAX_BPRINTF_BIN_ARGS	512
+
+struct bpf_bprintf_buffers {
+	char bin_args[MAX_BPRINTF_BIN_ARGS];
+	char buf[MAX_BPRINTF_BUF];
+};
+
 struct bpf_bprintf_data {
 	u32 *bin_args;
 	char *buf;
@@ -3536,9 +3583,32 @@ struct bpf_bprintf_data {
 	bool get_buf;
 };
 
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data);
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
+int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
+void bpf_put_buffers(void);
+
+void bpf_prog_stream_init(struct bpf_prog *prog);
+void bpf_prog_stream_free(struct bpf_prog *prog);
+
+void bpf_stream_stage_init(struct bpf_stream_stage *ss);
+void bpf_stream_stage_free(struct bpf_stream_stage *ss);
+__printf(2, 3)
+int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
+int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
+			    enum bpf_stream_id stream_id);
+
+#define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
+
+#define bpf_stream_stage(prog, stream_id, expr)                  \
+	({                                                       \
+		struct bpf_stream_stage __ss;                    \
+		bpf_stream_stage_init(&__ss);                    \
+		(expr);                                          \
+		bpf_stream_stage_commit(&__ss, prog, stream_id); \
+		bpf_stream_stage_free(&__ss);                    \
+	})
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 70502f038b92..a89575822b60 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
-obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o
+obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o
 ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
 obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
 endif
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a3e571688421..22c278c008ce 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -134,6 +134,10 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->ext_mutex);
 	mutex_init(&fp->aux->dst_mutex);
 
+#ifdef CONFIG_BPF_SYSCALL
+	bpf_prog_stream_init(fp);
+#endif
+
 	return fp;
 }
 
@@ -2861,6 +2865,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	aux = container_of(work, struct bpf_prog_aux, work);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
+	bpf_prog_stream_free(aux->prog);
 #endif
 #ifdef CONFIG_CGROUP_BPF
 	if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
@@ -2877,6 +2882,13 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	if (aux->dst_trampoline)
 		bpf_trampoline_put(aux->dst_trampoline);
 	for (i = 0; i < aux->real_func_cnt; i++) {
+#ifdef CONFIG_BPF_SYSCALL
+		/* Ensure we don't push to subprog lists. */
+		if (bpf_is_subprog(aux->func[i])) {
+			WARN_ON_ONCE(!llist_empty(&aux->func[i]->aux->stream[0].log));
+			WARN_ON_ONCE(!llist_empty(&aux->func[i]->aux->stream[1].log));
+		}
+#endif
 		/* We can just unlink the subprog poke descriptor table as
 		 * it was originally linked to the main program and is also
 		 * released along with it.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 89ab3481378d..98806368121e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -761,22 +761,13 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 	return -EINVAL;
 }
 
-/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
- * arguments representation.
- */
-#define MAX_BPRINTF_BIN_ARGS	512
-
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
-struct bpf_bprintf_buffers {
-	char bin_args[MAX_BPRINTF_BIN_ARGS];
-	char buf[MAX_BPRINTF_BUF];
-};
 
 static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
-static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
+int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
@@ -792,16 +783,21 @@ static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
 	return 0;
 }
 
-void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
+void bpf_put_buffers(void)
 {
-	if (!data->bin_args && !data->buf)
-		return;
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
 	this_cpu_dec(bpf_bprintf_nest_level);
 	preempt_enable();
 }
 
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
+{
+	if (!data->bin_args && !data->buf)
+		return;
+	bpf_put_buffers();
+}
+
 /*
  * bpf_bprintf_prepare - Generic pass on format strings for bprintf-like helpers
  *
@@ -816,7 +812,7 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
 	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
@@ -832,7 +828,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (get_buffers && try_get_buffers(&buffers))
+	if (get_buffers && bpf_try_get_buffers(&buffers))
 		return -EBUSY;
 
 	if (data->get_bin_args) {
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
new file mode 100644
index 000000000000..a9151a8575ec
--- /dev/null
+++ b/kernel/bpf/stream.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/percpu.h>
+#include <linux/refcount.h>
+#include <linux/gfp.h>
+#include <linux/memory.h>
+#include <linux/local_lock.h>
+#include <asm/rqspinlock.h>
+
+/*
+ * Simple per-CPU NMI-safe bump allocation mechanism, backed by the NMI-safe
+ * try_alloc_pages()/free_pages_nolock() primitives. We allocate a page and
+ * stash it in a local per-CPU variable, and bump allocate from the page
+ * whenever items need to be printed to a stream. Each page holds a global
+ * atomic refcount in its first 4 bytes, and then records of variable length
+ * that describe the printed messages. Once the global refcount has dropped to
+ * zero, it is a signal to free the page back to the kernel's page allocator,
+ * given all the individual records in it have been consumed.
+ *
+ * It is possible the same page is used to serve allocations across different
+ * programs, which may be consumed at different times individually, hence
+ * maintaining a reference count per-page is critical for correct lifetime
+ * tracking.
+ *
+ * The bpf_stream_page code will be replaced to use kmalloc_nolock() once it
+ * lands.
+ */
+struct bpf_stream_page {
+	refcount_t ref;
+	u32 consumed;
+	char buf[];
+};
+
+/* Available room to add data to a refcounted page. */
+#define BPF_STREAM_PAGE_SZ (PAGE_SIZE - offsetofend(struct bpf_stream_page, consumed))
+
+static DEFINE_PER_CPU(local_trylock_t, stream_local_lock) = INIT_LOCAL_TRYLOCK(stream_local_lock);
+static DEFINE_PER_CPU(struct bpf_stream_page *, stream_pcpu_page);
+
+static bool bpf_stream_page_local_lock(unsigned long *flags)
+{
+	return local_trylock_irqsave(&stream_local_lock, *flags);
+}
+
+static void bpf_stream_page_local_unlock(unsigned long *flags)
+{
+	local_unlock_irqrestore(&stream_local_lock, *flags);
+}
+
+static void bpf_stream_page_free(struct bpf_stream_page *stream_page)
+{
+	struct page *p;
+
+	if (!stream_page)
+		return;
+	p = virt_to_page(stream_page);
+	free_pages_nolock(p, 0);
+}
+
+static void bpf_stream_page_get(struct bpf_stream_page *stream_page)
+{
+	refcount_inc(&stream_page->ref);
+}
+
+static void bpf_stream_page_put(struct bpf_stream_page *stream_page)
+{
+	if (refcount_dec_and_test(&stream_page->ref))
+		bpf_stream_page_free(stream_page);
+}
+
+static void bpf_stream_page_init(struct bpf_stream_page *stream_page)
+{
+	refcount_set(&stream_page->ref, 1);
+	stream_page->consumed = 0;
+}
+
+static struct bpf_stream_page *bpf_stream_page_replace(void)
+{
+	struct bpf_stream_page *stream_page, *old_stream_page;
+	struct page *page;
+
+	page = __bpf_alloc_page(NUMA_NO_NODE);
+	if (!page)
+		return NULL;
+	stream_page = page_address(page);
+	bpf_stream_page_init(stream_page);
+
+	old_stream_page = this_cpu_read(stream_pcpu_page);
+	if (old_stream_page)
+		bpf_stream_page_put(old_stream_page);
+	this_cpu_write(stream_pcpu_page, stream_page);
+	return stream_page;
+}
+
+static int bpf_stream_page_check_room(struct bpf_stream_page *stream_page, int len)
+{
+	int min = offsetof(struct bpf_stream_elem, str[0]);
+	int consumed = stream_page->consumed;
+	int total = BPF_STREAM_PAGE_SZ;
+	int rem = max(0, total - consumed - min);
+
+	/* Let's give room of at least 8 bytes. */
+	WARN_ON_ONCE(rem % 8 != 0);
+	rem = rem < 8 ? 0 : rem;
+	return min(len, rem);
+}
+
+static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
+{
+	init_llist_node(&elem->node);
+	elem->mem_slice.ptr = elem->str;
+	elem->mem_slice.len = len;
+}
+
+static struct bpf_stream_page *bpf_stream_page_from_elem(struct bpf_stream_elem *elem)
+{
+	unsigned long addr = (unsigned long)elem;
+
+	return (struct bpf_stream_page *)PAGE_ALIGN_DOWN(addr);
+}
+
+static struct bpf_stream_elem *bpf_stream_page_push_elem(struct bpf_stream_page *stream_page, int len)
+{
+	u32 consumed = stream_page->consumed;
+
+	stream_page->consumed += round_up(offsetof(struct bpf_stream_elem, str[len]), 8);
+	return (struct bpf_stream_elem *)&stream_page->buf[consumed];
+}
+
+static noinline struct bpf_stream_elem *bpf_stream_page_reserve_elem(int len)
+{
+	struct bpf_stream_elem *elem = NULL;
+	struct bpf_stream_page *page;
+	int room = 0;
+
+	page = this_cpu_read(stream_pcpu_page);
+	if (!page)
+		page = bpf_stream_page_replace();
+	if (!page)
+		return NULL;
+
+	room = bpf_stream_page_check_room(page, len);
+	if (room != len)
+		page = bpf_stream_page_replace();
+	if (!page)
+		return NULL;
+	bpf_stream_page_get(page);
+	room = bpf_stream_page_check_room(page, len);
+	WARN_ON_ONCE(room != len);
+
+	elem = bpf_stream_page_push_elem(page, room);
+	bpf_stream_elem_init(elem, room);
+	return elem;
+}
+
+static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
+{
+	const int max_len = ARRAY_SIZE((struct bpf_bprintf_buffers){}.buf);
+	struct bpf_stream_elem *elem;
+	unsigned long flags;
+
+	/*
+	 * We may overflow, but we should never need more than one page size
+	 * worth of memory. This can be lifted, but we'd need to adjust the
+	 * other code to keep allocating more pages to overflow messages.
+	 */
+	BUILD_BUG_ON(max_len > BPF_STREAM_PAGE_SZ);
+	/*
+	 * Length denotes the amount of data to be written as part of stream element,
+	 * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
+	 * accomodate, therefore deny allocations that won't fit into them.
+	 */
+	if (len < 0 || len > max_len)
+		return NULL;
+
+	if (!bpf_stream_page_local_lock(&flags))
+		return NULL;
+	elem = bpf_stream_page_reserve_elem(len);
+	bpf_stream_page_local_unlock(&flags);
+	return elem;
+}
+
+__bpf_kfunc_start_defs();
+
+static int __bpf_stream_push_str(struct llist_head *log, const char *str, int len)
+{
+	struct bpf_stream_elem *elem = NULL;
+
+	/*
+	 * Allocate a bpf_prog_stream_elem and push it to the bpf_prog_stream
+	 * log, elements will be popped at once and reversed to print the log.
+	 */
+	elem = bpf_stream_elem_alloc(len);
+	if (!elem)
+		return -ENOMEM;
+
+	memcpy(elem->str, str, len);
+	llist_add(&elem->node, log);
+
+	return 0;
+}
+
+static int bpf_stream_consume_capacity(struct bpf_stream *stream, int len)
+{
+	if (atomic_read(&stream->capacity) >= BPF_STREAM_MAX_CAPACITY)
+		return -ENOSPC;
+	if (atomic_add_return(len, &stream->capacity) >= BPF_STREAM_MAX_CAPACITY) {
+		atomic_sub(len, &stream->capacity);
+		return -ENOSPC;
+	}
+	return 0;
+}
+
+static void bpf_stream_release_capacity(struct bpf_stream *stream, struct bpf_stream_elem *elem)
+{
+	int len = elem->mem_slice.len;
+
+	atomic_sub(len, &stream->capacity);
+}
+
+static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
+{
+	int ret = bpf_stream_consume_capacity(stream, len);
+
+	return ret ?: __bpf_stream_push_str(&stream->log, str, len);
+}
+
+__bpf_kfunc int bpf_stream_vprintk(struct bpf_stream *stream, const char *fmt__str, const void *args, u32 len__sz)
+{
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+		.get_buf	= true,
+	};
+	u32 fmt_size = strlen(fmt__str) + 1;
+	u32 data_len = len__sz;
+	int ret, num_args;
+
+	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
+	    (data_len && !args))
+		return -EINVAL;
+	num_args = data_len / 8;
+
+	ret = bpf_bprintf_prepare(fmt__str, fmt_size, args, num_args, &data);
+	if (ret < 0)
+		return ret;
+
+	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
+	/* If the string was truncated, we only wrote until the size of buffer. */
+	ret = min_t(u32, ret + 1, MAX_BPRINTF_BUF);
+	ret = bpf_stream_push_str(stream, data.buf, ret);
+	bpf_bprintf_cleanup(&data);
+
+	return ret;
+}
+
+__bpf_kfunc struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, void *aux__ign)
+{
+	struct bpf_prog_aux *aux = aux__ign;
+
+	if (stream_id != BPF_STDOUT && stream_id != BPF_STDERR)
+		return NULL;
+	return &aux->stream[stream_id - 1];
+}
+
+__bpf_kfunc void bpf_stream_free_elem(struct bpf_stream_elem *elem)
+{
+	struct bpf_stream_page *p;
+
+	p = bpf_stream_page_from_elem(elem);
+	bpf_stream_page_put(p);
+}
+
+static void bpf_stream_free_list(struct llist_node *list)
+{
+	struct bpf_stream_elem *elem, *tmp;
+
+	llist_for_each_entry_safe(elem, tmp, list, node)
+		bpf_stream_free_elem(elem);
+}
+
+static struct llist_node *bpf_stream_backlog_pop(struct bpf_stream *stream)
+{
+	struct llist_node *node;
+
+	node = stream->backlog_head;
+	if (stream->backlog_head == stream->backlog_tail)
+		stream->backlog_head = stream->backlog_tail = NULL;
+	else
+		stream->backlog_head = node->next;
+	return node;
+}
+
+static struct llist_node *bpf_stream_log_pop(struct bpf_stream *stream)
+{
+	struct llist_node *node, *head, *tail;
+	unsigned long flags;
+
+	if (llist_empty(&stream->log))
+		return NULL;
+	tail = llist_del_all(&stream->log);
+	if (!tail)
+		return NULL;
+	head = llist_reverse_order(tail);
+
+	if (raw_res_spin_lock_irqsave(&stream->lock, flags)) {
+		bpf_stream_free_list(head);
+		return NULL;
+	}
+
+	if (!stream->backlog_head) {
+		stream->backlog_head = head;
+		stream->backlog_tail = tail;
+	} else {
+		stream->backlog_tail->next = head;
+		stream->backlog_tail = tail;
+	}
+
+	node = bpf_stream_backlog_pop(stream);
+	raw_res_spin_unlock_irqrestore(&stream->lock, flags);
+
+	return node;
+}
+
+__bpf_kfunc struct bpf_stream_elem *bpf_stream_next_elem(struct bpf_stream *stream)
+{
+	struct bpf_stream_elem *elem = NULL;
+	struct llist_node *node;
+	unsigned long flags;
+
+	if (raw_res_spin_lock_irqsave(&stream->lock, flags))
+		return NULL;
+	node = bpf_stream_backlog_pop(stream);
+	if (!node)
+		goto unlock;
+unlock:
+	raw_res_spin_unlock_irqrestore(&stream->lock, flags);
+
+	if (node)
+		goto end;
+
+	node = bpf_stream_log_pop(stream);
+	if (!node)
+		return NULL;
+end:
+	elem = container_of(node, typeof(*elem), node);
+	bpf_stream_release_capacity(stream, elem);
+	return elem;
+}
+
+__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(enum bpf_stream_id stream_id, u32 prog_id)
+{
+	struct bpf_stream *stream;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_by_id(prog_id);
+	if (IS_ERR_OR_NULL(prog))
+		return NULL;
+	stream = bpf_stream_get(stream_id, prog->aux);
+	if (!stream)
+		bpf_prog_put(prog);
+	return stream;
+}
+
+__bpf_kfunc void bpf_prog_stream_put(struct bpf_stream *stream)
+{
+	enum bpf_stream_id stream_id = stream->stream_id;
+	struct bpf_prog *prog;
+
+	prog = container_of(stream, struct bpf_prog_aux, stream[stream_id - 1])->prog;
+	bpf_prog_put(prog);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(stream_kfunc_set)
+BTF_ID_FLAGS(func, bpf_stream_get, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_next_elem, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_free_elem, KF_RELEASE)
+BTF_KFUNCS_END(stream_kfunc_set)
+
+BTF_KFUNCS_START(stream_syscall_kfunc_set)
+BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_prog_stream_put, KF_RELEASE)
+BTF_KFUNCS_END(stream_syscall_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_stream_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &stream_kfunc_set,
+};
+
+static const struct btf_kfunc_id_set bpf_stream_syscall_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &stream_syscall_kfunc_set,
+};
+
+static int __init bpf_stream_kfunc_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_stream_kfunc_set);
+	if (ret)
+		return ret;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_stream_syscall_kfunc_set);
+}
+late_initcall(bpf_stream_kfunc_init);
+
+void bpf_prog_stream_init(struct bpf_prog *prog)
+{
+	int i;
+
+	prog->aux->stream[0].stream_id = BPF_STDOUT;
+	prog->aux->stream[1].stream_id = BPF_STDERR;
+
+	for (i = 0; i < ARRAY_SIZE(prog->aux->stream); i++) {
+		atomic_set(&prog->aux->stream[i].capacity, 0);
+		init_llist_head(&prog->aux->stream[i].log);
+		raw_res_spin_lock_init(&prog->aux->stream[i].lock);
+		prog->aux->stream[i].backlog_head = NULL;
+		prog->aux->stream[i].backlog_tail = NULL;
+	}
+}
+
+void bpf_prog_stream_free(struct bpf_prog *prog)
+{
+	struct llist_node *list;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(prog->aux->stream); i++) {
+		list = llist_del_all(&prog->aux->stream[i].log);
+		bpf_stream_free_list(list);
+		bpf_stream_free_list(prog->aux->stream[i].backlog_head);
+	}
+}
+
+void bpf_stream_stage_init(struct bpf_stream_stage *ss)
+{
+	init_llist_head(&ss->log);
+	ss->len = 0;
+}
+
+void bpf_stream_stage_free(struct bpf_stream_stage *ss)
+{
+	struct llist_node *node;
+
+	node = llist_del_all(&ss->log);
+	bpf_stream_free_list(node);
+}
+
+int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...)
+{
+	struct bpf_bprintf_buffers *buf;
+	va_list args;
+	int ret;
+
+	if (bpf_try_get_buffers(&buf))
+		return -EBUSY;
+
+	va_start(args, fmt);
+	ret = vsnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
+	va_end(args);
+	/* If the string was truncated, we only wrote until the size of buffer. */
+	ret = min_t(u32, ret + 1, ARRAY_SIZE(buf->buf));
+	ss->len += ret;
+	ret = __bpf_stream_push_str(&ss->log, buf->buf, ret);
+	bpf_put_buffers();
+	return ret;
+}
+
+int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
+			    enum bpf_stream_id stream_id)
+{
+	struct llist_node *list, *head, *tail;
+	struct bpf_stream *stream;
+	int ret;
+
+	stream = bpf_stream_get(stream_id, prog->aux);
+	if (!stream)
+		return -EINVAL;
+
+	ret = bpf_stream_consume_capacity(stream, ss->len);
+	if (ret)
+		return ret;
+
+	list = llist_del_all(&ss->log);
+	head = list;
+
+	if (!list)
+		return 0;
+	while (llist_next(list)) {
+		tail = llist_next(list);
+		list = tail;
+	}
+	llist_add_batch(head, tail, &stream->log);
+	return 0;
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index df33d19c5c3b..60778be870e3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -576,7 +576,7 @@ static bool can_alloc_pages(void)
 		!IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
-static struct page *__bpf_alloc_page(int nid)
+struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
 		return try_alloc_pages(nid, 0);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff34e68c9237..aba0b38733bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12117,6 +12117,7 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
 	KF_bpf_dynptr_from_mem_slice,
+	KF_bpf_stream_get,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -12221,6 +12222,7 @@ BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, bpf_dynptr_from_mem_slice)
+BTF_ID(func, bpf_stream_get)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -13886,10 +13888,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
 
-			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
+			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache]) {
 				regs[BPF_REG_0].type |= PTR_UNTRUSTED;
-
-			if (is_iter_next_kfunc(&meta)) {
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_stream_get]) {
+				regs[BPF_REG_0].type |= PTR_TRUSTED;
+			} else if (is_iter_next_kfunc(&meta)) {
 				struct bpf_reg_state *cur_iter;
 
 				cur_iter = get_iter_from_state(env->cur_state, &meta);
@@ -21521,8 +21524,10 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
-	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
-		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(BPF_REG_4, (long)env->prog->aux) };
+	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id) ||
+		   desc->func_id == special_kfunc_list[KF_bpf_stream_get]) {
+		u32 regno = is_bpf_wq_set_callback_impl_kfunc(desc->func_id) ? BPF_REG_4 : BPF_REG_2;
+		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(regno, (long)env->prog->aux) };
 
 		insn_buf[0] = ld_addrs[0];
 		insn_buf[1] = ld_addrs[1];
-- 
2.47.1


