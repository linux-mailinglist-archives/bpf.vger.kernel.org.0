Return-Path: <bpf+bounces-64571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA542B14576
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 02:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884147A9A88
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 00:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EAE17A316;
	Tue, 29 Jul 2025 00:54:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F88488;
	Tue, 29 Jul 2025 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753750440; cv=none; b=WCT2FWnenMiw6iQD44nl+5Wqi1GazWPo7cFiOFujm94dFdggce31DDiITCgmIbFrdSV4S7BegMhrSFtRIiBwXe/5PO19emlR11w7mQkfA8K4dJSkN0azgchC0+bw009LX2puPx4xR4prgnOTw7fqaIN+J2ZEN9R2Sc6QbJUDgM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753750440; c=relaxed/simple;
	bh=jj7uWA/8hk6DmMO4+cp9fpPG546SRyAWHd5JKeNiZo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLSJJaG23wU2sMDUkwYoUUwgT6S4R2irSY4eSsfMVZ01HDD2lTiaIbr0nEHwb5qkSA4JgFh0Ch8xL7YIdKHpfeXdx4UejLkVdAbq5nsM+x6lk5YSx3Izg2LDTw81Ou1vEEWOm6xybTtjxvATFvRxPqqPntNbs/qihp3/4JcCyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fd-68881ba231f0
Date: Tue, 29 Jul 2025 09:53:48 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
	pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	toke@redhat.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page
 pool in page type
Message-ID: <20250729005348.GB56089@system.software.com>
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
 <CAHS8izO6t0euQcNyhxXKPbrV7BZ1MfuMjrQiqKr-Y68t5XCGaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO6t0euQcNyhxXKPbrV7BZ1MfuMjrQiqKr-Y68t5XCGaA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvXOnM0OlZCgoV4lBq8QI7vHhuMTlQb0xajQa4xIjjUxsIyAW
	RTAxKdIIEltco5ZKcEE2tabsClTL6gqpYOoKIsVEEBWEgDQqlRh5+/Of//zfeTgCVj6XTRa0
	MYckXYw6SsXJWfkX36tzrgWnauZbW/3BYr3FQcFgAuS0lcnAkl+C4MfQGx5+V9Yh6Kup56Cr
	uhfB9asDGCyNBhb6rT8xuOvaeSiwbYDWm50sVKSUYmhPb+DAaBjGUDnUw8PxslwGLIV6HppK
	TDI4/zMbQ6m+jYcX9ywcvL/1WwadDiMLj8x5LHy7UIOh1bQS6rImwsCTbgQ11lIGBk5d4aDl
	8j0GzjmzOPhoaEXgrG5n4YInlYOMJBOC4cGRtp7TP2SQUfueXxlGq7u/YlqU94qhrqrHDC03
	v+Nplu0wLcwNo2kuJ6a2/JMctfWe5enblxUcbbg0zNLyD4tpeVkfQ43JPRz97n7N0q9VLdym
	gJ3yZZFSlDZe0s1bHiHXeO4M87H9fgnJjalYjzLHpyEfgYiLSJunn/unG5pPYK9mxVDiND3j
	vZoTZxKXa+ivHyjOIjeqzsjSkFzAYjZPKuxGlIYEIUDcTe7al3ozChHI/a5PvDejFK2IDDXk
	4NGBP3l0uYP1ajxS6sl0Yu8uFoNJzi9h1A4hycUZf20fcTO5fT7Aa08Qp5MHJfWMt5KI3QJp
	e/BONnrzJPIw18WeRv7mMQTzGIL5P8E8hpCF2Hyk1MbER6u1UYvmahJjtAlz9x6ItqGRL7t5
	zLOrDPU2bXEgUUAqX4XmZIpGKVPHxyVGOxARsCpQEZt9QqNURKoTj0q6A3t0h6OkOAcKFlhV
	kGLhwJFIpbhPfUjaL0mxku7flBF8JuvRjlX7hPQWu5/7WAobmGBJ6viuiHhKPIIDO1pCL7rp
	3fVdiutHloTPnng0opmuydg6Yxze9KtzfVfRt+0d00x7TGtDQjZveR1UHz3VVfvZTz/YbFxT
	vHqafYqiuijo7UtNX1hoXQ6T7Ybi3WftBwv9fFfYN64y7Ej/TGoN67YlhavYOI16QRjWxan/
	AEcuyGVhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/19f/f7/TqOnyv81AxnClGefcis+cd3nlbzh7GZbvrN3fRw
	u6tb2VBKzk1HZLguMup6wLVDXY90JcVa3MkiijzN2IUe9DTpmOm/917v9+f114fD8lKJP6eO
	SxC1ccoYBSOlpTvC0pZeDTColpV8CgOL7QYDJYNJYH3jkICluAxB31AHC2M1jQh6Gx4y8KX+
	B4JrVwcwWFrTaei3DWP40NjNQol9O3QVfKSh+kQ5hu7TTQxkpo9gqBnysHDMUUiB5XYKC/W5
	zRJ4UmaSQPZwPobylDcsuCstDHTeGJPAR2cmDc3mIhq+nW/A0GUKh8a8GTDw+CuCBls5BQOn
	chlou1RJwTlXHgPv0rsQuOq7aTg/amAgJ9WEYGRw3OY50yeBnAedbHgwqf/ag8mdohcUaa99
	RJEK82uW5NkTye3CxcTY7sLEXnySIfYfZ1ny6nk1Q5oujtCk4u06UuHopUhmmoch3z+8pElP
	bRsT4bdHuiFajFHrRW3oxiipavTWCKvpn5KU1mrAKejyJCPy4QR+ldD0LAN7M80vEFymFtab
	GT5IaG8f+sP9+EXC9dosiRFJOczns0L1vUxkRBzny+8VSu+FeTcyHoSqL59Y70bO25Aw1GTF
	f4tpQvOl97Q343Hp6GUX9t5iPkCw/uL+4jlC2t2cP9iHjxRuZvt68XR+vnC/7CF1Bk0xTxCZ
	J4jM/0XmCaI8RBcjP3WcPlapjlkdojuoSo5TJ4Xsj4+1o/E/Kjg8muVAfe7NTsRzSDFZpjp5
	QiWXKPW65FgnEjis8JNp8jNUclm0MvmQqI3fp02MEXVOFMDRipmyLbvEKDl/QJkgHhRFjaj9
	11Kcj38Kuha0RPN0paeoOHtqQem2uo7ywvSFvQ8iTkdaXNZUeDs5sEMxq8rtvFJ74YjhuH6t
	9WcN9G9SzYsQs9a0Dkd6tlaFJkKdvmcFhzU2yqKgf+3Gn7emboienV0Z3hLo7iiLeuE796ih
	IJ6a8Yiw603Xc1t3Ooxu09z14XdjUfBZBa1TKZcvxlqd8jfKgS4ZQwMAAA==
