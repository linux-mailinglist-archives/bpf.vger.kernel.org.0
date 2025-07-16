Return-Path: <bpf+bounces-63405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0ADB06CAA
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 06:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E03174B9D
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD4279DC0;
	Wed, 16 Jul 2025 04:27:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A5027144B;
	Wed, 16 Jul 2025 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752640055; cv=none; b=LOI383soLGhguaJz8BZTAzlAJWdIAqZ08e6oZ0GU8S3R2alu14vDoaWZcvRInNiivRh49BL1TgCs6cB1oyR6bLk9nfAC3eT7wiA9/gQW7HKiqfPthnNYrCh+HW5dYgK/Xxeht/ys5RfbEy9+1fjuy2cWqEfr791BrGHG5HMygjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752640055; c=relaxed/simple;
	bh=gYSJxs1CnBdNF+UKOy6bV8DYyOv8fBWKv4zRjZwmbRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bn2RP3TZfCgjtgGconwhsJwQCLXJ0xtYPlwjLSo4fKVuAK6rSWM0AI45d9Ga67UCrtwDJ+ZP7TI/SMjKE2zWF51gJd+rOX+Sq1aN5S4Nxem2roMQSEQHlyJ+sqKLpoDMq67MfwmhJaBIXY+VsqxCxCF6EEAySf+Ni5aNuTYOLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fe-68772a2f6dda
Date: Wed, 16 Jul 2025 13:27:22 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
	akpm@linux-foundation.org, andrew+netdev@lunn.ch, toke@redhat.com,
	david@redhat.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	bbhushan2@marvell.com, tariqt@nvidia.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org,
	nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	aleksander.lobakin@intel.com, horms@kernel.org, m-malladi@ti.com,
	krzysztof.kozlowski@linaro.org, matthias.schiffer@ew.tq-group.com,
	robh@kernel.org, imx@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
Message-ID: <20250716042722.GA12760@system.software.com>
References: <20250714120047.35901-1-byungchul@sk.com>
 <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
 <9bed2f6e-6251-4d0c-ad1e-f1b8625a0a10@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bed2f6e-6251-4d0c-ad1e-f1b8625a0a10@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUyTVxTHc5/3dm3y2Dl3lZhl3UTHNpnOZCd7CyNZ8vhhyab7MrfomrWj
	zQqaIhVMNhl0WyCKRDQppWjRIi0Yq2V9mRTUwpQpm1igqxSogmNMimwopKUM1paY8e2X/7nn
	/M5NDkfKPMw6TlOwX6UrUGjljJgST0kaXs3OOqB+bT66BcyOcwzcftRAQ0usGJruemkI2DG0
	9cYIMDe7ETyOh1lwVgyR8KjrOgNnGuZIiF84QoH5loGCWcc8CX9cG2Wh2/8vBS3ODyBydpwC
	3w8eEjpnN8Do0W4GjhgSJNSOfMfA0mCChvb4QxbKvDYC2iddLPS6q2g4Pt9Igqf0btI1FqSh
	75KZgb7y2whGzi3RMO5PCqO2IRaqWkwI/JftDJQZXoeo6zELf5/oIiFSlQOLRj1cs6yBuZtR
	BOHGAQKWfF4Wfhs5T0OXw0NA/704CXOH6xmonDqKYKD2EgE99RdosN7sJ5J77ITg0gIBNQEL
	A2OGCIJA5ygFdd9WIXB0hGj4x5f8ciJmZnJyhc7oNCl4h61I+NF+hxAmqhcJIdRxgxB+Mg2z
	gsVZJLTasoQzvr8IoTIUIAVncwUjOGeOscJQ0McI3cYEJbRaDwkTrbXow/W7xG8rVVqNXqXL
	fvdzsbrj1J/0vlJcHEtoStGArBKJOMxvw7GJq8wTdlhOpJniN+A7MzaUYobfiEOhOJni1fzL
	ePJ3P1uJxBzJN0qws95DpQpP80X49L1QmqU8YINhMt0s48MI91k2Leer8C+199NvyOTQhZOB
	5FAuyRm4aZFbjp/D5a66tEvEv4NdZQ+JFD/Dv4CvuK8TKS/mZ0R4uqeUWF56Lb5qC1HVaJVp
	hcK0QmH6X2FaobAgqhnJNAX6fIVGu22zuqRAU7z5i735TpQ857NfL3zqRTO9O/2I55BcIvW+
	pVfLaIW+sCTfjzBHyldLawLJSKpUlBxU6fbu0RVpVYV+lMFR8melW+cOKGV8nmK/6iuVap9K
	96RKcKJ1pcia+WB0Vpubt2vP/QdBYVhysfuNNsWv26vh2PqePLu95vm1p7xPRSYG14Tf049/
	PPb+0JubKozHRcVTmfzBSeUrkZL+nKbz7T5jblCyMTrodp+2ugDteMl3kj9sfPEjVvx9+ZUO
	bjozY+utz8KHsnfr6768Eb38c/v2TyxK9psK1CanCtWKLVmkrlDxH0J4lOfKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxiHd+65XzTU3FXEI2Zb7OYkED8WNHkTcSHbMu+27CNbsi3GRBu5
	2mqpri2Vmpgx6FwgE93AhFZwdXxYwFhzEehcZa4QxckmtsCqfGlR5wI6kUooIOwWs4z/nvN7
	z3l+7x+Hx5oyNoU3mKyS2aQzalkVrfpgY+HqtWn79eui/UuhwnuahevjJxlomMyDU7d8DATr
	CPzcNUlBRX0zgmisjwO5qB/DePtlFqpOTmCInT1MQ8U1Bw1PvFMY7l6KcNAReEpDg/w+DNXe
	o8H/TQuGticrIXKkg4XDjmkMzsGvWZi7Oc3AhdhDDgp8HgraKq8ox5EmDrqaSxgom6rB0JJ/
	Sykc7mUgdL6ChVDhdQSDp+cYuBdQWkc9/RyUNLgQBH6pY6HAkQGjTVEOHh1rxzBUkgWz5Ta4
	5E6GiaujCPpqeiiY8/s4+GPwDAPt3hYKum/HMEx8W8lC8YMjCHqc5ynorDzLQPXVbkrZ4xPo
	nZuhoDToZmHYMYQg2Bah4fhXJQi8rWEGxvwOOutNsW30Hyz6BqqReK7uBiXePzpLieHW3yjx
	J9cAJ7rlXLHRkyZW+f+mxOJwEItyfREryo+/58T+Xj8rdpRP02Jj9Zfi/UYn+ujFLarMbMlo
	sEnmta9vV+lbf/iL2ZdP8ianDfmoR1OMEngirCde9zE2zrSwktx47EFxZoVVJByO4TgnCelk
	5M8AV4xUPBZqEolc2ULHB4uFXPLj7fA8qwUgDsfI/GON0IdIyJ36LH+eXHHemb+DFenMiaAi
	5RVeTk7N8s/il0hh0/H5rgRhE2kqeEjFeYnwMrnYfJk6iha5FphcC0yu/02uBSY3outRksFk
	y9EZjBvWWPbo7SZD3pode3NkpPzV2oMz3/lQNLQ5gAQeaRPVvo02vYbR2Sz2nAAiPNYmqUuD
	SqTO1tkPSOa928y5RskSQMt5WrtU/e5n0naNsEtnlfZI0j7J/N+U4hNS8pGVHX70+ZYZ3QhV
	68ObMvyryj1Vb4ecv+7Yf3Aq/c6KVGvDh/VlznGjnPhG5oD9i+e6yQpTZ7bbcPFAbU80JWqW
	TW+ZF1nVO0ufjm0NLDux+b2IPTMjOakrMnmNXUc+TX91YNmSVzp3bsgae8H9sb0oVdx9SJ91
	ZnXp+oR3Dl34PfmBlrboda+lYbNF9y8C3OucpwMAAA==
