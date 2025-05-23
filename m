Return-Path: <bpf+bounces-58814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215EAC1AAA
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757BE7BC4D1
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC952798E2;
	Fri, 23 May 2025 03:26:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1C22A4E0;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970791; cv=none; b=cmDrPnxM+QTDPKTzmUpofkVBQuglSdiLEtzDHu5bs/xkYH6z4vGlHtFl0jNkGkF02N/fuh1CqXdPt+vc8fzDMlgT/eDiGornYfhV9SIImcMmVxOi2LOHHsTscycnPsAlMUI8gCid39FudIzruIbOTlo2jh+gcDed5ox+ZNxSRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970791; c=relaxed/simple;
	bh=dJj0069KrtHblFH15XSGouMC22wVlSq9OpZxzt44gMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LqNHT1oazsIjpfNolH0QvhaqWZtL0W/W90qQs1gUYkByONDfyQuBUx2wlThqPv1xT/YvdEou72zq2/9JtpppAwXaV7RTxP14stNpUpzM3fhW66ei8IgJZUVu0RV4KP7fRDI1lVHGQgRbToP6zqtmAgrXiIJaRuEyyg98U4G1DrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-01-682feadc3ddf
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [PATCH 15/18] netmem: remove __netmem_get_pp()
Date: Fri, 23 May 2025 12:26:06 +0900
Message-Id: <20250523032609.16334-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe3fenXMcDg5L6miRtIoiSiu1HiLLL+UbRNiFogvUSQ9uOKdt
	ZRoFpoNInEpZlK2a2UVXsVqmm7dqal6SEi1Z5iUWrghr5FLUFeYsv/34/Z/n/+XPUoomHMaq
	tSdEnVbQKGkZln0Pvr2671ukas0t10YwWR/S8GA8E+5/skvBZKlC8GviIwO+phYaykrHKDC9
	NWAYtU5SMPTKzcDgPQ+GuvPVFLgLW2kwGvwU5NjLJdBZVSCF4sm7FFRnf2Kgu8ZEw8DDKSl4
	nEYMbSUVGAYL4uCVeR6MvR5G0GStlsBY/g0aLnWZafhsGETQ1ejGcP1cAQJrg0sK/nETHbeY
	VFZ8kBBHST9DzLaT5Gn5SpLn6qKIzXKBJraRiwzp66mjSetVPyYOu09CjLk/aPJzqBcTb8N7
	mlgr32PSYW5iiM+2KIE7KNuUJGrUGaIucvNRmarZ7cbpt2SZI0YvzkbNbB4KYnkumu92TlGz
	fKGxGAeY5pbzLtfEjA/h1vI+d8u0l7EU90PKD5n8kkAwl9vAD7R/RwHG3DJ+uK1m5kHOrefr
	r+Qy/0rD+QePX8z4oGlfNDBKB1jBxfC173r/30ww/B+H5h+H8i/LXbgIyc1ojgUp1NqMVEGt
	iY5QZWnVmRGJaak2NL3tvbO/D9nRSOceJ+JYpAyW22WRKoVUyNBnpToRz1LKEHmzJ0KlkCcJ
	WadFXdoR3UmNqHeiBSxWzpevGzuVpOCShRNiiiimi7rZVMIGhWWjqH1HX9Y350ZJdu1+1rBq
	m7BTXZrWwyVo6l/suFPI2EwrSsOEfon3S8qbRx2JJV7HImnL1mOXqww/o073jU61VKRv6Iu+
	s2R7cGzs7zP9ZTmKWr2BLEg4MN4+2Xl4P7vQErKXlWuexzyhPFvW518LiU8OvRn/FVXNWX48
	fGll/NxaJdarhLUrKZ1e+AtvG9rA1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG/e+cnXM2HJym5MnCaBGV5Q3UflmEBNWhG5ZlZqbOPLjl3GRT
	06C0NEJxZiUhNmklmTdYqHhLpeb9gpWmLvPWShHxfsNLVM7o28Pz8r5fXgoT5+P2lFwZzamV
	UoWEEOLC80eSnAYmXGSuaR+cQGcoJqBoJQ7ejFTyQVdYjmBx9RsJCw3NBOS+XMZA9zEZhyXD
	GgajTWYShvPGcKh5WIGB+VELAdrkdQzuV+bzoD6nlQ+fytP5kLn2GoOKxBESuqt1BAwV/+HD
	mFGLQ2t2AQ7D6d7QpN8Ky+2TCBoMFTxYTssh4GmXnoAfycMIuurNODy/l47AUGfiw/qKjvCW
	sGUFX3lsVfYgyepLYtjSfEc21dSFsSWFKQRbMv+EZAd6awi2JWsdZ6sqF3isNmmaYOdG+3F2
	pq6HYHPHZ3msoawHZzv0DaTPlgDh0TBOIY/l1C7HQoSyRrMZj3ohjJvXzuCJqJFKRQKKod2Z
	lPpM3MIEvZcxmVYxC9vSbsyCuXnDCymMnuYzo7p1niWwoQ8xQ21TyMI4vYeZbK3eLIhoT6b2
	WRL5b3QnU/T2/aYXbPiMoSXCwmLag3n3pZ/MQEI9sipEtnJlbKRUrvBw1kTI4pXyOOcbqsgS
	tPFf3p1fjyvRYvcpI6IpJLEW7Yt0kYn50lhNfKQRMRQmsRU1jjnLxKIwafxtTq0KVscoOI0R
	badwiZ3o9BUuREyHS6O5CI6L4tT/Ux4lsE9EpWkHbQKvTSVMBc62hejtfq4Me82duNCrCEoY
	9O1z/G28bkrwUykVpRpt2ESxT36VYNvq4ZGObrm/qpA8MN1X7q90v3g5K7zab/elWw67sJOe
	V42hx0duegocHrxadKzVnB0PDXBpF3cqzyW6Wmd3Bqm9fMemrb6b9p8JntzB3f0swTUyqZsj
	ptZI/wJ9qe0wuwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

There are no users of __netmem_get_pp().  Remove it.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c2eb121181c2..c63a7e20f5f3 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -224,22 +224,6 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
-/**
- * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
- * @netmem: netmem reference to get the pointer from
- *
- * Unsafe version of netmem_get_pp(). When @netmem is always page-backed,
- * e.g. when it's a header buffer, performs faster and generates smaller
- * object code (avoids clearing the LSB). When @netmem points to IOV,
- * provokes invalid memory access.
- *
- * Return: pointer to the &page_pool (garbage if @netmem is not page-backed).
- */
-static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
-{
-	return __netmem_to_page(netmem)->pp;
-}
-
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 {
 	return __netmem_clear_lsb(netmem)->pp;
-- 
2.17.1


