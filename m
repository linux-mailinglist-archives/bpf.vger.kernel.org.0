Return-Path: <bpf+bounces-53652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D26A57B21
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 15:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8008318941A4
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686651DDC07;
	Sat,  8 Mar 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7A3nL+b"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB91A3035
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741444864; cv=none; b=i5Wr7MCtft0q4E31KEBk8KcgDyVBYfYymMAPWd8rdHsWQnudgErkqeixagcFwAJf2IQxfLMwyMTNgPCPRkeUDGOdQHd+hrzCnqGNncMBsarv7Cr/bNF2QURkRt5lna37YyE0F/s1Mmn+ZIa0BMWYIceZCrt706HFfur9xbDhWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741444864; c=relaxed/simple;
	bh=vynbLoaxWWTw6FcBux/dam6OzZjOEkedxpDbG+eoBos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VnDhJ8D6OLT/b7Awm+lVPo1CcPpjpa/GPqM4Q6NP/h/U1UgxCxFQ6GWChyKlZtj4x3HaaWjpV/7KEfdcw2RSyp24faV7QTHPtSRh5dGDKA/GWDY4ykZU1qfTDC9ezbw4femEVt9SvA8vS8DhkNte/tM4yKCa/ANNNK1JpjhN/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7A3nL+b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741444861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USWTb6fbfs9ctXuLN/jteJwX39h1/6zKvhemZZrzqrc=;
	b=b7A3nL+bJZlUkldZjeC2UNI+BNBkGednllIDBWoJV2Xbbf+yAtquqhEBI3THZmKbn0TOBY
	VIreAKLqBQ+Xn8yZSBTZlgdMfmUAaIsLycVjhQWf1WEE9gk5lswYJwHkbCG/GGgAdAeIWh
	DFYCQcZu9GmEqodDX5uN//J7UJtZLdE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-JCmd8ox2MwKdWF-vxn6wOw-1; Sat, 08 Mar 2025 09:41:00 -0500
X-MC-Unique: JCmd8ox2MwKdWF-vxn6wOw-1
X-Mimecast-MFC-AGG-ID: JCmd8ox2MwKdWF-vxn6wOw_1741444859
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac27ea62032so22418866b.1
        for <bpf@vger.kernel.org>; Sat, 08 Mar 2025 06:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741444859; x=1742049659;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USWTb6fbfs9ctXuLN/jteJwX39h1/6zKvhemZZrzqrc=;
        b=SbZWvITJi1YgTN6RIHS1xeCcF9jRAV/lXKKRPOislyuVtoEP+P6fRJgjaXVZh9CuCV
         eE2kcXipLAJfAuENEsHubifGP/vap/aygAVVRLnWGbL5QlSo38wO/SL+ipWtyNpbFbkG
         GWRX0ru1Su5GzOZsd7WpVUSaWKbr/cWAJBVOzbdn7BxmszcuhyAw49inKtuhPN7zMJv8
         Poul9Adite1kg1UchkYMA6b2My9Bv+V93mlBdopZmedIUIr8WrXNux36etHw+2Ua9/J0
         fP0Eeyed8uYx+nVE2UTTQeLvck+DcB8ENfh3N+9FCBChpyKE4wo4h2Bry8Obgo98nuZn
         6dgw==
X-Forwarded-Encrypted: i=1; AJvYcCV0TtGP+Ww777HjZnl4X2HZWrv/AafOVwqwmQZ2gWxENM+yA25dIg5pD9QLbTZ06oPFkYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGMzArvXeYkWXe/BfbfILssKY19hOH/L6j7yzO5xo0EoT/JCn
	zPJjcyoHL97n8bicjREblYFWoz9qzLmN/jzN2+0vUtHnWufZ2nd/vI0cmyq9CnEOSXZGi5AtEXi
	2DREQgrDpuQ1Z8swCcEZilRp3PF1HwUI7msWZ9GL/Dz6bUrdq3Q==
X-Gm-Gg: ASbGncvDwxY4JtYypywrRdqisYhCPfoRHgIsSfI0fgQO3C///4384aW0PRMWRywUJok
	k9PAxDxjtHgtSYI9bC7LnKq9oOE2YAe/F9Y1Qd2FVh1rv8CLW6QiSb9/3m3jfQTssUtshm8b/J0
	2VZpqMhyDsP+uVpGZ8OkxvMjrv6LMj+l4IHYoGZrc+1dPOgDitBr7zVj2c0iSPW7Ekp+UyOBGsO
	Tb1WIrE8UNPd2llxstx576QUEhSkakRscto5iluuX+HVHMZW0j7/9YR3/2PKsEfuv4g0wsfyO50
	1AISMtxJJWX1
X-Received: by 2002:a17:907:3e82:b0:abf:6f44:bffa with SMTP id a640c23a62f3a-ac252e9e7c4mr968100966b.36.1741444858735;
        Sat, 08 Mar 2025 06:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1kymkWxueuBLuXgFuW5FEYCy8fXWaTM8cfTQUCfcHK7lgqp5/vZPe/5nwj4qhwZPGfcHS0w==
