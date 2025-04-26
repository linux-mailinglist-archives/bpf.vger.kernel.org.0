Return-Path: <bpf+bounces-56770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCE4A9D942
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17726464150
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688525179F;
	Sat, 26 Apr 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFkvH3nT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1F1922D4;
	Sat, 26 Apr 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745655236; cv=none; b=XGWCUX465E7fGSVltXW805hANNX8CjTcudilr0e2In8BxF2/zcaKHY0RRJ54EeTdpKO6FECpGhzR8ENmfnBWRJaNB1yQY/Fo09xeXbxebR2r/znsbwDxi0mqWT7zhH3HINf0CGhSLkCNI2Yzjbp8oTxLXJIUC0Th1KQTqhf+On4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745655236; c=relaxed/simple;
	bh=RRgJ0M8WImGsVCT3LiCickwe65JTKgCkTOOLN+aRAdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP39WHzvZAugiPM5AMebHo6BhNdhxI12ubExwhobCxqxI28ZBhLLEBG4bDpBJoBbhgVFkj6rXZN+DOHT9XgFJMoFZgfABzMyRGWq4IqzSt4F3nW8gYRd+RLfzu2YRDpKOy6tO4QfUxGYXZpyr3keMXRCkucGDm39sSFMj5Bh6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFkvH3nT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376dd56f60so2346798b3a.3;
        Sat, 26 Apr 2025 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745655233; x=1746260033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eH8QzBJQF0/lOlRD7wA47uCgpgIE30Df48r/OH+A7Vc=;
        b=HFkvH3nTaViOSV4SzoDwY0I5nliY4pbVAJxTcRCsE/1maYMjr1xnf3dwIgob+c/8bn
         /7JyXFwusU/XvoeHpMOPQICDcbvQ/b4mgMN6PGOZVuJET8MexfP5SE+gV7MwQDQZ01MR
         QwNb/e38ECyPXhTy03db6N3/gNC0n5K+Y8DFl+gGEflwOM+zRUs4RGaScoXieU0wH1ZM
         B62v8BqZ6EtCMW+BegHTuBqOHG3djQouZqcO9wVNi4VHqgciJPKfLrlZ0QEL01AVnMlH
         /QCRI6IyUWnsoFv5/aIOLcX8RAXieG4HuTFVZGVntPxDMDPgZdcdgGmie9uVFFOocSPB
         10BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745655233; x=1746260033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eH8QzBJQF0/lOlRD7wA47uCgpgIE30Df48r/OH+A7Vc=;
        b=acy/GEg2YoVOmHsUJw6T5fICGGa7/8hPFdlX+OID+wW21001yy+MbszL3j6BCM+hq+
         OLz+3W3CyoOxwRoAg0xi4yiM3b9aAFekueSNUqOfRSt96HW5wYd5pJQYLg/QYxV6MbV6
         ixt11XhgLW2ufiiMzunU1kXVwxSitR0esmskNwtpwPYXM47JujkeJomPBva9EISB7EGW
         1jCDCWxpy2zg8+eIoT9dvXwr8AdHK09WRWO7H2OrS5cxP/NGkEu4jrCvsgLbbBagl0Hc
         ULSUa/ldfUyf0fq4jnwKSRmy63dTN4XMaXnUjhjV+AIWVxBb+OO6y9J7UA/EHmM86/ul
         x3/w==
X-Forwarded-Encrypted: i=1; AJvYcCWt74UqfQh0YxTRSS8xYNtvoflxNq014seD5vLI+aQHKLhJ24mWhYhNa40Q+OpOQSuC1jXn7TO1voNtbic6@vger.kernel.org, AJvYcCXkDOGt+Xf2kk09G6JOvx/Qn3HbhEKdj6N98bBgRETRydYDrfOkFpKUOQDa5D30OsuuSGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplYP8rwLtq3NmgcJIefjoJkkKEwNKTmho4oU6W0e0xVsp0MA4
	7aGwvi6j6+6St3qniMyQndDN+RBtoQTpYMYH0G5QD3MuoSfUj5G44wGqZHvI
X-Gm-Gg: ASbGnctt247ORRuQW/hzXKXGBN38zvp1ii5O4xyr0QvOFCIn9E5S9Qf3imcdCMpKhEW
	3DsObQUO75MgDLrV2pUdcis7Zj7XgKS8xH/I7w+C4qwNJO/fkILZqUdrZOpD8PSQDszmKwGKPOj
	eoCvK/18qEUnwkQTVSfN2Ic9zB0CS4w0c2A8y7AK3maRbi1SBwrccmOxwD5wo4RJT3BrcsOG9qJ
	7bbdbhrL7oczDfDV2gavRtzoPkUzLbnPF9FgC7zyk+sOF1jcdKJvS/OERocntSYHZHW80L5DNk5
	oZQzfjPk0gy2MWiLy9/ylVWsgAuCknRVt8kvCUfwN/86MkSKwKI+E3g+
X-Google-Smtp-Source: AGHT+IEnU9oZyJ5GoaLkPDm5yq3VJd2HPNs7PPm0BnwPXq1TSM0GRuSCzfX7Q++U5KRAZsW8ctxlbw==
X-Received: by 2002:a05:6a00:228e:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-73fd6de9577mr7983197b3a.8.1745655233008;
        Sat, 26 Apr 2025 01:13:53 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52b1:1f45:145e:af27])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bf7sm4503700b3a.68.2025.04.26.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 01:13:52 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net-next v2 2/2] xsk: convert xdp_copy_frags_from_zc() to use page_pool_dev_alloc()
Date: Sat, 26 Apr 2025 15:12:20 +0700
Message-ID: <20250426081220.40689-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426081220.40689-1-minhquangbui99@gmail.com>
References: <20250426081220.40689-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit makes xdp_copy_frags_from_zc() use page allocation API
page_pool_dev_alloc() instead of page_pool_dev_alloc_netmem() to avoid
possible confusion of the returned value.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 net/core/xdp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 89111c68e545..4e91c7790671 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -701,21 +701,21 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 		const skb_frag_t *frag = &xinfo->frags[i];
 		u32 len = skb_frag_size(frag);
 		u32 offset, truesize = len;
-		netmem_ref netmem;
+		struct page *page;
 
-		netmem = page_pool_dev_alloc_netmem(pp, &offset, &truesize);
-		if (unlikely(!netmem)) {
+		page = page_pool_dev_alloc(pp, &offset, &truesize);
+		if (unlikely(!page)) {
 			sinfo->nr_frags = i;
 			return false;
 		}
 
-		memcpy(__netmem_address(netmem) + offset,
-		       __netmem_address(frag->netmem) + skb_frag_off(frag),
+		memcpy(page_address(page) + offset,
+		       skb_frag_page(frag) + skb_frag_off(frag),
 		       LARGEST_ALIGN(len));
-		__skb_fill_netmem_desc_noacc(sinfo, i, netmem, offset, len);
+		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
 
 		tsize += truesize;
-		pfmemalloc |= netmem_is_pfmemalloc(netmem);
+		pfmemalloc |= page_is_pfmemalloc(page);
 	}
 
 	xdp_update_skb_shared_info(skb, nr_frags, xinfo->xdp_frags_size,
-- 
2.43.0


