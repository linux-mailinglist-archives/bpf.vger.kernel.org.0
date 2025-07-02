Return-Path: <bpf+bounces-62038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7647AF091C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04B44E1D53
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C71D54D1;
	Wed,  2 Jul 2025 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmEJm8E5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FEAD51
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426271; cv=none; b=b7aEeS5MP7GjuVxxS8u1gbSVBK5dnHbTeY2MnLL3G6QIAXQAh+00bO//tWl/9koa0CvLQVckF5m8E2Pg6wpU8O04zAqNIErBePThQCkfNA0TEhzYZjL0nHOSNnoblF2lp+zp5CFnP2SzkBOE3v5ZqNzZxznOJXg5hIWEDA2E6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426271; c=relaxed/simple;
	bh=r0Q3s0WS5B1ilis8t80r+fNnfYD8AgFNM5onzA0HuYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Am8wBLeIfXh7g0Kmn+IpVO6AchpSLg5xLfUXA5sxV28lz7lGLGdOjyWc18CvagShvIrdr+rKeGfCy4byTmd/C+TsVTBvNonc9iX9fZ/ENLOusrFcmWES5pR6yrMbIkE13qNZxkBWK4waZIoQPxr6/DwgHCcc7713M74mLzWOilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmEJm8E5; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ade76b8356cso754701766b.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426266; x=1752031066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dARzapxs4MycROu0YwTKyMjSvKpSd76WlqF74ok+uRI=;
        b=dmEJm8E5PRujhnvQYrUGLno02i2I7wLeBLnnNDSsRAuCBJ2neJA0iVAFxLSh7WUHz0
         N/LZ5bhmSgxJJYCC6Fmqsr8urr6kg6klK3l7TfqjhuhpBvBge3ahTQ/qPWQlLf/6Cudn
         FpX6zwQ62R1anFOcTtwLur0VjSySBlFGQr9XY+ONQaVJ/6RkhOP5fXJ4LfiQ4dSGlPhQ
         0igi65ddq5mHfY7ySJgIsxjkah/0eJ0VCEInWOiHCipTsZIuX2Mhf3pxiNVRToa5B8jm
         BeAViqZcts3+9uOwJ8bU/KcOxHM/5F/xc2GzxXH7dqieuhD9K4yfyxk2lt7bQoMjm8LR
         E+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426266; x=1752031066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dARzapxs4MycROu0YwTKyMjSvKpSd76WlqF74ok+uRI=;
        b=dKuJFeoBKQwT6ywuGK0WgJ483rCClnpQF/R94H+FXoYhvRd5KOSbX+9QbxOfObMJIv
         lEN/OkWzz6oN4cEp8ojUd9iaKFtqCCsAh3xab4X3eYcUsqbqvMIqEYQuo/C0h2OuqYGL
         gFJpfJVRNerBHvhXp/ruGU2MRsJcg7XuIBlOu5RA5hrjZHuR71v9sNuJN7tYN1A7SmzB
         LexyqRM/ni3ndEPqyjQ2iKObLYk0Pmu5lVvT2lNW+tJPD1/Eb2q+oRarL51ojCdc4e5W
         OGuwxP+f/sd4yFI9fN+Ssnx0Rfm9w96FAwimvwNpGfmnVpUlU7pHaDMKEJ0D2KH1EtHC
         ef8Q==
X-Gm-Message-State: AOJu0YyUq/XRX/TCT+onQEkThQjyNxniv8sj/Gv+xrjGPrPtCysCAB0M
	18PNg3FbTqJEy08x+hozUnJB3DdiaCsB+sGUOsDndyX/b8wVlRBW0q0ePirnyruGGJg=
