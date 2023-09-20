Return-Path: <bpf+bounces-10492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3E87A8E84
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171AB1C20A1E
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C75405D4;
	Wed, 20 Sep 2023 21:32:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ECA41A88
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 21:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D09C433C8;
	Wed, 20 Sep 2023 21:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695245554;
	bh=vjRK8abiTY5IO/VOKFmvUToCwsc2WucfO+Cn3NjJiEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjqmURTq2yX/Sg1vwwxo7bnlYUJK95kcUWhGNbeDnD/QdGPELQkR491Cfi+BCxg0V
	 U8QSDsfM2icetW2ze25Hrsm9tduRsv8lz6dN95HRyX67cT5fqF4gWP3arYE3WaDu+W
	 J32g07N1lXM5NjVWXgqJp17LWOpsLKgJV6zxQBzlXUTSVeckl4cq0wnt8NataQEg9H
	 AuMD+gV7ItQY5fwqodGVUdFPqvPeUuL3AqoGbuZrQZ7tIwgr0+fpM0oj+277ctGVBK
	 e5RKbZaQ3KKHa5IO3W8clg/XJWEScAS7lOnITvpMx6s3WULWbJ1GgNnCeffYYvqwfR
	 KwITqcM7sQcig==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv3 bpf-next 4/9] bpf: Count missed stats in trace_call_bpf
Date: Wed, 20 Sep 2023 23:31:40 +0200
Message-ID: <20230920213145.1941596-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920213145.1941596-1-jolsa@kernel.org>
References: <20230920213145.1941596-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase misses stats in case bpf array execution is skipped
because of recursion check in trace_call_bpf.

Adding bpf_prog_inc_misses_counters that increase misses
counts for all bpf programs in bpf_prog_array.

Reviewed-and-tested-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 16 ++++++++++++++++
 kernel/trace/bpf_trace.c |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 30063a760b5a..a82efd34b741 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2922,6 +2922,22 @@ static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
 
+static __always_inline void
+bpf_prog_inc_misses_counters(const struct bpf_prog_array *array)
+{
+	const struct bpf_prog_array_item *item;
+	struct bpf_prog *prog;
+
+	if (unlikely(!array))
+		return;
+
+	item = &array->items[0];
+	while ((prog = READ_ONCE(item->prog))) {
+		bpf_prog_inc_misses_counter(prog);
+		item++;
+	}
+}
+
 #if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
 void bpf_sk_reuseport_detach(struct sock *sk);
 int bpf_fd_reuseport_array_lookup_elem(struct bpf_map *map, void *key,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a9d8634b503c..44f399b19af1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -117,6 +117,9 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 		 * and don't send kprobe event into ring-buffer,
 		 * so return zero here
 		 */
+		rcu_read_lock();
+		bpf_prog_inc_misses_counters(rcu_dereference(call->prog_array));
+		rcu_read_unlock();
 		ret = 0;
 		goto out;
 	}
-- 
2.41.0


