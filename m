Return-Path: <bpf+bounces-76586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D8ECBCBA8
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 08:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA4830204B4
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D872E6CC5;
	Mon, 15 Dec 2025 07:10:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5CB248F69;
	Mon, 15 Dec 2025 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765782620; cv=none; b=tNGNRfg3DmgmvFrGNmO02bFNnEU7TbQYOXsX4sk45LMXTxQM66O308sSpzzw8KK79gtBEql+R+88B0TccfOf0zFEKygICXbh8bOGo3FRCzkJWAkSjr9UhqOYYsxq6tVchwrFkiJflJWxFDnJUcFsYCULusHMZy5k6t2FXdsPcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765782620; c=relaxed/simple;
	bh=Pmbek36vGnOS796i2W3E2I8Lj4ltAdL36PZ8seQMylk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=I5XpCIUJ/VjsznjcHhEeALbVISCfBvvKxVII7oJNeO/jmeEJPU7ejevipsDR+PEN5cM37Zmf2LnZMHU+XHYOXG/t5qbVVnKdPVDmrJuDceH5hVmeceRBKnGAWdoo114HOLLbnbkqlJZVjYR0AYeaYEuX1+SSVSwgumnn+b5lyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-9b-693fb453d267
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
Subject: [PATCH 0/2] finalize removing the page pool members in struct page
Date: Mon, 15 Dec 2025 16:09:59 +0900
Message-Id: <20251215071001.78263-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSf1CLcRwHcN89z77P0xjPLT+e+IPbcXWO0OXuk3PJPzxX13H6Q+Qwemhn
	/bB+KA6LnHT6pWJq7oqTfoyyfqxNUdskcVeGbg7FXHKZSWXMZKbOf697fz6f918fmpA4yMW0
	PCmNVybJFFIsIkVf5lStjmneJF+rqdgAmgYthvqfmXDrXZsQ3NoRAWjqWhFMul9T4O3oRjBh
	eYThs3kcwY0qFwGavhwSvjf8IsBgHEEwqr6NYbjbTkG9LhqGqj+S0H5eT4C9sAdDfo6HgA63
	k4IzbTW+4iYVBf2tBUIo/XWTAL3qHQXPjRoMg1qvED6a8kl4XF5LwliZhYChggjorlwIricO
	BJYGvQBcF69heHnVKICWjpcUlFgrMXzIGUJgNdtJKPudi6EiuwCB56ev0lk0KYSKh4NURDCX
	bbNhzuz4SnDNta8E3IC6mORs93sFnKH8LcVV6tK5ppqVXJ7NSnC6uguY041forg3A+2Y61F7
	SM7wPowztE0IuPyzTrx9wW7RxnheIc/glWvC94sSnCMFOKXQL3NU+wer0F2ch/xolgllH410
	oP92fDJNGzOBrM3mJv55PhPN3ml94ctFNME4Kbb9wY/pY38mim1psk8vkcwKVn+9gfpnMbOe
	vXnFTM6ULmXrGzuJGdfSrNqunHEA21VjI4vQ7Eo0qw5J5EkZiTK5IjQ4IStJnhl8MDlRh3w/
	UH3yd1wbGu+PMSGGRtI54v7mcLlEKMtIzUo0IZYmpPPFuTZfJI6XZR3nlcn7lOkKPtWEltCk
	dJE4xHUsXsIclqXxR3g+hVf+nwpov8UqFNTowCn3Tu3oW2f1jzzavUXXWxI4ttArHF6ubtm7
	fFVX9q4U+5T/+07jVvGqPVHgCNsYquuZsk6GaeMC0k/0C6Zi597Ijrm9OaBl7fOL23LLBkPq
	yw94/IKeSiwh34xpiZH8s52Bh4tfn5z35VBvqON0WKwzL9bsXVZ6ufXcgNIikZKpCbJ1Kwll
	quwvNeVonv8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+c/c9xNTqY2bEgY5DdMA0030rKIOqQVFJQ1JccddDhnLKZ
	l6iYKbRK7WLWUoNZaaar5Sy3mVpsZlrByhsnuszWxTJZMU2d2mUaffvxPO/7+/LQRJCTXEAr
	VJm8WiVXyrCElOxYnx+x+95GRZT90jKoMBkx1I3nwM1+qxh8xgERVNQ2IhjxvabgT0s7guG2
	Jxi+ObwIrleOElDhLCDhp2mCAFvTAIJB/W0Mn9rdFNSZt4Or+jMJzSctBLjPdmAoKpgkoMXn
	oeCEtcYvbtBS4LjaKYYXjcViuDhRRYBF209Bd1MFhnfGP2L4bC8iobPsFgk/StsIcBXHQ7sh
	BEafDSFoM1lEMFp4FUPvlSYR3G/ppaCky4DhQ4ELQZfDTULplA5DeV4xgslxv9JzbkQM5Y/f
	UfGRXJ4gYM4x9J3g7t16JeL69OdJTmh9KuJsZW8pzmA+zDXUrOBOC10EZ649hTmz9wLFvelr
	xlyHfpLkbO/XcjbrsIgryvfgxJD9krhDvFKRxasjNyRJUjwDxTjjbGDOoPE31qJ6fBoF0iwT
	zQ59saNpxsxSVhB8xDQHM9vZO409/lxCE4yHYpsfjs08zGUS2PsN7pkjklnCWq6ZqGmWMjFs
	1WUH+U8axtbdfUScQ7QBBdSiYIUqK02uUMas0qSm5KoUOasOpqeZkX/m6mNT561opHurHTE0
	ks2WCg82KILE8ixNbpodsTQhC5bqBH8kPSTPPcKr0w+oDyt5jR0tpEnZfOm2vXxSEJMsz+RT
	eT6DV/9vRXTgAi2K1D3eX7V5+EJaxI4xds3Ucv1XU6H1uzxuV0ne4k3u5c5wcLXOq0yuD9fH
	7vtl+JBY3d27siT0Y+Ieb8Doj+MpgqSnpmlOdl32TtsNnERFLfKeSUhmN+0u1ymnnkdVO7W7
	SsPWdcUOeo7OinbVL7PSwsuBLc59hXfys1Fo90KWkpGaFPnqFYRaI/8LI6l0buICAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This set depended on patches in the net-next tree.  Now that mm tree has
been rebased so as to include the net-next code that this set requires,
I can finalize the work removing the page pool members in struct page.

1/2 patch has been carried out in a separate thread so far for the
reviews [1]:

 [1] https://lore.kernel.org/all/20251119012709.35895-1-byungchul@sk.com/

Byungchul Park (2):
  mm: introduce a new page type for page pool in page type
  mm, netmem: remove the page pool members in struct page

 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 27 +++----------------
 include/linux/mm_types.h                      | 11 --------
 include/linux/page-flags.h                    |  6 +++++
 include/net/netmem.h                          | 22 ++++++++++-----
 mm/page_alloc.c                               | 11 +++++---
 net/core/netmem_priv.h                        | 20 +++++---------
 net/core/page_pool.c                          | 18 +++++++++++--
 8 files changed, 55 insertions(+), 62 deletions(-)


base-commit: d0a24447990a9d8212bfb3a692d59efa74ce9f86
-- 
2.17.1


