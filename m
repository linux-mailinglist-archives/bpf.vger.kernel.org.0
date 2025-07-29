Return-Path: <bpf+bounces-64570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C77B14571
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 02:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013141AA081F
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 00:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF378170A37;
	Tue, 29 Jul 2025 00:51:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA9382;
	Tue, 29 Jul 2025 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753750279; cv=none; b=eCQ3gBgMIRDqowM0W5odrZZ+apRc5TFOnl5NRhRuk2Gpsukbn5UyfposQMelO7Eby/wOmq5BH7hjS3cQryKqEC4yPL1PWJJCYMBbENPSHwLs09enf3wB91p64yiruqaqQNzP71+EVqu8MHknKxsVz4bXR5A3Dh2Yod58os/5Wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753750279; c=relaxed/simple;
	bh=AMCqaIGiL6plGruravax33DNh3vkktxzRI1hEALZIGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgzq18Z8x4SdKhZsPMkDF2wNCcAQjsltYuIsUZfiTEtt8jV4Aw+/E0PXmNtfAiQO/wPBsM9hA0x60vVAUMYGeCAZ7loHK5NRsKqK6/x0gWElG97nhPSDHHNVAorvG3pyhHsEAslXSs4SxpUbeKc2bV0gixe2AObIV2JpH2AgPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-77-68881afed51a
Date: Tue, 29 Jul 2025 09:51:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
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
	almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page
 pool in page type
Message-ID: <20250729005105.GA56089@system.software.com>
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTYRDH/Xa3u0ulyVo8PuHFFAwRFbwzxiO+mOwL8XzwiNEiG9twppxF
	JChVjnAUBZVSIkigHCaYghQQUMuphkAgYAGFgmKCVpBTLkULMfr2y39mfjMPw5LSCpEzqwwM
	FVSBcn8ZLabE3xwf71x2TlDs6tWuBX3ZExpK5yLBYK0Sgb6kEsH0fD8Dy3XNCKYaW2j42jCJ
	ID9vlgR9u4aCmbIFEkaahxkoNXrDYOFnCmrjTSQMp7XSkKJZJKFufoyBW1VFBOjLYxnoqEwV
	QcZCAQmmWCsDXTV6GgaeLIvgszmFgte6Ygq+ZzaSMJh6DJpzN8LsWxuCxjITAbPJOTR0Z9UQ
	cK8zl4aPmkEEnQ3DFGQuJdCQfTMVweLcH9uYdloE2U0DzDEPvsE2TvIVxb0Eb6l/Q/DVug8M
	n2sM48uLPPgkSyfJG0sSad44eZfh3/fU0nzrw0WKrx46yFdXTRF8StwYzU+M9FH8eH03fdLp
	gviwr+CvDBdUXkeviBVv6q1UcJZj5PKXIRSLMh2SEMtibh9uWwhNQg4rWKDJIO1McVtx04iG
	sjPNuWOLZX4lX89tx1/fmZkkJGZJ7j6D48tqabvHibuEn744ZO+RcIC7DDkiO0s5BS5q16LV
	fB1+nfVpxUlyHtjya5Swj5KcCzb8Yu2xA3cEtz3PW1m1gXPFLytbiNXTrCzu6d+6ypvxqyIL
	pUWc7j+r7j+r7p81F5ElSKoMDA+QK/33eSrUgcpIz6tBAUb055cKbyxdrEKTHWfMiGORzFGi
	SIxXSEXy8BB1gBlhlpStlwQX3FFIJb5ydZSgCrqsCvMXQszIhaVkmyR7ZiN8pdw1eajgJwjB
	gupvlWAdnGORwXb+PBOdPuR+xHDdR277xiYfX0yPOps+E6euCbNVux2nYiYePe4a/HS7zmQ2
	O/5Mizn1KPFOzOFGv5nuBzbvUXXEWJe7Ibsvf82w64G5oCZl51LbgLLDkLAl8cQz63jE6YfR
	ph/pUfvhwKvygaVt1lP1XtsrNMEF59xiOrQ79vrIqBCFfLcHqQqR/wbFFJJgRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+d3ffbk2uM2VFw2i9UIlSyo6YkVI0CUogogoqLzVrQ0fyZai
	UWA52rQ0S41cM+zhe2Vs5aNMazPLQgztsR7OR6k9RMvMZprmjMj/PnzP+XzPP4fFyguUP6uN
	PSzpYsVoNS0jZZvDU5aM+5s0yz4aV4Gl3EpDmScRijqqKLCUViAYGnnLwMS9BgTf6x/R8MU5
	iODq5WEMlmYDCT/Kf2HobuhioMy2CdoLe0ioMVZi6DrzmIZ0wyiGeyP9DJyoKibAYk9mwJnX
	SMGzigwKsn8VYKhM7mCg9Y6FBrd1goIeRzoJjeYSEr7m1GNoz1gHDfmzYfhpH4L68koChk/n
	0fAi9w4BWS35NLw3tCNocXaRkDNmouHi8QwEo57Jtv7MIQouPnQz64IFZ98AFm6VvCYEV+0T
	Qqg2tzFCvi1esBcHCWmuFizYSlNpwTZ4jhHevayhhccXRkmhujNMqK76TgjpKf208K37DSkM
	1L6gt6h2ylbvl6K1CZJu6dpImeZJbQcZlytPnPjciZJRjk8a8mF5bgVfYMjGXia5hfzDbgPp
	ZZpbzLtcI1O5igvmv7xyMGlIxmLuPMMby2voNMSyvtwu/mZduHdHwQHfWpRHeVnJafji5kz0
	N5/JN+Z+mOrEXBDvGv9EeFXMBfBF46w39uHW8E13L0+dmsXN5+9XPCIykcI8zTZPs83/7XyE
	S5FKG5sQI2qjV4boozRJsdrEkH2HYmxo8l8Kj42drUJDrRsciGORWq7QpBo1SkpM0CfFOBDP
	YrVKEVdwUqNU7BeTjki6Q3t08dGS3oECWFLtp9i4XYpUcgfFw1KUJMVJun9TgvXxT0Ylvnut
	t0X/+02B38qiPNkmye/pcP/gghM9iwIfrDbtyQpydi/HfqGiSTarrbbOE3n0dpTBbf+91fDR
	fqPvEhUxZ82O8KYZoePb3EsLeuW01t77MzXu5d2w3dmjVve1611LfL8GH5hnnDP0XN7hlEc0
	h1kDT3nUc7PK1qtagxdciVeTeo0YGoR1evEPOG9m1isDAAA=
