Return-Path: <bpf+bounces-58877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE1AC2CD8
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69977A413CC
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891A1DF970;
	Sat, 24 May 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEIJ/6Hf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644412A177
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049537; cv=none; b=rtIsFNkXydGc1WDc5ioia4tDG019CZApen6FQDgHFVk428+uNtztwfvhHrd8EllRppFqwIMJ4+O0qpvT5Np1vXb3WbBSRVsPMshVtvRVAnp3t6a495Sf4Z2Rro+n25QXYATB17zmSt5ekClPI2UVU4b5WzhUd2n2kmWVOxfkHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049537; c=relaxed/simple;
	bh=muDZ/Zrrhh9xqOBx+UzC9uStBcYb36MiFyPRT2rWPPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZLemWnHkDRlBF2Bv8p9D+4NK06ptSu0mEIMnkXKTevnosNSzlqNpPdSnFlUi626ss81u5u/jurZdimArR4HRYhV0HkvQERxflohqghVRgeAgjraCgh457m6LS3Ly8/x+I5eSuYdg+OOKX3g05MDEE+fScoKe22xpWKWgJxl0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEIJ/6Hf; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so4603455e9.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049532; x=1748654332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoZi2CBTvsoZsFQBKSA8VZdkH5vwIAbuJbNSuBgYHcI=;
        b=eEIJ/6HfIb4jFayx4JZlBAJj5uEenKcrUqEIyIeR/+whWr2iKbX6068gKY59lOISPW
         IerNo6YxNvkWIcP8B19K0ahHs9wunQN33QNolXpyGdlcNZwdaMNyjyCUN5PFf4pTsmSO
         NZTjh1FO3bG81qZWAiydOdZJhx65PsoKtIGuuB6wpJlzWTCME/4bUzUPfKbiLtC2ItLi
         T4CgG1Mrnek80u0znsyMd+oVrRTP8/JBQSGjz2d+2pXFCu7UGpru/2er3g/AcfZfdcTe
         LXCYsngJvSw2p9bEj4QBpAGDw4Akpk3W/obRjEzfIZjzPk47muyE3ojeld3C8760L49E
         34Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049532; x=1748654332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoZi2CBTvsoZsFQBKSA8VZdkH5vwIAbuJbNSuBgYHcI=;
        b=TzTqRogJohaTL21MBvqZ2F8jO6CLez/iIVciyLc3D0u4xNjV8aiAJdFx+bYLu4jYtC
         dSYcVGhtO8KFYHmImNV3J7jH2vuFVagHAI3K7J2ayFo8XKr5Jf/PT6lu4oQHR5mZVuf0
         bw6a/E263q3kjIBzw1niSMuRRu5vOdXfKPG0QbVvT4eY3o/L0N3f3OnslKctpxtUqtiv
         McIH41B2UJFBiV8JbyDwlHqpd5MTEM/wRJeMa5F4HCJa3wmDDThr7P8WaXHaaV6Q4iWO
         mDx3pVikEL+txRhlhPngUi4k7fFFunqfPG0zUWD8sV6BFCplxnBs9/U8RlUzykupF7yq
         MCsw==
X-Gm-Message-State: AOJu0YyK8DFuCE6cUcr8eQHg/pMHFMtYIWtVSGTTKFtQkGomdaZ7OfPw
	F25XB5sLW6AUD52yumEJy1LisM6idMSsCgLDjl+c4UqwjOyk8b1w2FgQXCZxZ8xog1U=
X-Gm-Gg: ASbGncuOwbUp5lty2U2O2HU+IhA2o3c6R4E2nGeSJZv4cRVzENSA4R0j7rwj7mtZPph
	0qCnAcllLnGg+eEvKp17ApN8GLQRtINe3PItLUtTjzhnKNWZl/Q+OqB+H+jdsi5cUDJa5HmugdC
	P1qQBc61CR6H6lx9igFzk8tUASGUU07FUMVnyq6rVenGntAEm3J+LZFt7VgsZGwKA3gIvYjQkBo
	U9k63GyO/FuyWlCoxKbQffLII5+5nfIE4tJVhiShUeqtZiLBXkq9PMC+s8C2/TvHH+youtyjvuh
	By5mqVUZA6xXsy1jn7yVTlBt41TGEPFxzdiOtqC7qA==
X-Google-Smtp-Source: AGHT+IH4MyT4T4pQM/miBiZRRxKxr8s2Cfytlr6YYfnqbiefQeKO4HUA7JT0zJODC3RMUWWirQu2WA==
X-Received: by 2002:a5d:5f8b:0:b0:3a3:655e:d472 with SMTP id ffacd0b85a97d-3a4cb488fb3mr975698f8f.47.1748049532000;
        Fri, 23 May 2025 18:18:52 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62961sm27800973f8f.49.2025.05.23.18.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 01/11] bpf: Introduce BPF standard streams
