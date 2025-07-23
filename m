Return-Path: <bpf+bounces-64144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE01B0E9D1
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 06:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B077F3AD3E9
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 04:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802C4238C04;
	Wed, 23 Jul 2025 04:49:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872C1FC8;
	Wed, 23 Jul 2025 04:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246185; cv=none; b=a06sRUdPJ0ELclh7VgKAr0eu+n1ba6tJy/eTF1uO7otFveEgndG5dPoksAAm/DMWHYtUC2IfLQK5qJXXQQtcrzLpyIvhz8lyvO+BtoazkPAAaf0wFTrWt9uOKE4hiMJKl38OUvcRSOUikZqz9IF5QgQnnB4tJMpeQ3XUwMUWisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246185; c=relaxed/simple;
	bh=26EE2xjoIICOObnyz/2jnRgqEmWOtW4bbfbTz6qa83o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLYGdRZUYJ2B0x0Ih7FJheCBOnxB/oFjOUBPuY5AFYrgFjmU9e533oI6cpSTVVKuNG0INDaLUkYQNVry0IukP/KPfwzapNNe8og7h0MLNw5tpyucXElrACnhQ4qfgo/jDJj41dIYKXsZc2CLnrJQ4ikFZ3Z87+KPu15lhrG2ARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ec-688069e2743d
Date: Wed, 23 Jul 2025 13:49:33 +0900
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
	akpm@linux-foundation.org, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, david@redhat.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
	ziy@nvidia.com, jackmanb@google.com, wei.fang@nxp.com,
	shenwei.wang@nxp.com, xiaoning.wang@nxp.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, tariqt@nvidia.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, mbloch@nvidia.com, danishanwar@ti.com,
	rogerq@kernel.org, nbd@nbd.name, lorenzo@kernel.org,
	ryder.lee@mediatek.com, shayne.chen@mediatek.com,
	sean.wang@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	aleksander.lobakin@intel.com, horms@kernel.org, m-malladi@ti.com,
	krzysztof.kozlowski@linaro.org, matthias.schiffer@ew.tq-group.com,
	robh@kernel.org, imx@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v12 00/12] Split netmem from struct page
