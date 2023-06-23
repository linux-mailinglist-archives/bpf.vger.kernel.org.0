Return-Path: <bpf+bounces-3321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED873C3E2
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 00:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5B41C21360
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005A16438;
	Fri, 23 Jun 2023 22:17:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892C156DF;
	Fri, 23 Jun 2023 22:17:13 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D82723;
	Fri, 23 Jun 2023 15:17:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso729707b3a.3;
        Fri, 23 Jun 2023 15:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687558623; x=1690150623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDXYsfJvatym3Oy6lMJ56GZiSfJfyD1pGvE3gJmovG0=;
        b=L8ikNoet7AueB84+izwdPzlfcYNFwgQKo+7BjsVjRF9Ijxy21C5kmod2iBlrnqsfoO
         rqnKMVCUvBtxkZNYdE+TujU40V7ZQFjnip3OeAzI5HGyq6WexVkUG2AMTC/cnshoFlp/
         UIIeRunkh68jjS5N5s6WQfqRfNha0sFcVGZVXqVrB9bnZgizo0VlcDORdeH3O5fAl1jj
         UfOkvdN3cYVzlcZonnwGwDIWKO8U0X1Sn49gRGd0hrRtFb+8mhQoGqaj4MpqndYrkgtN
         p70+V34SDXgL2INwqzzq27jZNw9y0PAmbPOwTSDr3MlyX+lon6zL409E73eQPRaor0Hq
         Cg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687558623; x=1690150623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDXYsfJvatym3Oy6lMJ56GZiSfJfyD1pGvE3gJmovG0=;
        b=EflEisZ6B7iZMaiBOb1WSsr+fw3P8R2ONhO4+/P4bEMkfq3fxNARJ0Q4R4DOvafjeC
         AjBd4OWzW3ZrvYpdJGycKRSEiSe7he+ofa5+2oG1kseEZ3nWa0TWBr4SZELIJ4I71OPD
         kc0KRElZ3glvTQFON+KBn6R/PR4XiybdHf//m0GaXKHnJl9HhlqcfwUX32B5AXj4oVFA
         Me5etTQilKK9n0pmvWFCNnHvnyjvAXO1tiQeKwLXpbKFitbIJDNyPLo+QskFa3d1kW2A
         Fhzfj32ANQOq1weVbdqfY6rLVZgoTYisLslAgs6/27y/WNBcVagpB6M2ot1JoFC3g3+5
         RhQA==
X-Gm-Message-State: AC+VfDx4eHMyAQ7yAiPrw+8ZCc9DHD4+D/6mp7KpypS5muX7Z2Jnma+D
	0Pp9qaMy9Us6dMxHFnl/kbg=
X-Google-Smtp-Source: ACHHUZ5Y+RtHqXU4NMHz285kJfLSNyqkgbN9BZZYhRTOm2uTdD0KHCxzDaboiI9we/f/7iS9PtKX9A==
X-Received: by 2002:a05:6a20:7353:b0:11f:a611:324 with SMTP id v19-20020a056a20735300b0011fa6110324mr14473957pzc.10.1687558623447;
        Fri, 23 Jun 2023 15:17:03 -0700 (PDT)
Received: from localhost (ec2-54-67-115-33.us-west-1.compute.amazonaws.com. [54.67.115.33])
        by smtp.gmail.com with ESMTPSA id a16-20020aa780d0000000b00666e2dac482sm24016pfn.124.2023.06.23.15.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:17:03 -0700 (PDT)
Date: Fri, 23 Jun 2023 04:37:55 +0000
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Arseniy Krasnov <oxffffaa@gmail.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <simon.horman@corigine.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams
Message-ID: <ZJUho6NbpCgGatap@bullseye>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-6-0cebbb2ae899@bytedance.com>
 <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
 <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 06:09:12PM +0200, Stefano Garzarella wrote:
> On Sun, Jun 11, 2023 at 11:49:02PM +0300, Arseniy Krasnov wrote:
> > Hello Bobby!
> > 
> > On 10.06.2023 03:58, Bobby Eshleman wrote:
> > > This commit adds support for datagrams over virtio/vsock.
> > > 
> > > Message boundaries are preserved on a per-skb and per-vq entry basis.
> > 
> > I'm a little bit confused about the following case: let vhost sends 4097 bytes
> > datagram to the guest. Guest uses 4096 RX buffers in it's virtio queue, each
> > buffer has attached empty skb to it. Vhost places first 4096 bytes to the first
> > buffer of guests RX queue, and 1 last byte to the second buffer. Now IIUC guest
> > has two skb in it rx queue, and user in guest wants to read data - does it read
> > 4097 bytes, while guest has two skb - 4096 bytes and 1 bytes? In seqpacket there is
> > special marker in header which shows where message ends, and how it works here?
> 
> I think the main difference is that DGRAM is not connection-oriented, so
> we don't have a stream and we can't split the packet into 2 (maybe we
> could, but we have no guarantee that the second one for example will be
> not discarded because there is no space).
> 
> So I think it is acceptable as a restriction to keep it simple.
> 
> My only doubt is, should we make the RX buffer size configurable,
> instead of always using 4k?
> 
I think that is a really good idea. What mechanism do you imagine?

For sendmsg() with buflen > VQ_BUF_SIZE, I think I'd like -ENOBUFS
returned even though it is uncharacteristic of Linux sockets.
Alternatively, silently dropping is okay... but seems needlessly
unhelpful.

FYI, this patch is broken for h2g because it requeues partially sent
skbs, so probably doesn't need much code review until we decided on the
policy.

Best,
Bobby

