Return-Path: <bpf+bounces-63864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F0B0B9B4
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 03:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812F716EFF1
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 01:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172CE1714B7;
	Mon, 21 Jul 2025 01:03:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507981732;
	Mon, 21 Jul 2025 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753059811; cv=none; b=TZsKYms1x9XRvgubWcljEBOL01lyFDsmse+7QJRN+p5sdWI88ivvzUBh3CSXyN48KlwJxQQ6fJfpgjpgVUroqAloDoUf+Aj/zvTzFwzfoIRo8BdluyLkDSLE9j+BolXcCoP8a05JlCLOjNzzWLMe7Xr6Rl6oUtQTTwQUJEMxxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753059811; c=relaxed/simple;
	bh=jw6XT5xuWPbHmIhPLnPQGra7fWdXYfi6VOY1fGU7dGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKFisDV60/wK7k4yk2znntVfOAK9uClw9gwxvJgAUE8gSLN2FBcra/UtGenpTO9mQAQVG1DtRxKYIOnnZKzFTkwOODJmCCsB+OGarspFoRL43EuitRSmHMDNHZwjJ91TYu6v9/bRMEzfjl/w492jjESRO0W9iz0Rns8iYnglWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-0d-687d91d6d773
Date: Mon, 21 Jul 2025 10:03:13 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: kernel test robot <lkp@intel.com>, willy@infradead.org,
	netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
	akpm@linux-foundation.org, andrew+netdev@lunn.ch, toke@redhat.com,
	david@redhat.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v11 12/12] libeth: xdp: access
 ->pp through netmem_desc instead of page