Message-ID: <20250723044933.GA8691@system.software.com>
References: <20250721021835.63939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG8973frWjyV0n7p2ELOlmlpEA6tSdkfkRN+Pd4jIjicnc4mzG
	zdoI1RRtgWSjIszZrUjAZbYrGU4sn4opAzqsbBaCnZrxJVj5KA42glpErVQqrqzXzMz/njzn
	ye85Jzk8Vleyy3i9Yb9kNGizNaySVs4k/JQ6qbfoVnh3g7OpkYW+8AkGGubzoOaGh4H+OgLn
	eucpcNa3IngQHeHAfWQUQ7jrIgsnT0QwRM/aaHD2FNMw1/QIw9/dExz4ff/Q0OD+AMZdUzR4
	D7dh6JxbDhNH/SzYihcw2IMlLCwOLzBwPnqHgyJPLQXnb7dw0NtaysCxR6cwtFluxLsmhxgY
	aHeyMHCoD0GwcZGBKV+8MFQ7ykFpgwOB79c6FoqK34BQywMO7n7XhWG8dCPEjpugu2opRC6H
	EIycGqRg0evh4I/gGQa6mtoouPpnFEPk20oWrDNHEQza2ym4UnmWgerLV6n4HpkwtPiYgor+
	KhYmi8cR9HdO0PDDwVIETR0BBu554ycvzDvZjZvEztAsFj1j1Uj8ue46JU6XxSgx0HGJEn9x
	jHFilfuA2FybIp703qREa6Afi+76I6zovl/OiaNDXlb0H1+gxebqQnG62Y62Je9Uvp0lZetN
	kjF9/W6lzve9ndpXti4veK0CW1BNuhUpeCKsJm1fVaCneup0JS1rWlhOHn5dwciaFV4jgUAU
	WxHPLxHSyVD5R1ak5LFwMIFMh2xYzrwgbCYufzsrZ1TCm8QSTpZttbCGhG55nmBUwvPkd/tf
	T/BYSCGB2E1KjmMhidTEeNlWCGvJRPw/ZJ0ovEJ+a71IyVVEmFKQMxdm/1vzJXKhNkCXIcHx
	DNbxDNbxP7YK4Xqk1htMOVp99uo0Xb5Bn5f22d4cN4o/reuLxx970P3eTB8SeKRJUFlaCnVq
	RmvKzc/xIcJjzRJV5NyXOrUqS5tfIBn3fmo8kC3l+lAST2teVK2KmLPUwufa/dIeSdonGZ9O
	KV6xzIKoolt7fFvL3hteqcw4vYGkHrs3IjWGt3U0JJpnMt9PchUGDyfv2pGyvUSlNy/tDpk+
	2ZThV8x5pkXbZqvd9m7XW3fuftg6vMJV9GOB25oa3rJr+3ODW8fKC2LmxENrHloMO+Gdktdd
	PePeb3ZkZM2aS7g0tGVV5OWeAYNkeLUv47qGztVpV6ZgY672X7cHPHiwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTdxTO7/7ui4Yb7yrDG3FL1sUZSZQtvk6iGybGcLPExYUZnfFBgze2
	A6procKSYdGazWZUlI3ZUhJQ5K0lRaBCRVeYgJqpFLAqFq0bAVfng4KWsmJrssz/vnPO9zh/
	fCyWh6mFrFqTK2k1ymwFLSNlX6w9vMyvNqg+vl7yAdjsTTTcmqyioPFVPtQ+cFIwUC9A581X
	BNga2hAEQ/cYcBwdwTDZ00vD6appDKHmYhJsN4wkTNlnMPx1xc9An/tfEhodm2C0ZowE1w/t
	GLqnFoP/WB8NxcYwBovvCA1zd8MUXAz9w8AhZx0B3RX90fHvVgZutpkp+HnmDIZ2w4No4KNh
	CjwdNho8h28h8DXNUTDmjqYG6kYYMDdaEbgv1dNwyLgCAq1BBp790oNh1LweIif1cKUyEaav
	BRDcOzNEwJzLycAfvnMU9NjbCRh8GMIw/VMFDaYnxxAMWToIuF7RTEH1tUEi+kc6DM/NElA6
	UEnDI+MogoFuPwnlRWYE9i4vBc9dRnL9BrE78BSLzvvVSDxff4cQx0sihOjtukqIF6z3GbHS
	kSe21CWLp10ThGjyDmDR0XCUFh0vTjDiyLCLFvtOhkmxpfqgON5iQZvf3y5bt0fKVuslbcpn
	GTKV+1cLsb/k03zf7VJsQLUpJhTHCvxKYexsBRnDJL9YePljKRXDNL9E8HpD2IRYNoFPEYZP
	fG1CMhbzRfHCeKAYxzjz+Y1CTV8HHeNw/BrBMPlebC3nVwmBx843Nhz/jtBv+fONPeaTBW9k
	gojRMZ8k1EbY2DqOXy34o52I4Xf5D4XLbb1ECeKsb6mtb6mt/6srEW5ACWqNPkepzl61XJel
	KtCo85dn7stxoGgla76fPe5EQU+aG/EsUsRzhtaDKjml1OsKctxIYLEigZvuLFTJuT3Kgu8k
	7b7d2rxsSedGSSypWMB9vlXKkPN7lblSliTtl7T/XQk2bqEBpS7b9HLBXfztog1lEfNmQ5DD
	X5Vn2TqbS6fsHbNLf0trMj7ZSeWdO1B28XjeN5nBVI/nam2z/EhNfvnMjR31iUVdZ8eTuLKq
	das1232ndqf9vmhbYa4ulO5cUljOFMxLjcDjXRnz5Dk7Mh1beqvCienJXw7F09sI/dBlV9nE
	R/2DClKnUn6SjLU65WsqBJKsjgMAAA==
