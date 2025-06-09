Return-Path: <bpf+bounces-60033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A0AD17F1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1922188AD5C
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93691283153;
	Mon,  9 Jun 2025 04:32:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FD027FD7E;
	Mon,  9 Jun 2025 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443564; cv=none; b=SpPfYy7nWl3u49R8Le+D5gbTjTG7O0D2nCtKUgmRNJ4sOkOjVjSm/HYr4FOSwy96gjFY7FDKlAuqND4TcPvZlOcm6kKUo/s8wR+6HD+0RwTu9RLSOR2MW538UQGV5yXiI5FJHhkGlTwP9RLwBFTxTf3LOhVq0Txpdu89YCc1Dtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443564; c=relaxed/simple;
	bh=4AV87ofT5Hw7IqKXWxanmT788lEeG1glCo5BFNGM1hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzx3LrUMCoxAkkDYLZSWl4V9fLxcgDfvHRt08JhVTanXvKaQLoIul0ctNAoc7yeLRgHfP8q1nVLlOec2fGiaBEJI6mFpx0eJRA972HttIXtBHo9H3Y9/VOzWk+9/RGL6+B2vWSXyQybemosSWvzWUcpWauAbWMagPge0WmM+d7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-84-684663e3335c
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
Subject: [PATCH net-next 6/9] netmem: remove __netmem_get_pp()
Date: Mon,  9 Jun 2025 13:32:22 +0900
Message-Id: <20250609043225.77229-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
References: <20250609043225.77229-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa2xLYRzGvX3fnp7WGmedcBgWTURCsMnI/4MsLiHvF2KIuCSsWY+10W10
	tQsRY4tLoyNuozvoIpuqSSm2blmGqrkmll2o2bTGRmS60KlNJbUa4duT5/97nufLn8Wqw9LJ
	rD7HJBhzNAY1oyCKz3GVc95nrtAlvzsnB9FZw8DVoUK4HHBLQXTUIhgcfi2DkPchA5cqwxjE
	56UEvjl/YOht7pGBv7qPQOOhOgw9xx4xYCmNYDjgtkugpbZMCqd+VGGoKw7IoK1BZOBNTVQK
	fR4LgcfWKwT8ZYuh2TYBwk/7EXiddRIIHz3PwMlWGwPvSv0IWu/3EKjYX4bA2eSTQmRIZBZP
	p7euvJLQemu3jNpcu+hN+yxq9rVi6nIcYajr6wkZ7XrRyNBHZyOE1rtDEmopCTL0S28noQNN
	HQx13uog9JnNK6Mh17TV3CbFIq1g0OcLxnlpGQrdk6BZsqNsbOFgeW4xcsjNSM7yXCr/5flb
	/Fd3D1TJYprhZvI+3/BvfzyXwod6HhIzUrCYC0r5XjEiMSOWTeDS+EBrcowh3Ax+f3uQxLSS
	W8B3DtRKRjuT+KvX7+IYLucW8gGfKWarRhBPux2P4vH843PvSQzBI7POC6qYjUeSJbcrcGyV
	56pYfqDB8adyEn/P7iPHEWf9L279F7f+F7ch7EAqfU5+tkZvSJ2rK8rRF87NzM12oZH/qN77
	c7MbfW1Z60Eci9Rxyozy5TqVVJOfV5TtQTyL1eOVnH+ZTqXUaop2C8bcrcZdBiHPgxJZop6o
	nB8u0Kq4LI1J2C4IOwTj36uElU8uRmui0YKXdZe3ELjxwUI3tF8Db7zC405eHwpptS1Ls0zL
	Z8ePDYS9loitOuMgiX5s6/qkawMxItbfnrqz80x2wYYGZLG3GcZdFLud6Q+SDu/pTk2fQk7v
	W1nzejBxXX/QNLwt7cn3JRv9a7tMd1OiiR3L6LSdq26exwl3XoyZoCZ5Ok3KLGzM0/wC6MpF
	ZxsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03SbUhTYRQH8J773N1dl4PbtLqYFAx6QdA0Mg4UIZZ1sZCwQCkzR97a8JVN
	xUWSpiQuNUvTmjMWoq4prabpKnth2tSKiqmxtFIspcympZm53jYk8tufc37nnC+HxpJPpB+t
	SM3glamyZCklIkVRW/MD3x3dJQ8eywfQmZooaJzLhoZhiwB0xlYEMz8GhTDd2UVB7dVZDLrn
	BSR8M81jGLWNCGGofoyE9sI2DCPnuikoKXBhOG0xENBR0yOAF62lAqiYr8PQljsshN47Ogre
	Nv0RwJi1hIQe7TUShkrDwKZfAbNPJhB0mtoImC2uoaDcrqfgXcEQAnvHCAnVeaUITPcdAnDN
	6agwKddy7RXB3da+EXJ6cybXbAjgNA475szGIoozf70g5F6/bKe47ksukrttmSa4knwnxX0Z
	HSC5yfv9FFf7YYrgTC39JPdU3ynct+ygaFsin6zI4pUbtyeI5I+dGiK9dGn2TFVaLjJ6aZAX
	zTKb2TeTdUJPppj1rMPxA3uyLxPCTo90kRokojHjFLCjOhehQTTtw2xnh+3BHkMya9m8Pifp
	yWImlB2YbCUWdq5hG288xB7uxWxhhx0ZnrLETax9BrzAl7E9l9+THoLdZ01XJJ4ydk/m36rG
	ZUisXaS0/5V2kdIjbES+itSsFJkiOTRIlSRXpyqyg46mpZiR+wXqc36et6CZ3t1WxNBI6i1O
	qIqQSwSyLJU6xYpYGkt9xczQDrlEnChTn+CVaUeUmcm8yopW0aR0pTgyhk+QMMdlGXwSz6fz
	yn9dgvbyy0XHfu2VWhQ35b577q2bOHB35/76TVNTark2Y1dlQmBZ1KPnzo4HPuVxJwt7zoau
	NhZVxpw6FkeciI4+3Gcj0v0DI6S2wb7fON7g//HzclVOrCAlsdiCnxWHhrOZqiVzDWckDc3X
	6ZMoPjYyYjklsV00V3yPTju0YdXr8LJx7/HYKCmpkstCArBSJfsLhimAuv4CAAA=
X-CFilter-Loop: Reflected

There are no users of __netmem_get_pp().  Remove it.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 65bb87835664..d4066fcb1fee 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -234,22 +234,6 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
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


