Return-Path: <bpf+bounces-5418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A975A641
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F41A1C212E6
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 06:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB05248;
	Thu, 20 Jul 2023 06:23:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F9383;
	Thu, 20 Jul 2023 06:23:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B95EC;
	Wed, 19 Jul 2023 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/QvVdhn5LHQNczKlivYbrTWjk8x34Zhu2grRA8NWy1s=; b=AqSaRvK0xTUrt3RAYmXQVISJNF
	9fpaZHhtQPK35TmTHM694ZKj5Mv5poxHf93oJ0wgkHh9vLBM6+g1KSIeXewLheB1mOgC7VlpjYULy
	OvlGox3Oq14nNFTGcn0isyoM0WPWTGaQVLOrzdOm6pSFVOSEpCfiBLRWSO4jO1GbQcjynxdkCo93i
	yR/g+TI8On5I+zW8no3+K71NZa4w59b176DmSyltc+0/ThU+WkRawesYEqLP+5eV4uhwqs3KJ3UKZ
	Rts+zegC4dyjTWH1/eok0G1U2KYo4JmfP/UoVlQbBaIeUYf21p6UAElCJZjGMPd8ctG+UwzB2umo6
	Rpi5Kcuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qMN4S-009vVW-38;
	Thu, 20 Jul 2023 06:23:28 +0000
Date: Wed, 19 Jul 2023 23:23:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one
 page
Message-ID: <ZLjS4D7urgIK1MxV@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEtoiHXese1sNJELeidmFc6nFR8rE1aA8MooaEKKUSw_eg@mail.gmail.com>
 <1689231087.0744615-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsf4+56veqem1HMWiqYhiW5LVw-1CbWX-cQSN6Z0zYMRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsf4+56veqem1HMWiqYhiW5LVw-1CbWX-cQSN6Z0zYMRQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jason,

can you please resend your reply with proper quoting?  I had to give
up after multiple pages of scrolling without finding anything that
you added to the full quote.


