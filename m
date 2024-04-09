Return-Path: <bpf+bounces-26275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD989D856
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 13:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD692819F6
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22D127B7B;
	Tue,  9 Apr 2024 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OxE5DP9J"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5586242;
	Tue,  9 Apr 2024 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663048; cv=none; b=iMQP3+2UK4bW0cW3ZVLSxUSjRal/sFKAzPvl2QI1s5cl8ag47akbl0VzzNH5X+CyXLRZYvzw9UfB5I779NRDmlgV6we4WIlpJE7DloctxBj34Sq+27f4bS2BNRZaPN+qVz/uDPCcQgVI4kCkPSCnbUIbBd1MmsyezAai0pwWLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663048; c=relaxed/simple;
	bh=1dQG2CvAIYQGD4YX1qhjNYbP21CNDqzNX0gQDzEE75w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=g6p0NbR4ilF4WoOlOUhUJDBTYH2DJcukpDCMuulg7pvlDiUijT5sWGbTZIK07oqJwoO/mTe/HyDgSZIy2ydDcuSajjDShPXst3PAjfcankYH+ZNy4PrT6k20GqR9SOyrTiThYVmLZgCkHRwDltPqTAuLa46Gj5YuGAeUuieVTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OxE5DP9J; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712663043; bh=ek038P3LxIw6ciT6YTkaoOBDNFyc6zhMZtJXRjLxO2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxE5DP9J5wJ4vPeRBpEtobdQDNHXMmx6jF/g7f4Mz1snQoYVLMGiL9YmOB808Qfgu
	 QJrHLRVKhDo2GU2WmqXay2HztKEGf/ydGkXVWQRNyMhACbHzqnhz8ISseyAZSSznx8
	 y8j4Ydwyqy3ao+fuiwgcb4+cKM4LYYLTp+LSYKTg=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 96A80033; Tue, 09 Apr 2024 19:37:42 +0800
X-QQ-mid: xmsmtpt1712662662tw6erwfdr
Message-ID: <tencent_AABA5D95191FCFD28DB325F58D8212525D07@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDVVgYBMuObIt7JY7d+1JJldgIEcNGDmR75Mny7SS/dHiEza6dSIl
	 G/Mq+ty3e57hyKBAmSoLMVu0nn/iwyNqwiNgwShDz/Wzp1qwnxR8IAKzJkgyUtXEgHTcRLJDoh44
	 dPQyOcex70aCjGv32PeQ8hpphjivh860XqgXXkE+8RySOSeS/j6Js1Q41fYgITH/frAnGOXRvz0s
	 ME4ZKTpQnrNTaxllfs5+Ch0GIg+8ivwTQ9XC3ZrBJGHpgd6uP0CZ0L4fjSD6lupgu3zgc//43ysD
	 6jJMb0i0ZqpgpRNLsGe1CYqJUihji8XNokAqdAkchbUJAOKrdOC8tiP/B0BIGwAbz9VUyLLMGbMS
	 HNT3GfUESr/93xMNphzEbYS90JvTdsj3ipwDm0ELC6BQqKkQpJghx5JLlSWHHGxSxEkTGNyBsSMT
	 yipAnTQMkIG2iw4RJRRKi5MX7mZAKq6PE0lz3jHzPvCruqXQbsK27+eOOvSMB4OVukXPXGfavviZ
	 nWtlCPx9MHwbDTq+eBs0fbVWFosb/45+UB7xGFyLLPOyzy+p9OBvwe9w5qs7NXvxPLjf72ff4K01
	 coIk7nuvZf3Pds8qmOzbz3CXo5GgOaweKUprYm9/yzMPAq9PFZJZ+58gQeS/6R0rMtLLUqUJorro
	 h8eOmfHJ0mVER/eE95YejLzVsH5eT2IVUn9QtiRUveS8WNet2AVSaLiqG+WGnfe95x4k4/xE0hHk
	 dF/Yp4BfrVUg5P28n4+jMy9vJu+hxDHfof9xUbKh9AJy1LwbQ03oNt0Mz5Q4UG2VYSRgNbHIHxTX
	 f2EVUBZyu1dL8vDZCnbMdW0earas4LzlyywTrbk1CkH+vNv3vYA+8akcZ61iY98Do7UJ2vw7Wadz
	 mJ8YUQt3h727jYFBUReIMcoAMAYBtQcLm2NleOZE0HCYpcxy7bz1OOX4I4BblYhGVBLoSqxOurvf
	 GErxvfbvUFFwDaVOSmeXmoFmZ1wZpBRzpjGuJ0fbh0U+/Xx00Iow==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: fix uninit-value in strnchr
Date: Tue,  9 Apr 2024 19:37:43 +0800
X-OQ-MSGID: <20240409113742.4055421-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000009e2ff406130de279@google.com>
References: <0000000000009e2ff406130de279@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the context in bpf_bprintf_prepare(), this is checking if fmt ends
with a NUL word. Therefore, strnchrnul() should be used for validation instead
of strnchr().

Reported-by: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 449b9a5d3fe3..07490eba24fe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -826,7 +826,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	u64 cur_arg;
 	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
 
-	fmt_end = strnchr(fmt, fmt_size, 0);
+	fmt_end = strnchrnul(fmt, fmt_size, 0);
 	if (!fmt_end)
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
-- 
2.43.0