X-Gm-Gg: ASbGnctgmZOKIDDghRXMYwcX04ODt9k6MI5MVa/nXRPJk1OB/uzLqDRGQe4qQs8lgkJ
	ntbPXEk7snrSkCZDx4s/5CUlk/nt4hcmdftmGRD2AG4jkp5VoILBXfVfQm33Xc1mDPlQx3p7vEH
	b37JzmNsnxvT2JzeO3cmL1zZIaGWaz5goICjk//pQhWyvhj/mLWtIvR8MXjQNRzB/0sCkkSVlWd
	deris/5Chp0IQFjXMW1ZGawBpv5GkSSj3RYOTOm6M6m1H7+I9Sz759qbf12x/yKIN5y9ZRwHydV
	VJueCEBAmAudHMccBgLoxo+JHSDu0Wt+42MdAqEaMOr4MoWnohU=
X-Google-Smtp-Source: AGHT+IFa0AXJb14gAks3woXZ3OkdoMCKq+MKeBLbvX9/GoYVce2GseZxNuTtsMQezoNPmUor5iuQVA==
X-Received: by 2002:a17:907:7eaa:b0:ae0:3391:f068 with SMTP id a640c23a62f3a-ae3c2c5f52fmr106704266b.19.1751426265986;
        Tue, 01 Jul 2025 20:17:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b35dsm999301766b.13.2025.07.01.20.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 02/12] bpf: Introduce BPF standard streams
Date: Tue,  1 Jul 2025 20:17:27 -0700
Message-ID: <20250702031737.407548-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28314; h=from:subject; bh=r0Q3s0WS5B1ilis8t80r+fNnfYD8AgFNM5onzA0HuYA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFQcJRi/KhcjuAQY7vWGWWJtCD6cxrWNymTmoev fVrljoCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUAAKCRBM4MiGSL8RyhlsEA CxkJEBOyXClB+qncDfegWqcXhioctLnE9QZz+/R8Ss7WrzTsqIOxz3JhsEnnl52rGeNYf6xi2g59G9 3VJxA1WVIwr+X+j0+oYLEv+EmCUy485BqLSP5WvfvLQ/iNEAMU8mr9/j4DvLYAcbC8Nw5FNuUqAOAC 2y0NMEC/5vGGWW4z7ggFhe0op1Zn3YFjVHmva6db3RIwTfk3VNuovpnPHN14fd5/w6hubRwtjTN9Vy a0t4/jZRxMINSmdcz01G4Onmd5CkJVzfqgzY38nuZyTqj0+Tz5JvzySkelTzh2c6h6/o/aVgw5cZmn VWFsehz4AmoiAAZ1uF83kRkJBcIAVPgXQYDUqL8sb0iEvfIS8s9BTNvnHVAekJ6TkEmwgWWrTSEo22 N1nYisEe44Qg8ooh+CzB9CaWKn6gI+y+gOIxApVy+2JtIoTmXNuB7EVWFqDKKWZjOcej9gJe2Ppg41 h5da2sxvkiRjYvrhxkNK4H1NCwn1mFR05mPF6jiVct7SOAD6r1ooTlcxF4z8liZ5SFHZot6uZYowpC psUGpuSm/8SunMPEB589zSLSyEJ5v6WHy2po5iTVEM6UIsCFVrEfh6f3+SWxW7+zMm4Q5/jwGBwqcO gmzg8NXbgf/Q2ENY1+ppIOb9Zlg5xt7e2fgJvmAHSOU6x5YRB7ffyo2kdI1w==
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
obtained using alloc_pages_nolock(). This ensures that we can allocate
memory from any context. The eventual plan is to discard this scheme in
favor of Alexei's kmalloc_nolock() [0].

This record is then locklessly inserted into a list (llist_add()) so
that the printing side doesn't require holding any locks, and works in
any context. Each stream has a maximum capacity of 4MB of text, and each
printed message is accounted against this limit.

Messages from a program are emitted using the bpf_stream_vprintk kfunc,
which takes a stream_id argument in addition to working otherwise
similar to bpf_trace_vprintk.

The bprintf buffer helpers are extracted out to be reused for printing
the string into them before copying it into the stream, so that we can
(with the defined max limit) format a string and know its true length
before performing allocations of the stream element.

