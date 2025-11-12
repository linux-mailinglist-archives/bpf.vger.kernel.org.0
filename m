Return-Path: <bpf+bounces-74336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA2C54CC9
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 00:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 621D64E0674
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9B62F2606;
	Wed, 12 Nov 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FtabXl5d"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCF35CBAF
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762989854; cv=none; b=b7D7ih/1K2CXZd8xnVnTB5R3jUk0THmJLgJPDBfHL6b3ANl/bI1gbKuznCIzriPMsZfQ914+8D4NB+8XzCuSp62aAzc2e+hj3zlCgF3mC+fE010xDqswLTBwIyaTEy15m5eDvbFeQXHomX8eOMoPSQqhbwtk5aOSqd2+X1Y/Mjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762989854; c=relaxed/simple;
	bh=/rrqrWefr6Be8/0xwOqC6LYKV/EgTwyOcbreEBWCCuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sn8XYzPEc0vLv2j4VzrUIJ8pBM5D9USl5FRpWVtCjDUt4W5gEh6Y0lXQVEqQIt80kbPcz6oM2MwsrTsW0IoBb8ZFw4/I30CSVyA/pUJQjKoW2ltRn/82nEUta4hq1glHAdhpbJaKl0Bug9TPZpOQoP7sfeHSsIOxJ+9e+OviPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FtabXl5d; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762989847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ae3Y9wLC7e7ztA80BXItavwEzFGlDsl4crb0Mx/OgXA=;
	b=FtabXl5dLrk+jCbT6Y9bZm8NdSH0StZRFNjxqiKkDpSgpmpCI9EB50QX4Dwn2Mh/JQDXhq
	uWDxxdkvrvANJfd10xVkxqTeU50xPvEzJiajee/TgnLeecoyB+rnHi0QW2bzmewAZ/LdaZ
	YW/WvQwZILBFJcHBucFPNmuRsQgSvtQ=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH bpf-next 1/2] bpf: Check skb->transport_header is set in bpf_skb_check_mtu
Date: Wed, 12 Nov 2025 15:23:30 -0800
Message-ID: <20251112232331.1566074-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf_skb_check_mtu helper needs to use skb->transport_header when
the BPF_MTU_CHK_SEGS flag is used:

	bpf_skb_check_mtu(skb, ifindex, &mtu_len, 0, BPF_MTU_CHK_SEGS)

The transport_header is not always set. There is a WARN_ON_ONCE
report when CONFIG_DEBUG_NET is enabled + skb->gso_size is set +
bpf_prog_test_run is used:

WARNING: CPU: 1 PID: 2216 at ./include/linux/skbuff.h:3071
 skb_gso_validate_network_len
 bpf_skb_check_mtu
 bpf_prog_3920e25740a41171_tc_chk_segs_flag # A test in the next patch
 bpf_test_run
 bpf_prog_test_run_skb

For a normal ingress skb (not test_run), skb_reset_transport_header
is performed but there is plan to avoid setting it as described in
commit 2170a1f09148 ("net: no longer reset transport_header in __netif_receive_skb_core()").

This patch fixes the bpf helper by checking
skb_transport_header_was_set(). The check is done just before
skb->transport_header is used, to avoid breaking the existing bpf prog.
The WARN_ON_ONCE is limited to bpf_prog_test_run, so targeting bpf-next.

Fixes: 34b2021cc616 ("bpf: Add BPF-helper for MTU checking")
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/core/filter.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1efec0d70d78..df6ce85e48dc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6429,9 +6429,12 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 	 */
 	if (skb_is_gso(skb)) {
 		ret = BPF_MTU_CHK_RET_SUCCESS;
-		if (flags & BPF_MTU_CHK_SEGS &&
-		    !skb_gso_validate_network_len(skb, mtu))
-			ret = BPF_MTU_CHK_RET_SEGS_TOOBIG;
+		if (flags & BPF_MTU_CHK_SEGS) {
+			if (!skb_transport_header_was_set(skb))
+				return -EINVAL;
+			if (!skb_gso_validate_network_len(skb, mtu))
+				ret = BPF_MTU_CHK_RET_SEGS_TOOBIG;
+		}
 	}
 out:
 	*mtu_len = mtu;
-- 
2.47.3


