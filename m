Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9B29E8A7
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgJ2KNq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 06:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgJ2KNq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 06:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603966425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yF8t+VbcmfxlDKlJ1pFHEIfkVu/3uA0FLN6iI9iGsuo=;
        b=aRdcCOEt8hHH4MmONyX41/JBfoEeCDINpUGwhnbezfC09U/bCG5XN8IUDP/VZowVnLzQWw
        H9/mP/Q1uwm8nrbBumgsD9bmqOaJ6v0x1ziHzVTeB6kADJlyrK48Dn4IGpv/983xFGj0c3
        Ac43rsaL2BhK8pIB7lR8bVbksLn3xB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-yVUY_AQ_Pde9wnq1v7q3uQ-1; Thu, 29 Oct 2020 06:13:43 -0400
X-MC-Unique: yVUY_AQ_Pde9wnq1v7q3uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 998B210082EC;
        Thu, 29 Oct 2020 10:13:41 +0000 (UTC)
Received: from carbon (unknown [10.36.110.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83C6C6EF71;
        Thu, 29 Oct 2020 10:13:30 +0000 (UTC)
Date:   Thu, 29 Oct 2020 11:13:29 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ilias.apalodimas@linaro.org, brouer@redhat.com
Subject: Re: [PATCH net-next 2/4] net: page_pool: add bulk support for
 ptr_ring
Message-ID: <20201029111329.79b86c00@carbon>
In-Reply-To: <cd58ca966fbe11cabbd6160decea6ce748ebce9f.1603824486.git.lorenzo@kernel.org>
References: <cover.1603824486.git.lorenzo@kernel.org>
        <cd58ca966fbe11cabbd6160decea6ce748ebce9f.1603824486.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 27 Oct 2020 20:04:08 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> +void page_pool_put_page_bulk(struct page_pool *pool, void **data,
> +			     int count)
> +{
> +	struct page *page_ring[XDP_BULK_QUEUE_SIZE];

Maybe we could reuse the 'data' array instead of creating a new array
(2 cache-lines long) for the array of pages?

> +	int i, len = 0;
> +
> +	for (i = 0; i < count; i++) {
> +		struct page *page = virt_to_head_page(data[i]);
> +
> +		if (unlikely(page_ref_count(page) != 1 ||
> +			     !pool_page_reusable(pool, page))) {
> +			page_pool_release_page(pool, page);
> +			put_page(page);
> +			continue;
> +		}
> +
> +		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> +			page_pool_dma_sync_for_device(pool, page, -1);

Here we sync the entire DMA area (-1), which have a *huge* cost for
mvneta (especially on EspressoBin HW).  For this xdp_frame->len is
unfortunately not enough.  We will need the *maximum* length touch by
(1) CPU and (2) remote device DMA engine.  DMA-TX completion knows the
length for (2).  The CPU length (1) is max of original xdp_buff size
and xdp_frame->len, because BPF-helpers could have shrinked the size.
(tricky part is that xdp_frame->len isn't correct in-case of header
adjustments, thus like mvneta_run_xdp we to calc dma_sync size, and
store this in xdp_frame, maybe via param to xdp_do_redirect). Well, not
sure if it is too much work to transfer this info, for this use-case.

> +
> +		page_ring[len++] = page;

> +	}
> +
> +	page_pool_ring_lock(pool);
> +	for (i = 0; i < len; i++) {
> +		if (__ptr_ring_produce(&pool->ring, page_ring[i]))
> +			page_pool_return_page(pool, page_ring[i]);
> +	}
> +	page_pool_ring_unlock(pool);
> +}
> +EXPORT_SYMBOL(page_pool_put_page_bulk);



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

