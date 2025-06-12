Return-Path: <bpf+bounces-60421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14BAD64A6
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 02:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DF71BC396E
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B390129A78;
	Thu, 12 Jun 2025 00:40:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518575258;
	Thu, 12 Jun 2025 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688809; cv=none; b=akNkf5l+r+7iov0/ybiFvOkri6zy6dOiDAvfL4TTxXdGoPdnNacf5BdWQQyyCnLrJASnn/w70cmhi+/xw5mPyMKea4Rlnpm4nnxDAangFFg2TOMF/VXdCr0RdoJZ82Z3tbPKVWAzcZUifh0Sw68Lw5Yb36jv/Gax/9eeiFxhXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688809; c=relaxed/simple;
	bh=NyPPNQeFrrcMeaekAXsQqeAlWSYzdoBw9X5oLRlU1Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4tJZ7qFBCAR8frgg0o4ykpHkSV9XQbPkNkCM0Ns8Ser9+B2qteQmfG5FDMVZBKpvWMBMr10dVZlkaV8QDJU+2fEGset4AX65Pz1JGDYiE9k3qUgJpkqFQOg3Vgnz3uW4ViQ1BgkPIG68HbingqSayIx6c8zsvwPoOiIFCT3jjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-7f-684a21dbc596
Date: Thu, 12 Jun 2025 09:39:49 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH net-next 9/9] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
Message-ID: <20250612003949.GA41589@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-10-byungchul@sk.com>
 <CAHS8izMLnyJNnK-K-kR1cSt0LOaZ5iGSYsM2R=QhTQDSjCm8pg@mail.gmail.com>
 <20250610014500.GB65598@system.software.com>
 <937e62c5-0d12-4bea-b0c1-a267c491cf72@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <937e62c5-0d12-4bea-b0c1-a267c491cf72@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfc95d3YcDo7T6tWgcBKBoaYZPVRG9CGOfeliRHdbeWojXTLT
	plDMMixLi5LMuWomqZk1WjanidkybymZZq2Ll9Tph65uJZZ2cZPIbz/+//d9fs+Hh6VlxaJA
	VqU+LGjUigQ5I8GSTz7XQ98GrVMutvRGgsFUwcCtcS2U9ltFYCi3IPj2460YXA1NDBQXjdFg
	eJaJ4bvpJw2OxgEx9JUMY6jNqqJh4FwzAzmZEzQct5ZR0GHJFUHezxs0VOn6xdBVY2Cgt+KP
	CIZtORha9Dcx9OWuhkbjbBh7+hFBg6mKgrGzVxi42GlkYDCzD0Hn4wEMhRm5CEx1dhFMjBuY
	1UF85c3XFF+t7xHzRnMKf68shM+2d9K8ufw0w5udF8T8u5e1DN98eQLz1VYXxeec+Mzwo443
	mP9S183wpspuzLcZG8S8yzxvA7ddsjJeSFClCprwVXskytz8SZzUGqQ92dFO6ZAjIBuxLOGi
	yNDrzdnI24M1Iy/EbsbcAlJa89DDDLeQ2O0/aDf7c4vIh1e2qVzC0txHETFlWbC78ONSSNaz
	854PUg7Il8G7nkcy7gxFxk+58HThS1oKhjxMT02dvNpJu5egubmk9Dc7Hc8nJ+4XemTeXDRp
	b24WuXkWF0zqLU2UeybhrCwpyqnH01sHkEdldnwe+epnKPQzFPr/Cv0MhRHhciRTqVMTFaqE
	qDBlmlqlDdt3KNGMpk6n5OjkDitydsTaEMciuY/UqoxRykSK1OS0RBsiLC33l872m4qk8Yq0
	dEFzKE6TkiAk29BcFsvnSCPHjsTLuAOKw8JBQUgSNP9aivUO1KHY/r1d/RuvhOhi2i99vWbb
	VTfoG5OoXXlU7LAmjdy57TU/KXj7krhC+aeGwP09Z7bqHtTubom7tn6Z0RmhDrfmm12FzvCd
	+9+vefK8dVThc7U0eh0bnbHNZCtbmq31+n56+aSFYgq25K0okTtfpZf/al3btDZoU+iSDT6h
	x44PtWXp5ThZqYgIoTXJir/o4XKSNgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRiH+Z/bjsPV8baO+iFahGR0owtvdLM+1CkogwipiDrVoY3clE3F
	RYHlanbZukI2ZyxE55aw8rKtMaympGblrcs0zbA2gyzzkmhKNheR3x5+v/d93i8vjUfryQRa
	ocoS1Co+XUaJCfHu9flL3y/YKV9RMxAPZkcFBffHc8H60U2C2e5EMDrxXgQj9Q0UlNwbw8Hc
	oiPgp+MXDoFnfSLoLQsS4NW7cOi72kiBQTeJwzl3OQZ1xU0ktDqNJNz6VYqDK++jCDo8Zgo+
	VEyTEPQZCGgy2QjoNabAM4sUxpoHENQ7XBiMXSmm4Ga7hYJPul4E7XV9BBSdNSJw1PpJmBw3
	UykyrtrWiXGPTD0izlKZzVWVJ3OX/O04V2m/SHGVwzdEXPdbL8U1Fk4S3CP3CMYZ8r9T3FCg
	i+AGa99QXMmXHxjnqH5DcC8s9aI9UQfEG44L6YocQb180xGx3Hh7ish8viD3fOtLLA8F4i+h
	CJplVrOe/teiGSaYRazV8zjMFJPE+v0T+AzHMkvYr+98oVxM48wAyTr0TmKmiGGyWX3LtfCC
	hAF28NPD8FA0cxljxwtGiL9FFNt053OY8ZB16m57yEqHOJG1/qb/xvPZ/Jqi8LEIZiP7srGR
	nOE4ZiH7xNmAXUNzTLNMplkm03+TaZbJggg7ilWocpS8In3NMs1JuValyF12LENZiULvUXZm
	6robjXZs9yGGRrJIiVu+Qx5N8jkardKHWBqXxUqkMaFIcpzXnhLUGYfV2emCxocSaUI2T7Iz
	TTgSzZzgs4STgpApqP+1GB2RkIesBbVHTb7kLXuD3sKk2lWJem9wNPI6HRX3dl9kolRr/xY8
	mxpPDqaWXK442C9dlzqtel5UBc2vFj+oaLM8bQ74DrV5beP9t+5MDJ22uTJLtl3Y2sB7koZ3
	GbpLD8cUv3Bt1qVdnGO8v0mZ3dW6H1X10Ie+rG3TFDi1hXWqzrlXZYRGzq9MxtUa/g/f9oLO
	GgMAAA==