Date: Fri, 23 May 2025 18:18:39 -0700
Message-ID: <20250524011849.681425-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=32409; h=from:subject; bh=muDZ/Zrrhh9xqOBx+UzC9uStBcYb36MiFyPRT2rWPPQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3Oyv7ZIGPRTA3n+gukSDW8+F821ZBFYq5pMY2k KSN6966JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzgAKCRBM4MiGSL8RypGOD/ wOL1HUgYrUNv08iZMh+IfVHW1TOAulJWFlgnwe4zegwTMJbaBBgmHVz9pCIPz7zDaCilUk0BUssRiK ZxWFIoJfMEja0wEjzTWXQ322YUC3Ubo+2OIKtJO78sBniLmD++7EtHBJ5plEzsGz9BOwKDlYNJaF/9 61djjrzPq0tj8jTXOF/gdrHTM74JRBCXGaEhjpLoax49lDJ74w2oEBohp6Y2aZ9l5H1ofhsCJwA32a UXOS5pgv/2u6tedyff8fivgq0XU4bqkrhcE/KGJidcKisetCg8+QDfjV9dH71G+J3tAYIq3Kyi9DZp NdsWCZwksHSJX8OaKLXIPxLwGHDO88SzQ4kl0aCrF7DpX5Vz4YNaADtCintdkIpAOEer7Iypt9iwfL fGYQzbQs864SdVuyVcUfHPM1tIMhjZb3Q/59hea6Pqr5texsCH2pFptSKxzHJlhNMU0Zi7wt6DILYH i0OAt4puzvfmYMCZ5UkrwMfcD7W8F5GNxX4SGLTlp95Vu7VbfXNER+3GfhaX5/pr4yxRi6WPDor0d5 CWnrP2b2i5WmvlqOjbiO0cy1W3/NDVPHfUxFiy3wyDJN9ZUEXG5RYiA/fn+L3lYKyMgDaPVGeZOMZu 2E4AOMPMcmhG/xU3SUVA/mlZIphKINK7oRQxzC4X7CwfW6GEQxIXvq+6YfaA==
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
 include/linux/bpf.h            |  73 ++++-
 include/uapi/linux/bpf.h       |  19 ++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/core.c              |  12 +
 kernel/bpf/helpers.c           |  26 +-
 kernel/bpf/stream.c            | 497 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  27 +-
 kernel/bpf/verifier.c          |   5 +-
 tools/include/uapi/linux/bpf.h |  19 ++
 9 files changed, 659 insertions(+), 21 deletions(-)
 create mode 100644 kernel/bpf/stream.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b25d278409b..d298746f4dcc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1538,6 +1538,41 @@ struct btf_mod_pair {
 
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
@@ -1646,6 +1681,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	struct bpf_stream stream[2];
 };
 
 struct bpf_prog {
@@ -2405,6 +2441,8 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
+
+struct page *__bpf_alloc_page(int nid);
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG
@@ -3543,6 +3581,16 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
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
@@ -3550,9 +3598,32 @@ struct bpf_bprintf_data {
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
+int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, int len);
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
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 16e95398c91c..137993ff63bd 100644
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
 
@@ -1842,6 +1854,13 @@ union bpf_attr {
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
index c1113b74e1e2..8598fdad25a4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -762,22 +762,13 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
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
 
@@ -793,16 +784,21 @@ static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
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
@@ -817,7 +813,7 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
 	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
@@ -833,7 +829,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (get_buffers && try_get_buffers(&buffers))
+	if (get_buffers && bpf_try_get_buffers(&buffers))
 		return -EBUSY;
 
 	if (data->get_bin_args) {
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
new file mode 100644
index 000000000000..b9e6f7a43b1b
--- /dev/null
+++ b/kernel/bpf/stream.c
@@ -0,0 +1,497 @@
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
+	unsigned long flags;
+
+	if (raw_res_spin_lock_irqsave(&stream->lock, flags))
+		return -EDEADLK;
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
+		ret = copy_to_user_nofault(buf + pos, elem->str + cons_len,
+					   elem->consumed_len - cons_len);
+		/* Restore in case of error. */
+		if (ret) {
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
+	raw_res_spin_unlock_irqrestore(&stream->lock, flags);
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
+	/* If the string was truncated, we only wrote until the size of buffer. */
+	ret = min_t(u32, ret + 1, MAX_BPRINTF_BUF);
+	ret = bpf_stream_push_str(stream, data.buf, ret);
+	bpf_bprintf_cleanup(&data);
+
+	return ret;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(stream_kfunc_set)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(stream_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_stream_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &stream_kfunc_set,
+};
+
+static int __init bpf_stream_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_stream_kfunc_set);
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
index 4b5f29168618..49868e2693c4 100644
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
@@ -5794,6 +5794,28 @@ static int token_create(union bpf_attr *attr)
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
@@ -5930,6 +5952,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
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
index d5807d2efc92..5ab8742d2c00 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13882,10 +13882,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
 
-			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
+			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache]) {
 				regs[BPF_REG_0].type |= PTR_UNTRUSTED;
-
-			if (is_iter_next_kfunc(&meta)) {
+			} else if (is_iter_next_kfunc(&meta)) {
 				struct bpf_reg_state *cur_iter;
 
 				cur_iter = get_iter_from_state(env->cur_state, &meta);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 16e95398c91c..137993ff63bd 100644
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
 
@@ -1842,6 +1854,13 @@ union bpf_attr {
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