For consuming elements from a stream, we expose a bpf(2) syscall command
named BPF_PROG_STREAM_READ_BY_FD, which allows reading data from the
stream of a given prog_fd into a user space buffer. The main logic is
implemented in bpf_stream_read(). The log messages are queued in
bpf_stream::log by the bpf_stream_vprintk kfunc, and then pulled and
ordered correctly in the stream backlog.

For this purpose, we hold a lock around bpf_stream_backlog_peek(), as
llist_del_first() (if we maintained a second lockless list for the
backlog) wouldn't be safe from multiple threads anyway. Then, if we
fail to find something in the backlog log, we splice out everything from
the lockless log, and place it in the backlog log, and then return the
head of the backlog. Once the full length of the element is consumed, we
will pop it and free it.

The lockless list bpf_stream::log is a LIFO stack. Elements obtained
using a llist_del_all() operation are in LIFO order, thus would break
the chronological ordering if printed directly. Hence, this batch of
messages is first reversed. Then, it is stashed into a separate list in
the stream, i.e. the backlog_log. The head of this list is the actual
message that should always be returned to the caller. All of this is
done in bpf_stream_backlog_fill().

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

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |  52 ++++
 include/uapi/linux/bpf.h       |  24 ++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/core.c              |   5 +
 kernel/bpf/helpers.c           |   1 +
 kernel/bpf/stream.c            | 478 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  25 ++
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |  24 ++
 9 files changed, 611 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/stream.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4fff0cee8622..85b1cbe494f5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1538,6 +1538,37 @@ struct btf_mod_pair {
 
 struct bpf_kfunc_desc_tab;
 
+enum bpf_stream_id {
+	BPF_STDOUT = 1,
+	BPF_STDERR = 2,
+};
+
+struct bpf_stream_elem {
+	struct llist_node node;
+	int total_len;
+	int consumed_len;
+	char str[];
+};
+
+enum {
+	/* 100k bytes */
+	BPF_STREAM_MAX_CAPACITY = 100000ULL,
+};
+
+struct bpf_stream {
+	atomic_t capacity;
+	struct llist_head log;	/* list of in-flight stream elements in LIFO order */
+
+	struct mutex lock;  /* lock protecting backlog_{head,tail} */
+	struct llist_node *backlog_head; /* list of in-flight stream elements in FIFO order */
+	struct llist_node *backlog_tail; /* tail of the list above */
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
@@ -1646,6 +1677,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	struct bpf_stream stream[2];
 };
 
 struct bpf_prog {
@@ -2408,6 +2440,7 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
+
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG
@@ -3573,6 +3606,25 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
 void bpf_put_buffers(void);
 
+void bpf_prog_stream_init(struct bpf_prog *prog);
+void bpf_prog_stream_free(struct bpf_prog *prog);
+int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, int len);
+void bpf_stream_stage_init(struct bpf_stream_stage *ss);
+void bpf_stream_stage_free(struct bpf_stream_stage *ss);
+__printf(2, 3)
+int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
+int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
+			    enum bpf_stream_id stream_id);
+
+#define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
+
+#define bpf_stream_stage(ss, prog, stream_id, expr)            \
+	({                                                     \
+		bpf_stream_stage_init(&ss);                    \
+		(expr);                                        \
+		bpf_stream_stage_commit(&ss, prog, stream_id); \
+		bpf_stream_stage_free(&ss);                    \
+	})
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 719ba230032f..0670e15a6100 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -906,6 +906,17 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_PROG_STREAM_READ_BY_FD
+ *	Description
+ *		Read data of a program's BPF stream. The program is identified
+ *		by *prog_fd*, and the stream is identified by the *stream_id*.
+ *		The data is copied to a buffer pointed to by *stream_buf*, and
+ *		filled less than or equal to *stream_buf_len* bytes.
+ *
+ *	Return
+ *		Number of bytes read from the stream on success, or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -961,6 +972,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_PROG_STREAM_READ_BY_FD,
 	__MAX_BPF_CMD,
 };
 