X-CFilter-Loop: Reflected

On Wed, Jun 11, 2025 at 03:30:28PM +0100, Pavel Begunkov wrote:
> On 6/10/25 02:45, Byungchul Park wrote:
> > On Mon, Jun 09, 2025 at 10:39:06AM -0700, Mina Almasry wrote:
> > > On Sun, Jun 8, 2025 at 9:32 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > 
> > > > To simplify struct page, the effort to separate its own descriptor from
> > > > struct page is required and the work for page pool is on going.
> > > > 
> > > > To achieve that, all the code should avoid directly accessing page pool
> > > > members of struct page.
> > > > 
> > > > Access ->pp_magic through struct netmem_desc instead of directly
> > > > accessing it through struct page in page_pool_page_is_pp().  Plus, move
> > > > page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> > > > without header dependency issue.
> > > > 
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > > > ---
> > > >   include/linux/mm.h   | 12 ------------
> > > >   include/net/netmem.h | 14 ++++++++++++++
> > > >   mm/page_alloc.c      |  1 +
> > > >   3 files changed, 15 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index e51dba8398f7..f23560853447 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > >    */
> > > >   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > 
> > > > -#ifdef CONFIG_PAGE_POOL
> > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > -{
> > > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > -}
> > > > -#else
> > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > -{
> > > > -       return false;
> > > > -}
> > > > -#endif
> > > > -
> > > >   #endif /* _LINUX_MM_H */
> > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > index d84ab624b489..8f354ae7d5c3 100644
> > > > --- a/include/net/netmem.h
> > > > +++ b/include/net/netmem.h
> > > > @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> > > >    */
> > > >   static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> > > > 
> > > > +#ifdef CONFIG_PAGE_POOL
> > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > +{
> > > > +       struct netmem_desc *desc = (struct netmem_desc *)page;
> > > > +
> > > > +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > +}
> > > > +#else
> > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > +{
> > > > +       return false;
> > > > +}
> > > > +#endif
> > > > +
> > > >   /* net_iov */
> > > > 
> > > >   DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 4f29e393f6af..be0752c0ac92 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -55,6 +55,7 @@
> > > >   #include <linux/delayacct.h>
> > > >   #include <linux/cacheinfo.h>
> > > >   #include <linux/pgalloc_tag.h>
> > > > +#include <net/netmem.h>
> > > 
> > > mm files starting to include netmem.h is a bit interesting. I did not
> > > expect/want dependencies outside of net. If anything the netmem stuff
> > > include linux/mm.h
> > 
> > That's what I also concerned.  However, now that there are no way to
> > check the type of memory in a general way but require to use one of pp
> > fields, page_pool_page_is_pp() should be served by pp code e.i. network
> > subsystem.
> > 
> > This should be changed once either 1) mm provides a general way to check
> > the type or 2) pp code is moved to mm code.  I think this approach
> > should acceptable until then.
> 
> I'd argue in the end the helper should be in mm.h as mm is going to
> dictate how to check the type and keep them enumerated.

Definitely yes, I agree.  However, mm cannot do that for now.  With the
current way, it should be served by pp code since the type checking is
done through the pp fields.

	Byungchul
> 
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> -- 
> Pavel Begunkov

