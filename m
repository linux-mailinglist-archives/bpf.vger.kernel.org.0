Return-Path: <bpf+bounces-39215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9E970B5D
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 03:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36466B21722
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 01:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB81CD2F;
	Mon,  9 Sep 2024 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6ZfF0K+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C041173F;
	Mon,  9 Sep 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845818; cv=none; b=cpWfeVLGbprgnxH3pKTYLuy6QLrLx/r4cAFLO3+Legv30LSVavBEn1kABMMr/po2seIWQPPi540k9Zl0cPXFPR1AXKqoSxs6EaI0AX5vjf4AfhPvU++rnBxQBkPbBK8BtXUAb5MvMKiQKRYHPqdp9DPhybQcqvoC4CpIA1TNfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845818; c=relaxed/simple;
	bh=YkJdh4kxKvOb4Mn7ACfv1Xo7kqGDDToIapY7046mY3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQFQdth1MadanzcbSuKyo2NL6IFT7KmqSMps1WEeRu5mTOUT2t6m/7RcHpnNfuhsqqpbF/6hkn/g4E1mnG33R6IlwNCDAHgA6qaoCfpsdQ+tLoV++w3NsHtPiRgOjKb8D6L349lVmvm8mlIjQfLatE/3jW53rD9YAhOTfIOs8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6ZfF0K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB71C4CEC3;
	Mon,  9 Sep 2024 01:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725845817;
	bh=YkJdh4kxKvOb4Mn7ACfv1Xo7kqGDDToIapY7046mY3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6ZfF0K+dDblR59zUQmCZdureyxdCOjvvakwaohNI/4RsGv+57Qj2/nHisfWgKUPj
	 VlFZjFBYrP+Z0I1lts7DBQIepOVet/tjOjQUlvsmsT7o6h1zh2sFkBdK8eYmwIJRei
	 Qgd5uhFx0vhTBXdBF3JgR8f2PiQLV3rprCCnRTMzZS+rIXJzHkTk6MnU+FjMLJa+Dc
	 xK2S13kYnCQwTRaIPN92olBS/gq1OElZdK2Rz0m5u3xoDN+N8UVVS+TANkg4V3DN9U
	 fD/P0PbUnDmleuNC6OGPDasukb1DMCZP/CtUv7gTQvN3tKpPJ1f4VRdpRG9zkP61KL
	 pxKdW+RY5pICg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v2 1/4] bpf: Add mptcp_subflow bpf_iter
Date: Mon,  9 Sep 2024 09:36:44 +0800
Message-ID: <a4a0e759b9f82a17ddd2eac68f6cd99788248683.1725845619.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725845619.git.tanggeliang@kylinos.cn>
References: <cover.1725845619.git.tanggeliang@kylinos.cn>
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

Then bpf_for_each() for mptcp_subflow can be used in BPF program like
this:

	bpf_rcu_read_lock();
	bpf_for_each(mptcp_subflow, subflow, msk)
		kfunc(subflow);
	bpf_rcu_read_unlock();

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 51 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  6 ++++++
 2 files changed, 57 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9672a70c24b0..799264119891 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -204,10 +204,59 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
+struct bpf_iter__mptcp_subflow {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct mptcp_sock *, msk);
+	__bpf_md_ptr(struct list_head *, pos);
+};
+
+struct bpf_iter_mptcp_subflow {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_mptcp_subflow_kern {
+	struct mptcp_sock *msk;
+	struct list_head *pos;
+} __attribute__((aligned(8)));
+
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+					   struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+
+	if (!msk)
+		return -EINVAL;
+
+	kit->msk = msk;
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
+	subflow = list_entry((kit->pos)->next, struct mptcp_subflow_context, node);
+	if (!msk || list_entry_is_head(subflow, &msk->conn_list, node))
+		return NULL;
+
+	kit->pos = &subflow->node;
+	return subflow;
+}
+
+__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
+{
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -221,6 +270,8 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
+__bpf_kfunc_end_defs();
+
 __diag_pop();
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d25d2dac88a5..b3f5254e3c0d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -715,6 +715,12 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
+struct bpf_iter_mptcp_subflow;
+int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+			       struct mptcp_sock *msk);
+struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it);
+void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it);
 bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
-- 
2.43.0


