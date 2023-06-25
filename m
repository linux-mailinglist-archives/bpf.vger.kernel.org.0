Return-Path: <bpf+bounces-3412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B773D4B3
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 23:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C87280ECC
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB89455;
	Sun, 25 Jun 2023 21:54:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E0944F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 21:54:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CDFD
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687730057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7K4oZGxfnRQ5Kbcr/TMT6ATY4u3TAiqKM1oEjq6Wqbs=;
	b=X/Jd8PWCq8grqXoJB9s31OEecqdzPVI6O9XbLoftpiJxpKlc9lmXNWcEFfxAYUypSDRGP+
	/4B8bzxRco+j21kDZnzSlB4Drc7VEvsCoEbi/Ox7uyk5MTq2xi9PMOcG/QWLX4fHm29rlj
	kKXRwb9B+ik+6mEBWykBrZzL19JwHds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-rIUrRI6_MlSXxve78h9Jkg-1; Sun, 25 Jun 2023 17:54:15 -0400
X-MC-Unique: rIUrRI6_MlSXxve78h9Jkg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so15255015e9.2
        for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687730039; x=1690322039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7K4oZGxfnRQ5Kbcr/TMT6ATY4u3TAiqKM1oEjq6Wqbs=;
        b=LxKcFA2uoqCu6FlFOuAdhNMtDJnTJgNgXP2RsxhdszMshMnf8Z7P7Lb+m4gY6EV7u5
         TjVLfAJvbc+Mt5f9GapXrcApZtXRwvwZpdHGYnQPZsKzS94T4srwz0skfc4FzOp+2gzs
         IPpcryzJhVmL4aurcf0VEgDsVmTcQNn/8fjjfhy53Iuj2yNyxn0jKF0I/xEN9m3BrBpG
         GLHFeYaDLP4+n02Kk5VFZzV6eajGdzKIcTBzWIH3zfpKZf1oSp5h8IC6J/BvQ9hYoAIo
         FJLbzClkMmmwfInmPJ/cyKV0FC5p/vXvgN70L0OmO7kg47rDVtFDrdo1G2hUyZWu276p
         9ynw==
X-Gm-Message-State: AC+VfDy0PCBukGHtDz+9N0hMmZ4V+r8+xEQHGR5PtGFu31PNH/JFYAg/
	a3O1o5r7JYkDp4W0cJerD9sNT3eF9btagMgDhEj30e4c8yhlkENYoMBlaBLNLd5qmMirkyxZvt7
	epsCczTrulu+o
X-Received: by 2002:a05:600c:2c2:b0:3f7:3699:c294 with SMTP id 2-20020a05600c02c200b003f73699c294mr20914691wmn.29.1687730039042;
        Sun, 25 Jun 2023 14:53:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YLKbrTNd4D5rPv7fDnrpFIdLUBGklnn9qU6r26Dqf36h1LAW2Xr+PDjXdq8RrNEdgpi4PmA==
X-Received: by 2002:a05:600c:2c2:b0:3f7:3699:c294 with SMTP id 2-20020a05600c02c200b003f73699c294mr20914680wmn.29.1687730038775;
        Sun, 25 Jun 2023 14:53:58 -0700 (PDT)
Received: from redhat.com ([2.52.156.102])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b00313f07ccca4sm1341205wrw.117.2023.06.25.14.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 14:53:57 -0700 (PDT)
Date: Sun, 25 Jun 2023 17:53:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] virtio-net: reprobe csum related fields
 for skb passed by XDP
Message-ID: <20230625175337-mutt-send-email-mst@kernel.org>
References: <20230624122604.110958-1-hengqi@linux.alibaba.com>
 <20230624122604.110958-2-hengqi@linux.alibaba.com>
 <ZJdCW4pxTioTPKJn@corigine.com>
 <45bda8e7-8d4a-c7c9-1fe2-af6926329ef7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45bda8e7-8d4a-c7c9-1fe2-af6926329ef7@linux.alibaba.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023 at 10:17:15AM +0800, Heng Qi wrote:
> 
> 
> 在 2023/6/25 上午3:28, Simon Horman 写道:
> > On Sat, Jun 24, 2023 at 08:26:02PM +0800, Heng Qi wrote:
> > 
> > ...
> > 
> > > +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> > > +				      struct sk_buff *skb,
> > > +				      __u8 flags)
> > Hi Heng Qi,
> > 
> > Unfortunately this appears to break an x86_64 allmodconfig build
> > with GCC 12.3.0:
> > 
> > drivers/net/virtio_net.c:1671:12: error: 'virtnet_set_csum_after_xdp' defined but not used [-Werror=unused-function]
> 
> I admit that this is a patch set, you can cherry-pick patches [1/3] and
> [2/3] together
> to make it compile without 'defined but not used' warning. If people don't
> want to
> separate [1/3] and [2/3], I can squash them into one. :)
> 
> Thanks.

the answer is yes, do not break the build.

> >   1671 | static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> >        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > --
> > pw-bot: changes-requested


