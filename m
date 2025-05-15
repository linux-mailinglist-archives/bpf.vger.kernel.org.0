Return-Path: <bpf+bounces-58269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6BAB7AFB
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 03:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9862C1B65EEA
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 01:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E062269AE6;
	Thu, 15 May 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AnoUd7QG"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298923BE;
	Thu, 15 May 2025 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747272776; cv=none; b=cTO4vnteVC31g6VCddAazi11T0RGVzclS/3oqrf71RbtQ7VoNgdZyo1iXgYOQ2GFtKP6HsSdsFi1l7Pj+Mk2ns/JSqJbDOs7TSUKLS94ud5ZCdloRTOafxndH3RmVPQywfCY7tMFdzSXVtNjqOSPSDob/f88iX6irmfa1AKqg1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747272776; c=relaxed/simple;
	bh=9wA7RdmbNapS/2b7J2TfGqrkP22KbPova+zjoxgyb+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJLtgL7eEgWALSFNH1X5rP6OUa6GyNEtcWr3QpuKbrj1AmAw2E8d9HYHc7EJ30EZm74msdWGYNB9lGxw8Ysvz40nlPYjpeArcvLbo76g//t1SXPUk6NF9kzEYd/C9mzT1moG4QNBB4pv8HK8uqfK20Fbkm9UF+GIT/LiJLfTK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AnoUd7QG; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ss
	eu97KlXl6TVBlUuVYBOxoW4h4rgHHPvwjyLex7C+8=; b=AnoUd7QGNahbWEFnxW
	LSWwxkfIt/bAFitKFtf05oVZKS4zH9KR6BRY//mIYTXU+qBK3Ee79CzUXBRAdOB9
	wkYszWe2ZCe3qtL2mtGBVtaiEVuwPHu2zrl9EWnREkWdgCrmeC862Ik9teNoESSF
	j5BN3R+ZlBkYNFdiyUpMS7IXc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXf9clRCVoPz_mAg--.40336S2;
	Thu, 15 May 2025 09:32:23 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH nf-next] netfilter: bpf: Remove bpf_nf_func_proto
Date: Thu, 15 May 2025 09:32:21 +0800
Message-Id: <20250515013221.25503-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXf9clRCVoPz_mAg--.40336S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF15Kr4DKr43ZryUCw17KFg_yoWfKFg_Cr
	y8tayxGFWrKr95Aa4UuFZrury5G34rWr4fXa4xXws8A343J3WvkFWxWr9YvrW5u3W7KryS
	yrs0kryUtrWDKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUji0eJUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiThpOeGglQ6wTrwAAs8

From: Feng Yang <yangfeng@kylinos.cn>

Only use bpf_base_func_proto, so bpf_nf_func_proto can be removed

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 net/netfilter/nf_bpf_link.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 06b084844700..f277722f9025 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -316,13 +316,7 @@ static bool nf_is_valid_access(int off, int size, enum bpf_access_type type,
 	return false;
 }
 
-static const struct bpf_func_proto *
-bpf_nf_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-{
-	return bpf_base_func_proto(func_id, prog);
-}
-
 const struct bpf_verifier_ops netfilter_verifier_ops = {
 	.is_valid_access	= nf_is_valid_access,
-	.get_func_proto		= bpf_nf_func_proto,
+	.get_func_proto		= bpf_base_func_proto,
 };
-- 
2.43.0