@@ -1463,6 +1475,11 @@ struct bpf_stack_build_id {
 
 #define BPF_OBJ_NAME_LEN 16U
 
+enum {
+	BPF_STREAM_STDOUT = 1,
+	BPF_STREAM_STDERR = 2,
+};
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1849,6 +1866,13 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct {
+		__aligned_u64	stream_buf;
+		__u32		stream_buf_len;
+		__u32		stream_id;
+		__u32		prog_fd;
+	} prog_stream_read;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 3a335c50e6e3..269c04a24664 100644
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
index e536a34a32c8..f0def24573ae 100644
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
 
@@ -2862,6 +2866,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	aux = container_of(work, struct bpf_prog_aux, work);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
+	bpf_prog_stream_free(aux->prog);
 #endif
 #ifdef CONFIG_CGROUP_BPF
 	if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8f1cc1d525db..61fdd343d6f5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3778,6 +3778,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
new file mode 100644
index 000000000000..c4925f8d275f
--- /dev/null
+++ b/kernel/bpf/stream.c
@@ -0,0 +1,478 @@
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
+#include <linux/mutex.h>
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
+	page = alloc_pages_nolock(NUMA_NO_NODE, 0);
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
+	elem->total_len = len;
+	elem->consumed_len = 0;
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
+	int len = elem->total_len;
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
+static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, struct bpf_prog_aux *aux)
+{
+	if (stream_id != BPF_STDOUT && stream_id != BPF_STDERR)
+		return NULL;
+	return &aux->stream[stream_id - 1];
+}
+
+static void bpf_stream_free_elem(struct bpf_stream_elem *elem)
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
+static struct llist_node *bpf_stream_backlog_peek(struct bpf_stream *stream)
+{
+	return stream->backlog_head;
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
+static void bpf_stream_backlog_fill(struct bpf_stream *stream)
+{
+	struct llist_node *head, *tail;
+
+	if (llist_empty(&stream->log))
+		return;
+	tail = llist_del_all(&stream->log);
+	if (!tail)
+		return;
+	head = llist_reverse_order(tail);
+
+	if (!stream->backlog_head) {
+		stream->backlog_head = head;
+		stream->backlog_tail = tail;
+	} else {
+		stream->backlog_tail->next = head;
+		stream->backlog_tail = tail;
+	}
+
+	return;
+}
+
+static bool bpf_stream_consume_elem(struct bpf_stream_elem *elem, int *len)
+{
+	int rem = elem->total_len - elem->consumed_len;
+	int used = min(rem, *len);
+
+	elem->consumed_len += used;
+	*len -= used;
+
+	return elem->consumed_len == elem->total_len;
+}
+
+static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
+{
+	int rem_len = len, cons_len, ret = 0;
+	struct bpf_stream_elem *elem = NULL;
+	struct llist_node *node;
+
+	mutex_lock(&stream->lock);
+
+	while (rem_len) {
+		int pos = len - rem_len;
+		bool cont;
+
+		node = bpf_stream_backlog_peek(stream);
+		if (!node) {
+			bpf_stream_backlog_fill(stream);
+			node = bpf_stream_backlog_peek(stream);
+		}
+		if (!node)
+			break;
+		elem = container_of(node, typeof(*elem), node);
+
+		cons_len = elem->consumed_len;
+		cont = bpf_stream_consume_elem(elem, &rem_len) == false;
+
+		ret = copy_to_user(buf + pos, elem->str + cons_len,
+				   elem->consumed_len - cons_len);
+		/* Restore in case of error. */
+		if (ret) {
+			ret = -EFAULT;
+			elem->consumed_len = cons_len;
+			break;
+		}
+
+		if (cont)
+			continue;
+		bpf_stream_backlog_pop(stream);
+		bpf_stream_release_capacity(stream, elem);
+		bpf_stream_free_elem(elem);
+	}
+
+	mutex_unlock(&stream->lock);
+	return ret ? ret : len - rem_len;
+}
+
+int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, int len)
+{
+	struct bpf_stream *stream;
+
+	stream = bpf_stream_get(stream_id, prog->aux);
+	if (!stream)
+		return -ENOENT;
+	return bpf_stream_read(stream, buf, len);
+}
+
+__bpf_kfunc_start_defs();
+
+/*
+ * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
+ * enum in headers.
+ */
+__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz, void *aux__prog)
+{
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+		.get_buf	= true,
+	};
+	struct bpf_prog_aux *aux = aux__prog;
+	u32 fmt_size = strlen(fmt__str) + 1;
+	struct bpf_stream *stream;
+	u32 data_len = len__sz;
+	int ret, num_args;
+
+	stream = bpf_stream_get(stream_id, aux);
+	if (!stream)
+		return -ENOENT;
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
+	/* Exclude NULL byte during push. */
+	ret = bpf_stream_push_str(stream, data.buf, ret);
+	bpf_bprintf_cleanup(&data);
+
+	return ret;
+}
+
+__bpf_kfunc_end_defs();
+
+/* Added kfunc to common_btf_ids */
+
+void bpf_prog_stream_init(struct bpf_prog *prog)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(prog->aux->stream); i++) {
+		atomic_set(&prog->aux->stream[i].capacity, 0);
+		init_llist_head(&prog->aux->stream[i].log);
+		mutex_init(&prog->aux->stream[i].lock);
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
+	ss->len += ret;
+	/* Exclude NULL byte during push. */
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
+	head = tail = list;
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
index 56500381c28a..8d947c510577 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5936,6 +5936,28 @@ static int token_create(union bpf_attr *attr)
 	return bpf_token_create(attr);
 }
 
