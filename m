Return-Path: <bpf+bounces-33949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94179286FC
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A312B22583
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B114885C;
	Fri,  5 Jul 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQQl+oZe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FKpLMTkU"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665F148312;
	Fri,  5 Jul 2024 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176098; cv=none; b=WZrEp1Vzr5iQa1yZWTA2KAgQsLzdIHwA/5/KI2Hj573clxuomntiePncOzpxu+gcL9rvhYg4Dkx4Mhfh2uRJRx3lqD0eiwhO5r2hXl4ESv9/ZDEz1pzOIFuQtx8Pa7KJ2FKuiUu4X3G2KWspBTLxo44mG6k3R+Mg1nIW6BderI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176098; c=relaxed/simple;
	bh=WrLvEPqussB+gTxkjuUCsszsRl9PTpcdBFp0rLY5tyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgcfIEc5bwadr4lyHNUYWhSkMEacWhjmiFfVSCiHNMBYVdCNCDIaoOVS2pvCRUFV6zcEwgSf3/xQIOVPjj+KBWgBJNzAU9Nj3rQ6+o66i++9oqp1pGOKeJ981A4TGHz7V4ogid9J9s/W1sWbnOJvj2gOcWKy+a59AqiS9AL6F4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQQl+oZe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FKpLMTkU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 5 Jul 2024 12:41:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720176095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fXMq/XNQs5YpQvzDhmCSvQaZvdAfxzgd0YaozA/EAD8=;
	b=WQQl+oZeP0joyZOhtAJVbQCISatfHb1QhLSblDu7/bjS5fnjeSIaMDe7MdvlIe518KnpRv
	DkLz/zOoKB1IsZE2FS4qGzH05oh4zEBBwaao7+QFUyJbRUZ7jzaVpT9+guiHTKzRgaWSFx
	dNljz4/B1G6Lv6dtpDxyXPq3tQt7vhqNujh202sDz5VNocSIMaig8GcbiKdtpewcQq5D22
	ryJ7RUk2M/xMDf/uZsITSdQavqT9bXKHX7VPKZ5dVLy+sK2HkO2c17tNwMEWaVDIIyH2uG
	1ohX0FpkNbMc1vIwMao0wr3VsbhjHeooLWTDTsxuTNKCxZDr8cv0+IM/ZF90JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720176095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fXMq/XNQs5YpQvzDhmCSvQaZvdAfxzgd0YaozA/EAD8=;
	b=FKpLMTkUO5S+Qaxu69ab4S/+Nqs0cKUGfPTGF7Blt6ZIBxJfspWM4rs6x3QeoomzN79u2q
	LAwf5RVr7mbPP8Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, dsahern@kernel.org, eddyz87@gmail.com,
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
	martin.lau@linux.dev, pabeni@redhat.com, sdf@fomichev.me,
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH bpf-next] seg6: Ensure that seg6_bpf_srh_states can only be
 accessed from input_action_end_bpf()
Message-ID: <20240705104133.NU9AwKDS@linutronix.de>
References: <000000000000571681061bb9b5ad@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000571681061bb9b5ad@google.com>

Initially I assumed that the per-CPU variable is `seg6_bpf_srh_states'
is first initialized in input_action_end_bpf() and then accessed during
the bpf_prog_run_save_cb() invocation by the eBPF via the BPF callbacks.
syzbot demonstrated that is possible to invoke the BPF callbacks (and
access `seg6_bpf_srh_states') without entering input_action_end_bpf()
first.

The valid path via input_action_end_bpf() is invoked within NAPI
context which means it has bpf_net_context set. This can be used to
identify the "valid" calling path.

Set in input_action_end_bpf() the BPF_RI_F_SEG6_STATE bit to signal the
valid calling path and clear it at the end. Check for the context and
the bit in bpf_lwt_seg6.*() and abort if missing.

Reported-by: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
Fixes: d1542d4ae4dfd ("seg6: Use nested-BH locking for seg6_bpf_srh_states.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 24 ++++++++++++++++++++++++
 net/core/filter.c      |  6 ++++++
 net/ipv6/seg6_local.c  |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0bbd2585e6def..cadddb25ff4db 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -739,6 +739,7 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_SEG6_STATE	BIT(5)
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -856,6 +857,29 @@ static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head **lh_ma
 		*lh_xsk = lh;
 }
 
+static inline bool bpf_net_ctx_seg6_state_avail(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	if (!bpf_net_ctx)
+		return false;
+	return bpf_net_ctx->ri.kern_flags & BPF_RI_F_SEG6_STATE;
+}
+
+static inline void bpf_net_ctx_seg6_state_set(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	bpf_net_ctx->ri.kern_flags |= BPF_RI_F_SEG6_STATE;
+}
+
+static inline void bpf_net_ctx_seg6_state_clr(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	bpf_net_ctx->ri.kern_flags &= ~BPF_RI_F_SEG6_STATE;
+}
+
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
  * lwt, ...). Subsystems allowing direct data access must (!)
diff --git a/net/core/filter.c b/net/core/filter.c
index 403d23faf22e1..ea5bc4a4a6a23 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6459,6 +6459,8 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
 	void *srh_tlvs, *srh_end, *ptr;
 	int srhoff = 0;
 
+	if (!bpf_net_ctx_seg6_state_avail())
+		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	if (srh == NULL)
 		return -EINVAL;
@@ -6516,6 +6518,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 	int hdroff = 0;
 	int err;
 
+	if (!bpf_net_ctx_seg6_state_avail())
+		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_X:
@@ -6593,6 +6597,8 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 	int srhoff = 0;
 	int ret;
 
+	if (!bpf_net_ctx_seg6_state_avail())
+		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	if (unlikely(srh == NULL))
 		return -EINVAL;
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index c74705ead9849..3e3a48b7266b5 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1429,6 +1429,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	 * bpf_prog_run_save_cb().
 	 */
 	local_lock_nested_bh(&seg6_bpf_srh_states.bh_lock);
+	bpf_net_ctx_seg6_state_set();
 	srh_state = this_cpu_ptr(&seg6_bpf_srh_states);
 	srh_state->srh = srh;
 	srh_state->hdrlen = srh->hdrlen << 3;
@@ -1452,6 +1453,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 
 	if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
 		goto drop;
+	bpf_net_ctx_seg6_state_clr();
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 
 	if (ret != BPF_REDIRECT)
@@ -1460,6 +1462,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	return dst_input(skb);
 
 drop:
+	bpf_net_ctx_seg6_state_clr();
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 	kfree_skb(skb);
 	return -EINVAL;
-- 
2.45.2


