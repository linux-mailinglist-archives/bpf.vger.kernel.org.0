Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1018629D5AE
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgJ1WH4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 18:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgJ1WHx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F180C0613D1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:07:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so690959wmj.5
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3343xBR6Dh8ReqfCLw87tn1NRZEnZI2QE0JKqvpe3RQ=;
        b=UeGIUCYf4rMMvGrBFcfgqoeNyTLPK74/k2cpwpIKm1lI6HnZFLbu5AbAmBinLPJyR6
         netuM+8vftn2IsJGrQ96qtdRUNT71tjGrij2fhuVL3lsXxELreIwA/VtpgjbY76O+Q71
         LOQJwNPsqK1L0+RpGf9PcgsjKQF/g1IU5uE6L92K8bREKCvZ3limjOxNKsvsL6Rv0Ggj
         b+SsguMqzNsnQy9VAyajs0kfL6rTuK91IiwPErOUNIwqtPS5PDj+9AxChl+AgzylZysI
         bMGqKovsK/i4MEcHEtO+jiTcPnZN8dGVccHntm/hznTqQo5nqgYhNn/jXwOfrpwr7gx0
         WL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3343xBR6Dh8ReqfCLw87tn1NRZEnZI2QE0JKqvpe3RQ=;
        b=dPB29EbyXmKkDix+nVQWgTTzw2ibvNYy+Q486lLUliGXVv+5nWG5ef/nNhZO+LGVy+
         vn0mcCW6t5bM1Cs1HukcKh7+2oow7Qg5dxHs5k1Fx7puiHf02KRYgo/HT00M1P6+Jw6s
         iUWKVPV9D83ebID+4yQ2Z/QgPUZmZiwt7ICOszm1Skn/Rmr9iqXZ33aLUZdeolnbk4GV
         e3cYXYgEUFBCv/K/dvlBkG8SBwd1ruMJp7qvyYzpx7vj/bwUjhOoR6B4sqHpJgIUB2a5
         dHaI50q7lEejsHdo/4V+7LZQtecnJLT37r5gUnKUMCa3YgOeNYZO8BfD0PpooAB+GK4Z
         MrlQ==
X-Gm-Message-State: AOAM530sOcDaxAJnGGkWf6kvY83fsSYCmaYgGldPGuEax7gm+C4LrUGc
        O4BrVOEr3g36HOY17+ODzA0t5fIWpmX5mg==
X-Google-Smtp-Source: ABdhPJwRmPZ19EMONpRJ9E2HxVwN/78IR48z/vUl35sS6mMnJKvxqelK2haM2QP6Ghu6uFetH9OYxQ==
X-Received: by 2002:a1c:9dcc:: with SMTP id g195mr6853796wme.113.1603877258354;
        Wed, 28 Oct 2020 02:27:38 -0700 (PDT)
Received: from apalos.home (athedsl-246545.home.otenet.gr. [85.73.10.175])
        by smtp.gmail.com with ESMTPSA id 4sm5971871wrp.58.2020.10.28.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 02:27:37 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:27:34 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        brouer@redhat.com
Subject: Re: [PATCH net-next 1/4] net: xdp: introduce bulking for xdp tx
 return path
Message-ID: <20201028092734.GA51291@apalos.home>
References: <cover.1603824486.git.lorenzo@kernel.org>
 <7495b5ac96b0fd2bf5ab79b12e01bf0ee0fff803.1603824486.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7495b5ac96b0fd2bf5ab79b12e01bf0ee0fff803.1603824486.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Lorenzo,

