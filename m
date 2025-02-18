Return-Path: <bpf+bounces-51781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73C4A3903C
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 02:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72160188FD23
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 01:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12291D52B;
	Tue, 18 Feb 2025 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n55o8bmk"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2723C749A;
	Tue, 18 Feb 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841583; cv=none; b=slYd2+e5rzr9k3CYtxRsy2jf69zSWjPhyYKftOZJ13AfCkz8r/VoMMdKixM0JzLNxg3wB3EfomAjd4o0Ub8VTshcguRFI5sMsJRqp1fmga54ILt3s5fn9Xir/tGY5FiJBRgpiPGIDHGEXfxZIipS2n4jSF98UDfyOsQ4U2mUFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841583; c=relaxed/simple;
	bh=c/ZQGdXIfgHE4q3zLhqGd2gcz/q/MQny26xl8zQZnXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtNYIKNCvukBHixBnnXIwd+ATa9tTK7Y6QR+kZvLmGEwf51JXetAUqlVeYgkHzybCyyUR6aO5gsrVr3nhOrCTSq0bPMRZcbh3jr9CNq9MFv3RY/3t0yf7s/vdjaQAvIcTZgDqGxhQs7PiIHiFsRnC/fPUTVuua6esRN86bnR1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n55o8bmk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1A4W/
	wxVhLOVPo5bfmTxi6BeWglYj96/K2R6TB6QL08=; b=n55o8bmkxkVxXAJXBBpp4
	UW8Q3PeaNmDgJfA8+UawiKpvwV3W1YV9ABXK8x9Q5vX+5hlYu/7moQle1egFrd03
	smAVTHfwAW+z6Mtn3GLFfkVqGZF38gJ+OtoGxt+WCJy6XfP++YPwdiuLoCnmpIvr
	jA7e7M0LSp5hwz/A8rcS9w=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHb+m637NnPp9RNA--.63284S4;
	Tue, 18 Feb 2025 09:17:48 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: kuba@kernel.org,
	louis.peens@corigine.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	haoxiang_li2024@163.com,
	qmo@kernel.org,
	daniel@iogearbox.net
Cc: bpf@vger.kernel.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
Date: Tue, 18 Feb 2025 09:17:44 +0800
Message-Id: <20250218011744.2397726-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHb+m637NnPp9RNA--.63284S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3tr48Zw43Gry7Zr1xAFb_yoWDXrcEkF
	129Fnak3yFkr1Ykr4jgw4avr9Fywn0qryruFZxKrZavry7Ar48XrykurZ5AF9rWF4xAFZr
	X3s7JrWUAa42qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqQD3bmez3bE5egAAsL

Add check for the return value of nfp_app_ctrl_msg_alloc() in
nfp_bpf_cmsg_alloc() to prevent null pointer dereference.

Fixes: ff3d43f7568c ("nfp: bpf: implement helpers for FW map ops")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- remove the bracket for one single-statement. Thanks, Guru!
---
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
index 2ec62c8d86e1..b02d5fbb8c8c 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
@@ -20,6 +20,8 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned int size)
 	struct sk_buff *skb;
 
 	skb = nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
+	if (!skp)
+		return NULL;
 	skb_put(skb, size);
 
 	return skb;
-- 
2.25.1