+#define BPF_PROG_STREAM_READ_BY_FD_LAST_FIELD prog_stream_read.prog_fd
+
+static int prog_stream_read(union bpf_attr *attr)
+{
+	char __user *buf = u64_to_user_ptr(attr->prog_stream_read.stream_buf);
+	u32 len = attr->prog_stream_read.stream_buf_len;
+	struct bpf_prog *prog;
+	int ret;
+
+	if (CHECK_ATTR(BPF_PROG_STREAM_READ_BY_FD))
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->prog_stream_read.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	ret = bpf_prog_stream_read(prog, attr->prog_stream_read.stream_id, buf, len);
+	bpf_prog_put(prog);
+
+	return ret;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -6072,6 +6094,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_TOKEN_CREATE:
 		err = token_create(&attr);
 		break;
+	case BPF_PROG_STREAM_READ_BY_FD:
+		err = prog_stream_read(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a352b35be479..aa62f1c5920e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -46,6 +46,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 
 enum bpf_features {
 	BPF_FEAT_RDONLY_CAST_TO_VOID = 0,
+	BPF_FEAT_STREAMS	     = 1,
 	__MAX_BPF_FEAT,
 };
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 719ba230032f..0670e15a6100 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -906,6 +906,17 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_PROG_STREAM_READ_BY_FD
+ *	Description
+ *		Read data of a program's BPF stream. The program is identified
+ *		by *prog_fd*, and the stream is identified by the *stream_id*.
+ *		The data is copied to a buffer pointed to by *stream_buf*, and
+ *		filled less than or equal to *stream_buf_len* bytes.
+ *
+ *	Return
+ *		Number of bytes read from the stream on success, or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -961,6 +972,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_PROG_STREAM_READ_BY_FD,
 	__MAX_BPF_CMD,
 };
 
@@ -1463,6 +1475,11 @@ struct bpf_stack_build_id {
 
 #define BPF_OBJ_NAME_LEN 16U
 
+enum {
+	BPF_STREAM_STDOUT = 1,
+	BPF_STREAM_STDERR = 2,
+};
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1849,6 +1866,13 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct {
+		__aligned_u64	stream_buf;
+		__u32		stream_buf_len;
+		__u32		stream_id;
+		__u32		prog_fd;
+	} prog_stream_read;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.47.1


