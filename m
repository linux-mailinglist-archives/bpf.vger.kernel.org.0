Return-Path: <bpf+bounces-39708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5502097657A
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 11:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107D52853E2
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE1A1990D2;
	Thu, 12 Sep 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPV1pqjT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF018A6A9;
	Thu, 12 Sep 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133164; cv=none; b=iqJ1eK1LInp4eogyzE8MWcTIJ0r/COTlok5s/rjLYX/ka50Cq/QJrN99yL4iMUUpPl6PSlx+rai/NRT4+tptTqt+7GVcHD4Cdggw9VEJLOg+H30u5tmvR2iEO2UMBNUfRZBFiHr57v78DHfPX1ku5wYvsnPw6ZBGSuEWILYTtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133164; c=relaxed/simple;
	bh=i1tfent+G9wgkD21AvmV+FJAVzh/MdSal+bBN4pXdGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPjCMG+BQeii/8bju2rl2Hce1iF4ZcF/TPsKDUEMhpl6sGLwsoD8DK96MCV3zl/sH7dPL/tqv1Pp0bSGhLwPj9S8Bvsp1s+qgo6ak24/Eoj3wwNVfcC5CkxcNwXZx/w2euB5JMc+juHaLFiv1jYTiPl8ycQY6cNw3TaSQCYyRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPV1pqjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED118C4CEC3;
	Thu, 12 Sep 2024 09:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726133163;
	bh=i1tfent+G9wgkD21AvmV+FJAVzh/MdSal+bBN4pXdGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPV1pqjTewkJFVGHmrLq9GncYKsYuqMveK6e2e8ck6cQjPIZB8vt74UfDmphAIVKQ
	 xOqavZ6qP3UAr62m1gMA2t18BdQZDowQsU5sfoj/AFlPh1yf5sedsH3SwAEijw5791
	 l6OoXK6b2Ory9fmJyQqT3bhrgLrWaRfTsrSQ9WNnGHuGRAfQvC/MV+qIftRP0dq0Y+
	 QfAaz4aM5Bpni1q2exFFemyxMTu22BYW/ZAudbqpyJ8/2UM4LciGdx06tcdFhaRVVT
	 7gB7AHnxnGltox7CoKpjJ8FB/4z8TU9QqCQr0aXKfEiJQxxYUxxlY4aemgz+JPOo7f
	 1upNSaLR8gcAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v5 1/5] bpf: Add mptcp_subflow bpf_iter
Date: Thu, 12 Sep 2024 17:25:51 +0800
Message-ID: <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726132802.git.tanggeliang@kylinos.cn>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's necessary to traverse all subflows on the conn_list of an MPTCP
socket and then call kfunc to modify the fields of each subflow. In
kernel space, mptcp_for_each_subflow() helper is used for this:

	mptcp_for_each_subflow(msk, subflow)
		kfunc(subflow);

But in the MPTCP BPF program, this has not yet been implemented. As
Martin suggested recently, this conn_list walking + modify-by-kfunc
usage fits the bpf_iter use case. So this patch adds a new bpf_iter
type named "mptcp_subflow" to do this and implements its helpers
bpf_iter_mptcp_subflow_new()/_next()/_destroy().

Since these bpf_iter mptcp_subflow helpers are invoked in its selftest
in a ftrace hook for mptcp_sched_get_send(), it's necessary to register
them into a BPF_PROG_TYPE_TRACING type kfunc set together with other
two used kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled().

Then bpf_for_each() for mptcp_subflow can be used in BPF program like
this:

	i = 0;
	bpf_rcu_read_lock();
	bpf_for_each(mptcp_subflow, subflow, msk) {
		if (i++ >= MPTCP_SUBFLOWS_MAX)
			break;
		kfunc(subflow);
	}
	bpf_rcu_read_unlock();

v2: remove msk->pm.lock in _new() and _destroy() (Martin)
    drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
v3: drop bpf_iter__mptcp_subflow
v4: if msk is NULL, initialize kit->msk to NULL in _new() and check it in
    _next() (Andrii)

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..fec18e7e5e4a 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -201,9 +201,51 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "kfuncs which will be used in BPF programs");
+struct bpf_iter_mptcp_subflow {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_mptcp_subflow_kern {
+	struct mptcp_sock *msk;
+	struct list_head *pos;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+					   struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+
+	kit->msk = msk;
+	if (!msk)
+		return -EINVAL;
+
+	kit->pos = &msk->conn_list;
+	return 0;
+}
+
+__bpf_kfunc struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = kit->msk;
+
+	if (!msk)
+		return NULL;
+
+	subflow = list_entry(kit->pos->next, struct mptcp_subflow_context, node);
+	if (!subflow || list_entry_is_head(subflow, &msk->conn_list, node))
+		return NULL;
+
+	kit->pos = &subflow->node;
+	return subflow;
+}
+
+__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
+{
+}
 
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
@@ -218,12 +260,15 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
-__diag_pop();
+__bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
-BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
@@ -241,6 +286,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					       &bpf_mptcp_sched_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0


