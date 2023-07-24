Return-Path: <bpf+bounces-5749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC876003D
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5434281449
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67D10948;
	Mon, 24 Jul 2023 20:06:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946A101CF
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:05:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA89610D9
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690229157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYP2jsSM7wu6tSo9cTMLY8NXdl2pRsOxDL4GNzMi1ow=;
	b=CNR+BUo56n98a7o8dhCFyx9e53UXFB1HPN4zDTeyZ3ALzyxZ9XwXDRvtqhpXC1uwX3bE5D
	fp+bFUYSg8Oa/KCVFie1Dc6MIWxgH62fxNOJ8/UUHu4oCEEG7N953K7k5NxqUdW9u/jgVh
	LKyANYY9AWMkbHXeMR5hVF0C1olglLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Zrq9VtV7Mq-xVwPvR3-DBA-1; Mon, 24 Jul 2023 16:05:56 -0400
X-MC-Unique: Zrq9VtV7Mq-xVwPvR3-DBA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31421c900b7so2812708f8f.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229155; x=1690833955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYP2jsSM7wu6tSo9cTMLY8NXdl2pRsOxDL4GNzMi1ow=;
        b=VpbCTNXEXVSeuBqHs2i+o2rtACMLGZHpFYM4VtwptCu3cPQuLN5y7s5WXf6b8iaqew
         4nbJNseI4IwlMbwGSXWKO8WxhxMctR/bpCyZqjJ19IncJDQWeLUFXhpqm/v8WD0NTYR4
         h7/S0sF/krh3gDOtXDZhke4WUHCjc/gcHKvm3pzv0juCyhcXnC12hAVz0+oMe/OoSz4W
         vk1asa+gn/E1mWwIH7gQxH97YDfl4aqeTGtBZ6VknmGkZZ4kJA8unbfX2LBInKjKMdd+
         tmkQXGolPcbcqggPRxcW/1Zn656eoMUUdMNyUOUszT3r1Qu+/1+SiQ7so5OqdmNfsm6t
         vpdA==
X-Gm-Message-State: ABy/qLZ4M4AleRI1hrEM+m6AiWeFN8gPu/uH+o3ax2Qn3NOpgKSulnYw
	nxx6jjVu4XykTsPuEhnyfSCwMNL5cTfFxd+iLF+LEcnCC4X3DDOHij1bzyobUQrzP4BzW1uH5rM
	Dp5DC8rP+WjMo
X-Received: by 2002:adf:eb05:0:b0:315:a043:5e03 with SMTP id s5-20020adfeb05000000b00315a0435e03mr8052324wrn.55.1690229154963;
        Mon, 24 Jul 2023 13:05:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8FTgAqrCH/MKiiYnFPararbVVgu6QGFkBPQebzHQooTua9/IeyBAZ0Zi401PXfeUNSe4JJA==
X-Received: by 2002:adf:eb05:0:b0:315:a043:5e03 with SMTP id s5-20020adfeb05000000b00315a0435e03mr8052311wrn.55.1690229154666;
        Mon, 24 Jul 2023 13:05:54 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7ce0f000000b0052238bc70ccsm1181121edv.89.2023.07.24.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 13:05:53 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:05:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
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
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230724160511-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <1689835514.217712-8-xuanzhuo@linux.alibaba.com>
 <ZLja73TJ1Ow19xdr@infradead.org>
 <1689838441.2670174-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689838441.2670174-9-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 03:34:01PM +0800, Xuan Zhuo wrote:
> On Wed, 19 Jul 2023 23:57:51 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Jul 20, 2023 at 02:45:14PM +0800, Xuan Zhuo wrote:
> > >  virtqueue_dma_dev() return the device that working with the DMA APIs.
> > >  Then that can be used like other devices. So what is the problem.
> > >
> > >  I always think the code path without the DMA APIs is the trouble for you.
> >
> > Because we now have an API where the upper level drivers sometimes
> > see the dma device and sometimes not.
> 
> No dma device is just for the old devices.
> 
> The API without DMA dev are only compatible with older devices. We can't give up
> these old devices, but we also have to embrace new features.
> 
> > This will be abused and cause
> > trouble sooner than you can say "layering".
> 
> I don't understand what the possible trouble here is.
> 
> When no dma device, the driver just does the same thing as before.
> 
> Thanks.

Instead of skipping operations, Christoph wants wrappers that
do nothing for non dma case.

-- 
MST


