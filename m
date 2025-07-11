Return-Path: <bpf+bounces-62988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D8B01054
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 02:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E871E4A7D12
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 00:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABBB26AD9;
	Fri, 11 Jul 2025 00:42:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E23320F;
	Fri, 11 Jul 2025 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194543; cv=none; b=hBW1BfOJySI6iFPerpO0zrpn7T8hFPAK6GzUs3ILuI1Pn6BJuV6d/43/nrHGz5Wr6rSEt/sa4XuBUsyIDMWyPhYdp5hRNfelwMAh50tnXoBYoSMnwV85D/yJcPwaswRVp0U3UCemBfwHfGkjwzLqWbLs5efSYVr9p6IfFqjjIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194543; c=relaxed/simple;
	bh=d5lIANhVIUBZuKKmajGnYSo/dPQpGs0dd0nRVA3ev00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOcSAt+FvI9dgkDUkUneUX+r6ywhQd560xCWr0VNLyGb9kQHGvhBLxpcIfE8IUJ+OQTOK3XHu62QBFuPdORmv+aUCYDYj2igI3xA2G3Jhje/aSxlYF4eqPLHofFKGEHGZQR82ghSp37ELTESPPwTq2HkZVjVymacYjYnBvZc8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a5-68705de5e4c6
Date: Fri, 11 Jul 2025 09:42:08 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 0/8] Split netmem from struct page
Message-ID: <20250711004208.GA40145@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <CAHS8izMie=XQcVUhW9CmydTqYEscp5soeOT4nwvFj2T+8X1ypA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMie=XQcVUhW9CmydTqYEscp5soeOT4nwvFj2T+8X1ypA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0jTYRTGefe/Ohr8Xbc3DYp1w65WRudDhQXB+8XQ/FB0s5F/22hOm7pU
	TMyMaKbdlHRabFpuqbRaXqaZlFlqGuXKXJkZSweRGeWlTLs4JfLbc57z8PzOh8NT8tuMH6/W
	xos6rVKjYKW09PMM8yrP/lhVYFMlA4W2chbKfiSC5b1jYiqtQjA02sXBYGMTC8XmEQoKn2XQ
	MGz7SUHfYzcHZfYQ6Cnx0FB3upoC97lmFrIyxii4NzrAQbrDKoHnVdkM5Py8TkF12nsOXtQW
	svCu/A8DnoYsGlqMN2joyQ6Gx6Y5MNLaj6DRVi2BkbNXWLjkNLHwIaMHgfOhm4aCE9kIbPUu
	BsZ+THQUPHrHBS8mD/u/UKTixmsJqTF2c8RkTyB3rMuJweWkiL30DEvs3y5y5O2rOpY0543R
	pMYxKCFZJwdY8rXvDU2+1HewxFbRQZM2UyMX6rtHuilS1Kj1om7NloNSlbkph4ntX5hoqbtD
	p6GauQbkw2MhCPfe6mD/6bKqj8iAeJ4WluDs0we8Nisswy7XKOXVs4QAfK3+AmNAUp4SjCzu
	qHXT3sVMYRvO/9Q5GZIJgLvbLZxXy4UU7Ll2nZnyfXFLfu9knpooHb/qpLwsSvDHlt/8lL0A
	n6wsmKzxEcJwbe74ZHy2sAjfr2qSeLlYaOZxp/MSN3XzPPzA6qLPI1/jNIRxGsL4H2GchjAh
	uhTJ1Vp9tFKtCVqtStKqE1cfiom2o4lHKjk+vteBvj0Pb0ACjxQzZMFlMSo5o9THJUU3IMxT
	ilmymyGxKrksUpmULOpiInQJGjGuAfnztGKubN3IsUi5cFgZLx4RxVhR928r4X380lBm6t6D
	zZuPWlOHksS+9Znm222elVmXT2zVRX1wa5eGMclRh7QRna9nf0/fUBnvKFDtVhTxO8jdUxu3
	K3fdxCXqiieBeUXDetu5t7769p37UvEzeOMXnpAJUZUpwzMtmq7W/tJbIej8irCAwxFuq9nw
	9GVvhulXqD2omNuaOz9aQceplGuXU7o45V+UuleFRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRiGefcdXa2+luWLFsZCRCErSHqgCDtQH0WRfzqSOfKjzdyUTU2j
	SJsmrZxadnAeMs9OcTLNU2qiK5OgcrE0ywOmUmSaWaJOLGdE/ru574vr+fOwhPQO5c4q1ZGC
	Ri0Pk9FiUnxkh27T8JkIxZanVj/IMpfTUDYdA8UDdRRkmWoQ/Jz5wMCktZ2G/EdTBGS9TiDh
	l3mWgOHngwyUWQ5Df9EICY1JtQQMprygITnBQUDTzBgD1+pKRNCW3UHBmxoDBemzhQTUxg0w
	8LYhi4a+8t8UjLQmk9BhLCWh3xAAz3PXwtTLUQRWc60Ipm5l03DHlkvDp4R+BLa2QRIy4w0I
	zM3dFDimFxyZz/qYAC++bXSc4KtL34v4emMvw+daoviqEl9e320jeIvpBs1bftxm+I/vGmn+
	xQMHydfXTYr4ZN0YzU8M95D8eLOd5vM/fxfx5mo7eVR6SrwzRAhTRguazbuCxYpH7elUxOiG
	mOLGKjIO1bvpkQuLuW24rOYL0iOWJTkvbEgKctY05427u2cIZ3blfHBBcxqlR2KW4Iw0tjcM
	ks5hNbcHZ3ztWoQkHODezmLGmaXcZTxSUEj97VfhjoyhRZ5YkM7l2AjnLYLzwMXz7N/aE+se
	Zy5qXLhA3HB3bhFfw23ELTXtolS0wrjEZFxiMv43GZeYchFpQq5KdbRKrgzz99NeUMSqlTF+
	58JVFrTwKkVX5tLq0M+3B1oRxyLZcklAWbhCSsmjtbGqVoRZQuYqqTgcoZBKQuSxlwRN+FlN
	VJigbUUeLClzkxw8LgRLufPySOGCIEQImn+riHVxj0Om3q7OipWp/oFMUZru4lB03lBTetXr
	68nHrPaJ6RzHsup1haYTqpX7HAa1Zj6lqGq9refJQKK1NFQ/sTcQ++fZxo5P3K9sdlvuftKz
	c/er4P0uswdP15eHx5e76SQ3r4ZaMkbvjVe+8f700L5TkdjHVW/XDbQEfQs9pPdV4RYfm4zU
	KuRbfQmNVv4H/fhXyyYDAAA=
