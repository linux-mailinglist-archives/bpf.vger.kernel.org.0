Return-Path: <bpf+bounces-7806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E8D77CC32
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 13:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DF11C20A5A
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEAF111B4;
	Tue, 15 Aug 2023 11:58:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68255C9D
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 11:58:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E21985
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692100663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bjmiQ78zXka/be7wSlHzWAbQz0mNi9OuhXjHfAzz0s=;
	b=KQRlDnBHT+PmRsgYNggYvy84rx7SKlI8RBaZWsY8XNd2Tj89hV0nVqNd2PJEPmIdjHHHzO
	bKQ4orG2jTZMkMdCMLwVaidbmEPteRBPQ418BdYLNRqeAQSyIa/ZPMsP2XSAQVALMP6WrH
	Tmm9RWAE87BmAhsG8d821ruWeKZWbL0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-aJA8PonSOT6C3FFoMhTJjQ-1; Tue, 15 Aug 2023 07:57:42 -0400
X-MC-Unique: aJA8PonSOT6C3FFoMhTJjQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-589ac93bc6eso71801257b3.0
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 04:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100661; x=1692705461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bjmiQ78zXka/be7wSlHzWAbQz0mNi9OuhXjHfAzz0s=;
        b=NkcFSCfevONUZAGD0jlYhZ7BUznsp/LAjIrkyiJRZMTSHj7oORs8imRftxMk+GFxlp
         DX3UXiZVYlpfQ0Mm6FAE013LUlSXwdPzeJ38+UrpBGldZTqjBGKVH98R2OP3B7T6rPiP
         CxDw+we2M0P3BkdFN0rjtO8O3gKL0ZPRK7yyKm1+4DZGkVq+Kiyb7SpJohFqiXSDg1ys
         GgWaTdl0ByYsn+Es9JSlnM/bLUWgmL6ZgBOUS7EDEANKhJs7Xi3HURgBXYmR6t+YAazD
         lwMwJ07n2eLjG2nxZ8N+U/fpSuKSy/Jte3sQrcXSHhdmMQCF322o0OK8S+8ntAEOCTHE
         CFCA==
X-Gm-Message-State: AOJu0YyaLdF83RVOGeqPMXJZKfIbFoinVvoEIZbh45gdVBPeQK26zzJV
	z7u1o1agRJ4ohqueyjmaC1SxXKO0+grPVoO7A/vOQSH3wa/6bDM8B6kB9GTXy/fWG+4b49qFFTn
	1vyxUCrfi06hD
X-Received: by 2002:a81:9485:0:b0:579:e318:4c01 with SMTP id l127-20020a819485000000b00579e3184c01mr18861422ywg.19.1692100661584;
        Tue, 15 Aug 2023 04:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa32SRzmLDzRL9d7mFMGVtctsdkaYjp8FEkY7pKzeAFfj3pB6VWOajMjS+DzIe14yU1WjDiw==
X-Received: by 2002:a81:9485:0:b0:579:e318:4c01 with SMTP id l127-20020a819485000000b00579e3184c01mr18861394ywg.19.1692100661208;
        Tue, 15 Aug 2023 04:57:41 -0700 (PDT)
Received: from redhat.com ([172.58.160.133])
        by smtp.gmail.com with ESMTPSA id b4-20020a0dd904000000b005772154dddbsm3327997ywe.24.2023.08.15.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 04:57:40 -0700 (PDT)
Date: Tue, 15 Aug 2023 07:57:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230815075702-mutt-send-email-mst@kernel.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 03:50:23PM +0800, Jason Wang wrote:
> On Tue, Aug 15, 2023 at 2:32 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> >
> > Hi, Jason
> >
> > Could you skip this patch?
> 
> I'm fine with either merging or dropping this.
> 
> >
> > Let we review other patches firstly?
> 
> I will be on vacation soon, and won't have time to do this until next week.
> 
> But I spot two possible "issues":
> 
> 1) the DMA metadata were stored in the headroom of the page, this
> breaks frags coalescing, we need to benchmark it's impact
> 2) pre mapped DMA addresses were not reused in the case of XDP_TX/XDP_REDIRECT
> 
> I see Michael has merge this series so I'm fine to let it go first.
> 
> Thanks

it's still queued for next. not too late to drop or better add
a patch on top.


> >
> > Thanks.
> >


