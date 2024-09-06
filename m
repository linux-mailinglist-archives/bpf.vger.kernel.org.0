Return-Path: <bpf+bounces-39135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641B96F609
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3493C1C2413D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9991D0140;
	Fri,  6 Sep 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HNUsqHrs"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CCE1CF290
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630983; cv=none; b=AS93OIDit4ZSryKy6hqJIrFnC/lAQh/QAPG1h7PhZVr//eCzDzahw9MiFjaZCUrxXPL1QR1gilU1Pb2bN6B9fS5lM2VHHCCFz43fAQAGWmuDckYxxCwTPNJ88ixnIqoUoN80CUuz1kxSG7Hyw9aDO4ajw/tQcg9hyTt/KgqTVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630983; c=relaxed/simple;
	bh=mOLqmcaj6NfBRTZVi/SyNZIiHuYz0BYonof+zJ3aA0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VL6esw5eDspUpmorTevL6djOXoe4ZWTrAQzIWZzlSufz35IRcWXmYmzm8z/KySfp3AR0kKOetA/Q3vtfp93UTH1lfvgN0QnxSzy0IxejnnCuV+5j9/SO/HVCP1PQv8M/VxDqcBpn7i2M9SEI8+o2hbw+7sPQr1LNxKt4bSxct04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HNUsqHrs; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hg9Nw2K/PwHqvGvwP5rsyT5iX/6zIzoEGXXOTrrrCuc=; b=HNUsqHrsQ0Yh3/L5Q7wtBpxLL/
	CqIsOZW7zJStUjcz+fBIlyJfyVFxauuiE6Ou0hOkvtwLcGlWqRh6nNibaOPUun0GfYSrWUwkUng5J
	YR3ZuZjeQuON6KKpTWnC2qdQVJC20ZpHuKoO2dmeQo9K26HuFS287rdPXfKTdKW2uFRpAFIM/rgmZ
	7PR2X6EdIqCeSKnG2PhyguwGGDnd6/TQa5P6zuIrnn/rcPKnTpmbFfsPrRgIi/wc4jqrpYaG3+j3n
	wR3WTXAJZkzjBiWpueDdPvXOlI1OPuRyUQMJa1EJdEbFsDcIuLvhRORmOum9Z16Xmqa8Uey5N7RUP
	ZvO704sg==;
Received: from 15.248.197.178.dynamic.cust.swisscom.net ([178.197.248.15] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smZRc-0001zH-SV; Fri, 06 Sep 2024 15:56:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 5/8] bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error
Date: Fri,  6 Sep 2024 15:56:05 +0200
Message-Id: <20240906135608.26477-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240906135608.26477-1-daniel@iogearbox.net>
References: <20240906135608.26477-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27390/Fri Sep  6 10:38:06 2024)

For all non-tracing helpers which formerly had ARG_PTR_TO_{LONG,INT} as input
arguments, zero the value for the case of an error as otherwise it could leak
memory. For tracing, it is not needed given CAP_PERFMON can already read all
kernel memory anyway hence bpf_get_func_arg() and bpf_get_func_ret() is skipped
in here.

Also, rearrange the MTU checker helpers a bit to among other nit fixes
consolidate flag checks such that we only need to zero in one location with
regards to malformed flag inputs.

Fixes: 8a67f2de9b1d ("bpf: expose bpf_strtol and bpf_strtoul to all program types")
Fixes: d7a4cb9b6705 ("bpf: Introduce bpf_strtol and bpf_strtoul helpers")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
 - only set *mtu_len in error path (Alexei)

 kernel/bpf/helpers.c |  2 ++
 kernel/bpf/syscall.c |  1 +
 net/core/filter.c    | 35 +++++++++++++++++------------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0587d0c2375a..ff66a0522799 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -523,6 +523,7 @@ BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
 	long long _res;
 	int err;
 
+	*res = 0;
 	err = __bpf_strtoll(buf, buf_len, flags, &_res);
 	if (err < 0)
 		return err;
@@ -549,6 +550,7 @@ BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
 	bool is_negative;
 	int err;
 
+	*res = 0;
 	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
 	if (err < 0)
 		return err;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index feb276771c03..513b4301a0af 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5934,6 +5934,7 @@ static const struct bpf_func_proto bpf_sys_close_proto = {
 
 BPF_CALL_4(bpf_kallsyms_lookup_name, const char *, name, int, name_sz, int, flags, u64 *, res)
 {
+	*res = 0;
 	if (flags)
 		return -EINVAL;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 4be175f84eb9..c219385e7bb4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6264,18 +6264,19 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 	int skb_len, dev_len;
 	int mtu;
 
-	if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
-		return -EINVAL;
-
-	if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
+	if (unlikely((flags & ~(BPF_MTU_CHK_SEGS)) ||
+		     (flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))) {
+		*mtu_len = 0;
 		return -EINVAL;
+	}
 
 	dev = __dev_via_ifindex(dev, ifindex);
-	if (unlikely(!dev))
+	if (unlikely(!dev)) {
+		*mtu_len = 0;
 		return -ENODEV;
+	}
 
 	mtu = READ_ONCE(dev->mtu);
-
 	dev_len = mtu + dev->hard_header_len;
 
 	/* If set use *mtu_len as input, L3 as iph->tot_len (like fib_lookup) */
@@ -6286,10 +6287,10 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 		ret = BPF_MTU_CHK_RET_SUCCESS;
 		goto out;
 	}
-	/* At this point, skb->len exceed MTU, but as it include length of all
-	 * segments, it can still be below MTU.  The SKB can possibly get
-	 * re-segmented in transmit path (see validate_xmit_skb).  Thus, user
-	 * must choose if segs are to be MTU checked.
+	/* At this point, skb->len exceeds MTU, but as it includes the length
+	 * of all segments, it can still be below MTU. The skb can possibly
+	 * get re-segmented in transmit path (see validate_xmit_skb). Thus,
+	 * the user must choose if segments are to be MTU checked.
 	 */
 	if (skb_is_gso(skb)) {
 		ret = BPF_MTU_CHK_RET_SUCCESS;
@@ -6299,9 +6300,7 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 			ret = BPF_MTU_CHK_RET_SEGS_TOOBIG;
 	}
 out:
-	/* BPF verifier guarantees valid pointer */
 	*mtu_len = mtu;
-
 	return ret;
 }
 
@@ -6314,16 +6313,18 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	int mtu, dev_len;
 
 	/* XDP variant doesn't support multi-buffer segment check (yet) */
-	if (unlikely(flags))
+	if (unlikely(flags)) {
+		*mtu_len = 0;
 		return -EINVAL;
+	}
 
 	dev = __dev_via_ifindex(dev, ifindex);
-	if (unlikely(!dev))
+	if (unlikely(!dev)) {
+		*mtu_len = 0;
 		return -ENODEV;
+	}
 
 	mtu = READ_ONCE(dev->mtu);
-
-	/* Add L2-header as dev MTU is L3 size */
 	dev_len = mtu + dev->hard_header_len;
 
 	/* Use *mtu_len as input, L3 as iph->tot_len (like fib_lookup) */
@@ -6334,9 +6335,7 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	if (xdp_len > dev_len)
 		ret = BPF_MTU_CHK_RET_FRAG_NEEDED;
 
-	/* BPF verifier guarantees valid pointer */
 	*mtu_len = mtu;
-
 	return ret;
 }
 
-- 
2.43.0