X-CFilter-Loop: Reflected

On Tue, Jul 15, 2025 at 11:37:45AM +0100, Pavel Begunkov wrote:
> On 7/14/25 20:37, Mina Almasry wrote:
> > On Mon, Jul 14, 2025 at 5:01 AM Byungchul Park <byungchul@sk.com> wrote:
> ...>> +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
> > > +{
> > > +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> > > +
> > > +       /* XXX: How to extract netmem_desc from page must be changed,
> > > +        * once netmem_desc no longer overlays on page and will be
> > > +        * allocated through slab.
> > > +        */
> > > +       return (struct netmem_desc *)page;
> > > +}
> > > +
> > 
> > Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> > which does not check that the page is the correct type. The
> > DEBUG_NET... is not good enough.
> > 
> > You don't need to add a generic helper here. There is only one call
> > site. Open code this in the callsite. The one callsite is marked as
> > unsafe, only called by code that knows that the netmem is specifically
> > a pp page. Open code this in the unsafe callsite, instead of creating
> > a generic looking unsafe helper and not even documenting it's unsafe.
> > 
> > >   /**
> > >    * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
> > >    * @netmem: netmem reference to get the pointer from
> > > @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > >    */
> > >   static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> > >   {
> > > -       return __netmem_to_page(netmem)->pp;
> > > +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> > >   }
> > 
> > This makes me very sad. Casting from netmem -> page -> nmdesc...
> 
> The function is not used, and I don't think the series adds any

That's whay I'd been keeping the patch, 'netmem: remove __netmem_get_pp()'
until v6 [1].

[1] https://lore.kernel.org/all/20250620041224.46646-7-byungchul@sk.com/

However, as the following change log described [2], I excluded the patch
from v7 since __netmem_get_pp() started to be used again by libeth.

[2] https://lore.kernel.org/all/20250625043350.7939-1-byungchul@sk.com/

> new users? It can be killed then. It's a horrible function anyway,
> would be much better to have a variant taking struct page * if
> necessary.
> 
> > Instead, we should be able to go from netmem directly to nmdesc. I
> > would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> > it return netmem_desc instead of net_iov. Then use it here.
> 
> Glad you liked the diff I suggested :) In either case, seems
> like it's not strictly necessary for this iteration as
> __netmem_get_pp() should be killed, and the rest of patches work
> directly with pages.

Killing __netmem_get_pp() would be the best I think.

	Byungchul
> 
> 
> > We could have an unsafe version of netmem_to_nmdesc which converts the
> > netmem to netmem_desc without clearing the lsb and mark it unsafe.
> > 
> 
> --
> Pavel Begunkov

