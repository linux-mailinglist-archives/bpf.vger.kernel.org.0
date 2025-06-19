Return-Path: <bpf+bounces-61073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE09AE02E1
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C78A4A1301
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06A224AF7;
	Thu, 19 Jun 2025 10:42:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4922422A;
	Thu, 19 Jun 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329740; cv=none; b=Fl3/KWUc/J2ilj+gNqeiU2NwEUuKP3g7CQcBSVObuJ0ro0tS3/9eWLT/CAjIf2RcPSlcDsQL7tDdqmLlyU7eOOJhgC5FP+Y8mM0YMUAIrQKGLw9PsbHQh5uuFaDRitR3o4oDd5xrq2Wr6d6jrTYDx6aqbXX7VDuzenepRpCBwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329740; c=relaxed/simple;
	bh=PK8spaztoIPzTEypHSSLTmUWzHXd0Q2JeodXfvrTmZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWqTLkGD9LPoJ+5YD0oGhDyXDLpZjfQmJR1gA/Qt5LOjiShWfxPTensRZsKor1hkC7HJY/UipK4i9psF9RAA4d/QNp98rI7ppudTFJFBuWMJZ36x2PkRzOWDgGWHlWeL4VpA8U4l2dXgidD2fyxS0gtZRYkwXohVBQ6Un99ywRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-20-6853e9833638
