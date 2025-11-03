Return-Path: <bpf+bounces-73346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C328C2BBFD
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 13:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEBF034AC2D
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886253101A3;
	Mon,  3 Nov 2025 12:39:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252D30E856;
	Mon,  3 Nov 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173596; cv=none; b=KycNY/takeSRYqIxmF7ujkW3qTGgsgTpH7eriYjnziVoT2w09pTD5a85HckBFwU9+HaqrmWuzKYv+SDkt6qUpeEuaW37ynkzeleR1+qm3lqV49+MXs/EuN9rjQ5tvP6PnOpsWy2ZSE1xHP/OS+O7Mc6AX/luLYz5X/0BGQayXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173596; c=relaxed/simple;
	bh=NahZnGHbeWb05O39co6q17AfcLe2V4xIORGRnSkMmng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWSl7DoTCAVl50Rs5TRBOi21lhb8w6KR8/7sNUdWd4kfUvHK/i6JU6oyjyGbaVwhWJr8lAYEWZyqF33h9G4cefSI0Z5Xla9seJA/upGPaeh1QkLAnH0iXJVB+RChxqxJGNNgoup7e4rtYUzEVXLnGWOLjSL8Sxe961qZ+glGB3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-34-6908a293b816
Date: Mon, 3 Nov 2025 21:39:42 +0900
From: Byungchul Park <byungchul@sk.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v5 2/2] mm: introduce a new page type for page pool in
 page type