X-CFilter-Loop: Reflected

On Mon, Jul 28, 2025 at 07:36:54PM +0100, Pavel Begunkov wrote:
> On 7/28/25 06:27, Byungchul Park wrote:
> > Changes from v1:
> >       1. Rebase on linux-next.
> 
> net-next is closed, looks like until August 11.
> 
> >       2. Initialize net_iov->pp = NULL when allocating net_iov in
> >          net_devmem_bind_dmabuf() and io_zcrx_create_area().
> >       3. Use ->pp for net_iov to identify if it's pp rather than
> >          always consider net_iov as pp.
> >       4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> 
> Oops, looks you killed my suggested-by tag now. Since it's still
> pretty much my diff spliced with David's suggestions, maybe
> Co-developed-by sounds more appropriate. Even more so goes for
> the second patch getting rid of __netmem_clear_lsb().

Sure.  I will.

	Byungchul

> Looks fine, just one comment below.
> 
> ...> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> > index 100b75ab1e64..34634552cf74 100644
> > --- a/io_uring/zcrx.c
> > +++ b/io_uring/zcrx.c
> > @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
> >               area->freelist[i] = i;
> >               atomic_set(&area->user_refs[i], 0);
> >               niov->type = NET_IOV_IOURING;
> > +             niov->pp = NULL;
> 
> It's zero initialised, you don't need it.
> 
> And a friendly reminder, please never send patches modifying a
> subsystem without CC'ing it, especially kept in another tree.
> Sure, you CC'ed me, but it's easy to lose.
> 
> --
> Pavel Begunkov
> 

