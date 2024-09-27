Return-Path: <bpf+bounces-40384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD2987E06
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 07:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF45B231F5
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 05:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF0817836E;
	Fri, 27 Sep 2024 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lptup54I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E911741C3
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416458; cv=none; b=OD+YylUb6gxoFNnlz9clWdbhGSl/JpURvNGtLXUcK9OJe7jI22pJNPRNzKcI68PoKxpjwSXPoOpX62GnszWSqKSmnMIJ5RnoihhelyPUZqk752K3Y7FU+Nc8UzPCmLi3zzm7ESk2yIB/41z8N7jBWY2GlZ6L9TBTxuvk5PQ3a6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416458; c=relaxed/simple;
	bh=G4hpnvLo0m/PQe/eCqe2pef7O4TSc1+b2w1IPvUZUSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXFY+RNXJnisTe+hJN2s90aw/MTxl5NFL9w/NWwaskyRMHamLvcemi79NHJzOckplx0x53Hjs/omASW25xaMS44aL+nX85leckg9CBhLf3j1KqrA8NjZiECumw9Z4q7wWR+kWnxOqkQ9c8m96zGtBDMNQllIt1uwHZvygNWmrCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lptup54I; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582fa01090so166311cf.0
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 22:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727416455; x=1728021255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbg8QJSSUgH7Q4nHSRemybsPSlB855qz0uznqiadyvc=;
        b=Lptup54IuW8FcaZfM/tPOF7A8ARekxwdyZJX2+ajQnPBv+RzcTqYiT3Z6aBICNzld7
         B3Jshr6LVb0Im1ZhLfCuT6aLVrGmAOyGucG529+ZfR9k+mJUowt1IGcuWPXJ1GhGC0fy
         zG7SipmI90f3ZLqWmjc1ftKXkvAOHdtbm3jOo+zK6M6YCl9Y1P7yf7uPl5KkV37L8mHe
         2Xp2AbrEgMRgoHRpcSO8iYovN4fkqXlhg0fPiySP/BfdNmtkdlnWR/ZWk7i7h5sE31RX
         B09848O4DfjmVnRJhF8mL5q/xiTb9kLFvVd6U5a1By8SEUIyiNhDKwD73gsdWNTNN90y
         rd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727416455; x=1728021255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbg8QJSSUgH7Q4nHSRemybsPSlB855qz0uznqiadyvc=;
        b=nJ2lkLQhwFBhQ1E9eKIN73WWGg/Qrua3u2LzS40GDmo+T5RpPyYRF+JIcE2BqsCCRj
         ulE47rlSRxZoPdKshoI+UGcvfgfw/ET1QZIHMd6wIEUBHrqvoVhapKS6rN4wLd7+VyzW
         zW3ThQGFIPPK48PQMyV37KdOV+EUA9p47VnQszL++w7ZPyUeon2pH2szJtBd119nPv7m
         geskJSVDTi3VMm6kUjjMYIzt0FReYv+ujlVOO8IlLrTol9PygJGSm09jXgV24cPJ5aAZ
         atv0YjYe/JWZ+yc2hcwHkIaQK9lw7BV8M7PxirLkLHVJEkAZJ5ZNK7QEgk/jhwyXX73N
         P2NA==
X-Forwarded-Encrypted: i=1; AJvYcCWyijkcQ9LKOCzSOsImfOr+uCc6n0gfnL+HojpgO83Cz/UQLakeULCfj49XIvLGju89VDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9DVD87IjNSLqsVluBv3xQwFKRi7GysBoWNfrzEveBtmZ0gfk
	CyKtOcDQv7gPSV5ZTPYBIXBsdC9UunQLdbp0SxuC9b6OqyKoDU3OzmnDSqFADfI9BQhRQ/JtGEK
	bRGM0oNGud/0PCBLAhbOxVy+Kp5FJrFWYuf8O
X-Google-Smtp-Source: AGHT+IFlWAzqms00GpX5qYW9TQZFSIQORw0rsVCeZaOGfdUcQ3vPP90oLkUJ8sEZ5IgWc6qBEG83z217FGnc5KOy/AE=
X-Received: by 2002:a05:622a:7d0e:b0:453:58b6:e022 with SMTP id
 d75a77b69052e-45ca02b0365mr2089571cf.28.1727416455179; Thu, 26 Sep 2024
 22:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com>
