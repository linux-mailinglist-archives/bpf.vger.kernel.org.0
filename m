Return-Path: <bpf+bounces-12523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045477CD61A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A2B210BE
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5214A8E;
	Wed, 18 Oct 2023 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxHvGvFF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC76F9D5
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 08:10:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBBFB6
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697616616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37/kJ7xBvGvJcqALMsAiYLG6+205Ian/eThnUNlAZmo=;
	b=dxHvGvFFfWTVXxR/jhtiuQBRUyrr44r0XyWbXRoWYdkzOXvGNTiAxWW570ScpLrw+oENkd
	F0m5lx0a1BFv/Oezc6+5E7QnA/FeqzeVi4/0Kz/IlbSCb0bRI0EuMFUInz87neJFEP/S8x
	a7RyFiRKBSRInVS1lyCnkcXa6HEJEh4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-t5o1MQ0aMIK1fD992VzzSA-1; Wed, 18 Oct 2023 04:10:05 -0400
X-MC-Unique: t5o1MQ0aMIK1fD992VzzSA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9bf8678af70so267556066b.2
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697616604; x=1698221404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37/kJ7xBvGvJcqALMsAiYLG6+205Ian/eThnUNlAZmo=;
        b=hioIewigWYDmuZBIMVSq9whoGVvUsMoBWuqFUO8mzC2He83bPM1EVmFi/AgznYfVeK
         iXTNo2e2xK6sSNmMXBJcHC8hDXHSQNZDuROoQqQa8mL3jXV9diK/p47RuTZgZSpGko8w
         Es6abApnWP+X9HH+XXBr0IcEa5tYAIlQjM1JDan0+dOhnsrug3srFA0QERtRCI3GcK7G
         ZKWsXWAVTXA9ZDmMrjSbY7ynUGjwTAjRS6SFE5/3mTZiWMN5MucqY+UYDSA7urOTqRnh
         1lx1lNrTQknwplJs8Jpjf5sWd3a55GWBKUBJM/56X7ZCcvAXudHAN1ylGSlhrdFL1vbl
         F9fg==
X-Gm-Message-State: AOJu0YzsLvO1d52DC5Ttr26ne+oCghQ4ZMMUXGJ2MB8A6ZvMxF84Stmj
	BFoPdwVPL+7vpfiTAhjPftKaQ+E/Kyvhl3mPNZ90az0Zg39cGVo2EHsrEAh1p0JH2PeiJY7yTwv
	qroy7p8JOEoSh
X-Received: by 2002:a17:906:ee81:b0:9be:481c:60bf with SMTP id wt1-20020a170906ee8100b009be481c60bfmr3207765ejb.55.1697616604100;
        Wed, 18 Oct 2023 01:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/uNRLOrJZqZfYt3SG8LZALHlWpLFAe29ra7F9UnNNgD7+57SContltcsRq/ZecphhcN7iQ==
X-Received: by 2002:a17:906:ee81:b0:9be:481c:60bf with SMTP id wt1-20020a170906ee8100b009be481c60bfmr3207746ejb.55.1697616603792;
        Wed, 18 Oct 2023 01:10:03 -0700 (PDT)
Received: from redhat.com ([193.142.201.34])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709062c5100b009aa292a2df2sm1118534ejh.217.2023.10.18.01.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:10:03 -0700 (PDT)
Date: Wed, 18 Oct 2023 04:09:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Message-ID: <20231018040907-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> Hi Michael,
> 
> Do you think it's appropriate to push the first two patches of this patch set to
> linux 6.6?
> 
> Thanks.


I see this is with the eye towards merging this gradually. However,
I want the patchset to be ready first, right now it's not -
with build failures and new warnings on some systems.


-- 
MST


