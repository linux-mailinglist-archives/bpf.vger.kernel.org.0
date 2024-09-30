Return-Path: <bpf+bounces-40536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7098994A
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 04:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C84282B6D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CDF20B0F;
	Mon, 30 Sep 2024 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PzhZRL6g"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1A2904;
	Mon, 30 Sep 2024 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727664110; cv=none; b=VdZ2E/jOObftamfbpaT6xMotSSbM52OjjmUeq93ie6IYnSbNGA+j67B6SRmc95u2bmNFmd8dYVyxfE0zJoz2ta0SFvH08D0Uhy7wao/9fGbvctybBnuxstFWIOsBGpb/ulU+JFIUKc+e0IQZLln+/ygAXmSB76e6Os3ITVbrmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727664110; c=relaxed/simple;
	bh=SwUa/2vFlzkdT+o7SCkvNnjW2SU3ed4Nqa9WCyYs+Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbWT+g3oSYmQOfM10rhZ6Irdv2OwW0yO6XG5mBzVL3oY3Xxv89GFLQayOW1sP84OH4rRTCenrwM1IoXN/xmSW9CJpi4kDpVk3OtLMaxlmxWpRr36DMUSYu50bV4oNC1FIUsLQP7/tvCDZzV/0OXDTJqyd7kkrjZdoMGg0h/M2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PzhZRL6g; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=WaNsb
	5YiXE/2eQuTLSUsqARxbxhkfizWFNXn7Ez68aI=; b=PzhZRL6gOwu1iZ3emlwHH
	2xqIOjPK3T4GV/uaOr3685a7g6REbNKmBYzEAGhkytDPX4EVDPAjl+WKzLIsUoOR
	8TjoS2Fsuh3BJuRlbASzD9KrES3MRiBeE0M+KOq/5WKeumq5kdbJNn0tZkKXoPcG
	3qGEbQjJ6za9HHDlmjiSkg=
Received: from localhost.localdomain (unknown [120.227.21.41])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3X1_LD_pmpubJAA--.25373S2;
	Mon, 30 Sep 2024 10:41:17 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [v2] bpf: fix the xdp_adjust_tail sample prog issue
Date: Mon, 30 Sep 2024 10:41:15 +0800
Message-ID: <20240930024115.52841-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X1_LD_pmpubJAA--.25373S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UGw1DuFW8Jw4rWF4UArb_yoWkArc_G3
	W7t3yruwn5tr4FyF1UXFn7Jr909ws7WryYvrWfWFy2k3Wvqw47WrWkuF1fAw1DWr4qkFy3
	Jwn5Xa48KFWqyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnuBT5UUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNxxpvWb5iM1S4QABsX

From: Yuan Chen <chenyuan@kylinos.cn>

During the xdp_adjust_tail test, probabilistic failure occurs and SKB package
is discarded by the kernel. After checking the issues by tracking SKB package,
it is identified that they were caused by checksum errors. Refer to checksum
of the arch/arm64/include/asm/checksum.h for fixing.

v2: Based on Alexei Starovoitov's suggestions, it is necessary to keep the code
 implementation consistent.

Fixes: c6ffd1ff7856 (bpf: add bpf_xdp_adjust_tail sample prog)
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 samples/bpf/xdp_adjust_tail_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/xdp_adjust_tail_kern.c b/samples/bpf/xdp_adjust_tail_kern.c
index ffdd548627f0..da67bcad1c63 100644
--- a/samples/bpf/xdp_adjust_tail_kern.c
+++ b/samples/bpf/xdp_adjust_tail_kern.c
@@ -57,6 +57,7 @@ static __always_inline void swap_mac(void *data, struct ethhdr *orig_eth)
 
 static __always_inline __u16 csum_fold_helper(__u32 csum)
 {
+	csum = (csum & 0xffff) + (csum >> 16);
 	return ~((csum & 0xffff) + (csum >> 16));
 }
 
-- 
2.46.0


