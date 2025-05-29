Return-Path: <bpf+bounces-59253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C889AC764E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A7502F1A
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7395D25DAEA;
	Thu, 29 May 2025 03:11:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ADA2505AA;
	Thu, 29 May 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488274; cv=none; b=tZC1OxvIWuZIW4xd7ylQenU58bTQx2jL0JLRahebqiv9QP1XWUdcW7SaGqYd8Nq4y1MjnWYWSq2B9rZAleBZ3y0C8jXAftJw4fXmiKTlBtdhdUHThXgfqWs333xwrpogD3ZLaEbMcFtdKs8Jslk3ckxyqK8GVyiRgmVFzGGT7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488274; c=relaxed/simple;
	bh=uIwR7axH9Equs+S/iZzeG25sMPe0xPv7iodn8Q2LgeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XM3oOfF0L/PnT22C/Rl5Ksbs6pF8gpbCB/GHmN8KhSfcCjOzeVg8AZdYo3rGDU4DxmKitk9cRO6u2zn1T43fFeKH8q1PWCUwiaKgTe/AbTMz1HV2EDHaIczSOBtV0ZoqyaUwVL27D0OB517f5PQmd8jFuC8ht2rHclMPEJuEQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-47-6837d042ae70
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
Subject: [RFC v3 13/18] netmem: remove __netmem_get_pp()
Date: Thu, 29 May 2025 12:10:42 +0900
Message-Id: <20250529031047.7587-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHfXfec3Zcrk7T8lhQNoxIULOsng9dzEhePxRR2IdEbOTRjeaF
	rZZGmdWiGrrCRXQ50UzMeWsxbc5QSzM1ijQrm92shVFQWq3sMrvMid9+PM//938+PCyl6MRz
	WE3ubkGXq9IqGRmWfQopj0nqW6leIopxINrrGKj9WQBVr100iDVOBN9+PZeCt7ObgYryMQrE
	XiOG7/bfFAx3eaQwdOUdhpZjTRR4TvYwUGr0UXDYZZNAn9NMw+nflRQ0Fb+WwqMbIgOv6v7R
	8K6jFMPd89UYhsyJ0GWdDWP3PiLotDdJYKzkIgOWfisDb41DCPpvezBcOGRGYG9z0+D7KTKJ
	C0hj9aCENJ9/KSVWxx7SYIsmJnc/RRw1Jxji+FomJS8GWhjSc9aHSbPLKyGlR0YY8mX4GSaj
	bU8YYm98gsl9a6eUeB3zNnPbZasyBa3GIOji1uyQqW13x3H+JVmB6DmOi9Ed1oSCWZ5L4Ed9
	9ZIp/lDmoieY4RbxbvcvaoLDuHje6+nGJiRjKW6E5odFX0AI5YD/0WwJMOYW8p/7Wv0yy8q5
	5fyDsozJzvl87bVbgZ5g//hMw5lAXOG/dc7Uzkx08tx3KX/5qYgmhQi+3ebGp5DcioJqkEKT
	a8hRabQJserCXE1B7M68HAfy//bKgfE0F/rat7UDcSxShsh70Eq1glYZ9IU5HYhnKWWY/PDa
	FWqFPFNVuE/Q5WXo9mgFfQeay2JluHzp2N5MBZet2i3sEoR8QTe1lbDBc4pRUYphgElPv7dh
	ZoLlWUJKqvbyttZlM2ZFBhmLFp/OcqxPTw7rNU//kx1zYnZ9UNX765eSV0co9nqc8LRHLFrm
	Pho+XvTQGRXpvLmUJL39q31Mb0qprMi6Gv+nWROV0+2q5NMGIzdqSiwH41IH1rH6N6F0RMVI
	9/T9Hw9sgaZpXJ0S69Wq+GhKp1f9B7yxTVrXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe3fOzs5Gg9MUO2mRLCKQWgpeHqhMCuokkZZdyC868+CGOmVT
	0UIyJ2RDrTSsbNJK03mBibdNMavNK0qaZmpWk8msvJfmbaKp0bcf/9vz4SExUSnuSsoVCaxS
	IY0REwJccOGY+sipXj+ZZ9aIGLSGSgIqlpOhdNTEBW15PYKFlREezLe0E1D0YhEDbU8GDn8M
	qxjY22w8sJaM49B014iB7X4HAdkZDgzSTXoOWAo7udBbn8OFR6uvMDCmjfKgv1FLwLfKDS6M
	m7Nx6Cwow8GaEwBtOhdY7JpC0GIwcmAxq5CAvD4dAWMZVgR9FhsOz+7kIDA0D3HBsawlAsRM
	bdkwh2ko+MpjdNWJTI3eg9EM9WFMdfk9gqn+nctjvnxqIpiOJw6caTDNc5hs9QzB/LJ/xpnZ
	5gGCKfoxx2EMtQM4061r4QXvChUcj2Rj5Ems8qh/uECm71zD458LkrW2TDwNtZIaxCdpypv+
	mWvibjFBHaKHhlawLXamvOh5WzuuQQISo2a4tF3r4GwZThTQSw1524xTB+m53tebZZIUUj70
	+9ywf5v76Yqqt9s7/E05vyZ/Oy7avPVU8454gAQ6tKMcOcsVSbFSeYyPRBUtS1HIkyU34mKr
	0eb7SlLXHprQQv9ZM6JIJN4p7EB+MhFXmqRKiTUjmsTEzsL0k74ykTBSmnKTVcaFKRNjWJUZ
	uZG4eLcw8BobLqKipAlsNMvGs8r/Lofku6YhPio2u3RNhdga0rIz486Ig89Zdl3kH9Acdory
	SV28Pp3ysTjH3fuNS3Re6HJQq2RwMtVd7e55OzDCaJ+uX3C83LDqu/ehgtn09cq6Jd+Ax+uR
	34P8J6suX5JGRfA+9NSFnB70dTtRar9qG9jTe4uvHrwyIRmb2DvcmFksMbadt4hxlUzq5YEp
	VdK/0he7z7oCAAA=
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
index 74f269c6815d..ef639b5c70ec 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -239,22 +239,6 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
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