X-CFilter-Loop: Reflected

On Mon, Jul 21, 2025 at 11:18:23AM +0900, Byungchul Park wrote:
> Hi all,
> 
> The MM subsystem is trying to reduce struct page to a single pointer.
> See the following link for your information:
> 
>    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> 
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for page pool.
> 
> Matthew Wilcox tried and stopped the same work, you can see in:
> 
>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> 
> I focused on removing the page pool members in struct page this time,
> not moving the allocation code of page pool from net to mm.  It can be
> done later if needed.
> 
> The final patch that removes the page pool fields will be posted once
> all the conversions are completed.
> 
> 	Byungchul
> ---
> Changes from v11:
> 	1. Rebase on net-next/main as of Jul 21.
> 	2. Change page_pool_page_is_pp() to check for const type of
> 	   page.  For now that it's called along with every
> 	   pp_page_to_nmdesc() call as Pavel suggested,
> 	   page_pool_page_is_pp() should also cover const type of page.

I believe the curretn version is good enough.

	Byungchul

> Changes from v10:
> 	1. Introduce __netmem_to_nmdesc() and use it in
> 	   __netmem_get_pp(). (feedbacked by Mina)
> 	2. Fix a bug that fails on casting 'const page -> const
> 	   netmem_desc', by using macros and _Generic. (feedbacked by
> 	   test robot)
> 	3. Add comment on pp_page_to_nmdesc() to ask for more attention
> 	   before using the helper. (feedbacked by Mina)
> 
> Changes from v9:
> 	1. Remove the patch 'page_pool: access ->pp_magic through
> 	   netmem_desc in page_pool_page_is_pp()' and decide to wait for
> 	   Pavel's work of PageNetpp() to identify page type for page
> 	   pool, that doesn't need to access ->pp_magic.
> 	2. Rename page_to_nmdesc() to pp_page_to_nmdesc() and add
> 	   DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page)) in it,
> 	   just in case. (feedbacked by Pavel)
> 	3. Apply just simple casting from page to netmem_desc for
> 	   accessing ->pp and ->pp_ref_count, instead of full converting
> 	   page to netmem_ref for network drivers e.g. mlx4, netdevsim,
> 	   and mt76.
> 	4. Expand the support for drivers to access ->pp and
> 	   ->pp_ref_count to fec, octeontx2-pf, iavf, idpf, mlx5, ti,
> 	   and xdp.
> 	5. Squash each helper with its first user. (feedbacked by Mina)
> 
> Changes from v8:
> 	1. Rebase on net-next/main as of Jul 10.
> 	2. Exclude non-controversial patches that have already been
> 	   merged to net-next.
> 	3. Re-add the patches that focus on removing accessing the page
> 	   pool fields in struct page.
> 	4. Add utility APIs e.g. casting, to use struct netmem_desc as
> 	   descriptor, to support __netmem_get_pp() that has started to
> 	   be used again e.g. by libeth.
> 
> Changes from v7 (no actual updates):
> 	1. Exclude "netmem: introduce struct netmem_desc mirroring
> 	   struct page" that might be controversial.
> 	2. Exclude "netmem: introduce a netmem API,
> 	   virt_to_head_netmem()" since there are no users.
> 
> Changes from v6 (no actual updates):
> 	1. Rebase on net-next/main as of Jun 25.
> 	2. Supplement a comment describing struct net_iov.
> 	3. Exclude a controversial patch, "page_pool: access ->pp_magic
> 	   through struct netmem_desc in page_pool_page_is_pp()".
> 	4. Exclude "netmem: remove __netmem_get_pp()" since the API
> 	   started to be used again by libeth.
> 
> Changes from v5 (no actual updates):
> 	1. Rebase on net-next/main as of Jun 20.
> 	2. Add given 'Reviewed-by's and 'Acked-by's, thanks to all.
> 	3. Add missing cc's.
> 
> Changes from v4:
> 	1. Add given 'Reviewed-by's, thanks to all.
> 	2. Exclude potentially controversial patches.
> 
> Changes from v3:
> 	1. Relocates ->owner and ->type of net_iov out of netmem_desc
> 	   and make them be net_iov specific.
> 	2. Remove __force when casting struct page to struct netmem_desc.
> 
> Changes from v2:
> 	1. Introduce a netmem API, virt_to_head_netmem(), and use it
> 	   when it's needed.
> 	2. Introduce struct netmem_desc as a new struct and union'ed
> 	   with the existing fields in struct net_iov.
> 	3. Make page_pool_page_is_pp() access ->pp_magic through struct
> 	   netmem_desc instead of struct page.
> 	4. Move netmem alloc APIs from include/net/netmem.h to
> 	   net/core/netmem_priv.h.
> 	5. Apply trivial feedbacks, thanks to Mina, Pavel, and Toke.
> 	6. Add given 'Reviewed-by's, thanks to Mina.
> 
> Changes from v1:
> 	1. Rebase on net-next's main as of May 26.
> 	2. Check checkpatch.pl, feedbacked by SJ Park.
> 	3. Add converting of page to netmem in mt76.
> 	4. Revert 'mlx5: use netmem descriptor and APIs for page pool'
> 	   since it's on-going by Tariq Toukan.  I will wait for his
> 	   work to be done.
> 	5. Revert 'page_pool: use netmem APIs to access page->pp_magic
> 	   in page_pool_page_is_pp()' since we need more discussion.
> 	6. Revert 'mm, netmem: remove the page pool members in struct
> 	   page' since there are some prerequisite works to remove the
> 	   page pool fields from struct page.  I can submit this patch
> 	   separatedly later.
> 	7. Cancel relocating a page pool member in struct page.
> 	8. Modify static assert for offests and size of struct
> 	   netmem_desc.
> 
> Changes from rfc:
> 	1. Rebase on net-next's main branch.
> 	   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
> 	2. Fix a build error reported by kernel test robot.
> 	   https://lore.kernel.org/all/202505100932.uzAMBW1y-lkp@intel.com/
> 	3. Add given 'Reviewed-by's, thanks to Mina and Ilias.
> 	4. Do static_assert() on the size of struct netmem_desc instead
> 	   of placing place-holder in struct page, feedbacked by
> 	   Matthew.
> 	5. Do struct_group_tagged(netmem_desc) on struct net_iov instead
> 	   of wholly renaming it to strcut netmem_desc, feedbacked by
> 	   Mina and Pavel.
> 
> Byungchul Park (12):
>   netmem: introduce struct netmem_desc mirroring struct page
>   netmem: use netmem_desc instead of page to access ->pp in
>     __netmem_get_pp()
>   netmem, mlx4: access ->pp_ref_count through netmem_desc instead of
>     page
>   netdevsim: access ->pp through netmem_desc instead of page
>   mt76: access ->pp through netmem_desc instead of page
>   net: fec: access ->pp through netmem_desc instead of page
>   octeontx2-pf: access ->pp through netmem_desc instead of page
>   iavf: access ->pp through netmem_desc instead of page
>   idpf: access ->pp through netmem_desc instead of page
>   mlx5: access ->pp through netmem_desc instead of page
>   net: ti: icssg-prueth: access ->pp through netmem_desc instead of page
>   libeth: xdp: access ->pp through netmem_desc instead of page
> 
>  drivers/net/ethernet/freescale/fec_main.c     |  10 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   8 +-
>  .../marvell/octeontx2/nic/otx2_txrx.c         |   2 +-
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c    |   4 +-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   3 +-
>  .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |   4 +-
>  drivers/net/netdevsim/netdev.c                |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt76.h     |   3 +-
>  include/linux/mm.h                            |   4 +-
>  include/net/libeth/xdp.h                      |   2 +-
>  include/net/netmem.h                          | 153 +++++++++++++++---
>  12 files changed, 161 insertions(+), 40 deletions(-)
> 
> 
> base-commit: 4701ee5044fb3992f1c910630a9673c2dc600ce5
> -- 
> 2.17.1

