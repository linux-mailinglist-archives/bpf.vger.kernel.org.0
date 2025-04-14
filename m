Return-Path: <bpf+bounces-55877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4DDA8883F
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B46C1899491
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD15127FD6F;
	Mon, 14 Apr 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jveYapVA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1927FD64
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647299; cv=none; b=LfsA3nEMVm5udkMYvRd3syHZZLL7fmywbTNo/C46yMLmGSNrou9ZTjqhyCvxuu8LO9YrN4B17hRk6isB3G7bkhUwXhvEP8vfq7FQdUHLCrXYfyKMgN2oPDdjImYat8iit2Y8Qz/n/4MB/CLpsqcRkeX63pSdvT+jP6z1VvSeVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647299; c=relaxed/simple;
	bh=cfy66DLdMTvAr6hCIr3AEk7P6uJbnD0rpLIPq6Ytq/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKHvxOhpIHAfz97iw/PC686KQBfr/UzUUSUliSXybWwDcK70WkfesmmnPv7svAv5iXDi43Zfm98VKM8SKTkn7meOs9XtH2IPcYan9SAdjVAQ9OG2rvjgZNx6EOfYmn3BO3KJ9O5cxV4iVPDKoAw/0AKuUUu+BQPdXwSM7L683F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jveYapVA; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43ede096d73so33210045e9.2
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647294; x=1745252094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5aN3cvZmVyWs8VU57+B9U0owlcvqzJJn0Fwc0DikgM=;
        b=jveYapVANZtxkH50lCY+uOeztMuaGVlcKawARFtdS9rwa93TMwtGanpQ6a81YgRkJ+
         N0g0VrLa1iodSh3RiGrBoIJoVbM0fO7kmGw7N6HiL5iaxcmeGN/sbA0EDbd3UMejb9wr
         uMNR0zahxYaFPzaEWrQM0SVoJfC2U01jNf94cXu+Cnw/ysn5GF0L5KNJaWWXhsBOasTw
         K+gkMgctCCJH9LTAeNt1uePsns3wUleqO10WojNOTwNQoBkCUZGrc4IbHE7kQ7OHG9b/
         yLei0mZCLh4oZatb5/r5E6ET2g/Iu9mUZfYBU4KwYc1lNGix1ShWPBZ3UzX5tSOXFYaQ
         L9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647294; x=1745252094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5aN3cvZmVyWs8VU57+B9U0owlcvqzJJn0Fwc0DikgM=;
        b=GdaVvTmwgoB0VUEHKnb5Y0OJesRnlYZS8Nq8OHbvLxORb934bpZbll67xBsq/7ltP6
         aDXmbP1NHcBTp4mPOlaT2tfEXFeOHKE44UvYz6doLIoGnlMNxRL3BL74SENMfxz2wT/E
         NW2wCQ1/LEb2hZuSfwIcmVYmxP8SNbS4+JwkZj+XKHC67UbNFvE8li6iuayOitdTPvuT
         NWw+o0jZOv30dbGBCGg7Q/5gzx6B//hbgRAjgXXERBtRojLhIECeSYZw5b+RkxRfVYAD
         nkYMkweC6U8NPk1N3A5SOiRPoslF/Gw6j4ZaUpb/qg3tZXNKTdVtW9Ku6Qr6Pmjy65dR
         Q5Uw==
X-Gm-Message-State: AOJu0Yx2ZC3GYmwSPDs1O1J0h1mNBPxlNvi5OY3aZDoLMXuMOdusf1m8
	UPsWxvZBLU/teEVIcteQjluH94brFTQ5Q+LX4FpY589zyBwLFxcR+BryfcD+cQA=
X-Gm-Gg: ASbGncuxUQwU/PYOeewNqkcQhR5XbhHpRQQETYIoMeOum6IEHpHZOluF1zFeoZWr6Bi
	At5BK0/lJcxveSsvVNwgZx10vZIInZLqDg0YMFTYztTLVDUYoF7sjmtLS5EINppJ3gN3sIE5zUP
	Zlr2k5+A21HDECXVcOINX77kSApPM5Lm/YfacvKfeqso9L4Uv5mqV1b1YNz7NVKT127kTNoknTq
	aAPILNoLK65As+Gytj/amWfEFvK+bRlXvW2+cViTyPKoWMAYd+jhNvvDAAskZ16WnhofERc04Np
	WS7MO0bFwlApXsKPaCVa28PYbn4=
