Return-Path: <bpf+bounces-63140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15447B03461
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 04:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CD218998AC
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 02:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED41CEADB;
	Mon, 14 Jul 2025 02:13:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C82A10A1E;
	Mon, 14 Jul 2025 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752459225; cv=none; b=aFvy9LvndyaKihHoZqwl7I3FTSHlw1TeiHTRZgl67ZE+DvRuoGYEfK1DTAdYPKjEHqXMSZ5P+0hLeBfckdtWXAfpUoDrqsZ5a06vGUUKcCARj7zuvUgLV3/jTOKqPFavFVH9tdXldt/V1ehKMCwQXte3C6gZNPTnkgAPdSdulDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752459225; c=relaxed/simple;
	bh=sdjr8AbPHXdRJMjgbFlVdtF0CEhEbkJzwj0cN1MLk6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNsCYVTZ8+nUlEeAs6TQ96WHzbnOkTNJ9PSWfPWaZ/VaZ+oA1X7Fby75BfMYsfCltH03HBaitLg9gnAQRhU0nz63YO7ux0fFYjk707PsjeRZZ/gCkxlV0Pd9YHhIh//QL9BPntl+4/w9mUuAtMuo09P1W/ProoMoDCCxfgYkqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8e-687467cf8f8f
Date: Mon, 14 Jul 2025 11:13:30 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 8/8] mt76: use netmem descriptor and APIs for
 page pool
Message-ID: <20250714021330.GA9457@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-9-byungchul@sk.com>
 <a21b340d-6d0f-4d39-906e-e983564605ed@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21b340d-6d0f-4d39-906e-e983564605ed@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjHvXvOnnPa7DhW6lXGZUlk5NaMJyOTD40XY5jhi3xgR4fdaVvN
	bvdxWWpEo5j4UFvYRJctlpXaQqMVyrWJtKHbpiQpiqabS1tj+Pab5/9/fvN8eDhKliH25FSa
	SEGrUajljISWfJl6eVntgUjlimvNCLLMRQwUDsVCXqtVDFmmEgTfh9+xMFD1mIGc7EEKsl4m
	0vDDPEJBxyMHC4WWrdCS20nD3aRSChxnqhlISRyl4N5wLwvHrfkiqC1JFcP5kasUlOpbWXhV
	nsVAc9FvMXTaUmioMRTQ0JIaBI+M7jD4tAdBlblUBIOnLzBwrs7IQHtiC4K6Bw4aMo+lIjBX
	2MUwOjTuyHzYzAYtJA96+ihSXNAoImWGJpYYLVHkVr4vSbbXUcRiOsUQS38aS96/ucuQ6vRR
	mpRZB0QkJaGXId863tKkr6KeIebiepo8M1ax26eHSNaFCmpVtKBdvn6vRHn8eSUT8XpubKK+
	HelRqXsycuEw749fJ1xh//Kd6qEJpnlvbNR3TzDD+2C7fZhyshu/FH9usI3PJRzFpzP4elsu
	k4w4bga/Czc92+/sSPk1uLq+Czk7Mv48wslWBz0ZTMc1GR8mmOJ9sf3XJ5Fzl+K9cN4vzoku
	fCC2OQKdjZn8Any/5LHIqcG8lcNPLt6kJ++chSvz7fRZxBv+sxr+sxr+WY2IMiGZShMdrlCp
	/f2UcRpVrN++g+EWNP4wuYfHdltRf+0OG+I5JJ8qtRfrlDKxIloXF25DmKPkbtLuJq1SJg1V
	xMUL2oN7tFFqQWdDXhwt95CuGowJlfEHFJFCmCBECNq/qYhz8dQj9wbr2HOfkCXBdbcbHbM3
	p30ME7d1viyessLk1S8+dETnikxkzibDtFu+OVsW/5y3PcKYVNOnTlkfYN7qPSO4vi/9JKmM
	vDhwLa/CpXdvT9eT95qjlwIWsdskMcFp5bSxfG1mwfwNjV9X+2ekvrihYb8pZVUbPczxwonA
	bHZnlOuonNYpFSt9Ka1O8QeU2HghLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zds7ZanBaZqc7rUSytIKiF8owBP1TGSFFVB9y1NENdYtN
	TYVg1UKStJuBTa0ToalJs2U6y6TmbXbB8pLL1NVMyRSnZeYtyxVR3348z/N7P70sqZiiFrMa
	bYKg16rilLSMku3ZeiawKSZBveGLJwhyLSU03BlPhtvvbRLILS5HMDrxjoGvtQ003Lo5RkJu
	k4mCb5ZJEnrr3QzcsUaAq6CPgqq0ChLcFxw0ZJimSHg8McTAaVshATV5jRJ4VZ4pgazJfBIq
	jO8ZaHmYS0N3yU8J9NkzKGg0F1HgygyBetEXxp4PIqi1VBAwdj6PhivNIg09JheC5ho3BTmn
	MhFYqp0SmBqfvZFT182E+OGaQQ+Jy4reErjS3MVg0ZqI7xcG4HRnM4mtxedobP1ymcGdb6po
	7MieonCl7SuBM84M0Xikt4PCnuo2Gt/6NExgS1kbtVdxSLbtmBCnSRL067dHydSnXz6lj7eu
	SDYZe5ARVfimIynLc5v4R45xxssU58eLxs+/meb8eadzgvSyD7eWH2i3z+YyluSyaf7uhwI6
	HbHsfO4g3/Ui2ruRc1t4R9sn5N0ouCzEp9vc1J9iHt947eNvJrkA3jnTT3hdklvC355hvSjl
	gnm7O9i7WMCt4p+UNxAXkdz8n2z+Tzb/k0VEFiMfjTYpXqWJ2xxkiFWnaDXJQUd18VY0+xIF
	J6cv2dBoS7gdcSxSzpU7ywxqhUSVZEiJtyOeJZU+8s9derVCfkyVkirodUf0iXGCwY6WsJRy
	oXznASFKwcWoEoRYQTgu6P+2BCtdbESpTQP+fpuWtkg7RmJcujqZ1hgcOiw6voeF+ZRFPDsc
	aFGueX31xrpCfmhXRmt+5PfUHQ9gOn5/Wni/Z/lKyyJqjuIbUSLFoyJ3NjqzvlSn3R3aV+ks
	Ku1K9IS2nvC006Yw3+sTy87u8zA6deePe6Wr5w1FsmLiTGT4E9E17a+kDGrVxgBSb1D9Amgj
	fDUOAwAA
