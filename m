Return-Path: <bpf+bounces-5424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6826175A70D
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C691C212AD
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 06:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDC156D1;
	Thu, 20 Jul 2023 06:58:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919414011;
	Thu, 20 Jul 2023 06:58:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FA5CC;
	Wed, 19 Jul 2023 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tpFZ9x/guiUwHSLCuwqhF00CriObkSLCrgFFWuig6CE=; b=vB2sfpF99Y6Hfs52IwYhy9ldql
	ERLNEp2xxsdUaVRoJT10S6gTAPE5tnR+qAB7f7VfX0oX3cOvJqF8fo6g4mLDnd2PfYTu5xml5wpBL
	iLd5oZCQhLBDRU1MM+/3xNT+ybh/tfavVoX8x9yRLTvtQCc0T+1YPbdWgG4AKB5pPD0xBiW5OseL1
	/zQX9OQWGDorBtGNe64ykoJ5nN5nJnCXu0CXEEpu3OJ0vh3QZeCmjqqBdd2u9lp80cpW9EWIXxZmy
	ZHJvBWVZHCkBYssiD6i2zCYMydZaLn0q9H/9vql01rlU702eUQirQH8MkQa+KhiTVGWXM1wZ3PRUf
	qcvSFVfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qMNbj-00A1hF-06;
	Thu, 20 Jul 2023 06:57:51 +0000
Date: Wed, 19 Jul 2023 23:57:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <ZLja73TJ1Ow19xdr@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <1689835514.217712-8-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689835514.217712-8-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 02:45:14PM +0800, Xuan Zhuo wrote:
>  virtqueue_dma_dev() return the device that working with the DMA APIs.
>  Then that can be used like other devices. So what is the problem.
> 
>  I always think the code path without the DMA APIs is the trouble for you.

Because we now have an API where the upper level drivers sometimes
see the dma device and sometimes not.  This will be abused and cause
trouble sooner than you can say "layering".

