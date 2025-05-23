Return-Path: <bpf+bounces-58809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB462AC1A8E
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F9A1C04D8C
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861C274659;
	Fri, 23 May 2025 03:26:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40E222618F;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970790; cv=none; b=ufk3oiqxG5Kds9CKCi41senPdm2tJv2B6f56GQGmAzMAMr9qAY10bgQP3gNerl+u63THNaXhxMJOTRNyUl6+WcLCawNyyVJaCfTw5TMnrQnkIh2dClW2J8naDhmgeBP+zjr9M6jGXyZHL0MterS0s9HAN0WBnSOeVYT0bMvpuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970790; c=relaxed/simple;
	bh=YONehhNSiKIx13tSF9qEqbSwL9lbM3m3QVv1jPV5eXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t6wNWW6GhK5Lm5k0vMBJ2Zl8PiRgL5YCMrytLrzZsS8bIQNzy3GY98baY5F8yiNNXDBwNcQTJG5fSygopqri+YE2nnBI2lBj2NiO2nRg0RUPqZVWUeYJxKGLOvaxnO9XkbLd/efdIvMR+z1Wt6pyAM99kOpRM1n/fhkLLTcGo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f7-682feadc7e0f
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
Subject: [PATCH 14/18] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Fri, 23 May 2025 12:26:05 +0900
Message-Id: <20250523032609.16334-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfUhTYRyFe3ff3Xs3Wt2W1K2gaPRBkppl9iMioojeosAwCQq0kZe2mlNm
	2gwqm1a41MSEYq6YSOZHNFvmZom4tdSoSCxrfqRibZKaUmuzXFHO6L+HczjPP4el5G68lFVr
	Tws6rVKjoKVY+mVuRVT/aIxqQ+h+HJit92io+6GHu0MOMZhrGxF8/9nHgN/dTkNlRZAC8+t8
	DAHrNAXetmEGBqt8GJqv2CkYvtZBQ1F+iAKDo1oEnY3FYiibvkOBPXeIgTePzTQM3PsjBp+r
	CMNzUw2GweId0GZZBMEX4wjcVrsIgoW3aLjeZaHhY/4ggq6nwxjKLxYjsLZ4xBD6YaZ3rCQN
	NT0i0mT6wBCLLYs8rI4kRk8XRWy1BTSxfStlSP+7Zpp03Axh0uTwi0hR3gRNvnp7MZls6aaJ
	taEbk5cWN0P8tuUJ3BHptlRBo84WdDHbj0lV76sLRBmXWX3hlAnnon7aiFiW5+L4sd5dRiSZ
	xcoXhUyYaW4t7/H8pMIcwcXy/uF2bERSluImxLzXHBKFi4XcYd4/+RuHGXOredO0YXYs4+L5
	kZcB8T/pCr6uvnVWJJnJSwYCdJjl3Gb+ydteJizluQDDT437qH+DJbyz2oNLkMyC5tQiuVqb
	naZUa+KiVTlatT76eHqaDc18W3Xu11EH+taZ6EIcixRzZQ5pjEouVmZn5qS5EM9SigjZM1+0
	Si5LVeacFXTpKbosjZDpQstYrFgs2xg8kyrnTihPC6cEIUPQ/W9FrGRpLopK+p2U3JK3+/yN
	Iwn1Q2tuj/a1enpu2vdYtyqUCTtvrKt0fv7+YOrilgv7bJL43RWrYg376xvPtw50lNtI3kTb
	gjNZKdtH9poll8om/+hVV7SPgmM1zrryTa+8EQcux0+vKqzikuc4C1Lvaq4eOrX160HT/GWG
	9SdrhU93pIml84q3KXCmShkbSekylX8BA3JZktcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF/e3e3d2tltcpdbE/goFpgi4h61uKCVHenvhHIPhHOfLmhvPR
	pqaiZE40l5pmZKwpE8nmA1ZLfGMx3yiVM8u3sjUTKTXnW8PU6L8P53DO+eOQmMiAu5Py2ARW
	GStViAkBLrgRoPYZn5PIThZPeILOWEtAzXoyvJ5u5IKuuh7B8sYYDxwd3QRUlK9ioPuUhcOK
	cRMDe5eVB1OVMzi05jRgYH3SQ0B+1hYGmY0GDrSX9nLhc30BF55tvsKgIWOaB4PNOgIma3e4
	MGPOx6FXW4XDVEEwdOkPw2rfTwQdxgYOrOaVElBs0RNgy5pCYGm34vDyYQECY9swF7bWdUSw
	mKmrGuEwTdoJHqM3JTLvDN6MZtiCMabqXIIxLT3lMeNfWwmm58UWzjQ1OjhMvnqeYH7bR3Fm
	oW2IYCpmFzmMsW4IZ/r1HbxQl3BBYCSrkCexSklQhED2zZDLic8mk/PWtHgGGic0iE/S1Cm6
	oi+Pt8cE5UkPD29ge+xG+dEOazeuQQISo+a5tF23xdkzXKkw2rHwB99jnPKgtZuZ+2EhdZr+
	0b/C/Vd6jK5582G/iL+rF06u7I+JKH+65csorxAJ9MipGrnJY5NipHKFv68qWpYSK0/2vRMX
	Y0K7/1Wmbxc1ouXBEDOiSCQ+KPSKkchEXGmSKiXGjGgSE7sJO2d8ZSJhpDQllVXG3VYmKliV
	GR0lcfER4ZUwNkJERUkT2GiWjWeV/10OyXfPQOqzHx9t3tN4tDizbY8Dl0It5276PJjLze55
	O7JIDmlcLeeLJMh8/Pn69w0fr0sDLjM5A5HNtu2yE+VrIRfAhhz2tFs7rZXk/TH32qC44i6+
	zZpa5HSgpP/qZXG+4/oZx/b79M4yuEashRa7LEUdUs+Gh5U4p110KLS/pHe3A8S4Sib188aU
	KulfqfQKkLsCAAA=
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
---
 include/net/netmem.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 29c005d70c4f..c2eb121181c2 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -172,10 +172,9 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(struct page *page)
-{
-	return (__force netmem_ref)page;
-}
+#define page_to_netmem(p)	(_Generic((p),			\
+	const struct page *:	(__force const netmem_ref)(p),	\
+	struct page *:		(__force netmem_ref)(p)))
 
 static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
 		unsigned int order)
-- 
2.17.1