X-Received: by 2002:a17:907:3e82:b0:abf:6f44:bffa with SMTP id a640c23a62f3a-ac252e9e7c4mr968098366b.36.1741444858267;
        Sat, 08 Mar 2025 06:40:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394859b2sm447048166b.69.2025.03.08.06.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 06:40:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 69D1918FA096; Sat, 08 Mar 2025 15:40:51 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Gaurav Batra
 <gbatra@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, IOMMU
 <iommu@lists.linux.dev>, MM <linux-mm@kvack.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v11 0/4] fix the DMA API misuse problem for
 page_pool
In-Reply-To: <40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com>
References: <20250307092356.638242-1-linyunsheng@huawei.com>
 <87v7slvsed.fsf@toke.dk> <40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 08 Mar 2025 15:40:51 +0100
Message-ID: <875xkj1t70.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 3/7/2025 10:15 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> ...
>
>>=20
>> You are making this incredibly complicated. You've basically implemented
>> a whole new slab allocator for those page_pool_item objects, and you're
>> tracking every page handed out by the page pool instead of just the ones
>> that are DMA-mapped. None of this is needed.
>  > > I took a stab at implementing the xarray-based tracking first sugges=
ted
>> by Mina[0]:
>
> I did discuss Mina' suggestion with Ilias below in case you didn't
> notice:
> https://lore.kernel.org/all/0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.c=
om/

I didn't; thanks for the pointer. See below.

> Anyway, It is great that you take the effort to actually implement
> the idea to have some more concrete comparison here.

:)

>>=20
>> https://git.kernel.org/toke/c/e87e0edf9520
>>=20
>> And, well, it's 50 lines of extra code, none of which are in the fast
>> path.
>
> I wonder what is the overhead for the xarray idea regarding the
> time_bench_page_pool03_slow() testcase before we begin to discuss
> if xarray idea is indeed possible.

Well, just running that benchmark shows no impact:

|                               |      Baseline     |     xarray      |
|                               |   Cycles |     ns | Cycles |     ns |
|-------------------------------+----------+--------+--------+--------|
| no-softirq-page_pool01        |       20 |  5.713 |     19 |  5.516 |
| no-softirq-page_pool02        |       56 | 15.560 |     57 | 15.864 |
| no-softirq-page_pool03        |      225 | 62.763 |    222 | 61.728 |
| tasklet_page_pool01_fast_path |       19 |  5.399 |     19 |  5.505 |
| tasklet_page_pool02_ptr_ring  |       54 | 15.090 |     54 | 15.018 |
| tasklet_page_pool03_slow      |      238 | 66.134 |    239 | 66.498 |

...however, the benchmark doesn't actually do any DMA mapping, so it's
not super surprising that it doesn't show any difference: it's not
exercising any of the xarray code. Your series shows a difference on
this benchmark only because it does the page_pool_item allocation
regardless of whether DMA is used or not.

I guess we should try to come up with a micro-benchmark that does
exercise the DMA code. Or just hack up the xarray patch to do the
tracking regardless, for benchmarking purposes.

>> Jesper has kindly helped with testing that it works for normal packet
>> processing, but I haven't yet verified that it resolves the original
>> crash. Will post the patch to the list once I have verified this (help
>> welcome!).
>
> RFC seems like a good way to show and discuss the basic idea.

Sure, I can send it as an RFC straight away if you prefer. Note that I'm
on my way to netdevconf, though, so will probably have limited time to
pay attention to this for the next week or so.

> I only took a glance at git code above, it seems reusing the
> _pp_mapping_pad for pp_dma_index seems like a wrong direction
> as mentioned in discussion with Ilias above as the field might
> be used when a page is mmap'ed to user space, and reusing that
> field in 'struct page' seems to disable the tcp_zerocopy feature,
> see the below commit from Eric:
> https://github.com/torvalds/linux/commit/577e4432f3ac810049cb7e6b71f4d96e=
c7c6e894
>
> Also, I am not sure if a page_pool owned page can be spliced into the fs
> subsystem yet, but if it does, I am not sure how is reusing the
> page->mapping possible if that page is called in __filemap_add_folio()?
>
> https://elixir.bootlin.com/linux/v6.14-rc5/source/mm/filemap.c#L882

Hmm, so I did look at the mapping field, but concluded using it wouldn't
interfere with anything relevant as long as it's reset back to zero
before the page is returned to the page allocator. However, I definitely
missed the TCP zero-copy thing, and other things as well, it would seem
(cf the discussion you referred to above).

However, I did consider alternatives: AFAICT there should be space in
the pp_magic field (used for the PP_SIGNATURE), so that with a bit of
care we can stick an ID into the upper bits and still avoid ending up
with a value that could look like a valid pointer.

I didn't implement that initially because I wasn't sure it was
necessary, but seeing as it is, I will take another look at it. I have
one or two other ideas if this turns out not to pan out.

-Toke


