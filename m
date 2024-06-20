Return-Path: <bpf+bounces-32581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5DB91018E
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1731C2186B
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A22594;
	Thu, 20 Jun 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ld3rbAwk"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D818EFEC;
	Thu, 20 Jun 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879862; cv=none; b=euGVbEo7X+3sOHudMEE4gGSbdHch8DcqJpNcsJt46Z/uMq/++Keu0Si/fCa0+K1126pc9hwNJ1bJKZs468kbSCVQ/aepphhcPj2xn1AddCUnh/Ci0jPmcheU+1JiMQrJC97XarBMsa8VgAZYe0HhRITGG0rgUkrR/0cKGmpSJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879862; c=relaxed/simple;
	bh=6aDztqjSTnaUeyltlCrlvYeHxUXqJDK5o3/xDHh0avg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=kBZ3XOQSOgEivsvRXEoH93YLcGnliW0+HWdLPm+Z6Ij20TLiy4lh79j7ay5ocPQKbxHtBDEYANzveqco8FVjpOj6R5SE7PypUG6QQtLlWuY52phkaYMGJwpJdFfgzE/03JHZBuc6IVS+DJ4qiVU5brSYWCMm7nB+ac9UmVrv3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ld3rbAwk; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718879857; h=Message-ID:Subject:Date:From:To;
	bh=VqYPr1Mqwxx2tXIhyczp5dCPFE4y5M+KHrE+laJzF9c=;
	b=ld3rbAwkF23bgMEtdED3uEtjjMZ/UptHQZljvKK8jPV4Low7NYjKUvZp4mLslYh3W6PbzcbTWju1RLiVwf2c+YTXto+4w0dz/BcHd9TdkPSEgDcvdVePctAHV61b1IZ1jR0TW1scqr+BqEOCCz9BiUZ45F7CsTf72P85jhXwfos=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8s8VNH_1718879855;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8s8VNH_1718879855)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 18:37:36 +0800
Message-ID: <1718879832.544193-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill with xsk buffer
Date: Thu, 20 Jun 2024 18:37:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
 <3554649e61063491cc3a04222c7dff68d46c2f99.camel@redhat.com>
In-Reply-To: <3554649e61063491cc3a04222c7dff68d46c2f99.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 12:20:44 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> Hi,
>
> On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> > @@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
> >  	}
> >  }
> >
> > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
> > +{
> > +	sg->dma_address = addr;
> > +	sg->length = len;
> > +}
> > +
> > +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
> > +				   struct xsk_buff_pool *pool, gfp_t gfp)
> > +{
> > +	struct xdp_buff **xsk_buffs;
> > +	dma_addr_t addr;
> > +	u32 len, i;
> > +	int err = 0;
>
> Minor nit: the reverse xmas tree order is based on the full line len,
> should be:
> 	int err = 0;
> 	u32 len, i;

Will fix.

>
> [...]
> > @@ -2226,6 +2281,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> >  		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
> >  	}
> >
> > +	oom = err == -ENOMEM;
> >  	return !oom;
>
> Minor nit: 'oom' is used only in the above to lines. You could drop
> such variable and just:
> 	return err != -ENOMEM;

Will fix.

>
> Please _do not_ repost just for the above, but please include such
> changes if you should repost for other reasons.

OK.


>
> Also try to include a detailed changelog in each patch after the tag
> area and a '---' separator, it will simplify the review process.

Will do.

Thanks.


>
> Thanks,
>
> Paolo
>

