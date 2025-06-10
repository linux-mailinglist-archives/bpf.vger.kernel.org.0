Return-Path: <bpf+bounces-60129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C3BAD2B56
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 03:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BF51891E47
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF701A5BBC;
	Tue, 10 Jun 2025 01:30:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE2D2F85B;
	Tue, 10 Jun 2025 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749519015; cv=none; b=iau+HvnoKNsA3byvYtGS53BP+Q7IQNZVkiQa3/tGYSzloXao3BnXUBFPNMiuhDl0BcJj3sYs9Uu9aIN8EFkINPxbbSHf7cZmA03iF0VEtG00Efzgv5ZVsyZO+MskYRMSJlbHQ7VIqTF2G8NbBnMT+N/BQwTzw6vpMjW4T4x2s4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749519015; c=relaxed/simple;
	bh=rdfVK43hbr9jSWpF4zgRCI/MtYOiOVGnh8t30rEKY5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdfuxfbOpLJYdsYOROOTnZ5+bTlrt8JjWZjbfxw7dQdul4MEaZmyJGW5K6hiPmWr2yxLZGyIzTrGsy0Bro/d5bDKEf2kBJgXoXeczPMGkzw8o3o32wdw5K5Avng0h2klHIRYLK8xZ27/5c6VzKEN23glr7i0hhpQalUXXoD+cfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d5-68478a9e01f0
Date: Tue, 10 Jun 2025 10:30:01 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, almasrymina@google.com,
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
	vishal.moola@gmail.com
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250610013001.GA65598@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609123255.18f14000@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SSUwTYRiG+Wem06HS5Lcq/uKSWDEmTQRUDt/BGE86JK7xoFECVBltFQoW
	QdAYQAloI6joQUoNRSM7VAqyiUQrkUVRhKjDJlixxgRBqVQ2t5YYuT15vzdP3sPH0QqDxI/T
	6k4Jep06SsnKGNkXn/z1eYbtmiBxWgYmSxkLpZOJUDhUJwFTSQ2C71N9UnA2t7BwJ99Fg+ll
	GgMTlmkaPj61S2GwwMFAY0YtDfYrrSxkps3QcL6uiILOmiwJ3Ji+S0NtypAUuhtMLLwr+y0B
	hy2TgTZjMQODWVvhqdkXXM9GEDRbailwXb7FwvUuMwsf0gYRdD2xM5CbmoXA0iRKYGbSxG5d
	zVcX91B8vXFAyput8XxVkYo3iF00by25xPLW8Wwp3/+mkeVbb84wfH2dk+IzL4yy/LePvQw/
	1vSa5S3Vrxn+ublZyjutq/bgg7LNkUKUNkHQB26JkGkK3+TTsQ3yxLc5vilIlBkQxxEcTCru
	hRmQtwfHz09RbmbwWjLQP+FhFq8jojhFu3kx9idpVTmMAck4GjskpCO71FNahMNISd8PD8sx
	EPvtNspdUuCLiBR2mNHcYSFpyxlm3ExjFRF/fabcI2i8nBT+4tyxN95AGt7/9FSW4DXkUU2L
	x0NwPkcmLg1J55YuI4+LROYqwsZ5WuM8rfG/1ozoEqTQ6hKi1dqo4ABNkk6bGHAkJtqK/n5I
	wbnZQ3VovHOfDWEOKX3krd3bNAqJOiEuKdqGCEcrF8uL3ZE8Up10RtDHhOvjo4Q4G1rOMcql
	8o2u05EKfEx9SjghCLGC/t+V4rz9UtDxZT2tP46mVqbfDfaFTyHl1+5Q9yucPqqdYrr+6CtU
	MyYbdr67nPqwwauyd0S3Y+9sbPmorpHZmHDSlhvye9HXkBehGWcjrODABwRtyC76QfLLJD+l
	q7s90/FwxdthVeBKFJ8cuv3BC3uQ5OyC3V6bwv3bnN9NHfvz6pce7mzvVTJxGvUGFa2PU/8B
	Dyafdx0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRyG+5/z39lxNTou04NSH9aNhEyp6NfFLl/0YFgSUVBhHvLQhvPS
	pqJGYTrKVl4qlVxTpqHzykhDl4jFFNPMCq/LezPFILS85SUrZ0R9e3jf5/320qRsArvTyoho
	QR3Bq+SUBEtOHkrelafzV3h3vt4PBnM5BWXzcWAatojAUFqNYGahTwzTja8oeJI/R4LhnRbD
	rHmRhNEmuxiGisYw1N2uIcGe3kxBqnaJhCRLMQENuS0ieF+dJoLMxUISahKHxdBRa6BgsPyX
	CMasqRha9CUYhtKOQZPRFeZavyBoNNcQMHcvl4KH7UYKRrRDCNob7Bge30xDYK63iWBp3kAd
	k3PPSj4Q3HP9gJgzVsZwVcWenM7WTnKVpXcornLqgZjr766juOZHS5h7bpkmuNTkCYr7NtqL
	ucn6Lop7Mv6V4MzPujD3xtgoDnI+LzkcKqiUsYJ695EQicLUnU9G1UrjenJcE5FNokNONMvs
	ZaeSFggHY2YbO9A/u8oUs4O12RZIB7swW1ltVQ7WIQlNMmMitu1B2aq0gQlmS/u+r7KUAdZe
	0EI4JBmTglhTmxH9KZzZlpxP2MEk48nafn5ekegV9mBNP2lH7MT4sLUfl1eVjcwW9mX1KyID
	SfX/rfX/rfX/1kZEliIXZURsOK9U7fPShCniI5RxXpcjwyvRyguKrv+4b0EzHf5WxNBIvk7a
	3OGnkIn4WE18uBWxNCl3kZY4ImkoH58gqCMvqWNUgsaKPGgsd5MGnBNCZMwVPloIE4QoQf23
	JWgn90QU7NtB2afva1NmVbO7Ks7M4BfZT8PkrgEZ/WvSfYyfzW/LmNyEpIN73HZM4qXCOt8T
	mePrL27OQhdMqLXTG2418CEBu9dDhXter0mpKyxW89eCAhuODhYErk3xPHtVPS5Yw2YGajbt
	DBrpmcoqM/odrxgvOrV92XzX/0b26QP9cqxR8D6epFrD/wZMmLhnAQMAAA==
