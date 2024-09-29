Return-Path: <bpf+bounces-40493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7998956F
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEADA1F222F9
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2817965E;
	Sun, 29 Sep 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JX9/zjoe"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102CF145345;
	Sun, 29 Sep 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613720; cv=none; b=hvaR0FvXSn50GULAMX5Vu5Xaj/M+S4dY99/C0ixyNo4Ht+wlDtJLYqVAuGYayoc2wUqHVyrWE0vwYPw6RmT88pEfhx8FE973pbUr6VRN5Ar6N8zElloTLTEEHX3AEwb+UstnsTqHpgMxYveitadxBHWRHK5YP8XGZUn4rxak4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613720; c=relaxed/simple;
	bh=J7kyE1n0xsM6ccqodkg64r5tCRvURZ74HSDilaV21Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGeXFSN68hhvN7l/xmXmgbgA6HIRI+Wn20Y4tQEDftSoc4kGzl0sNAr8TAZW8nHrsZ1730Ewp+hfmCM9STYKa9jnich+7Ty1Rf8DVDpCcxv5KrfMLSms70aqWkdiOxddWsGk/X90K1vIcH3Bq4qbEVfWrHBpzu3rM7p3GWUm1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JX9/zjoe; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=RJWa8
	ZjnZRFMHk5gb1cqv77PUKW/em9W3kVVCR0gW5E=; b=JX9/zjoejAlV1GgemAsSZ
	LLVn8gNmsqTjZL/Cycyz0XeK7CPmIm0L7/L2JefzOWUeQyk0ruOgFrml6hJHMexq
	CAAWKbf2vXxCrxUVEasUocTvUC7x2vKy7Q58fJLBu8tHXNoqLVVOZOhUm4H2xXLl
	JlS0bQsUR61aP9Pua+TcsM=
Received: from localhost.localdomain (unknown [120.227.21.41])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3P_H+SvlmiPtcAA--.11029S2;
	Sun, 29 Sep 2024 20:41:35 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] bpf: fix the xdp_adjust_tail sample prog issue
Date: Sun, 29 Sep 2024 20:41:34 +0800
Message-ID: <20240929124134.24288-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P_H+SvlmiPtcAA--.11029S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UGw1DuFW8Jw4rJF4rAFb_yoWkCFg_Kw
	1Ut3yru3s5tr4rZF1UXFn7Jryqkw4xG34Fq3yfKFy7u3WFqw4UWrykur1fAw1DWr4v9Fy3
	Jrn3ua48GFWjkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnC4EtUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNwxpvWb5OlK5OQAAsY

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