X-CFilter-Loop: Reflected

On Mon, Jul 28, 2025 at 11:39:52AM -0700, Mina Almasry wrote:
> On Mon, Jul 28, 2025 at 11:35 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >
> > On 7/28/25 06:27, Byungchul Park wrote:
> > > Changes from v1:
> > >       1. Rebase on linux-next.
> >
> > net-next is closed, looks like until August 11.
> >
> > >       2. Initialize net_iov->pp = NULL when allocating net_iov in
> > >          net_devmem_bind_dmabuf() and io_zcrx_create_area().
> > >       3. Use ->pp for net_iov to identify if it's pp rather than
> > >          always consider net_iov as pp.
> > >       4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> >
> > Oops, looks you killed my suggested-by tag now. Since it's still
> > pretty much my diff spliced with David's suggestions, maybe
> > Co-developed-by sounds more appropriate. Even more so goes for
> > the second patch getting rid of __netmem_clear_lsb().
> >
> > Looks fine, just one comment below.
> >
> > ...> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> > > index 100b75ab1e64..34634552cf74 100644
> > > --- a/io_uring/zcrx.c
> > > +++ b/io_uring/zcrx.c
> > > @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
> > >               area->freelist[i] = i;
> > >               atomic_set(&area->user_refs[i], 0);
> > >               niov->type = NET_IOV_IOURING;
> > > +             niov->pp = NULL;
> >
> > It's zero initialised, you don't need it.
> >
> 
> This may be my bad since I said we should check if it's 0 initialized.

I thought you wanted to explicitly initialize it in the user sides, but
seems not.  Okay, I won't include the explicit initialization from the
next.

	Byungchul

> It looks like on the devmem side as well we kvmalloc_array the niovs,
> and if I'm checking through the helpers right, kvmalloc_array does
> 0-initialize indeed.
> 
> --
> Thanks,
> Mina