X-CFilter-Loop: Reflected

On Mon, Jun 09, 2025 at 12:32:55PM -0700, Jakub Kicinski wrote:
> On Mon,  9 Jun 2025 13:32:17 +0900 Byungchul Park wrote:
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> > 
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, and make it union'ed with the existing fields in struct
> > net_iov, allowing to organize the fields of struct net_iov.
> 
> What's the intended relation between the types?

One thing I'm trying to achieve is to remove pp fields from struct page,
and make network code use struct netmem_desc { pp fields; } instead of
sturc page for that purpose.

The reason why I union'ed it with the existing pp fields in struct
net_iov *temporarily* for now is, to fade out the existing pp fields
from struct net_iov so as to make the final form like:

	strcut net_iov {
		struct netmem_desc desc;

		net_iov_specific_variable_1;
		net_iov_specific_variable_2;
		...
	};

> netmem_ref exists to clearly indicate that memory may not be readable.
> Majority of memory we expect to allocate from page pool must be
> kernel-readable. What's the plan for reading the "single pointer"
> memory within the kernel?
> 
> I think you're approaching this problem from the easiest and least

No, I've never looked for the easiest way.  My bad if there are a better
way to achieve it.  What would you recommend?

> relevant direction. Are you coordinating with David Howells?

It's mm's project driven by Matthew Wilcox but as for page pool part,
I'm working alone.

   https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

	Byungchul

