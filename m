Return-Path: <bpf+bounces-6587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAF76B956
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1151280CC8
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF231ADF4;
	Tue,  1 Aug 2023 16:05:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DD1ADD9
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 16:05:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F0BF
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690905908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZTW9cojqSQW2bZi6sZ+IdoqRlKJXkCjqyxPfvTXPbg=;
	b=TyxXpEcRQZL0XBuKm5G6GayN3Bk1KsA+e0+sESOLqqmuWGi1f+sbiKXIoFRbNGKB0SVZ8n
	EGnI4nuQw8M3jM/C2vjNj6QURpoEaVaxf9XOdhFCEE+E9Xuj4ppl6ckRdnVy0/JJoHJkU4
	MsmOJZHmYeW2mT1vcfUMIOOPf12E+6Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-YfCTGYscPM-1AguFnf6XDw-1; Tue, 01 Aug 2023 12:04:53 -0400
X-MC-Unique: YfCTGYscPM-1AguFnf6XDw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe13881511so19741935e9.3
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 09:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905890; x=1691510690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZTW9cojqSQW2bZi6sZ+IdoqRlKJXkCjqyxPfvTXPbg=;
        b=bpknIX1cE4F45Eudrq6kZvP+10Js+H+Ayshp1s2iXDJz3R5krZ/W8APBISQ1CnuYWB
         hlCibmEMKmgUcMyYf9p4iA/TChrJzxTr0273a+nJqUs4Uq2p7SI53XJFr5V1WM/bWLYO
         IhiqjsqXj6kDHq+9ONH2qXssXU85J/MKNcxJw/Jmu4SBWEvd8XgAX7xE2cEEo7uD9ixf
         /UJ6U+/zWWHGL8B/hElAdhLZ7zgAHT5MebfiTRMqqNnHzxysOibsomvMvX0hnKU6zHSB
         LANxdwMXwnBj4F4l/lFdnjy7v/tD0ykRXMD/1uwlYfGwc0i6HkkJNB2NMBWc/UtiixjR
         0R1Q==
X-Gm-Message-State: ABy/qLbo/O4cTUDU9bkDJKnc4+mYad8bZ9qiB9Zlb3Lj+dJ8gxF7ylet
	TqR3Fujf+mG+fKRbtfF6BP2T9Ge7Ru3LYqD/ysVQI0ASu+ggDn8LoMwlOdtVUab485W6+UdInFJ
	RzI72kefOC6+Z
X-Received: by 2002:a1c:7310:0:b0:3fb:e189:3532 with SMTP id d16-20020a1c7310000000b003fbe1893532mr2701253wmb.20.1690905890720;
        Tue, 01 Aug 2023 09:04:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNvxPggY+ulCpxWm153ryyCBd6qp7Nemz78JW1jh60aRTALT7If6+aYqQcQ/iizAk261YnOw==
X-Received: by 2002:a1c:7310:0:b0:3fb:e189:3532 with SMTP id d16-20020a1c7310000000b003fbe1893532mr2701225wmb.20.1690905890321;
        Tue, 01 Aug 2023 09:04:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id d7-20020adfe2c7000000b00317ac0642b0sm3078341wrj.27.2023.08.01.09.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:04:49 -0700 (PDT)
Date: Tue, 1 Aug 2023 18:04:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, linux-hyperv@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Simon Horman <simon.horman@corigine.com>, 
	virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryantan@vmware.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Krasnov Arseniy <oxffffaa@gmail.com>, Vishnu Dasa <vdasa@vmware.com>, 
	Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <nnftjp3ek3hpiqlvz6ajbxcjswraclrayei2wi2qwgxzi7gpl6@yxdcz5eknofy>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
 <20230726143736-mutt-send-email-mst@kernel.org>
 <tpwk67lij7t7hquduogxzyox5wvq73yriv7vqiizqoxxtxvfwq@jzkcmq4kv3b4>
 <ZMiKXh173b/3Pj1L@bullseye>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZMiKXh173b/3Pj1L@bullseye>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 04:30:22AM +0000, Bobby Eshleman wrote:
>On Thu, Jul 27, 2023 at 09:48:21AM +0200, Stefano Garzarella wrote:
>> On Wed, Jul 26, 2023 at 02:38:08PM -0400, Michael S. Tsirkin wrote:
>> > On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
>> > > This commit adds a feature bit for virtio vsock to support datagrams.
>> > >
>> > > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > > ---
>> > >  include/uapi/linux/virtio_vsock.h | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> > > index 331be28b1d30..27b4b2b8bf13 100644
>> > > --- a/include/uapi/linux/virtio_vsock.h
>> > > +++ b/include/uapi/linux/virtio_vsock.h
>> > > @@ -40,6 +40,7 @@
>> > >
>> > >  /* The feature bitmap for virtio vsock */
>> > >  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>> > > +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>> > >
>> > >  struct virtio_vsock_config {
>> > >  	__le64 guest_cid;
>> >
>> > pls do not add interface without first getting it accepted in the
>> > virtio spec.
>>
>> Yep, fortunatelly this series is still RFC.
>> I think by now we've seen that the implementation is doable, so we
>> should discuss the changes to the specification ASAP. Then we can
>> merge the series.
>>
>> @Bobby can you start the discussion about spec changes?
>>
>
>No problem at all. Am I right to assume that a new patch to the spec is
>the standard starting point for discussion?

Yep, I think so!

Thanks,
Stefano


