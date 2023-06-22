Return-Path: <bpf+bounces-3161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E8B73A5AA
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BF1281A03
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E74200A3;
	Thu, 22 Jun 2023 16:10:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D7E1F95D
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:10:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1291FEB
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687450191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4ZeA3fCzpsP/weTyEHljBjdeImnc1sztgg04Zvr3Iw=;
	b=FRSVsHcxCtKhffxsiURcxdDsh3FXHGnZ4rlHgSEFYmOZU2lpx1gPVdbeCProCWgZ8d4vq3
	LYysXfwbTPASeKZBx4FJY2qktrIvbnISFZ+PvM4OzWyyU+jHPVlu4TImkyH+Y/gDGjjLAi
	aNQ/u24o3Dy1H8pmxnDkGP3BJZZLhuc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-8OuRDdcRNDCPizflr5mU3w-1; Thu, 22 Jun 2023 12:09:35 -0400
X-MC-Unique: 8OuRDdcRNDCPizflr5mU3w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b46bfa6710so48136691fa.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450156; x=1690042156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4ZeA3fCzpsP/weTyEHljBjdeImnc1sztgg04Zvr3Iw=;
        b=lX5Dfq/7Hs7kXzZX0oPTNz/pTpRRQagj9GJhCNsL2HmqyHO7YAHgR2J0Z52IZAFYNd
         w13zln7A+xpCj7GqCvjHlDZyntqehXxNcEldFHuzuriR/+4v6q/nvHzd0bNEgnfQMfr4
         Eh1/eApZPJE+qrn8N2dhZu9CGlYwMkevap2RN56jmCS4HxFLh0QHKalpY3vyxlY25GPA
         k0AOTFDY42bW4NXQ3uSmy+ml0lwt+NK01Uy2NwAhde3xuveswDfzRadEUfFn7xcM7VE1
         HT7ijKhCTkwTRWu7dSoIweQ8d39feyqgMayDofghWNJZR8aHs71cVYaTH3qayPvo6Gm4
         t2yQ==
X-Gm-Message-State: AC+VfDwIbpC5nxGegWXLaJ6hRMI2d8hZ6ih0uDXuBGJa1sBmbV37auax
	SST27MKhJ1UsU5fSqQjwXt3tkJLDdNwwyho23HzAsDJGt0pvln6TTVEhwvwazwezo2gOUC+Eq2/
	LuJWWXE5Pum25
X-Received: by 2002:a2e:9a8e:0:b0:2b5:8cfd:5236 with SMTP id p14-20020a2e9a8e000000b002b58cfd5236mr2267181lji.17.1687450155866;
        Thu, 22 Jun 2023 09:09:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PUI9RE8kTcJcsGtpi7DjRk/Abacp0W+tVcBZjDh9XPq5tuQJut8wknojrAHXz03XIsMl3gQ==
X-Received: by 2002:a2e:9a8e:0:b0:2b5:8cfd:5236 with SMTP id p14-20020a2e9a8e000000b002b58cfd5236mr2267154lji.17.1687450155518;
        Thu, 22 Jun 2023 09:09:15 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b0098d2f91c850sm1026234ejr.89.2023.06.22.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:09:14 -0700 (PDT)
Date: Thu, 22 Jun 2023 18:09:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <oxffffaa@gmail.com>
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Simon Horman <simon.horman@corigine.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams
Message-ID: <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-6-0cebbb2ae899@bytedance.com>
 <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 11, 2023 at 11:49:02PM +0300, Arseniy Krasnov wrote:
>Hello Bobby!
>
>On 10.06.2023 03:58, Bobby Eshleman wrote:
>> This commit adds support for datagrams over virtio/vsock.
>>
>> Message boundaries are preserved on a per-skb and per-vq entry basis.
>
>I'm a little bit confused about the following case: let vhost sends 4097 bytes
>datagram to the guest. Guest uses 4096 RX buffers in it's virtio queue, each
>buffer has attached empty skb to it. Vhost places first 4096 bytes to the first
>buffer of guests RX queue, and 1 last byte to the second buffer. Now IIUC guest
>has two skb in it rx queue, and user in guest wants to read data - does it read
>4097 bytes, while guest has two skb - 4096 bytes and 1 bytes? In seqpacket there is
>special marker in header which shows where message ends, and how it works here?

I think the main difference is that DGRAM is not connection-oriented, so
we don't have a stream and we can't split the packet into 2 (maybe we
could, but we have no guarantee that the second one for example will be
not discarded because there is no space).

So I think it is acceptable as a restriction to keep it simple.

My only doubt is, should we make the RX buffer size configurable,
instead of always using 4k?

Thanks,
Stefano


