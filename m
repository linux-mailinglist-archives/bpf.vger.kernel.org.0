Return-Path: <bpf+bounces-73322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E9DC2A680
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106264EDCD9
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B215A2C11DA;
	Mon,  3 Nov 2025 07:51:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31C1E834E;
	Mon,  3 Nov 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156291; cv=none; b=u8y/I4/ZPd7aZvkm5qrsjt3fjWGG2NR5No2/xpWNI5k8vA8jKM56ya6f1VoMiVDUnLlFr7Y/MZ0kI02kJzGbZzmIkltc0IaYmsgxGHw2MUg5dY0WaVKsUV/+QlS8WyjsAPIC8TTDy6+k0+PRTtbiugcBdMje+QxjO/9ypZZq4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156291; c=relaxed/simple;
	bh=lmbHi80nnh19DiCFLWcj7De/Bp/yXnNt4u3xlxG2LGs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=L3kcbByk0kkcylLZD1WMmFeS1dLyC0X+9SWCQNUM36z/YAAZTqC9Kr+VWI99d7Ns3sQf3i1dSlSDrCkQv0d/7vomHInvpGcJRmErAZpf4Adjc7YKP6GTD54Xipt2YWl5I72XbTxv/AoZVlESRLBBLJSkktgOAy5QBF5oYQp3QyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-f0-69085ef71258
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
Subject: [RFC mm v5 0/2] mm, page_pool: introduce a new page type for page pool in page type
Date: Mon,  3 Nov 2025 16:51:06 +0900
Message-Id: <20251103075108.26437-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRiH/Z9zds5xtjrNLsf6YAxEsbQLSm8Q4ZfgFEhK3yqqoQcdOS+b
	2RQCTcm01GVbeVm5CqduxmxetplazaWmXcwuTExnVgppFtNmXsC80LeH9+H3fHppXDxF7KBl
	yem8IlmaJCGFhPDnhgdhc2dp2b6qUgZ05noSTH9VUDNqE8B8/QQGOmMLgtn5IQqW27sQzDi7
	SZjs9CB4eN+Lg+5tHgF/zAs42FsnEPwoe0TC964xCkyWaHAbxgloy7fiMFbSQ0JR3iIO7fPT
	FFyx1a6EG7Mp6G8pFoBmoRoHa/YoBe9bdSSM1C8LYNxRRMDLijoCfmudOLiLo6BLvw28fVMI
	nGYrBt4bd0n4WN6KQXP7RwpuDehJ+JrnRjDQOUaAdukaCZU5xQgW/64kp9WzAqh8MUJFhXM5
	LhfJdU79wrmmukGM+1R2k+BcHb0YZ68Ypji95SLXWBvKFboGcM5iLCA5i6eU4j5/aiO5nrJF
	grN/OcTZbTMYV5Q7TcZsPSU8HM8nyTJ4xd4j54WJda9dWKp5k+qboQfPRhq/QuRLs0wEayyY
	xAoRvcZN6rTVM8kEsy7XPL7KW5h9bK12doWFNM5cp9mhjsdrwp85w1YZNGtMMEGsoztXsMoi
	JpI11T9F6/1A1tTwbG3MMtU0+91gJNZFAPu81kWokZ8e+RiRWJacIZfKkiLCEzOTZarwuBS5
	Ba38gOHy0mkb8vSfdCCGRpINotE4SiYWSDOUmXIHYmlcskU0mEfIxKJ4aWYWr0g5p7iYxCsd
	aCdNSLaLDngvxYuZBGk6f4HnU3nFf4vRvjuyUblTbuoLCAtpzmqcTjsarA3xOD3pEuvtg1eL
	++OVpgVqkyRomHLb/WKcd1KPaSLngj4s9dA1o6ELu+65N1teBWrfRYdhxze+sX07dVat31jo
	W+Lf6lO1JzZd94T1eo70evWDjWadqoD3qS6LtXakNtS8nWtS2dUJ3WljJ/J3SwhlonR/KK5Q
	Sv8B0EkNPv8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRfUgTcRzH8X53t7tzuTrM9DAqWEgk2QNofM2K/ol+BEUEFVSoQw8d6szN
	xEWJNunBdM3awtJoEdl0q+V82CY6YzNdWSaaNTHTrAxSLHSNdMLSoP9e8IbPPx+WjOijYli5
	okBQKmQ5UlpMiY8ka+IDKax8xwN7EtRaLTSY/xTB43GHCOYt3wmobWhF4J8fYSDU0Y1grquH
	hinPLIKHDwIk1L4to+C3dYEEZ9t3BD+qn9DwrXuCAbPtMIzVTVLQfsVOwsQNLw2VZUESOuZn
	GLjkMC0NN5Uw4Ln3UgT9rVoR6BcekWAvGWdgsK2Whk+WkAgm3ZUUvLxbT8EvQxcJY9r90G2M
	gkDvNIIuq52AQMU9GobutBHQ0jHEwK0BIw1fysYQDHgmKDAsXqWhplSLIPhnaXJG5xdBzYtP
	zP7tuNTno7Fn+ieJm+uHCfy+uorCPtcrAjvvjjLYaDuHm0xxuNw3QGJbwzUa22ZvMvjj+3Ya
	e6uDFHZ+TsJOxxyBKzUz9NGoU+I9GUKOvFBQbt+XJs6qf+MjzlpXF32t85IlSL+yHLEszyXw
	zbr8chTG0txm3uebJ5cdye3gTQb/ksUsyV1n+RFX47+whjvD36/T/zPFxfLuHo1o2RIukTdb
	OtGyeW4jb372nNQh1ohWNKBIuaIwVybPSdymys5SK+RF29Lzcm1o6eW6i4tVDuQfPOhGHIuk
	4ZLxdEYeIZIVqtS5bsSzpDRSMlxGySMkGTL1eUGZl6o8lyOo3GgdS0mjJYdOCmkRXKasQMgW
	hLOC8n8l2LCYEpQQdq1nyts3pQtGXTSd0fQde/5w91p15miKK6g9YPxgcr3ee9vjDdcq1oQ0
	MdmE/+SisCFVV9mfcV8RirdYoPeFP3c2Vd2i7wydLjYNRD/a228uwsp3NRWuq0+Pn2DWX94q
	NBZvsQ0ubCos+BbYnXj8wgomOX/VhuJ2h2GXNVZKqbJkO+NIpUr2F4rnsTHhAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This set is supposed to go via the mm tree, but it currently also
depends on patches in the net-next tree.  For now, this set is based
on linux-next, but will apply cleanly (or get rebased) after mm tree was
rebased.

Changes from v4:
	1. Rebase on the latest version of linux-next as of Nov 3.
	2. Improve commit messages. (feedbacked by Jakub and Mina)
	3. Add Acked-by and Reviewed-by.  Thanks to Mina.

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
  page_pool: check nmdesc->pp to see its usage as page pool for net_iov
    not page-backed
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


base-commit: e1f5bb196f0b0eee197e06d361f8ac5f091c2963
-- 
2.17.1


