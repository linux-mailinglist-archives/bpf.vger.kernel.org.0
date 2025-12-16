Return-Path: <bpf+bounces-76674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65832CC0AD0
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 04:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1B5D30413F6
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FED2F6590;
	Tue, 16 Dec 2025 03:03:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA95259C84;
	Tue, 16 Dec 2025 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854215; cv=none; b=QuOP1qzuenURu2ZpLSotIcZQWWqBW3TSvgon9hhqjd2aFWq/sfM/6/uEfDBD9mAEWB/pkM5f31OGBbZS6+/vgUIw0QAnK/Kqwvwi25eurSi2UUCSK/PMh44kwX6h7LTSoHIOUoEA8lknF+gEq/w1Eu0sA6hRydrL3j6vby2P7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854215; c=relaxed/simple;
	bh=ErpQkvysehdoKvtB95pcMs7X1/KMSCP1USDNrJsYuWs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fTZCjjxvs/AlX1qii5hVX78YQUdd/eCCu8HFHTLDT8vKAQh6/v41v2A0Jimf9PYGthdcv7dH80udei+A4gFRkN3MkVq9Od7Gp2l0dlyb5Z2EdyvVH5JesYPvLxiMhEfCVSrp71Mum3Q0aCdnVyt09cmByOKcSYeKD2HvrxdoTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-3d-6940cbfe996a
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
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
Subject: [PATCH v2 0/1] finalize removing the page pool members in struct page
Date: Tue, 16 Dec 2025 12:03:13 +0900
Message-Id: <20251216030314.29728-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRyHe885O+e4HB7WxZNFwUSCIrtg8BfCRIJeIksoogtdRp7ayhub
	mobFzNnM0tQSTVcppnlLY9rcxlbmvaQ0LZmUt3UxKjW1LHNkLvHbAw+/59OPJaUjlBerjIgW
	VBHyMBktpsQj7oUb/rYHKjfZuj1BX11JQ8XvOLg/aBLBdOUwAfpyI4If028ZmLW1IJhsaqXh
	a+MEgqLCKRL0HVoKflb/IcFsGUbwJfcBDR9bHAxUGIJhoOQTBVZdHQmO6200pGlnSLBNjzJw
	yVQ6F67RMNBpTBfBzT/FJNRpBhnotuhp6K+cFcGnhjQKnuWVUfA9u4mEgfRAaClYDlPt3xA0
	VdcRMHXtNg1vblkIeGR7w8CNrgIa3msHEHQ1OijIdqbQkJ+YjmDm91xyNOOHCPKb+5lAX5xo
	t9O48dsYiWvLegnck5tJYfvj5wQ25/UxuMAQg2tK1+FUexeJDeVXaGyYyGLwux4rjdtyZyhs
	HvLHZtMkgdOSRumQZYfF20KFMGWsoNoYcEKsuHe5mYzKEMcVtb5AGpTLpCI3luf8eEerRrTA
	SUYn5WKaW8vb7dOki5dywXyV8TVKRWKW5EYZ3vrkF+0SS7g9fEp5DuFiivPhM7VF/8cSbivf
	raum56Nr+IqH9aRrzHOFLD+WnIPmxQr+aamdykCLC9CiciRVRsSGy5Vhfr6K+AhlnO/JyHAD
	mjtByQXnEROa6NzXgDgWydwleHa7UiqSx6rjwxsQz5KypZIUe4BSKgmVx58XVJHHVTFhgroB
	rWQpmadky9S5UCl3Wh4tnBWEKEG1YAnWzUuDspynNJ+PJ1z08aq9mjTuPYReVc32JfToD8mW
	Z+3q/bDJuqzt1vpowwEPfYj/7qo72/fJi0I6ysx+v86s0mVH6oymRLegZNvDYwaPXRmraz7u
	7/Bor7Bo9+4oDre2HdYpmk9oulnsfdS7/uXdL3/HSoZFyf79aOd4sfqF09tBHAySUWqFfPM6
	UqWW/wN8heHSAAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0iTYRyHe7+zo8WXSX3ZRTCQTpQJFf9ISrqot+h0E4E3OfRDl5vKlrZ1
	oJWiNnK5DmQ5wZppHlLZapviVDYzTcSYh9ZhakYlZTN0eVyZFt098PB7bn4cGd5DRXKKtLOi
	Ok2ulDESSnJsT/bW311xiu19NhrMdTUMVM9ooWLYScNszRcCzFV2BMHZdywsuNoRTLa9YOCb
	ZwKB5cEUCeaeHAp+1s2R0ND4BcHXoicMfGofYaHaehSGyj9T0JTnIGHkRgcDBTnzJLhmAyxc
	dT5eDNv0LHhKOml4ZTfScHvuEQkO/TALvY1mBgZrFmj47C6goPN+JQU/7rSRMGSMg/bS1TDV
	NYagrc5BwNT1Egb67zUS8MzVz8ItbykDH3OGEHg9IxTcCeUzUHzFiGB+ZjEZKAzSUPx8kI2L
	xld8PgZ7xsZJ/LTyDYEHikwU9jW/JHDDfT+LS62Z2PZ4Mzb4vCS2Vl1jsHXiJovfDzQxuKNo
	nsINH3bjBuckgQuyA8yJ1fGS2CRRqcgS1dF7EyQpZbnPyYxCidbyohvpURFrQGGcwO8Qsu0h
	aokZfoPg882SSxzBHxVq7X3IgCQcyQdYoallmlkSq/hjQn7VXWKJKT5KMOVY/o6l/E6hN6+O
	+RddL1TXt5KFiCtFy6pQhCItSyVXKHdu06Sm6NIU2m2J6SorWry5/FLI5ETB3oNuxHNItlyK
	F/Ypwml5lkanciOBI2UR0nzfXkW4NEmuOy+q00+rM5Wixo3WcZRsjfTwKTEhnE+WnxVTRTFD
	VP+3BBcWqUcQe9nyMFYf6dDHGafPnQRDrT/prX3U63LZOiuPl2U8SVYl+VX7Y9SOmC5t7MmQ
	bmP3mUn/gVtbci2H5oLNgW7dwyNlTafiv3MX3/v9z1Yi24VNbr2pIi8st7znw4rlM2OOXd7E
	X856nkDKtfQ4/Xo0qrWF121svTQ9mluSIqM0KfKYzaRaI/8DjxHjcOICAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Since this patch requires to use newly introduced APIs in net tree, I've
been waiting for those to be ready in mm tree.  Now that mm tree has
been rebased so as to include the APIs, this patch can be merged to mm
tree.

This patch has been carried out in a separate thread so far for the
reviews [1]:

 [1] https://lore.kernel.org/all/20251119012709.35895-1-byungchul@sk.com/
---
Changes from v1:
	1. Drop the finalizing patch removing the pp fields of struct
	   page since I found that there is still code accessing a pp
	   field via struct page.  I will retry the finalizing patch
	   after resolving the issue.
---
Byungchul Park (1):
  mm: introduce a new page type for page pool in page type

 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 27 +++----------------
 include/linux/page-flags.h                    |  6 +++++
 include/net/netmem.h                          | 15 +++++++++--
 mm/page_alloc.c                               | 11 +++++---
 net/core/netmem_priv.h                        | 20 +++++---------
 net/core/page_pool.c                          | 18 +++++++++++--
 7 files changed, 53 insertions(+), 46 deletions(-)


base-commit: d0a24447990a9d8212bfb3a692d59efa74ce9f86
-- 
2.17.1