In-Reply-To: <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 26 Sep 2024 22:54:01 -0700
Message-ID: <CAHS8izN-3Ooiexsr+Xp2234=GqMUy0sTTMqExKVkXAgmjeWQ6w@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	IOMMU <iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 8:58=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/9/27 2:15, Mina Almasry wrote:
> >
> >> In order not to do the dma unmmapping after driver has already
> >> unbound and stall the unloading of the networking driver, add
> >> the pool->items array to record all the pages including the ones
> >> which are handed over to network stack, so the page_pool can
> >> do the dma unmmapping for those pages when page_pool_destroy()
> >> is called.
> >
> > One thing I could not understand from looking at the code: if the
> > items array is in the struct page_pool, why do you need to modify the
> > page_pool entry in the struct page and in the struct net_iov? I think
> > the code could be made much simpler if you can remove these changes,
> > and you wouldn't need to modify the public api of the page_pool.
>
> As mentioned in [1]:
> "There is no space in 'struct page' to track the inflight pages, so
> 'pp' in 'struct page' is renamed to 'pp_item' to enable the tracking
> of inflight page"
>
> As we still need pp for "struct page_pool" for page_pool_put_page()
> related API, the container_of() trick is used to get the pp from the
> pp_item.
>
> As you had changed 'struct net_iov' to be mirroring the 'struct page',
> so change 'struct net_iov' part accordingly.
>
> 1. https://lore.kernel.org/all/50a463d5-a5a1-422f-a4f7-d3587b12c265@huawe=
i.com/
>

I'm not sure we need the pages themselves to have the list of pages
that need to be dma unmapped on page_pool_destroy. The pool can have
the list of pages that need to be unmapped on page_pool_destroy, and
the individual pages need not track them, unless I'm missing
something.

> >
> >> As the pool->items need to be large enough to avoid
> >> performance degradation, add a 'item_full' stat to indicate the
> >> allocation failure due to unavailability of pool->items.
> >>
> >
> > I'm not sure there is any way to size the pool->items array correctly.
>
> Currently the size of pool->items is calculated in page_pool_create_percp=
u()
> as below, to make sure the size of pool->items is somewhat twice of the
> size of pool->ring so that the number of page sitting in the driver's rx
> ring waiting for the new packet is the similar to the number of page that=
 is
> still being handled in the network stack as most drivers seems to set the
> pool->pool_size according to their rx ring size:
>
> +#define PAGE_POOL_MIN_INFLIGHT_ITEMS           512
> +       unsigned int item_cnt =3D (params->pool_size ? : 1024) +
> +                               PP_ALLOC_CACHE_SIZE + PAGE_POOL_MIN_INFLI=
GHT_ITEMS;
> +       item_cnt =3D roundup_pow_of_two(item_cnt);
>

I'm not sure it's OK to add a limitation to the page_pool that it can
only allocate N pages. At the moment, AFAIU, N is unlimited and it may
become a regression if we add a limitation.

> > Can you use a data structure here that can grow? Linked list or
> > xarray?
> >
> > AFAIU what we want is when the page pool allocates a netmem it will
> > add the netmem to the items array, and when the pp releases a netmem
> > it will remove it from the array. Both of these operations are slow
> > paths, right? So the performance of a data structure more complicated
> > than an array may be ok. bench_page_pool_simple will tell for sure.
>
> The question would be why do we need the pool->items to grow with the
> additional overhead and complication by dynamic allocation of item, using
> complicated data structure and concurrent handling?
>
> As mentioned in [2], it was the existing semantics, but it does not means
> we need to keep it. The changing of semantics seems like an advantage
> to me, as we are able to limit how many pages is allowed to be used by
> a page_pool instance.
>
> 2. https://lore.kernel.org/all/2fb8d278-62e0-4a81-a537-8f601f61e81d@huawe=
i.com/
>
> >
> >> Note, the devmem patchset seems to make the bug harder to fix,
> >> and may make backporting harder too. As there is no actual user
> >> for the devmem and the fixing for devmem is unclear for now,
> >> this patch does not consider fixing the case for devmem yet.
> >>
> >
> > net_iovs don't hit this bug, dma_unmap_page_attrs() is never called on
> > them, so no special handling is needed really. However for code
>
> I am really doubtful about your above claim. As at least the below
> implementaion of dma_buf_unmap_attachment_unlocked() called in
> __net_devmem_dmabuf_binding_free() seems be using the DMA API directly:
>
> https://elixir.bootlin.com/linux/v6.7-rc8/source/drivers/gpu/drm/amd/amdg=
pu/amdgpu_dma_buf.c#L215
>
> Or am I missing something obvious here?
>

I mean currently net_iovs don't hit the __page_pool_release_page_dma
function that causes the crash in the stack trace. The dmabuf layer
handles the unmapping when the dmabuf dies (I assume correctly).

--=20
Thanks,
Mina

