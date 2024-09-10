Return-Path: <bpf+bounces-39402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE239728EE
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 07:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2B0B21297
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 05:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4747175D5F;
	Tue, 10 Sep 2024 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb/M3JU0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B5167265;
	Tue, 10 Sep 2024 05:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946657; cv=none; b=GoPHrrXfct1+pz9tuvqCmjSwatrzc241h6j6VHo3+4M8wUhDhWcfXgFE/ytgQMm0MnQHqN4+w27UFlq9git9k7ebDulPpIZJ/z6nnm4XNRALdcuduxuoTYDRCIapk4VJL0OXTqn9jUK9RCZG1REaAVN8Wpo4lyM7BQ2WbiMRVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946657; c=relaxed/simple;
	bh=D5TYavM29ltridmAsCsO8PzJ/nzNH0IhkjhLoU87B1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B40pJV+dKKc+ecUBlmNYc8KDKwjjzFS17I89j8iBePOkXSwU9zIfO0LtAKObVIhSBrFXPhNlrNSueriGny7i1hmeS+Lv63+vf39b2dFYgPUrmhyCCRUxsstpz2qjZtexSzhNlWSwF0tlJbSVbPuFMc1txbV/rsMD/ABiAs8/7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb/M3JU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FE0C4CEC3;
	Tue, 10 Sep 2024 05:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725946656;
	bh=D5TYavM29ltridmAsCsO8PzJ/nzNH0IhkjhLoU87B1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jb/M3JU04RjAlCYKSqVHue2EQuRIqTq2kyBE1AFwZKgOXv+NOx8MvUXdIMkIVmZeF
	 FkRMc/6q8eijqY+KID39U+RlEWUzJRpRX3iSa0gBS1mGvVBD6iQ7tGigEB1FD/XytO
	 wPWOPbOxyIPSlpGFgj8/X2XK6Mx4L7QDJ+pqiUkb7VyszzhJH60ndn5dXtOeMvgHzS
	 7dzt7wiP0BWE5/eI2tlq58zRNREAJyWqURpdWBwOJYmfAv3WhfIjN9g5MoqCy6sO3L
	 U31j2Xn4tn45rVGwz2YWJED1FEMJmhrX5f6aNPAdulgysopZMz9IcYQJBYJ/Pji1i0
	 q7CJ8VoPMbqXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v3 1/5] bpf: Add mptcp_subflow bpf_iter
Date: Tue, 10 Sep 2024 13:37:23 +0800
Message-ID: <026dce3d6903ad189e4b0518a64b60c910e660c0.1725946276.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725946276.git.tanggeliang@kylinos.cn>
References: <cover.1725946276.git.tanggeliang@kylinos.cn>
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
 net/mptcp/bpf.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..350672e24a3d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -201,9 +201,48 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
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
 
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
@@ -218,7 +257,7 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
-__diag_pop();
+__bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-- 
2.43.0


