Return-Path: <bpf+bounces-39725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB54976BF2
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64841F27BE8
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0F1B3F3A;
	Thu, 12 Sep 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8f4WN0B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF441B013F
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151141; cv=none; b=CeRPXl1sE5krOPv7CgFOWwP/rsR0NV07GlHw1QIlp3UiYVnoLwHl/iFG1nz+k20t0M0zNViImn72gDr3oYYEaAFbyzKVSa+G88LtYGyk8zrgAUMS86IsMOTqmJONNsAl0ZyDdF9lG58BeHpDdexFx23AjS78jRmVmtWqn/3Zk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151141; c=relaxed/simple;
	bh=8OYqBuEjfe5EjdWcxDT76k63UIQ5ek8DyxYuIqau7AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRr1uK8zoH88LDFK+WD7YX21hPcbqu3OxBimsAMeBUoqmny7n0wtV/GZ+P/6QzqyaRWdekbr2zbKeVw8OskHZuzREsLIgmCCmZGrdKmrpX/uJ2+gx1Z3NAIjQbvbCXwHPG1dvhGwENGV2BPCF9dNaGqvw4t1aP6uTwrh0lU6rI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8f4WN0B; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4582fa01090so281481cf.0
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726151138; x=1726755938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwLc+XjyWhYA8wehQi12J7lKOf62muLl4QoZfdwa35k=;
        b=T8f4WN0B1r0Ru+CIVCuCki26uryBc7LHH9HWG+2A03bvVo2ecFCy+FpKoE3PBVVA9J
         ObyU3VA6wYjRzpbFQQxiFTNiT0tkfP2eIvjdQel3Ljfd0heCfijLWZGG6lmRNml/fAH9
         WLe0Ky2aBnRy0I3NSE/T+CJgCzH/3uvew02aesnXrljPFkOtJBzruKmC5kZJpMcUmo86
         quMhUdM9krrv1wrsiljAq3RUizV66IYw1aZvwyGxWXlyWcXNCs0OvOSmFSbcVzGIN5HZ
         grXK2u9oq2LvWdWRKoGHnwWwI83D/BvGWKhbdFR+sm/uccV0q/HHUqGLFTullfY4HMqX
         D9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151138; x=1726755938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwLc+XjyWhYA8wehQi12J7lKOf62muLl4QoZfdwa35k=;
        b=nfWZPr735QCSiAhupZ8SiBaHTMrX+7+guqLiT6aFNso/5tS+h9TQ+LRaIb7Jp7iqNp
         IZ6gOYox8VUccgAnAKKd4wHbYctYZnsEENVwxoesD87MJbutCoTEN6a3plZdOJu9jDZS
         KwVSkBZEEh+o2NZXXSrAiWDXmuPBTx8dEO6oDfFVpotXV2ZAjGQRJQEUsvVUKOuszX99
         n2U7tOLi2EXjcIorEDOxmUZPPLwrHWhXjQMe+mzf34XsMD94b1TV9PCoRVhArlt/FcG+
         C2evBAEy7AhHlutKMN4QKuDVOjrBNIv4T0Z1jWDGAKy/oiDy9s3mPixqnG9D3teCrMAK
         p7IA==
X-Forwarded-Encrypted: i=1; AJvYcCXr2z3hFyK4SvJTHvXC/ElvOhuQM1PEPsApO74Ux4XfKlpFMweFirUP1Np3X5/dVY1socY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1HIg+5UCYErNw3r29fc/B7ArEavL6tNgsAo1SKwaXv4uXqXT
	3qaMCgvipzPJvoPxNcPcHy1bAYPRK1MuuWR0hrY+QC0ZP4OYUc/YYTK2bKciIgL2IFpOgMYGMI/
	WehVyAbZnwJN+hM0l+zknBia8G79i/iwTsfqI
X-Google-Smtp-Source: AGHT+IFyltmncYSZz561uPWQsvsGb5DFmLf+mGb3Vo6WS5NNhJE43ms4WKqkq6D4X3fyD6kxk1+1bYCNn1kURkFiU6A=
X-Received: by 2002:a05:622a:202:b0:456:7f34:f560 with SMTP id
 d75a77b69052e-458608812bdmr4020001cf.22.1726151137360; Thu, 12 Sep 2024
 07:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912124514.2329991-1-linyunsheng@huawei.com> <20240912124514.2329991-3-linyunsheng@huawei.com>
In-Reply-To: <20240912124514.2329991-3-linyunsheng@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 07:25:23 -0700
Message-ID: <CAHS8izPc8fy08mL1RJtnxiOvTx=Uk037Q5SKobC80jQocEKMJQ@mail.gmail.com>
Subject: Re: [RFC 2/2] page_pool: fix IOMMU crash when driver has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, 
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

On Thu, Sep 12, 2024 at 5:51=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.
>
> As mentioned in [1], attempting DMA unmaps after the driver
> has already unbound may leak resources or at worst corrupt
> memory. Fundamentally, the page pool code cannot allow DMA
> mappings to outlive the driver they belong to.
>
> Currently it seems there are at least two cases that the page
> is not released fast enough causing dma unmmapping done after
> driver has already unbound:
> 1. ipv4 packet defragmentation timeout: this seems to cause
>    delay up to 30 secs:
>
> 2. skb_defer_free_flush(): this may cause infinite delay if
>    there is no triggering for net_rx_action().
>
> In order not to do the dma unmmapping after driver has already
> unbound and stall the unloading of the networking driver, add
> the pool->items array to record all the pages including the ones
> which are handed over to network stack, so the page_pool can
> do the dma unmmapping for those pages when page_pool_destroy()
> is called.
>

The approach in this patch is a bit complicated. I wonder if there is
something simpler that we can do. From reading the thread, it seems
the issue is that in __page_pool_release_page_dma we're calling
dma_unmap_page_attrs() on a pool->p.dev that has been deleted via
device_del, right?

Why not consider pool->p.dev unusable if pool->destroy_cnt > 0? I.e.
in __page_pool_release_page_dma, we can skip dma_unmap_page_attrs() if
destry_cnt > 0?

More generally, probably any use of pool->p.dev may be invalid if
page_pool_destroy has been called. The call sites can be scrubbed for
latent bugs.

The hard part is handling the concurrency. I'm not so sure we can fix
this without introducing some synchronization between the
page_pool_destroy seeing the device go away and the code paths using
the device. Are these being called from the fast paths? Jespers
benchmark can tell for sure if there is any impact on the fast path.

> Note, the devmem patchset seems to make the bug harder to fix
> and to backport too, this patch does not consider fixing the
> case for devmem yet.
>

FWIW from a quick look I did not see anything in this patch that is
extremely hard to port to netmem. AFAICT the issue is that you skipped
changing page_pool to page_pool_items in net_iov. Once that is done, I
think the rest should be straightforward.

--=20
Thanks,
Mina

