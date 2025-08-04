Return-Path: <bpf+bounces-64971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDEB199CE
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 03:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF633B2F0F
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 01:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D61E231E;
	Mon,  4 Aug 2025 01:17:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19E94A28;
	Mon,  4 Aug 2025 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270265; cv=none; b=c6oYN7bWqSRhoM0GSTdxibFyvb920h0MCa09n4HINdu5GcZtDo77TWtagmOGen+CHrd/++SiJSbk2Urk0+TzUxAwt1ZUJLR8CoryoLTVOdiuNeRUl7aFdnZus4jJNo1doCdko0qWoAxXlDpIhEFyEhK9LszRRCOtd0Cs24OI0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270265; c=relaxed/simple;
	bh=ZaZhQqQIxHFirOaw7xjj8DtF5xa8nwZa6KWHSiUQ7aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgb4h1ejNE8Br313RoiF//inFltqpUOzAWqFRrS5R8YoHji+TxXhdxGYq9ep2Z1w7N8MhDgwDJyNk3r+HEGtJOPxuqqWGy+nKB7oZTXHiUfq36b1/RlPfAcxjrB2TRgzse0bI0tXQVq2rozcjzBE5CTyucz4MyBWJonF9BcKZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-35-68900a2f40c4
Date: Mon, 4 Aug 2025 10:17:30 +0900
From: Byungchul Park <byungchul@sk.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
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
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
Message-ID: <20250804011730.GB39461@system.software.com>
References: <20250729110210.48313-1-byungchul@sk.com>
 <20250802150746.139a71be@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802150746.139a71be@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTVxjHc97z3mhodqwwj5AsWE0w1BvOhMdIFrNk8fWDiUFjzLZEuvXN
	2ghoCkVwoqBdtjVCmZeopWqRDBGI1aLcJlIKFnAzGDa0IgLjGkVQKzaFEpVilvntl//zP7/n
	+XBErGrkYkRDRpZszNCmqXkFq5iMvLR6raJYv+5xMBbszmoeqoI5cHmwngN7ZS2C6ZnHArxr
	8iJ43dbOw0SrH0FZaQCDvcvMwhvnLIZR75AAVa5tMFA+xsKtn+swDFk7eCg0hzA0zUwJcLS+
	ggF7Tb4A92uLODg1+zuGuvxBAf5utPPQX/2OgzFPIQudtissvDzdhmGgaDN4HZ9C4M/nCNqc
	dQwEjp/noedcIwM3m3oEONnt4GHYPICgu3WIhdNzv/BQUlCEIBScV04VT3NQcqdf2KyRCnw+
	Xmp9/gJLN648YiTf7buM1GB7IkgOl0mqqUiQLL5uLLkqf+Ull/+EIPU9uMVLHWdDrNTw70ap
	of41IxUem+KlV6O97PaorxXJOjnNkC0b136RqtB7zVZhv5PPcdzrw/mogLMgUaRkAx2Z/NKC
	Ihaw/dUcG2aWrKDBaTcXZp7EU59vBofrUURD3SFiQQoRk6sCHXwSEMKdxURPay4MM2FWEqBd
	E5MLb1XkO1rWUMd/yBfRznMjC35MEqjv7VMm7MQkll5+K4bjCJJEWx4+W6hHk+XUXdvOhHdR
	MijS3uvt3Ic7l9KWCh9bjIjtI63tI63tf60D4UqkMmRkp2sNaRvW6HMzDDlrvt+X7kLzP6o8
	b+6beuS/v8ODiIjUkcrdOqtexWmzM3PTPYiKWB2l/PbIfKTUaXMPysZ9e4ymNDnTg2JFVr1E
	uT5wQKciP2iz5L2yvF82/jdlxIiYfIRjK9078sY1Ly8uWhbqMievKv3xyAFh+bjoLtn0JvGE
	nv3KZB/i+nbHm/5J/qvZZDnaZ7T0bi35xHZwa/nOiN+u+SOvefY6/Ss1W+LYM6nNKRd0+LM/
	NDGzEx1xiaPVW1KSDnVnWdff/WksSRcXHTyccq/5WWmZd5eup/Nz60zC2LiazdRrExOwMVP7
	HnS0DcVNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH932+zz3P4+rmIepZ/ru0mkq1Mp/GSuuPntW0/qtZW648dVdH
	upPRT2L9uOFIVi7a6afUsk5xJxp3IpmEVU/icGITIa6bw8hpLf+9P6/P5/X+68Ng30LJSkYV
	lyBo4hRqOSUlpfvC0jZslGYrNw2KEigofUbB08kkeNxjnp9KyhE43d9omKuuRzBR10DBkG0c
	wf0iF4aClnQSfpdOYeivd9Dw1BQJ3Y8GSKi6WoHBoX9HQWb6NIZq9wgNl83FBBSUpdBgK2yU
	wMfyLAncnHqIoSKlh4b2ygIK7M/mJDBgzSSh0fCEhLG8OgzdWRFQb1wOrqZhBHWlFQS4Mgop
	+JRfScCr6k805LYZKehL70bQZnOQkDdzjYI7qVkIpifnK0eynRK489ZOR6znU0WR4m3Do5h/
	+eQrwYtv3hO8xdBF80bTGb6sOIjXiW2YN5Vcp3jT+A2a7/xcRfHvbk+TvKV3G28xTxB8ZtoI
	xf/q7yD3+0dJw2MEtSpR0GzcHi1V1qfr6fhSKsnY3IlTUKpEh7wYjt3KNfyaIT2ZZAO5SWfN
	AqfYNZwourEOMYwfu46rmWZ1SMpg9jnN9XS5aM/NMlbJld3tIzxZxgLXMvRzwfVlj3D3LRXU
	X+7DNeZ/X+jHbBAnzg4Snk7MBnCPZxkP9mJDudovPxbO/dlVXE15A5GNZIZFtmGRbfhvGxEu
	QX6quMRYhUodEqw9qUyOUyUFHz0Va0LzT/PowkyOGTnbd1sRyyD5UtnBGL3SV6JI1CbHWhHH
	YLmf7NCleSSLUSSfFTSnDmvOqAWtFQUwpHyFbM8BIdqXPa5IEE4KQryg+bclGK+VKah2ruZ5
	bmSr9z0yweeDXd87l9NbWdtfvmtHYJGPVYzvsJ94mZcZpba8GNKX7Z1h/I/eszV27bzoOh9p
	tW7x1g2eC3e03q6+9aAyzC1vfm1ekjrkMxpxDE2tXtbVXnWa9u9zQ2jAlTHN9hHK4jwW67hV
	1bRmYunltUmo5GNGiD1YTmqVis1BWKNV/AFarF8GMAMAAA==
X-CFilter-Loop: Reflected

On Sat, Aug 02, 2025 at 03:07:46PM +1000, Stephen Rothwell wrote:
> Hi,
> 
> On Tue, 29 Jul 2025 20:02:10 +0900 Byungchul Park <byungchul@sk.com> wrote:
> >
> > Changes from v2:
> > 	1. Rebase on linux-next as of Jul 29.
> 
> Why are you basing development work in linux-next.  That is a
> constantly rebasing tree.  Please base your work on some stable tree.

Sorry about the confusing.  I misunderstood how to work for patches
based on linux-next.

However, basing on linux-next is still required for this work since more
than one subsystem is involved, and asked by David Hildenbrand:

   https://lore.kernel.org/all/20250728105701.GA21732@system.software.com/

I will base on linux-next and work aiming at either network or mm tree.

	Byungchul

> -- 
> Cheers,
> Stephen Rothwell



