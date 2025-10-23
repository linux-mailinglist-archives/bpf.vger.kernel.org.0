Return-Path: <bpf+bounces-71869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627BBFFADA
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 09:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC3719C6408
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6202D0298;
	Thu, 23 Oct 2025 07:44:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DFA2BF011;
	Thu, 23 Oct 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205474; cv=none; b=qbFJJz/wBxlWt1lUAcwq/e+hNUSrUdDFK59PIo8G+E7cuYeCnHScfz7Ffr6sT0Ko/GoFhsvHT3YMr3xL18DS38ty/xIv3xLV0nr5lvGHg5o/anPtkaRHqWlASc9YJdqgK6F02n3zJ7rkiy64vpqd8JB3QY2phoZhxLJpSwpsNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205474; c=relaxed/simple;
	bh=/ievbL36Rs5ZFE2K+CltxLGakEwUPtbnWP2MFWEQ/Vs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=e1IW17TDnjS/cc6NONcmYpU9UDQa9bY9dq3YWHkcnsOc4QO6gMLHy8P2KpE5cxUxrU+nhA5Vq/6QGnJbckcUKfBbnUPUNpYExS58TrQVqrMW4PJehsNH3DMsMcsaRkofTAexruo9ezihsdc7iBFitgL1CdKt3GT3VmFVA2oRF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-4f-68f9dcd425f0
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ilias.apalodimas@linaro.org,
	willy@infradead.org,
	brauner@kernel.org,
	kas@kernel.org,
	yuzhao@google.com,
	usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com,
	almasrymina@google.com,
	toke@redhat.com,
	asml.silence@gmail.com,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au,
	dw@davidwei.uk,
	ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: [RFC mm v4 0/2] mm, page_pool: introduce a new page type for page pool in page type
