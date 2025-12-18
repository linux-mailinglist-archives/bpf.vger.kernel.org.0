Return-Path: <bpf+bounces-76935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF56CC9DFC
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B76ED3028FC4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFFB1EBA14;
	Thu, 18 Dec 2025 00:18:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E51A58D;
	Thu, 18 Dec 2025 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766017091; cv=none; b=t/bjWYe4JJdKcJ8tG/bAuU/ySdr9woxytMfTjwk0Uq1i3nqudyHEM1EI55HcEuvidn8S4nt/gUD8DDKxoxS6NaM8JYGCcMuJwn1FpPyWLIEPp1V+SGYgVrbNfvqUg+au/4hmoZBNmmqWy41iYF2oNYIm0f4RCisNS1osDxaxpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766017091; c=relaxed/simple;
	bh=eB6xIUCuuf2mpahlEwg01sFXJZ5oyFlsxLWzVbk6mLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLnvxdO6yfw/mIDrcsolHVcVLyerVBpuv8Ks2lOKG2Y8iDv/0ZOhvWCBCsBnX5FMGV6zw+1KcLq/nsZGmjsrFUrr+QKpps06CxRQSC+RVmOWK/h4vxVmjzNGXWbFZrFbRP1wMbTVUVvK5yhv/eYwhB37h4E9XTxnYYns/QC7R34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-19-69434833c5b5
Date: Thu, 18 Dec 2025 09:17:49 +0900
From: Byungchul Park <byungchul@sk.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
	willy@infradead.org, brauner@kernel.org, kas@kernel.org,
	yuzhao@google.com, usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com, almasrymina@google.com,
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH v2 0/1] finalize removing the page pool members in struct
 page
Message-ID: <20251218001749.GA15390@system.software.com>
References: <20251216030314.29728-1-byungchul@sk.com>
 <776b0429-d5ae-4b00-ba83-e25f6d877c0a@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776b0429-d5ae-4b00-ba83-e25f6d877c0a@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH932e557n6dbZ0wlfmT9czISE/vhYRtjsS7PZMJvWdLqHbq5w
	kbKZK224uYSaXDUlVFdWu/STLJUU5UetPIhylRZJKs3143KXNf577fX+ft+fzx8fnlY2yLx4
	beRJUR+p1qlYOSP/7p61ej3ZpvWzNy6F9MICFvJ/x0BOV7kM7AV9FKRbShGM2j9wMF1Vj2Ck
	7hkL32qHEWRnjdGQ/iqBgV+F4zRUVPYh+Jp6n4XeehsH+dZd0HnvCwOPLpTRYLvSwIIpYYKG
	KvsgB/Hluc7iYgMHr0sTZZA8fpeGMkMXB62V6Sx8KpiWwZcaEwON5jwGhlLqaOhMDIT6zPkw
	9mIAQV1hGQVjlzNYaLtZSUFJVRsH11syWehO6ETQUmtjIGXyIgtpcYkIJn47KweTRmWQ9vQT
	F+hL4iSJJbUDP2jyIO8dRdpTrzJEevycIhXmjxzJtJ4ixbk+xCi10MRqucQS6/A1jnS0P2JJ
	Q+oEQyo+byAV5SMUMZ0fZHfPOyDfqBF12mhRv2ZTqDy8d8pBHTd6xLQathhQtrsRufFY8MdJ
	liJmlm8YH9IuZoRl2DFgkrmYFZZjSbLPeE9hKbYVPXV6OU8LPzg82XqLdQVzhb148E2TM+B5
	hQC4rHq7SyuFw3ikvmfmr0LwwI03e2Zm0YIPlhz9lOs5LSzCOQ7epd2EAHy72UK5eJ7gjatL
	n1F/Vxvl8VTTqr+8ED/JlZgkJJj/azX/12r+15qJaAtSaiOjI9Ranb9veGykNsY37FiEFTnv
	697ZyeByNPx6Tw0SeKRyVwSmbdUqZeroqNiIGoR5WuWp8Gt2KoVGHXtG1B87qD+lE6Nq0CKe
	US1QrBs7rVEKR9QnxaOieFzUz6YU7+ZlQJp+r74Ah6bwzjddMHd+ZNq2cElIVpDfyzi/5g9N
	S1QrVuUvJlJJ3/63b/rj42/BNo8dxphzcTs7kkMTqODuTVlzkteHBd+eGvLOuBLk83b8vcIR
	UBv4kU85FBb6U9b+vcPE1eVsn+ydvrj5/T5uf0i72+YXGaVtPf57rjWdOLEyaL6KiQpXr/Wh
	9VHqP0AbKktbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zds5xuTia2SGjD6sIFt66wGtFmVH96YaE0O1Djjzlyhub
	ihrBTKEaOdMSbWkttTIvWavcNBcydTpTKk2dqGmWSSUWusRbqy2I+vbwe97f8+llSe8K0XJW
	EZcoKOPkMVJaTIkPbsnw34B3KoJe2hZBYXUlDRUzKXB/2CSC2coxAgrLaxA4ZvsZ+GW2Iphq
	aqHha+MkgpI70yQUvsqk4Ef1HAm1dWMIvhRU0TBqHWGgwnAAhu59oqD+opGEkexWGrIy50kw
	z04wcMFU5hp+omagscgmgtc1WhFcn7tLglE9zEBXXSEN7yp/ieCTJYsCm+4BBd/zmkgY0oaC
	Ve8L0y/HETRVGwmYvlJEQ/eNOgKembsZuNapp+FD5hCCzsYRCvIWLtFwM12LYH7GNTlx1SGC
	m83vmNBAnG6307hx/BuJnz7oI3BPQQ6F7S/aCFyrG2Sw3pCEn5TJsMbeSWJD+WUaGyZzGTzQ
	U0/j1oJ5Cte+D8G1pikCZ2VM0OG+x8Rbo4QYRbKgDNwWKY4e/ekkEjReKV3qHWpU4qlBHizP
	beTzNc9Jd6a4NbxzPEvkzjS3lrfbZ/9wH241P/Ko2cXFLMl9Y/iFrtu0u1jCRfATb9pdBctK
	OOCNDbvd2Js7xU9ZP/5xJZwXb7vxkXJnkpPxdudnwn1Ocn78fSfrxh7cFr64o5xw56XcKr6h
	poW4iiS6/2zdf7bun61HZDnyUcQlx8oVMZsCVGejU+MUKQEn42MNyPVC984v5JiQo2uPBXEs
	knpKcHGYwlskT1alxloQz5JSH0lQhwtJouSpaYIy/oQyKUZQWZAfS0mXSfYeFiK9udPyROGs
	ICQIyr8twXosV6NNIRcfppu8eriTe5mMCH1Zb9uMc3izLPVNcFLaD03aLhRqlJ2uGjVrQ8dO
	LM4diLZY1w9rO9eXWkozE3x6K/z7A5W36KHHO/afcRTkJ76NlzuapYeurztsy1h0zjfsqMbc
	16p1Zlcy2/cNivvDu4+vXNG+lRl8Xte05EhUWHbReymlipYHy0ilSv4bFmu/pj4DAAA=
