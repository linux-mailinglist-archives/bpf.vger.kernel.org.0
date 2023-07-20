Return-Path: <bpf+bounces-5430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4210575A906
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 10:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042E5281C83
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7B174D1;
	Thu, 20 Jul 2023 08:21:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63C174C0;
	Thu, 20 Jul 2023 08:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2E2110;
	Thu, 20 Jul 2023 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NqLEMJC7fYxhCSn83KJr6oToHsj8izdq9tSB9Ugi6bU=; b=2d/fYZrKqw67I24WjJ5lvu/zoc
	dul2IKATOMlxqldTLbyOVLkP9BV4xjJCJVylu8pcxCXCLllrbpy2Sb0q0ajxJ5xW6U+Urc6uBhx7J
	W9iV5FEMmaabUufPI+NoOw2c2SDi/JQ73YFg2l8V15JzLVKteaSXww2eHlj6tzh3oa72XEJEto/3o
	xJRhQtdkTQJPVqy4Wo2g64rdSg/gmbUCsTToZ60C7EALMZk99rsLZNLLMqChUkmWdXyQIg1Mulxyr
	jBCLilzUwsIeC4O9IswurY59ogK8VJ8vJJkgn9DXtp4CdhMGY1OoC7QAdys/EZ/XnCr4l1UGmYClk
	ydD/Hqhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOut-00AHtv-3C;
	Thu, 20 Jul 2023 08:21:43 +0000
Date: Thu, 20 Jul 2023 01:21:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one
 page
Message-ID: <ZLjul7mYcMujUfxQ@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEtoiHXese1sNJELeidmFc6nFR8rE1aA8MooaEKKUSw_eg@mail.gmail.com>
 <1689231087.0744615-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsf4+56veqem1HMWiqYhiW5LVw-1CbWX-cQSN6Z0zYMRQ@mail.gmail.com>
 <ZLjS4D7urgIK1MxV@infradead.org>
 <CACGkMEsbzWU3+pA1kLNwGEmwYjP9riRANpUtsmE-YXJmnFAuhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsbzWU3+pA1kLNwGEmwYjP9riRANpUtsmE-YXJmnFAuhw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 03:41:56PM +0800, Jason Wang wrote:
> > Did you actually check that it works though?
> > Looks like with swiotlb you need to synch to trigger a copy
> > before unmap, and I don't see where it's done in the current
> > patch.
> 
> And this is needed for XDP_REDIRECT as well.

DMA always needs proper syncs, be that for swiotlb or for cache
maintainance, yes.

