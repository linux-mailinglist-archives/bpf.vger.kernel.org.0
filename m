Return-Path: <bpf+bounces-59247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A7AC763D
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F0B501CE3
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586C25B1F7;
	Thu, 29 May 2025 03:11:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2271324EF6B;
	Thu, 29 May 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488273; cv=none; b=t0j19YbVMTobvzwXLxEOdTflAPGrPRrVcBlaPG4x66C18pZ5A5KY9/CW9yVwVP4nVfRdzqqLqJJwF33TJFFdGJVMI0ue8A+YMr1eAuQF8HRxQavi3JGQdm6z9QCnBcKYavE/VanNYFN/0W/pMQyNX5ZLKbNZA07FD6qOSkPbUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488273; c=relaxed/simple;
	bh=YzQxkzcO1JoGwIsmMYcm4/jqKG+DGfbOq6kIShlW2yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aHB9pGVdkZrtPpxkQkOLXCpIItPlhvbNDFeHbgrsG8KXHgPuphsGonZQf5SCsdFC4I6RGbCXuLj4FyRLe1fg/gWlChZF43WY5XM0mUGBGp7f8qTmneDuSZs4dog0YlgUiOhzXmi0ix3BjIxgOcrm4QFeQYpit6gU5HR3cB8s57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-3d-6837d0427df8
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
Subject: [RFC v3 12/18] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Thu, 29 May 2025 12:10:41 +0900
Message-Id: <20250529031047.7587-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRTH/e0+dh0uLkvqpuByIoKZU9M8ZJQEwi/CCISICvKWlzaaD+Yj
	DUIzH2TOQkPUFk1Em49cTFEXarmJGgaKoS3zhaZW+CBf+Mx85H8fvufD9xw4DCGzkS6MOiZB
	0MbwGgUtISWzTqUnL/QGq/ym631Ab6qhoXo1Gd6MNVGgr2pAsLT2XQyL7Z00lJWuEKDvySBh
	2bROwGTHuBhGK6ZIaM5uJGD8WRcNuowNAtKbjCLobcij4MV6OQGNaWNi+PJeT8NIzTYFU1Yd
	CZ9KKkkYzQuFDsMRWOmeQdBuahTBSu4rGgr6DDRMZIwi6LONk/DyUR4CU6udgo1VPR3qjusr
	v4mwpWRYjA3mRFxn9MY59j4Cm6ue0Ni8kC/GQwPNNO4q2iCxpWlRhHWP52j8Z3KQxPOt/TQ2
	1feT+LOhXYwXzW5X2OuSs1GCRp0kaJXnIiWqzuZlcVwtk2zT1VBpaJPOQY4MxwZy9m2j6IDL
	LPY9plkvzm5fI3bZmfXnFsc7yRwkYQh2juIm9Rs7EsMcZq9x/S3qXYdkPbnu/JE9X8oGcYNb
	Fmq/U85Vv/u4lzvu5IV1hXv9sp1dxTlt/29YFnMzw9w+H+PajHbyOZIakEMVkqljkqJ5tSbQ
	V5USo072vRMbbUY7r614uHmjCS30RlgRyyCFk7QLBatkFJ8UnxJtRRxDKJyl6edPq2TSKD7l
	gaCNvaVN1AjxVuTKkIqj0oCV+1Ey9i6fINwThDhBezAVMY4uaSj7g0eHzCVLm3hxOqza1faL
	Grn6Ixwd8iv3LJ4PCMlz3wzjHPobtnCtp5fh+DCXm0rK5b1Tt3//fN0SWnWzKD2yoPSS3ONM
	JiGvy1xQpES8nR3oUk6kx10ezAqPCDml1LWqffghxVPLVoBy/sTVnq9bicFGN36JCQkS/U21
	+inIeBXv701o4/l/ojAkXNYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF++0+djdaXKfVxUjhRkVilpT5jR6KRl5C0v8KKXLkpS3ntE3F
	B9VSo5SmZSFpEyYj37SYopuY+MJHWpqPWpaPlEngu6n4rKbRf4dzPpzzx6EwaQnuTilU8bxa
	JVOypBgXXz6TfjSo119+vK5kP+hNlSRUrCRByZiFAH15DYLF1W9CcLS2k2AsWsZA35OBw5Jp
	DQN727gQRosncah/VIvBeE4HCbqMdQzSLKUCaCnsJKC3JpuAF2uvMajVjgmhv05PwkjlHwIm
	m3U4dBaU4TCaHQhthj2w3DWNoNVUK4DlJ4UkPO8zkDCRMYqgr2Uch1cPshGYGmwErK/oyUCW
	qy77KuCsBcNCzmBO4KpKvbgsWx/GmcszSc78K1fIff9cT3IdL9dxzmpxCDhd+izJLdiHcG6u
	YZDkjD/nBZypehDnug2twnCXCPHZKF6pSOTVx85HiuXt9UvCuDdUUouuktCiDTILiSiGPskY
	rTbBlibpw4zNtoptaTfal3GMt+NZSExh9CzB2PXrToiiXOmrzOA7xRaD0weZrtyRbV5C+zFD
	m1biX6cnU/G2cdsXOf28qrztfqlzKz+riXyKxAa0oxy5KVSJMTKF0s9HEy1PVimSfG7GxpiR
	877iuxvPLGixP6QZ0RRid0o6kL9cSsgSNckxzYihMNZNkhZwSi6VRMmSU3h17A11gpLXNKN9
	FM7ulVy6wkdK6VuyeD6a5+N49f9UQInctUiXL529HUTlN/p3BzdFHNLNlxrPDVd/CVNKHDOW
	IwMHlEUOW6vrp6EwF+Hc4mnfDXOf1DN0+s4JD+/UiswNl3tVIbqB0vzduy7/8A6Yelw30Z9a
	mWnTXpz2frhgfx+cHc5GbrZlWsP87nv8TklLnbpwLXRmJuc6y66FiTp7Pn6YY3GNXObrhak1
	sr/C7lYzugIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The current page_to_netmem() doesn't cover const casting resulting in
trying to cast const struct page * to const netmem_ref fails.

To cover the case, change page_to_netmem() to use macro and _Generic.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index d52f86082271..74f269c6815d 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -200,10 +200,9 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(struct page *page)
-{
-	return (__force netmem_ref)page;
-}
+#define page_to_netmem(p)	(_Generic((p),			\
+	const struct page * :	(__force const netmem_ref)(p),	\
+	struct page * :		(__force netmem_ref)(p)))
 
 /**
  * virt_to_netmem - convert virtual memory pointer to a netmem reference
-- 
2.17.1


