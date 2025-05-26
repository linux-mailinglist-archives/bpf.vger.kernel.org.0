Return-Path: <bpf+bounces-58917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70AAC37F4
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 04:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499E9171F84
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F3174EE4;
	Mon, 26 May 2025 02:23:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E8146A72;
	Mon, 26 May 2025 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748226200; cv=none; b=JzB+kelxaq8PL+CZNMKiiJzBBzV4CaUhR6SY4iSIIAVA5zVXWFKYJZpO3OBh7LJxusmuaWu8mShVdMaK8GigK0MUsB1WdjR/p1XkkCYEeAyUtIvviuwx9qEB82dspebV/JwmH/ri5LSEa8uOHV1IvAxjDKiN7I2k278quRBFCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748226200; c=relaxed/simple;
	bh=NmqXIV/7Pk3eDXAP9hueFGbWPTqhHGafye3KtB68iuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvcfKqZJkhRpiOCTJzDtcAdhKUOsSfE5Hi51L2lmOHPDx4ynIAEZPTlInBxMtPrBhgHQUxtq06Rbffxl2UwB+0UPYyzRChENybcTF8lghvbXHHjQvDvrGDCvy/8+Z7FgE10X/iEF262iOxm+no570RWVr1K0BYZk1AYbJjPl4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-27-6833d0903008
Date: Mon, 26 May 2025 11:23:07 +0900
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
	vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
Message-ID: <20250526022307.GA27145@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZe9rpcPU6rJ62khUiC5SXoFBV+qvdDkVFBFKEjX9rMqUwz
	VxSWg0jU7lFzyUzLeYnR8jJDJJeZVqZo6uzm0mmhVqa1vGW1SeS3H/9zDr//h8NRMiPjz6kS
	UwVNoiJBzkpoyWfvgtCLbZHKsLy6VWAwl7NQNpEOxQ4rA4bSKgTfJ9+IYbzhKQuFBS4KDK06
	Gn6YpygYaOwTQ+/dQRpqz1VT0HehiYUc3TQFZ60mEbRV5TJwdeoOBdUZDjF0PDSw8L78NwOD
	thwamvUlNPTmRkGjcQm4no8gaDBXi8CVfYuFK+1GFvp1vQjaH/fRkHcmF4G5zs7A9ISBjVrF
	V5T0iPga/Tsxb7Qc4x+YQvgsezvFW0rPs7xl7LKYf9tVy/JNN6ZpvsY6LuJzMr+w/LeB1zT/
	ta6T5c0VnTT/wtgg5sctK6PxAcnmOCFBlSZo1m2NlSgv3zCiZAdOnxjuYTNQmTQLcRzB68l0
	fkAW8vLg8PXbjJtpHERM91soN7M4mNjtkx72w2tIUd0lzw6Fexny0hDvZl8cT7Jff2TdLMVA
	usvOe1iGSxB53hoyl/uQ5ptOeu42mMzkt1PuChQOIMWz3FwcSDIr8zyxF95NWiq2uePFeDV5
	VPVUlIUkf1ve40jHaKForvIyUm+y0xeRj36eQT/PoP9v0M8zGBFdimSqxDS1QpWwfq1Sm6hK
	X3s4SW1Bf//m7qmZg1Y01rbHhjCH5N7SWHmkUsYo0lK0ahsiHCX3ky43hCll0jiF9oSgSYrR
	HEsQUmwogKPlS6URruNxMnxEkSocFYRkQfNvKuK8/DPQisFN2WFPtD4xRbVDs/qNXW9nna/U
	Q90bRq+H2gsKDzRi54KzURGj9mf++3aZTpX7ftihXKQ1WKMdLmvN15CM8AjHSfOvQ2Nbir9p
	Qv1atuzfuDNGcNYX/PSejWSSggqdV9do0nSVI5+G2fvGwNPqE7ZuSb9ueyguX7jXqz76Wp6c
	TlEqwkMoTYriD+mmdEMzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRSA+e0+dh3euC6tWwbCoqShZalwolCDsFvQC6I3uFEXt+WmbWoa
	GZoT6aG5ih5rxtIyXzFa5raQVSraSJ1MzPWcWVlklKaJj6jcJPK/j++c8/11KEysJxZTSk0m
	r9XI0ySkCBdtW1cYXdYdq4ipsNFgstSTUDeRA3f67QSYahsRjE2+EsJoazsJlTfHMTC59Tj8
	tExh8LFtQAi+qkEcmoptGAycf0pCiX4ag1P2agG0lLsI6G4sJeDS1G0MbPn9Quh5aCLhbf0f
	AgabS3BwGWtw8JUmQZt5AYw/+4qg1WITwPi5chIueswkvNf7EHhaBnC4XlCKwOL0EjA9YSKT
	JFxDzQsB5zC+EXJmaxZ3v1rKnfF6MM5ae5rkrD8uCLnXz5tI7unVaZxz2EcFXEnhN5Ib+fgS
	5747e0mu8vOwgLM09OJch7lVuCNkv2j9YT5Nmc1rVyXIRIoLV80oo5/JmRh6QeajOvoMCqJY
	Jo4dulxB+BlnlrHV9zoxP5NMJOv1TgY4lFnB3nIaAjsY4yPYLpPKz/MZFXvu5SfSzzQDbF/d
	6QCLmRrEPnNLZ30I67r2AZ+9jWR/3fDMNKkZDmfv/KZmdQRb+OB6QAcxO9nOhmS/DmOWso8b
	2wVlaJ5xTsg4J2T8HzLOCZkRXotClZpstVyZFr9Sd0SRq1HmrDyUrraimd+oyvtlsKOxnk3N
	iKGQJJiWSWIVYkKerctVNyOWwiSh9BJTjEJMH5bnHue16SnarDRe14zCKVyykN6yh5eJmVR5
	Jn+E5zN47b+pgApanI9OdhSE9emKH9+NoA2JVdFR2gix2HW0hTok3bx3u6YgLjOl2zWiyiu6
	khzl2Bf5Y4Es9lGC+ljf8JBzdHDXtXfB7o1xX7pePfHlG07ELNqqVG44ICw6TwsTjqcuL2s7
	EUxMFVkd0U8Si0OHUtZ+O9jRtS883n3WHbLGk6wq3+0tr5TgOoV8tRTT6uR/Aallo/wXAwAA
