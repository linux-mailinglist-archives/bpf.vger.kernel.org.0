Return-Path: <bpf+bounces-33895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930DF927934
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 16:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08BD1C237AB
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB281B121A;
	Thu,  4 Jul 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A9G99dop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yo9Veu5u"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD31B0119;
	Thu,  4 Jul 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104504; cv=none; b=HNTynO8I/wxDyXpNPJgfeXZ0WgyE1V59pb0anNkycUO5b1plV5uQsw8mC+fGOv8PcdZj6c0FH0EWBS//0OpZUkZuZIEFyGkRqEqHy8Ypa50CtIwgFg9sZ0ACBNrExIOH+0qqCGCjRLKppDHig+Q12L4NmgBUHwYr9q56VTB2bTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104504; c=relaxed/simple;
	bh=7IbRb6nkHrpJ13bDe2oFJmfdzxaSQs8AktYQ5Q2YCuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot3VBTP64QkAtV1OyQN/h2DmrRD0qXMUpGX/Q8xF07q294yqE0F8CQchcoSsTTYXRHMUlDwfmKGgaWE/TLCOwYdI7o26Cqkw1pxJaZmm/ADoXcXwBoeFp7C47kbUlKSPtAKASCjugLUnAs4luGtOmIGG2VycIQEq9X9Y1OdNO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A9G99dop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yo9Veu5u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Jul 2024 16:48:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720104497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku+Vvlezy5P2YrWCu67ao5XGVudaVeUu84F76nh+12M=;
	b=A9G99dophpgFq/nF/UDQWNVx0Cn6XSNXDOsBApopEbe8Brgnps41VC2zszYz6KNBUn7Uds
	Sj6SoPh8t//FBxfFwKQo67C56pfkfXKPBzaxgf9k4hbrApLKxnguv+fYgtufUTc9F+j1wP
	FyOATW121JzIyzwc+/PMt3YvVxH5e6NKQ6zCBMXxtGnZLZLo+2HvhHvpPb25BPL9z1sU+H
	g3+6ckVuaftKmsekTWnHWSmsxYSbLHT2KN6XI27L04uxKTYxcC4TPFMqSmz5ALWteag+oz
	ynyAPyDwJsIFqUKbB1czc1Ch+nlnCfaD7NDPDB1j0XrrEaD2ptuW1zk2tNcBtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720104497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku+Vvlezy5P2YrWCu67ao5XGVudaVeUu84F76nh+12M=;
	b=Yo9Veu5ulTGYhTyIymRCAHj3kVOvMpb3JaoJLJTUL71m8wLHXOL8MMxAwH7Wp9Jwi3CNTC
	6pMNjetcP6w9gEDA==
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
Subject: [PATCH v3 net-next] tun: Assign missing bpf_net_context.
Message-ID: <20240704144815.j8xQda5r@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240703192118.RIqHj9kS@linutronix.de>
 <20240704101452.NhpibjJt@linutronix.de>
 <20240704072433.4531a7e1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240704072433.4531a7e1@kernel.org>

During the introduction of struct bpf_net_context handling for
XDP-redirect, the tun driver has been missed.
Jakub also pointed out that there is another call chain to
do_xdp_generic() originating from netif_receive_skb() and drivers may
use it outside from the NAPI context.

Set the bpf_net_context before invoking BPF XDP program within the TUN
driver. Set the bpf_net_context also in do_xdp_generic() if a xdp
program is available.

Reported-by: syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com
Reported-by: syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com
Reported-by: syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com
Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on =
PREEMPT_RT.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2024-07-04 07:24:33 [-0700], Jakub Kicinski wrote:
> LG, but can I bother you for a repost? the subject tag is typo'ed
> (net-net vs net-next) and our CI put this on top of net, since it
> applies. But it doesn't build on top of net.=20
> Feel free to repost without any wait.

I am sorry for the trouble.

v2=E2=80=A6v3:
  - Repost due to typo in subject.

v1=E2=80=A6v2:
  - Add the wrapper to do_xdp_generic().
  - Remove the wrapper from tun_get_user() where it was used for a
    single do_xdp_generic() invocation.

 drivers/net/tun.c | 7 +++++++
 net/core/dev.c    | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9254bca2813dc..9b24861464bc6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1661,6 +1661,7 @@ static struct sk_buff *tun_build_skb(struct tun_struc=
t *tun,
 				     int len, int *skb_xdp)
 {
 	struct page_frag *alloc_frag =3D &current->task_frag;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog *xdp_prog;
 	int buflen =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	char *buf;
@@ -1700,6 +1701,7 @@ static struct sk_buff *tun_build_skb(struct tun_struc=
t *tun,
=20
 	local_bh_disable();
 	rcu_read_lock();
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 	xdp_prog =3D rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		struct xdp_buff xdp;
@@ -1728,12 +1730,14 @@ static struct sk_buff *tun_build_skb(struct tun_str=
uct *tun,
 		pad =3D xdp.data - xdp.data_hard_start;
 		len =3D xdp.data_end - xdp.data;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
=20
 	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
=20
 out:
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 	return NULL;
@@ -2566,6 +2570,7 @@ static int tun_sendmsg(struct socket *sock, struct ms=
ghdr *m, size_t total_len)
=20
 	if (m->msg_controllen =3D=3D sizeof(struct tun_msg_ctl) &&
 	    ctl && ctl->type =3D=3D TUN_MSG_PTR) {
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 		struct tun_page tpage;
 		int n =3D ctl->num;
 		int flush =3D 0, queued =3D 0;
@@ -2574,6 +2579,7 @@ static int tun_sendmsg(struct socket *sock, struct ms=
ghdr *m, size_t total_len)
=20
 		local_bh_disable();
 		rcu_read_lock();
+		bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
=20
 		for (i =3D 0; i < n; i++) {
 			xdp =3D &((struct xdp_buff *)ctl->ptr)[i];
@@ -2588,6 +2594,7 @@ static int tun_sendmsg(struct socket *sock, struct ms=
ghdr *m, size_t total_len)
 		if (tfile->napi_enabled && queued > 0)
 			napi_schedule(&tfile->napi);
=20
+		bpf_net_ctx_clear(bpf_net_ctx);
 		rcu_read_unlock();
 		local_bh_enable();
=20
diff --git a/net/core/dev.c b/net/core/dev.c
index 385c4091aa775..73e5af6943c39 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5126,11 +5126,14 @@ static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_k=
ey);
=20
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+
 	if (xdp_prog) {
 		struct xdp_buff xdp;
 		u32 act;
 		int err;
=20
+		bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 		act =3D netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
 		if (act !=3D XDP_PASS) {
 			switch (act) {
@@ -5144,11 +5147,13 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struc=
t sk_buff **pskb)
 				generic_xdp_tx(*pskb, xdp_prog);
 				break;
 			}
+			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
 	}
 	return XDP_PASS;
 out_redir:
+	bpf_net_ctx_clear(bpf_net_ctx);
 	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
--=20
2.45.2


