Return-Path: <bpf+bounces-40492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAFA989564
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78683285062
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9C176FA7;
	Sun, 29 Sep 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G1L7U3Yr"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5B224F0
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613554; cv=none; b=sO5lYtJwTfODPvrplfNzGdj/9dE+wdCgy3XiY2qhxk/sxrMpwIL6WXc5NUhMu/DwJBv672UWodObe1cJLPyg5A4TWivbU9rOsbLmqDn8dl8uK/2H+F+2cdWcXOGKg+RAdPTbGEzs0Gs/B9Z4elJ7sbL36mfIv1vzyR9Ug75hbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613554; c=relaxed/simple;
	bh=J7kyE1n0xsM6ccqodkg64r5tCRvURZ74HSDilaV21Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FerhPkZCgN48zCq9zZS05CQq9JByqcXwfJVvMoBA5T+dp+iWA5LQAA51bPuOtc5FSyPcRV/fP5F6XVobDxB9PMTe+6MB6A5i0li1t6GL+Fkc1Z7+HKnr9VQ8eqEU3fH2TKciSSYimAxFoCU3q37kVH3z50VOtM5vm3i/5onEyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G1L7U3Yr; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=RJWa8
	ZjnZRFMHk5gb1cqv77PUKW/em9W3kVVCR0gW5E=; b=G1L7U3YrToYuiOj2epUf4
	DU4OLHsBokJSLQGjUF4yG3eUk/EakrzV6p3lXjdaYdf1kNlF/r6bMpXhriqYCJOk
	6k53dOOilHDyuXxwZ7Ukv3+edHK/niu5rT3g87qOdfA2fZw7iHiOmHS8UJP+tRhj
	lLQN6ErZZMjHjFp15dGa2g=
Received: from localhost.localdomain (unknown [120.227.21.41])
	by gzsmtp5 (Coremail) with SMTP id tCgvCgD3P2VkSvlmpReIAA--.26101S2;
	Sun, 29 Sep 2024 20:39:01 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: ast@kernel.o,
	andrii@kernel.orgrg
Cc: netdev@vger.kernel.o,
	bpf@vger.kernel.org
Subject: [PATCH] bpf: fix the xdp_adjust_tail sample prog issue
Date: Sun, 29 Sep 2024 20:38:59 +0800
Message-ID: <20240929123859.24086-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:tCgvCgD3P2VkSvlmpReIAA--.26101S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UGw1DuFW8Jw4rJF4rAFb_yoWkCFg_Kw
	1Ut3yru3s5tr4rZF1UXFn7Jryqkw4xG34Fq3yfKFy7u3WFqw4UWrykur1fAw1DWr4v9Fy3
	Jrn3ua48GFWjkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnuBT5UUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiJwppvWb5N8LNxwAAsZ

From: Yuan Chen <chenyuan@kylinos.cn>

During the xdp_adjust_tail test, probabilistic failure occurs and SKB package
is discarded by the kernel. After checking the issues by tracking SKB package,
it is identified that they were caused by checksum errors. Refer to checksum
of the arch/arm64/include/asm/checksum.h for fixing.

Fixes: c6ffd1ff7856 (bpf: add bpf_xdp_adjust_tail sample prog)
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 samples/bpf/xdp_adjust_tail_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/xdp_adjust_tail_kern.c b/samples/bpf/xdp_adjust_tail_kern.c
index ffdd548627f0..3543ddd62ef4 100644
--- a/samples/bpf/xdp_adjust_tail_kern.c
+++ b/samples/bpf/xdp_adjust_tail_kern.c
@@ -57,7 +57,8 @@ static __always_inline void swap_mac(void *data, struct ethhdr *orig_eth)
 
 static __always_inline __u16 csum_fold_helper(__u32 csum)
 {
-	return ~((csum & 0xffff) + (csum >> 16));
+	csum += (csum >> 16) | (csum << 16);
+	return ~(__sum16)(csum >> 16);
 }
 
 static __always_inline void ipv4_csum(void *data_start, int data_size,
-- 
2.46.0