X-CFilter-Loop: Reflected

On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the effort to seperate its own descriptor from
> > struct page is required and the work for page pool is on going.
> >
> > To achieve that, all the code should avoid accessing page pool members
> > of struct page directly, but use safe APIs for the purpose.
> >
> > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> > page_pool_page_is_pp().
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/mm.h   | 5 +----
> >  net/core/page_pool.c | 5 +++++
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 8dc012e84033..3f7c80fb73ce 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >
> >  #ifdef CONFIG_PAGE_POOL
> > -static inline bool page_pool_page_is_pp(struct page *page)
> > -{
> > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > -}
> 
> I vote for keeping this function as-is (do not convert it to netmem),
> and instead modify it to access page->netmem_desc->pp_magic.

Once the page pool fields are removed from struct page, struct page will
have neither struct netmem_desc nor the fields..

So it's unevitable to cast it to netmem_desc in order to refer to
pp_magic.  Again, pp_magic is no longer associated to struct page.

Thoughts?

	Byungchul

> The reason is that page_pool_is_pp() is today only called from code
> paths we have a page and not a netmem. Casting the page to a netmem
> which will cast it back to a page pretty much is a waste of cpu
> cycles. The page_pool is a place where we count cycles and we have
> benchmarks to verify performance (I pointed you to
> page_pool_bench_simple on the RFC).
> 
> So lets avoid the cpu cycles if possible.
> 
> -- 
> Thanks,
> Mina

