Return-Path: <bpf+bounces-8826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40478A6E2
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FC41C20825
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57610FE;
	Mon, 28 Aug 2023 07:56:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FB10F4
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E8DC433C8;
	Mon, 28 Aug 2023 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209406;
	bh=XghO+TwMKbJ16Pe2fSCXJYqMHbJ8W/7XubAP8jk4mpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hW/z3PSJqRlWwTNXrkWQGMQisWnZap1iqsBsJHVDlwp8Kk/SGl/pN/f3tzLipHZ4u
	 4QcHNguIMCblB4lPqNcl91lnqk92O16B2F2Mx+huN0TaJamq2j210KsMfO1LBWgBnO
	 eFfDGFtfIvOuviDFta/dTkaVpMHfiyd49vIw83n3Kq6ZzoClJTixbKjmKgBk75x2og
	 VGmH/1/yYwSE1CZIdsXkVdZnuphtSSgF9JpdVQs53T5N3larvleJGAZV049w/DOwVr
	 lu7QE5ZflPmnCy+1czMB6e6kXmjA2hgjSrJh6Bh4Zjz+PCFYZ0iE0pjaa43/sCX4ey
	 NsWvl2WKzZFDA==
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
Subject: [PATCH bpf-next 06/12] bpf: Count missed stats in trace_call_bpf
Date: Mon, 28 Aug 2023 09:55:31 +0200
Message-ID: <20230828075537.194192-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase misses stats in case bpf array execution is skipped
because of recursion check in trace_call_bpf.

Adding bpf_prog_missed_array that increase misses counts for
all bpf programs in bpf_prog_array.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 16 ++++++++++++++++
 kernel/trace/bpf_trace.c |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 23a73f52c7bc..71154e991730 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2932,6 +2932,22 @@ static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
 
+static __always_inline void
+bpf_prog_missed_array(const struct bpf_prog_array *array)
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
index cde6360bf8e8..7961f9d9dd13 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -117,6 +117,9 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 		 * and don't send kprobe event into ring-buffer,
 		 * so return zero here
 		 */
+		rcu_read_lock();
+		bpf_prog_missed_array(rcu_dereference(call->prog_array));
+		rcu_read_unlock();
 		ret = 0;
 		goto out;
 	}
-- 
2.41.0


