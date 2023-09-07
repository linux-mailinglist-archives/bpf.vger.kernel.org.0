Return-Path: <bpf+bounces-9398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8144797072
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 09:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000B5281507
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 07:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E61109;
	Thu,  7 Sep 2023 07:13:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40A1102
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 07:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FD1C43391;
	Thu,  7 Sep 2023 07:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694070838;
	bh=PkX4pfDAyroFR09ush4N+KU140QFXKAkajCQymdK13c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y33eH2JtJ5lKQJg5GLhSDFHaaKNvwnfdu/lTRWSTVYa445hckHiO8DsZnK0X2Rbsz
	 3UJOVs7JJfwJByOAzB09kN5vU1YRMt25hk+9zwOI4il5F55FyX6WcgAmcc+X92Niw0
	 3Bgitpf/dQ1viPGfniEEtploz8CcbVSs9WEuhKhLlEWnshY8FZbgmtmD8+0iLhKoEq
	 MQhIkwNiy/CaRIXPBMwesA8UxnqFLtCOBm86e8de+aIfLDoN378cLP+H7aourB9F/Q
	 UjutRutweBHSAlBNrL5HnG6DRmUHLuGtKpbl6Y+eg1WrxdHiIXRA2iibcnsK7ftCBf
	 jO9/m9NhS61ow==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv2 bpf-next 4/9] bpf: Count missed stats in trace_call_bpf
Date: Thu,  7 Sep 2023 09:13:06 +0200
Message-ID: <20230907071311.254313-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907071311.254313-1-jolsa@kernel.org>
References: <20230907071311.254313-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 16 ++++++++++++++++
 kernel/trace/bpf_trace.c |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 87eeb3a46a1d..abc18d6f2f2e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2911,6 +2911,22 @@ static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
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


