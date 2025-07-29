Return-Path: <bpf+bounces-64574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F92B14591
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF95E3BC0B5
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B959619B5B1;
	Tue, 29 Jul 2025 01:09:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061517A2E0;
	Tue, 29 Jul 2025 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751368; cv=none; b=dCLPvcKqdc+uFoeQJQHSH399Y8WkTxTfWlmRdCqZPCuNP9Ffx3fR1lBw7GRRdXplPYmc/gFqqI3pMEPuEtpRHx2WOajx9Ep+gT77gRYFVMIIEgElufcLpGegd6ejAzd7XNTLxYlogqJDkjpfmAyF7T/zrYXOomWFqf32JSv5Xuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751368; c=relaxed/simple;
	bh=Qx+SZKAe5e3AuZnFZZmZAutyGTlZrZ+pt380AJBmqMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6UZKn9OuKUtvzD/CUuRYD6p1nu3yvPIpt7Nd1ewtYzaAIpi/C/NmZVNZ+qhkxxvSBOpzKKcEBEaJ2/0roFRaQfj9jGLWR/T/caZvu6aLRMoOcFpW82q7hjQZU/yJUHWGofzZQCzUg5Eq/RJEUTvXTW7xK/opZBUww9xwaBCO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-05-68881e0fb1f4
Date: Tue, 29 Jul 2025 10:04:10 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
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
Message-ID: <20250729010410.GC56089@system.software.com>
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
 <CAHS8izO6t0euQcNyhxXKPbrV7BZ1MfuMjrQiqKr-Y68t5XCGaA@mail.gmail.com>
 <da4a9efd-64b3-4dc5-a613-b73e17f160d6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da4a9efd-64b3-4dc5-a613-b73e17f160d6@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+fadnXMcGx2X1ZcGwSoKK7sZvd2FCL7+CKIiKimdeWgjN23L
	WxCsklzS7E41V6yrt9CYTrdKq2leKszMalnN0gyqaaYmmtJlSuR/D8/7Ps/v/ePlsfKJNJTX
	6veJBr06QcXKGFmn/MrcqKlmzfzCIh5sxTdZKBxIg9z3LinYCsoQ9A2+4eB3RQ2C3upaFr5W
	9SC4erkfg+1pBgM/in9i6Khp46DQsR5ab3xi4G5mOYa243UsWDKGMFQMdnFwyJUnAVuJiYPG
	smwpnPl5HUO56T0Hz2/bWPDd/C2FTx4LA/XWfAa6z1ZjaM2Oghr7ROh/7EdQXVwugf5jF1l4
	ceG2BE432Vloz2hF0FTVxsDZYTMLOQezEQwN/G3rOtEnhZyHPi4qnFb5v2Famv9aQr2VjyTU
	bX3HUbsjmZbkhdMsbxOmjoKjLHX0nOLo25d3WVp3foih7g9LqdvVK6GWw10s/d7RwtBvlS/Y
	DeO3y1bEiwnaFNEwb1WsTHPN1oKTLgenHTRtNaHP8iwUxBMhknR21EuzED+in91RBWxGmEFK
	T/q4gGaFmcTrHcQBHSLMJl9feUZ8LFzlyCVfaCA6XthBbt1bHrAVAhBnpp/NQjJeKbQh4vxw
	Do8Ogkn9hY/MaHYmGb7UhANZLISR3F/8qD2VHHbmjKwHCSvJvc6GEdQEYRq5X1YrCXQSwc8T
	93GXdPT8yeRBnpc5gYKtYxDWMQjrf4R1DMKOmAKk1OpTdGptQmSEJl2vTYvYlahzoL8/duPA
	cLQL9TRu8iCBRyq5QnM0U6OUqlOM6ToPIjxWhSiSrh/RKBXx6vT9oiExxpCcIBo9KIxnVJMU
	C/tT45XCbvU+cY8oJomGf1MJHxRqQlfOtXq2RKNVO0tjYsmSrQfOGLTr/C1F5m5z5LLzubO+
	x22bXueWR5sXJes25y9wr16stMylMX3+qF2xDRsLyn2vS1KNAxGKZiZsXu/CWrtuy9rUVw1r
	dhO1fm9qtzOZzpHHPdieZAlZMeWx/JY8DoaNXzLtRbi5tn2Ts3FcRruKMWrUC8Kxwaj+A1Z8
	W4FfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRjF++9/d+91trquVRfNglUISpZQ8ITa64f+RUnUhywKveatDafJ
	pqJBMFOyJM1ezJxTNFPzhazp1JllTFNX0MvEMis1UykyzTTJlKwpkd8O5zzn93w5LFbckbqz
	mqgYURclaFW0jJIF+SetW7zyvHrDWDIDpsoKGsp/xkNJb50UTGU1CMYn3zIw86AFwVhzKw1f
	mr4jKCyYwGB6nkzBj8pfGAZa+hgoN++DnuJBChpSajH0XWqjIS15CsODyWEGztbdloCpysBA
	U65dCi9q0qVw7VcRhlpDLwPt9SYauitmpDBoS6PAbiyl4FtmM4ae9G3Qkr8MJp4OIWiurJXA
	xMVcGjqy6yVw1ZFPw8fkHgSOpj4KMqfP05CTmI5g6udf2nDGuBRyHncz23xI09AIJtWlbySk
	8+ETCbEa3zMk3xxLqm57k9ROBybmsgs0MX+/wpB3rxpo0nZjiiLWD5uJtW5MQtKShmkyOtBF
	kZGHHfR+5RFZQLio1cSJuvVbQmXqW6YuHF3gFp9oCDagzwtTEcvy3Eb+5X1VKnJhKW4tX325
	m3FqmvPiOzsnsVMrOR/+y2vbrI+5QobP63Z3Vpdwx/i7jf5OW84Bb0kZolORjFVwfYi3fMjC
	c4Ebb8/up+a6Xvx0ngM7u5jz4Et+s3P2Kj7JkjN77sIF8o1fn82+Wsqt5h/VtEoy0CLjPJJx
	Hsn4n2ScR8pHVBlSaqLiIgWNdpOvPkKdEKWJ9z1+KtKM/q6o+Mz05To03r7LhjgWqRbK1RdS
	1AqpEKdPiLQhnsUqpTy66JxaIQ8XEk6LulMhulitqLchD5ZSLZfvOSSGKriTQowYIYrRou5f
	KmFd3A2o9VOaSnC94Tq5prQ+cve5PR8/b5db7nr6p99bfszuvT/pemDwgsBvJ+lRVOw5EbPC
	33LaviPFb9eLWFJ4lBv/6jq9M9RSrY0LSvyddbCW9TiwNSbTb2w0I6T95czZfnZksVVpL7L6
	7pC77T0shJWvXR1wYupefcnNyg4HExaQ7fJYRenVgp831umFP0DnRSdBAwAA