X-Google-Smtp-Source: AGHT+IHZANKspI6vouwPZ3z7VMJLtfTWF9yV8i6lHkjKJf7M7/ag7zVbe6WCv1OrD78FOWB18JufnQ==
X-Received: by 2002:a05:600c:5494:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-43f3a93d850mr119814045e9.11.1744647293975;
        Mon, 14 Apr 2025 09:14:53 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96bdb5sm11285869f8f.21.2025.04.14.09.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 07/13] bpf: Introduce per-prog stdout/stderr streams
Date: Mon, 14 Apr 2025 09:14:37 -0700
Message-ID: <20250414161443.1146103-8-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26489; h=from:subject; bh=cfy66DLdMTvAr6hCIr3AEk7P6uJbnD0rpLIPq6Ytq/s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOJxKo92/tTDnVw8ePru7Mi0nDnc0e5abxd3tHD KSnUxTOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0ziQAKCRBM4MiGSL8RymI3D/ 9bShAdS1Yea3T3dgMMmM9l4v5QWydsSJfg/7nmYy+lQEwS0SKCDJH/n5bPOJb1+m4KZ35jJwU7FM0W 0DJIN7XAuNaBE0JDTKc/EXlM+7JG5WeA5Ng6nwUqOG3t7ThiExMvO8Mw3SPe3HtZVV/Fj7BqLMG6qw pTCBNDLv8VJ2pLR/6yaM4zALGKNK/f/S0TI34VvM17IILQ5cZWg8ssn5uv/E7gztldYOQy37HfWlW6 M9uXRHO7oLGEWPCYkN+M3Y77Mt0w+jEVm6lHYTWKZwOWa8Cw1sIAaLBzYMiaohRjDJmCL5hG/yfle9 c9RxFtMOHtktAoGIG4rdUEEC/SK0+mQCxRSNj4I9lYnGShAQc6xViDE/Qox+nyLzRm71PFrCFZ+Gq2 1QXt32dEtyjdyM9dfD/Go5Rlp+0uR7N4S8G+wT77dipKWa2zivuj+2E7iFypKixARRi4ddrXFFW7Ub +JnsJvi8Wrqc5XdtRzhVj0lasuO+2pGAZegeiWoFsL41svrmfkgv4XVQ5oX2FQXf7BHCRgFDUVRASp yvoquH1neRwPGNGvuznCLuVu8U5nYEzHfTN4hupDnO+Gk4oV0RTNcM0/1UUh568xHelnHx2LY61Jsq 9ENIxXYB4DGO+k6prwPamhluteVE5Gc2km3ZWx7uSw5vi4xpRXlxPNqUYCPw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce a set of kfuncs to implement per BPF program stdout and stderr
streams. This is implemented as a linked list of dynamically allocated
strings whenever a message is printed. This can be done by the kernel or
the program itself using the bpf_prog_stream_vprintk kfunc. In-kernel
wrappers are provided over streams to ease the process.

The idea is that everytime messages need to be dumped, the reader would
pull out the whole batch of messages from the stream at once, and then
pop each string one by one and start printing it out (how exactly is
left up to the BPF program reading the log, but usually it will be
streaming data back into a ring buffer that is consumed by user space).

The use of a lockless list warrants that we be careful about the
ordering of messages. When being added, the order maintained is new to
old, therefore after deletion, we must reverse the list before iterating
and popping out elements from it.

Overall, this infrastructure provides NMI-safe any context printing
built on top of the NMI-safe any context bpf_mem_alloc() interface.

