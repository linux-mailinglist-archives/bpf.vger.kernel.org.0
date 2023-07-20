Return-Path: <bpf+bounces-5417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B375A63F
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F881C212B3
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256DF5246;
	Thu, 20 Jul 2023 06:22:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C81FB0;
	Thu, 20 Jul 2023 06:22:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C5EC;
	Wed, 19 Jul 2023 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HUP+DIpQEJ+J3ZFRioO6mUYK9Zf5foE9GL/pmlIJbNk=; b=Iz/+glSxz/t0efRzHLCvwawV5i
	s53oVWwjCsoWJivSBjVC5gOJkWutebR9IYsqhZOlWiD+m9EjY3fWJEIzuSOV+GRrp7ser7lw3RAl+
	qzuDLZPlpX2vxsEfL+MwrlGiADysLXKc48IQe5ZcQIZFMtSuB6jhY0dGFhKuyAJcvh5F6oxFB9Xz+
	9WA/NVzYCJVnBkhBOkuw4lImcmOcecqX5vQN60DXNzQDPJgjdOPICsuxERIW6EaYQMYM3rFDESLAK
	4C8R3cShxaEzOGc967ydvBWMGBlYIE3fF+IWfM2nHrxpvYuuHBPPGNnA1HalTbyeNJp5I9U7ZTzqQ
	/RzsoQ0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qMN3i-009vOe-0z;
	Thu, 20 Jul 2023 06:22:42 +0000
Date: Wed, 19 Jul 2023 23:22:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <ZLjSsmTfcpaL6H/I@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713104805-mutt-send-email-mst@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 10:51:59AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 13, 2023 at 04:15:16AM -0700, Christoph Hellwig wrote:
> > On Mon, Jul 10, 2023 at 11:42:32AM +0800, Xuan Zhuo wrote:
> > > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > > caller can do dma operation in advance. The purpose is to keep memory
> > > mapped across multiple add/get buf operations.
> > 
> > This is just poking holes into the abstraction..
> 
> More specifically?

Because now you expose a device that can't be used for the non-dma
mapping case and shoud be hidden.

