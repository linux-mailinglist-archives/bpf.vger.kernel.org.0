Return-Path: <bpf+bounces-54896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B32A75A10
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 14:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883D316901B
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3101CAA6C;
	Sun, 30 Mar 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="USRgcXdD"
X-Original-To: bpf@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAE158A13;
	Sun, 30 Mar 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743337446; cv=pass; b=HwQZiL3QpSRR49IJ0ZEru4oiJqbZYivlByeVAbyW/WufTs5mPJviQuO6FkoA3X+6Hz6pHcgsIkKfJzZQR2f2q1FCJBDKSlJcBbQXqpvcgjEqpQH3OwuXllN50ULGe7oA1tHOqnfLGDsvt/XdZ315a9FFuqd8iB84WkCsJXGLg1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743337446; c=relaxed/simple;
	bh=SGD5O0nr6VC6fbVT1etVdb3PMfIKF7sy2ecIqezxLfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b47cG+T/BOcf+0fRxZVoVPGQtvwTeSdELPDMuFJ3pvbe/hBDPSAnum+qmGjAuwXVQWZc8AdNzYrY33eGEu7FJFElFO5sPma3/gucNRsRP9ux4JB5T2/ikUUjg9Bujv6xoTlbmsCq12UVNdwVTPiKHUyqRI6r4oRheTsEJaXOzzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=USRgcXdD; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZQYMw5y8xz49QB9;
	Sun, 30 Mar 2025 15:23:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743337438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGk790DxeR6uG6Xv1mTCCd3mPVISN0jmLoUn7FXY/PA=;
	b=USRgcXdDb/njzFsAUDq8GL97BdDGtYhunEk5Lb46d6o4TGyESl4G8TlPAvAqPLe0i7Ego/
	JSVlGbLAB9aNiAUOpvhTny/gUyhl4gS6/Mg9vHqInx18r0xPcPUiUs1VJnxK6a52m9zOoI
	rErfcL8Ytdq86kn4R4sL6EeLB6ECSnzZRyIKUloiJDi/SdLuHxrQ01HPGfvr47J4tzxGme
	bi9vPDeIe/kMrUizGBODtLVDXafQxkO1QIX21ApdBMmepZckOzxJjYzsud++x/nR1L2O5R
	zfHYg57o7f9BKY0mEMKsnmfR0JTbnm1XAfRhwt5HrMTM64Mwr/xsnize02T4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1743337438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGk790DxeR6uG6Xv1mTCCd3mPVISN0jmLoUn7FXY/PA=;
	b=iqq3sYfCWEM66p+OyAc6bxjtvTqeGK5YkvGxr8YGKVj/iIKIF8xdZM5x9wxq71HhkoJzgr
	NwY/w/Lmo3qAJK/2EAAJ3hZp2abVcSWPOD19h9+z3+Kgexv6RA1E3XL1LfQEI3yrXzDhRT
	MMF6hGaCJ8o5ixNY2M5uOe5OBv7d5vsgI20/Ht37H36O73ggDK4SOqgPCswTG0e/USWqul
	vSPb3sI/4+6kw3lB+ZMWPGdv9RoKWVKQXAr2YXppq4W2xLOnVWrNzzMal+LJ4wzxgIjqRo
	OvqD+A50i3NU9EyPRD79h2WUIxo26xVfHuQq6FAvCxWbG02NT6tbVDhp0tdjrQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1743337438; a=rsa-sha256;
	cv=none;
	b=cZ8ZBV9wHJUdbbwdUEis9P5U5Trk9FJs2BmmURi6PQOi7BcGXPdFwLrhEMcuiDlLZxu2Aa
	l8d7l6fpyftg+q85W3ce1QkyiaR0ytfAhls64SyR/bjBFxCF4bgI+ZWmjmrVAuHRidgBvZ
	xtZDHTK8omM+dNeOyMB9tBqDCLLr+dVa8LlM90aWEY2xdbczNjBHw308e3Tau0GVZwLfat
	MRvTeXOrk/DdqqNej1GXmRTMwBpN6eOxMEHDokU1GF3q15PwlY+KVmnUQU/cTuXyl0s3Oa
	qokUHI96IS+lp2DpMK0Uq/3OdMGQf1XOmoL38hJtLbG8aEWheHpTGx5zDMXUJw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	kerneljasonxing@gmail.com
Subject: [PATCH 2/3] [RFC] bpf: allow non-TCP skbs for bpf_sock_ops_enable_tx_tstamp
Date: Sun, 30 Mar 2025 15:23:37 +0300
Message-ID: <4c44029f32c3e6d5e3190e1f5687a604ebeafdff.1743337403.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743337403.git.pav@iki.fi>
References: <cover.1743337403.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change bpf_sock_ops_enable_tx_tstamp() kfunc to only set SKBTX_BPF flag,
so that it can be used also for non-TCP skbs.  Do not set TCP-specific
fields if the socket is not TCP.

***

Doing it this way requires a valid tskey is set by the socket family,
before BPF_SOCK_OPS_TSTAMP_SENDMSG_CB.  Alternatively, it maybe could be
hardcoded per socket type here, or some new proto_ops added.
---
 net/core/filter.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 46ae8eb7a03c..1300b0ef3620 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12127,6 +12127,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 					      u64 flags)
 {
+	struct sock *sk;
 	struct sk_buff *skb;
 
 	if (skops->op != BPF_SOCK_OPS_TSTAMP_SENDMSG_CB)
@@ -12135,10 +12136,17 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	if (flags)
 		return -EINVAL;
 
+	sk = skops->sk;
+	if (!sk)
+		return -EINVAL;
+
 	skb = skops->skb;
 	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
-	TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
-	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+
+	if (sk_is_tcp(sk)) {
+		TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
+		skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+	}
 
 	return 0;
 }
-- 
2.49.0