Message-ID: <20250721010313.GA21807@system.software.com>
References: <20250717070052.6358-13-byungchul@sk.com>
 <202507180111.jygqJHzk-lkp@intel.com>
 <20250718004346.GA38833@system.software.com>
 <20250718011407.GB38833@system.software.com>
 <35592824-6749-4fa4-89d9-2de9caccc695@gmail.com>
 <1fe747ea-56ce-4418-92cb-057d989e3732@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fe747ea-56ce-4418-92cb-057d989e3732@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfc85O+e4HByn6ZtCwSICTSsRepUUiT68BUEQfinBRh7caF6Y
	d9HSFDJB81akLpjmXWM6ZU5RqXmZUZSYlyWmstS8pKZmeUvbUaK+/Xj+z/N7ng8PS0r3KTdW
	GRnLqyPlKhktpsRLDmVeI/mpinNdVj+k0TXQqH4zEVVPGUVIU2cAaL3HTCPNh0wKbei2STTT
	Z2VQvf4amqyapVBO5g6JOreWGTRgyBWh1rQpBn1s19BoomFfhGZNORRayLDSaDI3CPVpXZCp
	dohAPbpWAo3s7xKocFBLo8FuK4VK03MB0nVZRGi1w7ZqZ9PmMA/N2ILeCSboBO7+tkLiltpP
	BG4r+cxgrT4ON9d44Bcd8wTW1z2isX6tgMHjIx007n+2Q+G55mKA24zrBM7JWKZx07KRwKsz
	YxRe6RqmrzvdFF8M41XKeF59NvC2WDFnORL9VpyYttBIpoHHbDZgWcj5QoPZMRvYH6BW/5QS
	mOJOwZrqcUZgmjsNLZYtUmBnzhMujppsdTFLcu9FcGxhgRA8Tlwi3NXECz0SDsH9qSUg9Ei5
	MgJOr24zh4EjfFM8fbCA5DygZW/+YJbk3GH1HiuU7bkA2DLWIhL4KHcSvjKYCcEDuScs1OV8
	ER0eegy+rrFQeYAr+U9b8p+25J9WC8g6IFVGxkfIlSpfb0VSpDLR+05UhB7Y3qIqdfeWEawN
	3DABjgUyB0k0laqQiuTxMUkRJgBZUuYsweZkhVQSJk9K5tVRoeo4FR9jAu4sJXOV+PxMCJNy
	4fJY/i7PR/PqvynB2rulgYd7ejtVpWkuuqy/bjYAeRb+7myO8rliN9Yk9b8q818tbw9xyqov
	vb/V1Uscv3cptNa9AYz8qAguckTv/Ppfli+6pbv0qMYvV1gT8kOMKUzwbCUzM+pFBhZEtOUv
	B38dzst6vuHgLK9NUaVfyPju+stBdSZcvF3UuPegdCXXXSqjYhTy8x6kOkb+BwduVGISAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTcRjG+Z/bjtPBaZmeFK0WMTDSgqI/eckv4Z+o6FNBILry0IZzyqY2
	DWuhXzSmaRdyzZok3kmd5iVMcppLtKVObYm3REWXF+YFvCxtMyK//Xif53mfF14aF04RfrRM
	kcwpFRK5iOIT/GuhmaeG8zOkp9sei6G+ppqCVRtqWDbZTEJ9ZSOAq51mCuq/ZRFwvWYLhzNd
	UzxYZbwKJ0pnCajN2sbhx80lHuwo6iZhX2MuCZs0kzxo/aCn4Hj1LglnTVoC2jOnKDiRGwm7
	DD7QVDGIwc6aJgwO7zox+HTAQMGBjikCvnqUC2BNm42EjlZX3/aGa4d5cMYlfB7nRR5FHQvL
	OGqo+IGhFt0YDxmMKai+PAi9bZ3HkLEym0LGlQIeGh1updCXl9sEmqsvBKileRVD2swlCtUt
	NWPIMTNCoOW2Ieq69y1+WBwnl6VyypCIWL50zuaZ1MNXa+y1uAbk0TnAg2aZs6zB+IJwM8Gc
	YMvLRnluphgxa7Nt4m72Zk6yv76bXHM+jTMWkh2x27EcQNMHGTXr1Ke6PQIGsruTi8DtETLF
	GDvt2OL9FQ6w3YXTewU4E8Tadub3sjjjz5bt7N3gwYSzDSMNpJsPMcfZT41m7AkQ6PaldfvS
	uv9pA8ArgbdMkZogkcnPBavipWkKmTr4TmKCEbg+X5rhzG8Ga9YoE2BoIPISJBEZUiEpSVWl
	JZgAS+MibwEyp0uFgjhJWjqnTIxRpsg5lQn404TIV3D5JhcrZO5Kkrl4jkvilP9UjPbw04De
	5+evDFrHHhaRMnDjniMt0LM1JiTAXlf7bHVebFm/1MIxmlKzVlAc6Fhp75X+VAca4Gt/y+0H
	bT3vFpdnQzcXRxPz+vs9+D6/ndH3q7LZ2qGFkguxFwNKet6EN60de69SI/MRbZ81SuFbMKL0
	MhyOtnzNbgmLWNxJELcXAxGhkkrOBOFKleQP7wjHK/UCAAA=
X-CFilter-Loop: Reflected

On Fri, Jul 18, 2025 at 10:32:38AM +0100, Pavel Begunkov wrote:
> On 7/18/25 10:18, Pavel Begunkov wrote:
> > On 7/18/25 02:14, Byungchul Park wrote:
> ...>>>>     include/linux/mm.h:4176:54: note: expected 'struct page *' but argument is of type 'const struct page *'
> > > > >      static inline bool page_pool_page_is_pp(struct page *page)
> > > > >                                              ~~~~~~~~~~~~~^~~~
> > > > 
> > > > Oh.  page_pool_page_is_pp() in the mainline code already has this issue
> > > > that the helper cannot take const struct page * as argument.
> > 
> > Probably not, and probably for wrong reasons. netmem_ref is define
> > as an integer, compilers cast away such const unlike const pointers.
> 
> Taking a look libeth, at least at the reported spot it does
> page->pp->p.offset, that should be fine. And your problem
> is caused by the is_pp check in pp_page_to_nmdesc().

Exactly, but you asked me to add the check,
DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p)) in pp_page_to_nmdesc().

What I meant was, in order to apply that, page_pool_page_is_pp() should
take 'const struct page *' as argument.

I think it's good idea to change the proto type like, as you said:

   static inline bool page_pool_page_is_pp(const struct page *page);

Thanks.

	Byungchul
> 
> --
> Pavel Begunkov
> 

