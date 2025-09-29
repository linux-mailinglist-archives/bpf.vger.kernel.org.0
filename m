Return-Path: <bpf+bounces-69954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40596BA97DE
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E033C6D51
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BAF309DCC;
	Mon, 29 Sep 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dAnvrH4q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCD309DAF
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154967; cv=none; b=aTUCdgxnY791XmYzX3sI/FcRlK948OvUQpT70Ot0Z3SVdg73yARzOYldyUi9o3sKYnvZa9kiR0JDOvbFQWDPC7dOTa/crupfLWKCRwo8hYMgkmVkDUJCqUX8iRO0UslbIpAY/ZrYmEnQlj12F5Xny6K7RR+G1T4g41KtJ00VAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154967; c=relaxed/simple;
	bh=jphV3hLYyJpq5wHhzxxIdaldllEhemXAkq3l8pQxo6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpKd+3igSOAPsrykxj3rA6jToDhSTPga4OsowkwAfh+GPce1M7ae43R5fUB13lAqtABWcm6vwOi9T2raRM000EJAmfwapXHGcrGjpLqoo4RKIGhDW3crMRnu7si3ASSrLq9H6wzatmu16ezNfftbh174F13bzqFCuY8Xz2+drsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dAnvrH4q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78ead12so820260966b.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154963; x=1759759763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=dAnvrH4qGPtT4GTRf9NQxHOyCJxdbX8s+07GvPS9lWYMBr/q8ye8lsnV618l8a7yuM
         BVVOC0RY/JWkGISqYgmUB4RPnpSZzdTagIWFEQlTxnYOSf3uzDbwvPstKxzvsD1jma8B
         XL9dnV0LgrC7LBOcKaZrBdqu1q+IeMLbYrMctXkzineyIXcYXmEYOIWqtrWs/nfOTl4r
         Nz0gX5WkEuOimKg0B80pvoUNjzHxbzumXBjS+/nN/ByZmv5YMPUfShWUk1r+u/CymvQs
         4Vh8If+tD0xyzFEGKO0NIb+sesrvaLhS6O8DUZacvDVmEJOZRzfEzvZu3e1ci3y6L5LG
         GtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154963; x=1759759763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=EBr8rgBjIQSwGRrlpDyEgbMLpMqS+mSnkcPAp/fdL46WQp8Smnq27Lve/jRUgF8Zyi
         1RiV00zyYRaSj1uituWnMKpRrMiw9xX6iwZnzL4iQQS7/hlani30kxYiMi9t5kW+kKzd
         hbBI0nUSHW7k880XJvjR2MKGcFY8iVmHsJqlifzt6diisffp740pWtYMjV/FzjNlTiy0
         40CuGiVP0BDKlZRaWIhP2hYfvhKNd5oUAuyA3W7krnDEwDOnAGKRB9JGtqNW0i0isigR
         dxlHrWRj2LJxLYH54/wbpWLo1Gyzq7phTn49XcpO08DgJ1aHPkQMLwf/00iM6gonHx+K
         yHrg==
X-Gm-Message-State: AOJu0YzZKDF3o/BbnmpODccGsV12W63mXGKJyzD2lW72ZbsA30nDyh0V
	veyf/NEHZKE86Do/WWdNxvOMYOhT43XZfw7lGAeSBXovkpqp3F1P00lfBXLVsN9jqX4=
X-Gm-Gg: ASbGncsbyMNmKU++MVUr5cT9nHjd5sLGdMhCxkAzL7czqAdb148bJ2O8vanyjtJMiNb
	xK/p0ryRpRwLI9YPV+ugjeWbBrunLDe4Eu2tPCOBBaDwxQtjrpFJ22ApOfbjLPy3Sg93W15V6qV
	IHA+5WvI3+niPcCOwsvbsMhwnunIvW/BbddMcNuKDHjNLNhazOQwnsVxr2JXFeFWQndjpnoT9wC
	BdnD/PxcpLQFNP4ZmTuqBIOosR53D64ejNL//9myqL5nPdM1wscpFfCpKyXQ9I0FHUwfSiJELjD
	oKL3PqHNgD6WJKqtRqYpBhhA7Fbr+RsT22mwMq6lMy9DGHT72FHLbqGIhLBcWbWJeIXVlO77zpo
	q/T7Nl6KMt6qrmnxH7qZEcPjwmIS5tEpcZYzsrHVeKTYzNoqdV6YY7+s8Y6isut+Hu5ncKDiBqQ
	KfLm1wQQ==
X-Google-Smtp-Source: AGHT+IF4eH/unk1vgoVBN6X3ue+fuhzf0WaaTMslFL86MtHu8OVmK5qSN5+YJgEp6MXvduaOg4k8EQ==
X-Received: by 2002:a17:907:9713:b0:b40:cfe9:ed2c with SMTP id a640c23a62f3a-b40cfe9f8e1mr151533666b.64.1759154963281;
        Mon, 29 Sep 2025 07:09:23 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3d2801992csm309701166b.16.2025.09.29.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:08 +0200
Subject: [PATCH RFC bpf-next 3/9] vlan: Make vlan_remove_tag return nothing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-3-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

All callers ignore the return value.

Prepare to reorder memmove() after skb_pull() which is a common pattern.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 15e01935d3fa..afa5cc61a0fa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -731,10 +731,8 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
  *
  * Expects the skb to contain a VLAN tag in the payload, and to have skb->data
  * pointing at the MAC header.
- *
- * Returns: a new pointer to skb->data, or NULL on failure to pull.
  */
-static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
+static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 {
 	struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data + ETH_HLEN);
 
@@ -742,7 +740,7 @@ static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
-	return __skb_pull(skb, VLAN_HLEN);
+	__skb_pull(skb, VLAN_HLEN);
 }
 
 /**

-- 
2.43.0


