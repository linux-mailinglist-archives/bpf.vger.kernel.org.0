Return-Path: <bpf+bounces-18027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99560814E4E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1B61C24099
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF56E2D3;
	Fri, 15 Dec 2023 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRSorbBE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKkDOU1m"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2816AB83;
	Fri, 15 Dec 2023 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wD16ISNyde986dSZRGGV32udEpTGLhg+lI5u4jYKrqw=;
	b=SRSorbBEjdXTPPsLCYBR3BfHZUztde0viH5AXb6BnrVRO+dRpLMHGwt39krhGG0dIGg2gc
	U/GPYQC8QIJryAvWdpneFKRQPe6h9ZTqEWdzui8QpFNXWEeO85TAeVO/cv65RLccd4/YRK
	WzlvjMKRk5knp71bJzfOBYegir5nHiJNyJqFAqoY8QhtCasD/8/viDwUyU06Aoa/DCR6yt
	/Bo5pe68KaOdpzj5Ej1RmwGXZF6GFCUwJ4j6BVvHO/0/fuqfNBRqPARUavf+TmVV9muEYn
	DgRMLZwgTHliPnTc22SgXQvtzytCGCuEBcYzPMfFPZaWDtx9BK4682g+Lzyb7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wD16ISNyde986dSZRGGV32udEpTGLhg+lI5u4jYKrqw=;
	b=bKkDOU1m4UEsf1ODMNSff2+rozRNCsjhcGgYFGGAkJKSnk1VerHLACuMKMr3ry8mJ6DtKt
	6a997HCgOHDcT6Dw==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH net-next 24/24] net: bpf: Add lockdep assert for the redirect process.
Date: Fri, 15 Dec 2023 18:07:43 +0100
Message-ID: <20231215171020.687342-25-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The users of bpf_redirect_info should lock the access by acquiring the
nested BH-lock bpf_run_lock.redirect_lock. This lock should be acquired
before the first usage (bpf_prog_run_xdp()) and dropped after the last
user in the context (xdp_do_redirect()).

Current user in tree have been audited and updated.

Add lockdep annonation to ensure new user acquire the lock.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Hao Luo <haoluo@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/xdp.h |  1 +
 net/core/filter.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 349c36fb5fd8f..cdeab175abf18 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -493,6 +493,7 @@ static inline void xdp_clear_features_flag(struct net_d=
evice *dev)
 static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 					    struct xdp_buff *xdp)
 {
+	lockdep_assert_held(this_cpu_ptr(&bpf_run_lock.redirect_lock));
 	/* Driver XDP hooks are invoked within a single NAPI poll cycle and thus
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
diff --git a/net/core/filter.c b/net/core/filter.c
index 72a7812f933a1..a2f97503ed578 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2495,6 +2495,7 @@ int skb_do_redirect(struct sk_buff *skb)
 	struct net_device *dev;
 	u32 flags =3D ri->flags;
=20
+	lockdep_assert_held(this_cpu_ptr(&bpf_run_lock.redirect_lock));
 	dev =3D dev_get_by_index_rcu(net, ri->tgt_index);
 	ri->tgt_index =3D 0;
 	ri->flags =3D 0;
@@ -2525,6 +2526,8 @@ BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
 {
 	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
=20
+	lockdep_assert_held(this_cpu_ptr(&bpf_run_lock.redirect_lock));
+
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return TC_ACT_SHOT;
=20
@@ -2546,6 +2549,8 @@ BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flag=
s)
 {
 	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
=20
+	lockdep_assert_held(this_cpu_ptr(&bpf_run_lock.redirect_lock));
+
 	if (unlikely(flags))
 		return TC_ACT_SHOT;
=20
@@ -2568,6 +2573,8 @@ BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct b=
pf_redir_neigh *, params,
 {
 	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
=20
+	lockdep_assert_held(this_cpu_ptr(&bpf_run_lock.redirect_lock));
+
 	if (unlikely((plen && plen < sizeof(*params)) || flags))
 		return TC_ACT_SHOT;
=20
@@ -4287,6 +4294,8 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 	struct net_device *master, *slave;
 	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
=20
+	lockdep_assert_held(this_cpu_ptr(&bpf_run_lock.redirect_lock));
+
 	master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
 	slave =3D master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
 	if (slave && slave !=3D xdp->rxq->dev) {
@@ -4394,6 +4403,7 @@ int xdp_do_redirect(struct net_device *dev, struct xd=
p_buff *xdp,
 	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type =3D ri->map_type;
=20
+	lockdep_assert_held(this_cpu_ptr(&bpf_run_lock.redirect_lock));
 	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
=20
@@ -4408,6 +4418,7 @@ int xdp_do_redirect_frame(struct net_device *dev, str=
uct xdp_buff *xdp,
 	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type =3D ri->map_type;
=20
+	lockdep_assert_held(this_cpu_ptr(&bpf_run_lock.redirect_lock));
 	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
=20
--=20
2.43.0


