Return-Path: <bpf+bounces-7799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE0277C8DE
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 09:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053172813E2
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D89BA26;
	Tue, 15 Aug 2023 07:50:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366425242
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 07:50:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25909172A
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692085838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUb2n6Q11KVMArkdv0WcRmLKrFLcgRyJRWatuAzlaDY=;
	b=U6jN1H5lo0nfUfm5EFL3f+knEauKYJF0K/SZtdiVoG6JsmR5cRk9Ows5rcZLZh4nZ0tuVW
	VqzYl181x/G+hYBCJjpdkV503RD7JMn58gLg2h4Z9toXn2+izCLZ8vD3qZdUtJymyLD8F+
	YRGMS8WFsHX/AU8BuHm5+DlsbNRikgE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-7pbaE3C_OFOOXnUW3V9OMA-1; Tue, 15 Aug 2023 03:50:36 -0400
X-MC-Unique: 7pbaE3C_OFOOXnUW3V9OMA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9dc1bfddcso29954591fa.0
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 00:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692085835; x=1692690635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUb2n6Q11KVMArkdv0WcRmLKrFLcgRyJRWatuAzlaDY=;
        b=QM7C15E1PH45BYtst1Wj+krGEYSbtzx4thSI6Enbh4bdxE2rSo9G6umOp4nB/34WkD
         vqNqnY9BpEUQYrVxD3M0sJTONQ1yEGG7vp9emRYdHBrI9CdEZmGijJv8H1UJPhWJLIUh
         nJGQ2p2qIh2wLcPVNP19GOmyuHhPy7TLA4YgvYzZiv3svxkqHEACsjr5FRDMGXR4lCxg
         xVeTPLEpVzwYK3Mzy9tP/OHaXnf4qvWVeyYKYLGSewUdqJdlw2lpr4ioIccJ/H7PpY3Y
         iqdn86LwL/VH1S+0/7JeYQ9nTIDkivzizuKcVGXC7hB8g0Ahd5KBoCYudI9xnh+8pFQF
         Tjag==
X-Gm-Message-State: AOJu0YzUqh+adG1eoQZ6n4EiwJ1hxg4PMutORUz3Rec/d/7DRkTQK8xt
	3akkHUcOa74dL0Ukb0UoS5gTeabSudHsTbBe8+fyId71NXkZPBuPsH4jccdSXqLRkUMIeiGx1Ir
	6WKi5NLJbP5CvDp7XsaN3ziuLUKQL
X-Received: by 2002:a2e:b5cd:0:b0:2ba:8197:5b42 with SMTP id g13-20020a2eb5cd000000b002ba81975b42mr364201ljn.10.1692085835596;
        Tue, 15 Aug 2023 00:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2PAmBtKQ9ZnmjhZ9eS5fy7BGjFEsLr29JIN9ZtyHi+hnDN0FBcYAl19yjmo+5USD8xM2Rvyvilm8K6oTA9Eo=
X-Received: by 2002:a2e:b5cd:0:b0:2ba:8197:5b42 with SMTP id
 g13-20020a2eb5cd000000b002ba81975b42mr364187ljn.10.1692085835304; Tue, 15 Aug
 2023 00:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com> <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 15:50:23 +0800
Message-ID: <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 2:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
>
> Hi, Jason
>
> Could you skip this patch?

I'm fine with either merging or dropping this.

>
> Let we review other patches firstly?

I will be on vacation soon, and won't have time to do this until next week.

But I spot two possible "issues":

1) the DMA metadata were stored in the headroom of the page, this
breaks frags coalescing, we need to benchmark it's impact
2) pre mapped DMA addresses were not reused in the case of XDP_TX/XDP_REDIR=
ECT

I see Michael has merge this series so I'm fine to let it go first.

Thanks

>
> Thanks.
>