X-CFilter-Loop: Reflected

On Thu, Jul 10, 2025 at 11:35:33AM -0700, Mina Almasry wrote:
> On Thu, Jul 10, 2025 at 1:28 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > Hi all,
> >
> > The MM subsystem is trying to reduce struct page to a single pointer.
> > See the following link for your information:
> >
> >    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> >
> > The first step towards that is splitting struct page by its individual
> > users, as has already been done with folio and slab.  This patchset does
> > that for page pool.
> >
> > Matthew Wilcox tried and stopped the same work, you can see in:
> >
> >    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> >
> > I focused on removing the page pool members in struct page this time,
> > not moving the allocation code of page pool from net to mm.  It can be
> > done later if needed.
> >
> > The final patch removing the page pool fields will be posted once all
> > the converting of page to netmem are done:
> >
> >    1. converting use of the pp fields in struct page in prueth_swdata.
> >    2. converting use of the pp fields in struct page in freescale driver.
> >
> > For our discussion, I'm sharing what the final patch looks like, in this
> > cover letter.
> >
> >         Byungchul
> > --8<--
> > commit 1847d9890f798456b21ccb27aac7545303048492
> > Author: Byungchul Park <byungchul@sk.com>
> > Date:   Wed May 28 20:44:55 2025 +0900
> >
> >     mm, netmem: remove the page pool members in struct page
> >
> >     Now that all the users of the page pool members in struct page have been
> >     gone, the members can be removed from struct page.
> >
> >     However, since struct netmem_desc still uses the space in struct page,
> >     the important offsets should be checked properly, until struct
> >     netmem_desc has its own instance from slab.
> >
> >     Remove the page pool members in struct page and modify static checkers
> >     for the offsets.
> >
> >     Signed-off-by: Byungchul Park <byungchul@sk.com>
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 32ba5126e221..db2fe0d0ebbf 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -120,17 +120,6 @@ struct page {
> >                          */
> >                         unsigned long private;
> >                 };
> > -               struct {        /* page_pool used by netstack */
> > -                       /**
> > -                        * @pp_magic: magic value to avoid recycling non
> > -                        * page_pool allocated pages.
> > -                        */
> > -                       unsigned long pp_magic;
> > -                       struct page_pool *pp;
> > -                       unsigned long _pp_mapping_pad;
> > -                       unsigned long dma_addr;
> > -                       atomic_long_t pp_ref_count;
> > -               };
> >                 struct {        /* Tail pages of compound page */
> >                         unsigned long compound_head;    /* Bit zero is set */
> >                 };
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 8f354ae7d5c3..3414f184d018 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -42,11 +42,8 @@ struct netmem_desc {
> >         static_assert(offsetof(struct page, pg) == \
> >                       offsetof(struct netmem_desc, desc))
> >  NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
> > -NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
> > -NETMEM_DESC_ASSERT_OFFSET(pp, pp);
> > -NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
> > -NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
> > -NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> > +NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic);
> > +NETMEM_DESC_ASSERT_OFFSET(mapping, _pp_mapping_pad);
> >  #undef NETMEM_DESC_ASSERT_OFFSET
> >
> >  /*
> 
> 
> Can you remove the above patch/diff from the cover letter?

I added the diff for those who might get lost due to the lack of the
final patch.  However, sure, I will remove it.

	Byungchul

> --
> Thanks,
> Mina