X-CFilter-Loop: Reflected

On Wed, Dec 17, 2025 at 02:43:07PM +0100, Vlastimil Babka wrote:
> On 12/16/25 04:03, Byungchul Park wrote:
> > Since this patch requires to use newly introduced APIs in net tree, I've
> > been waiting for those to be ready in mm tree.  Now that mm tree has
> > been rebased so as to include the APIs, this patch can be merged to mm
> > tree.
> >
> > This patch has been carried out in a separate thread so far for the
> > reviews [1]:
> >
> >  [1] https://lore.kernel.org/all/20251119012709.35895-1-byungchul@sk.com/
> > ---
> > Changes from v1:
> >       1. Drop the finalizing patch removing the pp fields of struct
> >          page since I found that there is still code accessing a pp
> >          field via struct page.  I will retry the finalizing patch
> >          after resolving the issue.
> 
> Could we just make that necessary change of
> drivers/net/ethernet/intel/ice/ice_ethtool.c part of this series and do it
> all at once? We're changing both mm and net anyway.

Yes.  That's what I think it'd better do.  1/2 can be merged separately
and Andrew took it.  I'd like to re-post 'ice fix' + 2/2 in a series if
it's allowed.

> Also which tree will carry the series? I assume net will want to, as the

I'm trying to apply changes focused on mm to mm tree, and changes
focused on net to net tree.  However, yeah, it'd make things simpler if
I can go with a single series for mm tree.

	Byungchul

> changes are mostly there?
> 
> > ---
> > Byungchul Park (1):
> >   mm: introduce a new page type for page pool in page type
> >
> >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
> >  include/linux/mm.h                            | 27 +++----------------
> >  include/linux/page-flags.h                    |  6 +++++
> >  include/net/netmem.h                          | 15 +++++++++--
> >  mm/page_alloc.c                               | 11 +++++---
> >  net/core/netmem_priv.h                        | 20 +++++---------
> >  net/core/page_pool.c                          | 18 +++++++++++--
> >  7 files changed, 53 insertions(+), 46 deletions(-)
> >
> >
> > base-commit: d0a24447990a9d8212bfb3a692d59efa74ce9f86