Date: Thu, 19 Jun 2025 19:42:06 +0900
From: Byungchul Park <byungchul@sk.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, horms@kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH net-next 9/9] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
Message-ID: <20250619104206.GA37590@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-10-byungchul@sk.com>
 <18ee4f16-0885-45f4-bea6-c025a1a0b969@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ee4f16-0885-45f4-bea6-c025a1a0b969@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXcuOw4Hx2X2qlS4CsFyaUg+UYnQl+OHLihRVFArT23kjalL
	hUhzJI68F+hcMTHnJWMxS7e8X1K7kGZp81KKpRRd1Czz2uVokd9+/P8Pz+/58DCErIjyYNRR
	cbwmShkhpyWk5LNzkW/qhzCV38eBADBaKmm4PZsApSM2CowV1Qi+zQ2KYbqtg4biohkCjF06
	Er5b5gkYax8Vw7B5nIS6tBoCRrM6acjQLRBw2VYmgu7qTAquzZcQUJM8IoYXD4w0vKn8RcF4
	SwYJjwzlJAxnBkO7yQ1mnnxC0GapEcHM1Rs05PWYaHirG0bQ0zpKQmFKJgJLg4OChVkjHezF
	3SvvF3F2w2sxZ7LGc1VlPpze0UNw1op0mrN+zRVzQ311NNeZv0Bydtu0iMtI/UJzU2MDJDfR
	0Etzlnu9JPfU1Cbmpq0bDrHHJHvC+Qi1ltdsDzolUU1W+sfMOSfYSxyiZGSW6BHDYDYAN+f4
	6JHTMk5U9SMhJtkt+E7PViGmWW/scMwRAruym/Ho3YeUHkkYgh2jcE5vHy0Ua9h4nNaVLRZY
	ygJ+1ZgrFoZkbB7C16+b/xYu+FHBO1Jggt2G7feHaEFGsJ649CezEm/EqfcLl2VO7G6cf+cn
	JfBadhNuqu4QCTsxa2NwVpMdrRztjpvLHGQ2cjGsUhhWKQz/FYZVChMiK5BMHaWNVKojAhSq
	xCh1guJMdKQV/Xkc88XF4zb0tTusBbEMkjtLgytCVTJKqY1NjGxBmCHkrtLizgMqmTRcmZjE
	a6JPauIj+NgW5MmQ8nXSHTMXwmXsOWUcf57nY3jNv1bEOHkko7gjngrXlMeDWm3zpZ1l733r
	zS7X1ocMbUgfqteHRKbd3l65lKl181ty9r6S++xmQluf7dCPoNkO+2KtwpI/2Xm09YS/W61m
	yvhSkX/WFlrwI3rjwY9Lhqa4Xe7Nk/xhXSBvvfU8x+tTYNLpgv37BvvlpkZdjWwwxxxf4NQV
	OGfeKydjVUp/H0ITq/wNMyeRczQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRiGeb+zo8Xn0nytH9UqCitrZfBEp/2I/JKSMigIoo38aEOdtqVo
	FHgKS9KOks0NVqvlsYWnzTITtdQyXIpulTWZGgVRliXqKmsdyH8X9/1w3X8ejpSdoudxWt0x
	Ua9TJ8oZCSWJ3ZizKufdXs2a95WLwGSvZKBiIh1uDTppMJXXI/gy+ZKFsbZ2BqzXxkkwdedS
	8NU+RcLIIx8LXtsbChrzHCT4znUwUJDrJyHbWUpAq7mTBld9IQ2Xp26S4MgcZKH3romB15XT
	NLxpKaCg01hGgbdQCY8sc2H8yXsEbXYHAeNnzQxc6rEwMJTrRdDT6qOgJKsQgb3JQ4N/wsQo
	5UJt2XNCaDC+YgVLdapQUxoh5Ht6SKG6/AwjVH++yAoD/Y2M0FHsp4QG5xghFOR8YIRPIy8o
	4WNTHyNY344Sgr22jxK6LG3s7uADkk3xYqI2TdSv3qKSaEYrFSmTs9IbbnqITGST5KMgDvNR
	+GPNc5SPOI7il+KqnhWBmOGXYY9nkgxwCL8E++48pPORhCP5ERpf6OtnAsUcPhXndZ9nAyzl
	AbsfXGQDRzL+EsJFRba/RTDuvDpMBZjkV+KGugEmMEby8/GtH9yfeAHOqSv5PRbEb8TFVT/o
	AIfyi3FzfTtxHs02zjAZZ5iM/03GGSYLospRiFaXlqTWJq6PNCRoMnTa9MjDyUnV6Ndz2E5+
	u+BEX3qjWxDPIfksqbI8TiOj1WmGjKQWhDlSHiK1dsRqZNJ4dcZxUZ98SJ+aKBpa0HyOkodJ
	Y/aLKhl/RH1MTBDFFFH/ryW4oHmZaPtsxQG5ubdu81D3cOY+q7LjSrLrnsqtXXh/yFWAq+5a
	le6xPdM7ksIGzvqebg0/vdyStTP7hCx0264u52ju2sN+b3p4XIzbHHVj4Pr40fDJhy6vz5m2
	xK+omBiOqSjbr2xr1m/Y6TQnE9NZ0sd5ju/RQ6oPZfrbcsO6g8/ImlA5ZdCoFRGk3qD+CWyb
	nz4YAwAA
X-CFilter-Loop: Reflected

On Thu, Jun 19, 2025 at 11:55:03AM +0200, Vlastimil Babka wrote:
> On 6/9/25 06:32, Byungchul Park wrote:
> > To simplify struct page, the effort to separate its own descriptor from
> > struct page is required and the work for page pool is on going.
> >
> > To achieve that, all the code should avoid directly accessing page pool
> > members of struct page.
> >
> > Access ->pp_magic through struct netmem_desc instead of directly
> > accessing it through struct page in page_pool_page_is_pp().  Plus, move
> > page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> > without header dependency issue.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> I'm not that worried about the new include as it's for a .c file and not
> between .h files.
> 
> > ---
> >  include/linux/mm.h   | 12 ------------
> >  include/net/netmem.h | 14 ++++++++++++++
> >  mm/page_alloc.c      |  1 +
> >  3 files changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index e51dba8398f7..f23560853447 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >   */
> >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> 
> Do you plan to move also all these PP_ constants/macros (bunch more above
> this one) to a net header?

No, but it should.  I will consider it too.  Thanks.

	Byungchul

> 
> Thanks,
> Vlastimil
> 

