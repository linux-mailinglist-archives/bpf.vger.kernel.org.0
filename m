Return-Path: <bpf+bounces-33768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6D92604B
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 14:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A711C21A0B
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE371176AB0;
	Wed,  3 Jul 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hRZYA297";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Oyqklkl"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B216F84E;
	Wed,  3 Jul 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009683; cv=none; b=a3+a4oKwUUvaD+Qa5k9Ju5XH9CBVqjcnS6CFOyz0FyP6qcyFDNlFd3803ZrCfScb+8yDGq0wvXVCkh3qc+tx3bhyHDDEZzO7xXQbW/d86u9XFBPEgXrBjWvjvkBRzGs4bHKgBn9HwsluJsCAfvIMqaXo4wlCXPB+LdxSwBhA2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009683; c=relaxed/simple;
	bh=213ci+0cxZ10GqVJJAbw2lpuJ/8tXssG4bIdE6Qu3gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgMda2klcle9qD6V77/RkL2iC/Ho0AQTBvNyXISwgA3qPkLcuBw9CYHO0gmNy4bwby96tihqXxuk4DO844KPrMKs3UlySYGS3NTXRAc8THjggMP2fH7IJ7APK2fuo5wv+4sYcUjj4ddirrTg1eLTYuGYtc+hoik+wGJMt+/J2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hRZYA297; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Oyqklkl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Jul 2024 14:27:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720009679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VEgcupWrb36dcZYH1yhSo7JVJd/uausUyMuli7DmLp8=;
	b=hRZYA297jYac2WMZflGkRXGcnaHSBfvkiKBRliEdgL5xCwghF+GRgTgNDfWOtwnwVAYE7I
	BkKNy34qY1/vR/PfiZfrYqHWID5PCn2LkVvwXjAPQ3gRRHb7q0Y1+9SKIwWmnbcZxzZWiL
	dkyghnDGHoSiMc3Qn9SwxcJiZ1gRIqoZODM9LneUDLRnJF0NuVSNo/sIulgwGtBYgMMbC0
	urVqi83Z8b+s9Yuwh5hRPhqV7vh8j4Mo10CoHe8B99SNjk5wvrUnnpAW3jzqKjREOFqN1R
	sJHLYp2IkJdbT2jvpJmwuxYMttTfddZ9PZC1Jwygwy7ojiHXN5cvLvwBjD6VSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720009679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VEgcupWrb36dcZYH1yhSo7JVJd/uausUyMuli7DmLp8=;
	b=1OyqklkloIhT/PPpuo4cXwNLY2uCwimSN1Bis+J5CiivXkDwWC4xjLOgN5XBM5d7HRXecj
	h/LH1EzxDp+p1XDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240703122758.i6lt_jii@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702114026.1e1f72b7@kernel.org>

During the introduction of struct bpf_net_context handling for
XDP-redirect, the tun driver has been missed.

Set the bpf_net_context before invoking BPF XDP program within the TUN
driver.

Reported-by: syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com
Reported-by: syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com
Reported-by: syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com
Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/tun.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9254bca2813dc..df4dd6b7479e1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1661,6 +1661,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     int len, int *skb_xdp)
 {
 	struct page_frag *alloc_frag = &current->task_frag;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	char *buf;
@@ -1700,6 +1701,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 	local_bh_disable();
 	rcu_read_lock();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		struct xdp_buff xdp;
@@ -1728,12 +1730,14 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		pad = xdp.data - xdp.data_hard_start;
 		len = xdp.data_end - xdp.data;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 
 	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
 
 out:
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 	return NULL;
@@ -1914,20 +1918,24 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 		struct bpf_prog *xdp_prog;
 		int ret;
 
 		local_bh_disable();
 		rcu_read_lock();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		xdp_prog = rcu_dereference(tun->xdp_prog);
 		if (xdp_prog) {
 			ret = do_xdp_generic(xdp_prog, &skb);
 			if (ret != XDP_PASS) {
+				bpf_net_ctx_clear(bpf_net_ctx);
 				rcu_read_unlock();
 				local_bh_enable();
 				goto unlock_frags;
 			}
 		}
+		bpf_net_ctx_clear(bpf_net_ctx);
 		rcu_read_unlock();
 		local_bh_enable();
 	}
@@ -2566,6 +2574,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
 	    ctl && ctl->type == TUN_MSG_PTR) {
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 		struct tun_page tpage;
 		int n = ctl->num;
 		int flush = 0, queued = 0;
@@ -2574,6 +2583,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 		local_bh_disable();
 		rcu_read_lock();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 		for (i = 0; i < n; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
@@ -2588,6 +2598,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		if (tfile->napi_enabled && queued > 0)
 			napi_schedule(&tfile->napi);
 
+		bpf_net_ctx_clear(bpf_net_ctx);
 		rcu_read_unlock();
 		local_bh_enable();
 
-- 
2.45.2