X-CFilter-Loop: Reflected

On Sat, Jul 12, 2025 at 03:22:17PM +0100, Pavel Begunkov wrote:
> On 7/10/25 09:28, Byungchul Park wrote:
> > To simplify struct page, the effort to separate its own descriptor from
> > struct page is required and the work for page pool is on going.
> > 
> > Use netmem descriptor and APIs for page pool in mt76 code.
> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > ---
> ...>   static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
> > diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > index 0a927a7313a6..b1d89b6f663d 100644
> > --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > @@ -68,14 +68,14 @@ mt76s_build_rx_skb(void *data, int data_len, int buf_len)
> > 
> >       skb_put_data(skb, data, len);
> >       if (data_len > len) {
> > -             struct page *page;
> > +             netmem_ref netmem;
> > 
> >               data += len;
> > -             page = virt_to_head_page(data);
> > -             skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> > -                             page, data - page_address(page),
> > -                             data_len - len, buf_len);
> > -             get_page(page);
> > +             netmem = virt_to_head_netmem(data);
> > +             skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
> > +                                    netmem, data - netmem_address(netmem),
> > +                                    data_len - len, buf_len);
> > +             get_netmem(netmem);
> >       }
> > 
> >       return skb;
> > @@ -88,7 +88,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
> >       struct mt76_queue *q = &dev->q_rx[qid];
> >       struct mt76_sdio *sdio = &dev->sdio;
> >       int len = 0, err, i;
> > -     struct page *page;
> > +     netmem_ref netmem;
> >       u8 *buf, *end;
> > 
> >       for (i = 0; i < intr->rx.num[qid]; i++)
> > @@ -100,11 +100,11 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
> >       if (len > sdio->func->cur_blksize)
> >               len = roundup(len, sdio->func->cur_blksize);
> > 
> > -     page = __dev_alloc_pages(GFP_KERNEL, get_order(len));
> > -     if (!page)
> > +     netmem = page_to_netmem(__dev_alloc_pages(GFP_KERNEL, get_order(len)));
> > +     if (!netmem)
> >               return -ENOMEM;
> > 
> > -     buf = page_address(page);
> > +     buf = netmem_address(netmem);
> 
> We shouldn't just blindly convert everything to netmem just for the purpose
> of creating a type casting hell. It's allocating a page, and continues to
> use it as a page, e.g. netmem_address() will fail otherwise. So just leave
> it to be a page, and convert it to netmem and the very last moment when
> the api expects a netmem. There are likely many chunks like that.

Thanks for the feedback.

Unon reconsideration, focusing on the conversion between page and
netmem_desc, plus small modification on user side code e.i. driver are
sufficient to achieve my objectives.  I won't change a lot on user side
code like this from the next spin.

	Byungchul

> > 
> >       sdio_claim_host(sdio->func);
> >       err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
> > @@ -112,7 +112,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
> > 
> >       if (err < 0) {
> >               dev_err(dev->dev, "sdio read data failed:%d\n", err);
> > -             put_page(page);
> > +             put_netmem(netmem);
> >               return err;
> >       }
> > 
> > @@ -140,7 +140,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
> >               }
> >               buf += round_up(len + 4, 4);
> >       }
> > -     put_page(page);
> > +     put_netmem(netmem);
> > 
> >       spin_lock_bh(&q->lock);
> >       q->head = (q->head + i) % q->ndesc;
> --
> Pavel Begunkov