On Tue, Oct 27, 2020 at 08:04:07PM +0100, Lorenzo Bianconi wrote:
> Introduce bulking capability in xdp tx return path (XDP_REDIRECT).
> xdp_return_frame is usually run inside the driver NAPI tx completion
> loop so it is possible batch it.
> Current implementation considers only page_pool memory model.
> Convert mvneta driver to xdp_return_frame_bulk APIs.
> 
> Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/marvell/mvneta.c |  5 ++-
>  include/net/xdp.h                     |  9 +++++
>  net/core/xdp.c                        | 51 +++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 54b0bf574c05..43ab8a73900e 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -1834,8 +1834,10 @@ static void mvneta_txq_bufs_free(struct mvneta_port *pp,
>  				 struct netdev_queue *nq, bool napi)
>  {
>  	unsigned int bytes_compl = 0, pkts_compl = 0;
> +	struct xdp_frame_bulk bq;
>  	int i;
>  
> +	bq.xa = NULL;
>  	for (i = 0; i < num; i++) {
>  		struct mvneta_tx_buf *buf = &txq->buf[txq->txq_get_index];
>  		struct mvneta_tx_desc *tx_desc = txq->descs +
> @@ -1857,9 +1859,10 @@ static void mvneta_txq_bufs_free(struct mvneta_port *pp,
>  			if (napi && buf->type == MVNETA_TYPE_XDP_TX)
>  				xdp_return_frame_rx_napi(buf->xdpf);
>  			else
> -				xdp_return_frame(buf->xdpf);
> +				xdp_return_frame_bulk(buf->xdpf, &bq);
>  		}
>  	}
> +	xdp_flush_frame_bulk(&bq);
>  
>  	netdev_tx_completed_queue(nq, pkts_compl, bytes_compl);
>  }
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 3814fb631d52..9567110845ef 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -104,6 +104,12 @@ struct xdp_frame {
>  	struct net_device *dev_rx; /* used by cpumap */
>  };
>  
> +#define XDP_BULK_QUEUE_SIZE	16
> +struct xdp_frame_bulk {
> +	void *q[XDP_BULK_QUEUE_SIZE];
> +	int count;
> +	void *xa;
> +};
>  
>  static inline struct skb_shared_info *
>  xdp_get_shared_info_from_frame(struct xdp_frame *frame)
> @@ -194,6 +200,9 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
>  void xdp_return_frame(struct xdp_frame *xdpf);
>  void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
>  void xdp_return_buff(struct xdp_buff *xdp);
> +void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq);
> +void xdp_return_frame_bulk(struct xdp_frame *xdpf,
> +			   struct xdp_frame_bulk *bq);
>  
>  /* When sending xdp_frame into the network stack, then there is no
>   * return point callback, which is needed to release e.g. DMA-mapping
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 48aba933a5a8..93eabd789246 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -380,6 +380,57 @@ void xdp_return_frame_rx_napi(struct xdp_frame *xdpf)
>  }
>  EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
>  
> +void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq)
> +{
> +	struct xdp_mem_allocator *xa = bq->xa;
> +	int i;
> +
> +	if (unlikely(!xa))
> +		return;
> +
> +	for (i = 0; i < bq->count; i++) {
> +		struct page *page = virt_to_head_page(bq->q[i]);
> +
> +		page_pool_put_full_page(xa->page_pool, page, false);
> +	}
> +	bq->count = 0;
> +}
> +EXPORT_SYMBOL_GPL(xdp_flush_frame_bulk);
> +
> +void xdp_return_frame_bulk(struct xdp_frame *xdpf,
> +			   struct xdp_frame_bulk *bq)
> +{
> +	struct xdp_mem_info *mem = &xdpf->mem;
> +	struct xdp_mem_allocator *xa, *nxa;
> +
> +	if (mem->type != MEM_TYPE_PAGE_POOL) {
> +		__xdp_return(xdpf->data, &xdpf->mem, false);
> +		return;
> +	}
> +
> +	rcu_read_lock();
> +
> +	xa = bq->xa;
> +	if (unlikely(!xa || mem->id != xa->mem.id)) {

Why is this marked as unlikely? The driver passes it as NULL. Should unlikely be
checked on both xa and the comparison?

> +		nxa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);

Is there a chance nxa can be NULL?

> +		if (unlikely(!xa)) {

Same here, driver passes it as NULL

> +			bq->count = 0;
> +			bq->xa = nxa;
> +			xa = nxa;
> +		}
> +	}
> +
> +	if (mem->id != xa->mem.id || bq->count == XDP_BULK_QUEUE_SIZE)
> +		xdp_flush_frame_bulk(bq);
> +
> +	bq->q[bq->count++] = xdpf->data;
> +	if (mem->id != xa->mem.id)
> +		bq->xa = nxa;
> +
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
> +
>  void xdp_return_buff(struct xdp_buff *xdp)
>  {
>  	__xdp_return(xdp->data, &xdp->rxq->mem, true);
> -- 
> 2.26.2
> 

Cheers
/Ilias