Message-ID: <20251103123942.GA64460@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-3-byungchul@sk.com>
 <87jz07pajq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jz07pajq.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTYRSF889MZ6YNjUNF+BETTV3jAm6J17ihUfMb18QHN6I2MtLGAqYo
	glGDiFsVXJBIC8aqEShCwCq0JWKUHdwIbjXK6oJBrMhSqahIUSNvJ+eee777cHla0SIZyWsi
	9oi6CJVWycoY2WevK9OSr/Ka6dn1AOl5OSzc6I2BzCabBNw5rRSkZxci6Ha/5qC/uAJBV1kl
	C59KOxFcu+KiIf1JAgM9ed9psBe1ImhLzWXhfUULBzcsq6Ex4wMDd45baWg5U8VCYkIfDcVu
	JwfxtqyB4ltxHNQWJkngwvfrNFjjmjh4WpTOQkNOvwQ+lCQyUG00M9CRUkZDY1IwVJh8wfWg
	HUFZnpUC1+lLLDw3FFFQUPycg+Q6EwtvExoR1JW2MJDy4wQLaYeTEPT1DlQ6z3ZLIK28gQsO
	JIcdDpaUtn+hyW3zK4q8SD3HEMfdGorYjfUcMVn2kltZk4neUUcTS/ZJllg6z3PkzYs7LKlK
	7WOIvXkusdu6KJJ4xMmuG7FZNj9U1GqiRV3Qwu0ydZU1hdr9zSum9ls5E4ceyvRIymNhNnYd
	raD+6fziR4xHM8I4XJ/slng0K0zEDoeb1iOe9xEW4we9YXok42nByeH+3FbakxkubMBfHA2D
	ebkA2PrSPOgrhAO4sib5r++Nqw3vBvtpYSq2F7xhPZ20EIAzf/F/7NH4SEHa4KpUGI8NJz8i
	jx4hjMX3CispDxcLp6S4tLof/bnZH9/PcjBnkbdxCMI4BGH8jzAOQZgQk40UmojocJVGOztQ
	HRuhiQncERluQQOfl3HwxxYb6qxdX4IEHim95MTEaxQSVXRUbHgJwjyt9JHrYwcseagqdr+o
	i9ym26sVo0pQAM8o/eQzXftCFUKYao+4SxR3i7p/U4qXjoxDqcPjQfGoZ9W7sDX2Cf7SkHy/
	jWE7V+Z68eruoI9PfZucSm/X8qZ7ywzP2uMv7njML22OH2OZsmBYUChp65nVnZ9wLPhyuXvt
	z3kHTDcNZ6Y0H1tBxr6SjcpcpN3I+EWqAzLaQoT9VujYfKhvyaY5XZO2mv3R15fRD9dytnPl
	HZfMSiZKrZoxmdZFqX4DHLABhHUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03SbUxTZxQH8Dz3eXrvpVp3ZahXCdHVt4woSjLMmRqjwcQnJho/LBr9InXe
	0AYoplVCF02qEJ2NrSI2QqlaNQMpNZAilHZ0cYC86BYZBFdUwDEtBpQaxUoBRYoa+fbP/5zz
	+3R4HNskW8RrtIclnVaVqWTlRL5zQ97qwmu8Zm2o+juwV7pYqBjNhbIndTKIuAYYsDtrEYxE
	HnEw6W9G8KaphYWhxtcIrl8NY7DfzyfwtnIMg9c3gGCw6CYLz5r7Oahw74C+0iCB+lMeDP1n
	W1kw549j8EeGOThRd2MKrjZy0HipTQbttRYZXBj7DYPH+ISDTp+dhV7XpAyCDWYCbbZyAq+s
	TRj6LJuh2TEfwvdeIGiq9DAQPnOJha5iHwM1/i4OCjscLPyf34ego7GfgHXiVxZKjlsQjI9O
	kcPnRmRQcqeX27yGHg8EWNr4IoTprfJuhj4oKiA08MddhnptPRx1uI/Q6huJ1BTowNTtPM1S
	9+vzHH38oJ6lrUXjhHr/+5F6694w1Jw3zO6av0++8aCUqcmRdGs2pcnVrR4rc+jd7Nz2d3eI
	Ef0lN6EYXhR+EKv8f5NoJsIysacwIotmVlgpBgIRbEI8HydsEe+NppuQnMfCMCdO3hzA0Z1v
	hT1iKNA7va8QQPT8Wz7dxwpHxZa7hZ/7uWJb8dNpHwurRG/NYzZqYiFeLPvAf6oXi3k1JdOn
	McJysfj0cxTN84Sl4u3aFuYcmmObIdlmSLavkm2G5EDEieI02pwslSYzJUmfoTZoNblJP2dn
	udHUb5UemyioQyOd2xqQwCPlbAV18JpYmSpHb8hqQCKPlXEKk2GqUhxUGX6RdNn7dUcyJX0D
	iueJcoFi+x4pLVZIVx2WMiTpkKT7MmX4mEVGlFyG1+/NGNiuujbIXCcPLXbmxIr3Pun7Hlib
	fLFr1jfGKlKfcGVw6M9S24RBedSdVKH90Hbx/SnfyytVJ0vMY/7E+suzxteHljjM/2wLLnT5
	f3rqSt/6Momk7A6tWubcZbds3RhUr1waVIc749bdTrP+viI1q5saH6U4w6kJ1gNKolerkhOx
	Tq/6CMKBWTFXAwAA
X-CFilter-Loop: Reflected

On Mon, Nov 03, 2025 at 01:26:01PM +0100, Toke Høiland-Jørgensen wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> > determine if a page belongs to a page pool.  However, with the planned
> > removal of ->pp_magic, we should instead leverage the page_type in
> > struct page, such as PGTY_netpp, for this purpose.
> >
> > Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> > and __ClearPageNetpp() instead, and remove the existing APIs accessing
> > ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> > netmem_clear_pp_magic().
> >
> > This work was inspired by the following link:
> >
> > [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >
> > While at it, move the sanity check for page pool to on free.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Zi Yan <ziy@nvidia.com>
> > Acked-by: Mina Almasry <almasrymina@google.com>
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> IIUC, this will allow us to move the PP-specific fields out of struct
> page entirely at some point, right? What are the steps needed to get to
> that point after this?

Yes, it'd be almost done once this set gets merged :-)

Will check if I can safely remove pp fields from struct page, and do it!

	Byungchul
> 
> -Toke