X-CFilter-Loop: Reflected

On Mon, Jul 28, 2025 at 07:49:30PM +0100, Pavel Begunkov wrote:
> On 7/28/25 19:39, Mina Almasry wrote:
> > On Mon, Jul 28, 2025 at 11:35 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> > > 
> > > On 7/28/25 06:27, Byungchul Park wrote:
> > > > Changes from v1:
> > > >        1. Rebase on linux-next.
> > > 
> > > net-next is closed, looks like until August 11.
> > > 
> > > >        2. Initialize net_iov->pp = NULL when allocating net_iov in
> > > >           net_devmem_bind_dmabuf() and io_zcrx_create_area().
> > > >        3. Use ->pp for net_iov to identify if it's pp rather than
> > > >           always consider net_iov as pp.
> > > >        4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> > > 
> > > Oops, looks you killed my suggested-by tag now. Since it's still
> > > pretty much my diff spliced with David's suggestions, maybe
> > > Co-developed-by sounds more appropriate. Even more so goes for
> > > the second patch getting rid of __netmem_clear_lsb().
> > > 
> > > Looks fine, just one comment below.
> > > 
> > > ...> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> > > > index 100b75ab1e64..34634552cf74 100644
> > > > --- a/io_uring/zcrx.c
> > > > +++ b/io_uring/zcrx.c
> > > > @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
> > > >                area->freelist[i] = i;
> > > >                atomic_set(&area->user_refs[i], 0);
> > > >                niov->type = NET_IOV_IOURING;
> > > > +             niov->pp = NULL;
> > > 
> > > It's zero initialised, you don't need it.
> > > 
> > 
> > This may be my bad since I said we should check if it's 0 initialized.
> > 
> > It looks like on the devmem side as well we kvmalloc_array the niovs,
> > and if I'm checking through the helpers right, kvmalloc_array does
> > 0-initialize indeed.
> 
> I wouldn't rely on that, it's just for zcrx I do:
> 
> kvmalloc_array(...,  GFP_KERNEL | __GFP_ZERO);

For net_devmem_bind_dmabuf(), __GFP_ZERO will add bigger overhead than
just assignment, 'niov->pp = NULL'.

I'd like to ask you if you are still good with __GFP_ZERO overhead
before going ahead.

	Byungchul

> 
> --
> Pavel Begunkov