Later patches will add support for printing splats in case of BPF arena
page faults, rqspinlock deadlocks, and cond_break timeouts.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  52 ++++-
 kernel/bpf/Makefile   |   2 +-
 kernel/bpf/core.c     |  12 +
 kernel/bpf/helpers.c  |  26 +--
 kernel/bpf/stream.c   | 496 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c  |   2 +-
 kernel/bpf/verifier.c |  15 +-
 7 files changed, 582 insertions(+), 23 deletions(-)
 create mode 100644 kernel/bpf/stream.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9feaa9bbf0a4..ae2ddd3bdea1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1523,6 +1523,36 @@ struct btf_mod_pair {
 
 struct bpf_kfunc_desc_tab;
 
+enum bpf_stream_id {
+	BPF_STDOUT = 1,
+	BPF_STDERR = 2,
+};
+
+enum {
+	BPF_STREAM_ELEM_F_PAGE	= (1 << 0),
+	BPF_STREAM_ELEM_F_NEXT  = (1 << 1),
+	BPF_STREAM_ELEM_F_MASK	= (BPF_STREAM_ELEM_F_PAGE | BPF_STREAM_ELEM_F_NEXT),
+};
+
+struct bpf_stream_elem {
+	struct llist_node node;
+	struct bpf_mem_slice mem_slice;
+	union {
+		unsigned long flags;
+		struct bpf_stream_elem *next;
+	};
+	char str[];
+};
+
+struct bpf_stream_elem_batch {
+	struct llist_node *node;
+};
+
+struct bpf_stream {
+	enum bpf_stream_id stream_id;
+	struct llist_head log;
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1631,6 +1661,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	struct bpf_stream stream[2];
 };
 
 struct bpf_prog {
@@ -2390,6 +2421,8 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
+
+struct page *__bpf_alloc_page(int nid);
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG
@@ -3528,6 +3561,16 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
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
@@ -3535,9 +3578,16 @@ struct bpf_bprintf_data {
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
+__printf(2, 3)
+int bpf_prog_stderr_printk(struct bpf_prog *prog, const char *fmt, ...);
 
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
index ba6b6118cf50..1bfc6f7ea3da 100644
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
 
@@ -2856,6 +2860,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	aux = container_of(work, struct bpf_prog_aux, work);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
+	bpf_prog_stream_free(aux->prog);
 #endif
 #ifdef CONFIG_CGROUP_BPF
 	if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
@@ -2872,6 +2877,13 @@ static void bpf_prog_free_deferred(struct work_struct *work)
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
index 95e9c9df6062..7f59367b1101 100644
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
index 000000000000..2019ce134310
--- /dev/null
+++ b/kernel/bpf/stream.c
@@ -0,0 +1,496 @@
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
+ * Ideally, we'd have a kmalloc() equivalent that just allowed allocating items
+ * of different sizes directly leading to less fragmentation overall. Let's use
+ * this scheme until support for that arrives, and when we cannot capture memory
+ * from bpf_mem_alloc() reserves.
+ */
+
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
+	return rem < 8 ? 0 : rem;
+}
+
+static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
+{
+	init_llist_node(&elem->node);
+	elem->mem_slice.ptr = elem->str;
+	elem->mem_slice.len = len;
+	elem->flags = 0;
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
+	struct bpf_stream_elem *elem = NULL, *next_elem;
+	struct bpf_stream_page *p1, *p2;
+	int room = 0;
+
+	p1 = this_cpu_read(stream_pcpu_page);
+	if (!p1)
+		p1 = bpf_stream_page_replace();
+	if (!p1)
+		return NULL;
+
+	room = bpf_stream_page_check_room(p1, len);
+	room = min(len, room);
+
+	/*
+	 * We have three cases to handle, all data in first page, some in first
+	 * and some in second page, and all data in second page.
+	 *
+	 * Some or all data in first page, bump p1's refcount.
+	 */
+	if (room)
+		bpf_stream_page_get(p1);
+
+	/* Some or all data in second page, replace p1 with it. */
+	if (room < len) {
+		p2 = bpf_stream_page_replace();
+		if (!p2) {
+			bpf_stream_page_put(p1);
+			return NULL;
+		}
+		bpf_stream_page_get(p2);
+	}
+
+	if (!room)
+		goto second;
+
+	elem = bpf_stream_page_push_elem(p1, room);
+	bpf_stream_elem_init(elem, room);
+	elem->flags |= BPF_STREAM_ELEM_F_PAGE;
+
+	if (room == len)
+		return elem;
+second:
+	next_elem = bpf_stream_page_push_elem(p2, len - room);
+	bpf_stream_elem_init(next_elem, len - room);
+	next_elem->flags |= BPF_STREAM_ELEM_F_PAGE;
+	if (!room)
+		return next_elem;
+
+	elem->next = next_elem;
+	elem->flags |= (BPF_STREAM_ELEM_F_PAGE | BPF_STREAM_ELEM_F_NEXT);
+	return elem;
+}
+
+static struct bpf_stream_elem *bpf_stream_elem_alloc_from_bpf_ma(int len)
+{
+	struct bpf_stream_elem *elem;
+
+	elem = bpf_mem_alloc(&bpf_global_ma, offsetof(typeof(*elem), str[len]));
+	if (!elem)
+		return NULL;
+	bpf_stream_elem_init(elem, len);
+	return elem;
+}
+
+static struct bpf_stream_elem *bpf_stream_elem_alloc_from_stream_page(int len)
+{
+	struct bpf_stream_elem *elem;
+	unsigned long flags;
+
+	/*
+	 * Let's not try any harder, caller tried bpf_mem_alloc() before us, so
+	 * we've exhausted the per-CPU caches and cannot refill, and so we're
+	 * either an NMI hitting between the local_lock() critical section, or
+	 * some nested program invocation in that path (e.g. in RT, preemption
+	 * is enabled, hardirq (apart from NMIs) are still allowed, etc.).
+	 */
+	if (!bpf_stream_page_local_lock(&flags))
+		return NULL;
+	elem = bpf_stream_page_reserve_elem(len);
+	bpf_stream_page_local_unlock(&flags);
+	return elem;
+}
+
+static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
+{
+	const int max_len = ARRAY_SIZE((struct bpf_bprintf_buffers){}.buf);
+	struct bpf_stream_elem *elem;
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
+	elem = bpf_stream_elem_alloc_from_bpf_ma(len);
+	if (!elem)
+		elem = bpf_stream_elem_alloc_from_stream_page(len);
+	return elem;
+}
+
+__bpf_kfunc_start_defs();
+
+static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
+{
+	struct bpf_stream_elem *elem, *next = NULL;
+	int room = 0, rem = 0;
+
+	/*
+	 * Allocate a bpf_prog_stream_elem and push it to the bpf_prog_stream
+	 * log, elements will be popped at once and reversed to print the log.
+	 */
+	elem = bpf_stream_elem_alloc(len);
+	if (!elem)
+		return -ENOMEM;
+	room = elem->mem_slice.len;
+	if (elem->flags & BPF_STREAM_ELEM_F_NEXT) {
+		next = (struct bpf_stream_elem *)((unsigned long)elem->next & ~BPF_STREAM_ELEM_F_MASK);
+		rem = next->mem_slice.len;
+	}
+
+	memcpy(elem->str, str, room);
+	if (next)
+		memcpy(next->str, str + room, rem);
+
+	if (next) {
+		elem->node.next = &next->node;
+		next->node.next = NULL;
+
+		llist_add_batch(&elem->node, &next->node, &stream->log);
+	} else {
+		llist_add(&elem->node, &stream->log);
+	}
+
+	return 0;
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
+__bpf_kfunc struct bpf_stream_elem_batch *bpf_stream_next_elem_batch(struct bpf_stream *stream)
+{
+	struct bpf_stream_elem_batch *elem_batch;
+	struct llist_node *batch;
+
+	if (llist_empty(&stream->log))
+		return NULL;
+	/* Allocate our cursor. */
+	migrate_disable();
+	elem_batch = bpf_mem_alloc(&bpf_global_ma, sizeof(*elem_batch));
+	migrate_enable();
+	if (!elem_batch)
+		return NULL;
+	/*
+	 * This is the linearization point for the readers; every reader
+	 * consumes the whole batch of messages queued on the stream at this
+	 * point, and can see everything queued before this. Anything that is
+	 * queued after this can only be observed if the next batch is
+	 * requested.
+	 */
+	batch = llist_del_all(&stream->log);
+	batch = llist_reverse_order(batch);
+	elem_batch->node = batch;
+	return elem_batch;
+}
+
+__bpf_kfunc struct bpf_stream_elem *
+bpf_stream_next_elem(struct bpf_stream_elem_batch *elem_batch)
+{
+	struct llist_node *node = elem_batch->node;
+	struct bpf_stream_elem *elem;
+
+	if (!node)
+		return NULL;
+	elem = container_of(node, struct bpf_stream_elem, node);
+	elem_batch->node = node->next;
+	return elem;
+}
+
+__bpf_kfunc void bpf_stream_free_elem(struct bpf_stream_elem *elem)
+{
+	struct bpf_stream_page *p;
+
+	if (elem->flags & BPF_STREAM_ELEM_F_PAGE) {
+		p = bpf_stream_page_from_elem(elem);
+		bpf_stream_page_put(p);
+		return;
+	}
+
+	migrate_disable();
+	bpf_mem_free(&bpf_global_ma, elem);
+	migrate_enable();
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
+__bpf_kfunc void bpf_stream_free_elem_batch(struct bpf_stream_elem_batch *elem_batch)
+{
+
+	migrate_disable();
+	bpf_stream_free_list(elem_batch->node);
+	bpf_mem_free(&bpf_global_ma, elem_batch);
+	migrate_enable();
+}
+
+__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(enum bpf_stream_id stream_id, u32 prog_id)
+{
+	struct bpf_stream *stream;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_by_id(prog_id);
+	if (!prog)
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
+void bpf_prog_stream_init(struct bpf_prog *prog)
+{
+	prog->aux->stream[0].stream_id = BPF_STDOUT;
+	init_llist_head(&prog->aux->stream[0].log);
+
+	prog->aux->stream[1].stream_id = BPF_STDERR;
+	init_llist_head(&prog->aux->stream[1].log);
+}
+
+void bpf_prog_stream_free(struct bpf_prog *prog)
+{
+	struct llist_node *list;
+
+	list = llist_del_all(&prog->aux->stream[0].log);
+	bpf_stream_free_list(list);
+
+	list = llist_del_all(&prog->aux->stream[1].log);
+	bpf_stream_free_list(list);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(stream_kfunc_set)
+BTF_ID_FLAGS(func, bpf_stream_get, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(stream_kfunc_set)
+
+BTF_KFUNCS_START(stream_consumer_kfunc_set)
+BTF_ID_FLAGS(func, bpf_stream_next_elem_batch, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_free_elem_batch, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_stream_next_elem, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_free_elem, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_prog_stream_put, KF_RELEASE)
+BTF_KFUNCS_END(stream_consumer_kfunc_set)
+
+BTF_ID_LIST(bpf_stream_dtor_ids)
+BTF_ID(struct, bpf_stream_elem_batch)
+BTF_ID(func, bpf_stream_free_elem_batch)
+
+static const struct btf_kfunc_id_set bpf_stream_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &stream_kfunc_set,
+};
+
+static const struct btf_kfunc_id_set bpf_stream_consumer_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &stream_consumer_kfunc_set,
+};
+
+static int __init bpf_stream_kfunc_init(void)
+{
+	const struct btf_id_dtor_kfunc bpf_stream_dtors[] = {
+		{
+			.btf_id		= bpf_stream_dtor_ids[0],
+			.kfunc_btf_id	= bpf_stream_dtor_ids[1],
+		},
+	};
+	int ret;
+
+	ret = register_btf_id_dtor_kfuncs(bpf_stream_dtors, ARRAY_SIZE(bpf_stream_dtors), THIS_MODULE);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_stream_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_stream_consumer_kfunc_set);
+}
+late_initcall(bpf_stream_kfunc_init);
+
+int bpf_prog_stderr_printk(struct bpf_prog *prog, const char *fmt, ...)
+{
+	struct bpf_stream *stream = bpf_stream_get(BPF_STDERR, prog->aux);
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
+	ret = bpf_stream_push_str(stream, buf->buf, ret);
+	bpf_put_buffers();
+	return ret;
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6..a8e8286a3d95 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -575,7 +575,7 @@ static bool can_alloc_pages(void)
 		!IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
-static struct page *__bpf_alloc_page(int nid)
+struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
 		return try_alloc_pages(nid, 0);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26aa70cd5734..a1ac856ad078 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12126,6 +12126,7 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
 	KF_bpf_dynptr_from_mem_slice,
+	KF_bpf_stream_get,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -12220,6 +12221,7 @@ BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, bpf_dynptr_from_mem_slice)
+BTF_ID(func, bpf_stream_get)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -13883,10 +13885,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -21520,8 +21523,10 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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


