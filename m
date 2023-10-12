Return-Path: <bpf+bounces-12010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D816E7C66A7
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 09:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC02282924
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596615E9C;
	Thu, 12 Oct 2023 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8ErYKva"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7CED533
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 07:50:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDACD7
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697097028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiG13da8k/ZbjjqgCy1pf25ts3THBZ36xeSgrel6qHw=;
	b=i8ErYKva0Z0GYhkPx14724ZbwMHt9+lYYUeGWJl0lNQ0pspH9TsAuq51HnYIF/FLwsRky6
	95m+m46hiSG7gsAcG0zzTNdKKD9OWiCvJOexy2eHC8O9J8RAIs2oG1NH4I6zYwizJRJ/Ao
	TTdE58KWtnMGHq3XfYQkL/jpYeyYNMU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-YJXk7owwO72DZycKyyUj6w-1; Thu, 12 Oct 2023 03:50:26 -0400
X-MC-Unique: YJXk7owwO72DZycKyyUj6w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c296e650easo6264671fa.3
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 00:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097025; x=1697701825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiG13da8k/ZbjjqgCy1pf25ts3THBZ36xeSgrel6qHw=;
        b=uvQVDa8jtSxk3yKov5/OtlHoWLk5ogjfOS4IRO/OtLEYIVkd0qIsipWQHtOnqfjN7a
         us6VI5hobBpPv4+CDPs4zbLUYMMWjD/rSjOry+WXeMGXthO6aTQvcgbu5sLtMy58pl7C
         MCmAFBaYM+t8bgyDEX+BbEWdWgMpiSsbXEQ+rrnWbPx/LjExnIN6O5+iiSgOL7hnJD45
         DydYrJBL9TUESu4ADNKEz3c3yGtXmlVgsRwHVndvAkTa32i7/3jzaO6RwjyAzjVcmyNq
         MjsUqz8tQG9MEcN70vDcUMwl/RtZ8CttSoknC+YnGfgXj6TH1ZCR+Xz7VNXKKInyFRv8
         zj1Q==
X-Gm-Message-State: AOJu0YzbM6vDdLzFsIJMQYpOevhccZyY5vdTC4twG+penqYQ1X8LfDXu
	Ndeb5hnAtnLbFYXywR1r/UZ9ApSBLMCKTmZsPiC/tjvk8gcuI+S764lHsCZc5wP0Meq9DHOkMc5
	rAFB8C10Ps8P+PMdV2vuQN38h/jPW
X-Received: by 2002:a2e:2c1a:0:b0:2bc:e470:1405 with SMTP id s26-20020a2e2c1a000000b002bce4701405mr18183621ljs.46.1697097025336;
        Thu, 12 Oct 2023 00:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzYu7Lfht/V4Rj2WUdNomulK6QlCD6ZyUl6D/Bh+QtwT3mYue+hyDIjXaThrj7GL3e+cS6zO8ebpAqF5FI2rI=
X-Received: by 2002:a2e:2c1a:0:b0:2bc:e470:1405 with SMTP id
 s26-20020a2e2c1a000000b002bce4701405mr18183602ljs.46.1697097025022; Thu, 12
 Oct 2023 00:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011100057.535f3834@kernel.org> <1697075634.444064-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697075634.444064-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Oct 2023 15:50:13 +0800
Message-ID: <CACGkMEsadYH8Y-KOxPX6vPic7pBqzj2DLnog5osuBDtypKgEZA@mail.gmail.com>
Subject: Re: [PATCH vhost 00/22] virtio-net: support AF_XDP zero copy
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 9:58=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 11 Oct 2023 10:00:57 -0700, Jakub Kicinski <kuba@kernel.org> wrot=
e:
> > On Wed, 11 Oct 2023 17:27:06 +0800 Xuan Zhuo wrote:
> > > ## AF_XDP
> > >
> > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. T=
he zero
> > > copy feature of xsk (XDP socket) needs to be supported by the driver.=
 The
> > > performance of zero copy is very good. mlx5 and intel ixgbe already s=
upport
> > > this feature, This patch set allows virtio-net to support xsk's zeroc=
opy xmit
> > > feature.
> >
> > You're moving the driver and adding a major feature.
> > This really needs to go via net or bpf.
> > If you have dependencies in other trees please wait for
> > after the merge window.
>
>
> If so, I can remove the first two commits.
>
> Then, the sq uses the premapped mode by default.
> And we can use the api virtqueue_dma_map_single_attrs to replace the
> virtqueue_dma_map_page_attrs.
>
> And then I will fix that on the top.
>
> Hi Micheal and Jason, is that ok for you?

I would go with what looks easy for you but I think Jakub wants the
series to go with next-next (this is what we did in the past for
networking specific features that is done in virtio-net). So we need
to tweak the prefix to use net-next instead of vhost.

Thanks


>
> Thanks.
>