Date: Thu, 23 Oct 2025 16:44:08 +0900
Message-Id: <20251023074410.78650-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe885e8/ZanBYVif7kAy6UGkXujxdKIM+vB8qivxgJdTIkxs5
	J9NsBoKWoGmuq2S6aBXqdAtz5mXizLybUGoZJzI1IwVvxTJzTlzT6NuP/4/n9+nhaNUEE8zp
	4hJFY5wmVo0VjGJi2ZPQD31e7TbXdQBLmQODfcYExYM1MvA6RiiwlFYhmPJ+ZsHvbkXwq7kN
	w1iTB8GzJ9M0WN6lM/C7bJYGV+0IgtG85xi+tw6xYHceg4GiYQbqMqppGLrVjiEn3UeD2zvJ
	wrUaWyBckcpCV5VZBvdnC2moTh1k4X2tBUO/wy+D4cYcBjrySxj4mdtMw4A5HFqtK2G6cxxB
	c1k1BdM3H2HofVhLQaW7l4V7PVYM39IHEPQ0DTGQO5eJoSDNjMA3E0hO3p6SQUFLPxseRtIk
	CZOm8R80eVnyiSIf8+4wRKp/QxFX/heWWJ2XSYVtE8mSemjiLL2BidNzlyV9H+swac/zMcT1
	dS9x1fyiSM71SXxixRnFgWgxVpckGrcePK/QTtzz4/hRpSnb0cmmIq88C8k5gd8pvPK/o/9z
	RuY4XmDMbxAkybu4B/HbBFvuVIAVHM1nc8Ln+vJFsZyPEp6P/EELzPDrhOwO8yIr+V1CZamP
	/RddK9hfNCweC3whJ3zrzqL+idXCa5vE3EZLrWhJKVLp4pL0Gl3szjBtcpzOFHbBoHeiwBMU
	pcydrUGerlONiOeQepkyvG1Gq5JpkhKS9Y1I4Gh1kDLpdGBSRmuSr4pGwznj5VgxoRGt4Rj1
	KuWO6SvRKj5GkyheEsV40fjfUpw8OBWtnj2kuhgif7vbt8Xa4G9Wt+Nr3ZMW3fyVkBNRVP5M
	yRgf+iDNVGHpUllM68tP1od0S4Z0d4N/4tlTdcz8Rv3NKb9hT1b1fsNhm+3H41tHT0YeOx62
	r7cvYly/OeJTYjn9eLjAnFHVmniJjKXUP/IeaYnMkRe7rSbPnxFPvD1YzSRoNds30cYEzV9l
	YPpMAAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTcRjH8f47Z/9zHC0OKnXoQjCLyEi7CY8V4RvpX1FEEFFpNurUhjpl
	s6FJZbrQNNfFFt5ZROY1a6Vuplabl2lBNbUWVtqiJFtWauacYtPo3YfnB983D0v5v6AXs0pV
	kqBWyeNkWEJL9mzJWNvzzqNYV9a3AoprqzFUTSTDnQGzGDzVgyIorqxHMObpY2CmuR3BaGsH
	hm+2EQS3bo5TUPxCR8Pv2kkKLI2DCIbyazB8bncxUGXaDf1lX2hoymygwHXZjiFX56Wg2TPM
	QLq53Bd+kMaAraRTDC/r9WK4Pnmbgoa0AQa6G4sxfKieEcMXay4NnYUVNPw0tFLQr4+AduNC
	GH/mRtBa2yCC8UslGHoLGkVQ19zLQJ7DiOGTrh+Bw+aiwTCVhaHovB6Bd8KXHL4yJoaitg9M
	RCg573RiYnP/oMjDirci8jr/Kk2cLV0iYil8zxCj6RR5UB5Msp0OipgqL2JiGrnGkHevmzCx
	53tpYvkYTizmURHJzRjGexcekmw9LsQptYI6dNtRieJ73gxOHJIm51Q/Y9KQxy8b+bE8t4nP
	zHLjWWNuFe90eqhZB3Lr+HLDmM8SluJyWL6v5f7cEMBF8TWDf9CsaW4ln9Opn7OUC+PrKr3M
	v+hyvureE+oKYo1oXiUKVKq08XJlXFiIJlaRolImhxxLiDch35vLzkxdNaOx7u1WxLFINl8a
	0TGh8BfLtZqUeCviWUoWKNUe9J2kx+UppwV1Qoz6VJygsaIlLC1bJN15QDjqz52UJwmxgpAo
	qP+vItZvcRqy17xafTc8svSRMSy6p+rIhjXTwdFB94beT5fq9925kHQ4ypso/bq5pzldPRCC
	cd2njarURetR0cdf7mVdAU+GYu93fF4w89Qy2huWYGhIfBuZai+tP3fAaD/rutVN+FXcROqu
	tsmH5oSCG4+fh+7YH6QrP/gm/NzSmJwTngDiyGRltEYhXx9MqTXyv50GY8HiAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This patch is supposed to go via the mm tree, but it currently also
depends on patches in the net-next tree.  For now, this patch is based
on linux-next, but will apply cleanly (or get rebased) after mm tree was
rebased.

Changes from v3:
	1. Rebase on next-20251023 of linux-next.
	2. Split into two, mm changes and network changes.
	3. Improve the comments (feedbacked by Jakub)

Changes from v2:
	1. Rebase on linux-next as of Jul 29.
	2. Skip 'niov->pp = NULL' when it's allocated using __GFP_ZERO.
	3. Change trivial coding style. (feedbacked by Mina)
	4. Add Co-developed-by, Acked-by, and Reviewed-by properly.
	   Thanks to all.

Changes from v1:
	1. Rebase on linux-next.
	2. Initialize net_iov->pp = NULL when allocating net_iov in
	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
	3. Use ->pp for net_iov to identify if it's pp rather than
	   always consider net_iov as pp.
	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.

Byungchul Park (2):
  page_pool: check if nmdesc->pp is !NULL to confirm its usage as pp for
    net_iov
  mm: introduce a new page type for page pool in page type

 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 27 +++----------------
 include/linux/page-flags.h                    |  6 +++++
 include/net/netmem.h                          |  2 +-
 mm/page_alloc.c                               |  8 +++---
 net/core/devmem.c                             |  1 +
 net/core/netmem_priv.h                        | 25 +++++++++--------
 net/core/page_pool.c                          | 14 ++++++++--
 8 files changed, 40 insertions(+), 45 deletions(-)


base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
-- 
2.17.1


