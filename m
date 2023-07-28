Return-Path: <bpf+bounces-6144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7825776616F
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F8A282580
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23417CF;
	Fri, 28 Jul 2023 01:42:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1527C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:42:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD53584
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690508534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+B8/dh9FxUlYlsfj6c2Az3RVvE6Mk5Zpo699JVAL0Us=;
	b=UCrkxbwTTj/NOaU+mujwbU4bv7w4azAAj/C59hBh27WyxcysgBHUHSyRfaLsD3OuoIZwwH
	WSc6nro4Z7msCDddyTazjNwrr2lXBpgsMi/nevq+AfnBNHr9UqQ0HMt40nudfm1fg9RIQ4
	AQU8Qm2qNYQShi4eKJ0VtgU+lskOwhM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-hIvt1f5DORS9qEQL5Jn3FA-1; Thu, 27 Jul 2023 21:42:12 -0400
X-MC-Unique: hIvt1f5DORS9qEQL5Jn3FA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb76659d44so1396252e87.3
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508531; x=1691113331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+B8/dh9FxUlYlsfj6c2Az3RVvE6Mk5Zpo699JVAL0Us=;
        b=WJyHWSu37bMYgcPx2Cc4kTylxp3kmT4j19uUs+pdndJLxrumDLE0A9mac2f7CWatsM
         d6IvVZRfRg/p5Dtf9hsB0j6MvTNT1E/CMD7OTaq4xZH7NMmj6gygERP/6fj0VpY7/2xf
         uOobXx5+UA/2yIJNdWpByQzhwuF6Go22xxbHspMI53GB05PDqY8bLr15rR8Evks8EiG7
         fA6ozkkh5194PnyCYauS6tVYODS10Mfpm6uK/sya7WgvNwxPthRKGXdYhTgytEapJDbt
         /63szOPwaOM/JgWLialFn8aLZn1ihpSwV2cZ8i52QeskRLNq0WvtGiIkRFlqZERYoI0o
         vSsQ==
X-Gm-Message-State: ABy/qLaYdcuGm+jEH0E+pwVS2Puthh4RjsXd26OKTkhnLnLQXqKOLZkp
	06Tnyc9U9W/FG6N9a73ON8O54Uea+igw40rIiRktGiNX8tun7APHAreLLbUf3OhJ47j4jV4zIgV
	7ITIU4Ut6MMmb1tjAICOsR3wL7mrh
X-Received: by 2002:a05:6512:1591:b0:4fb:893e:8ffc with SMTP id bp17-20020a056512159100b004fb893e8ffcmr676872lfb.17.1690508531485;
        Thu, 27 Jul 2023 18:42:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHY6/ERBGZV6AEAlBJS5xI4dIRaHz1bMCv6qrVkYLdcfZ1S0GvRrifqu9u3Yc1vreyW0L0NNEbcznbuvGQrl6o=
X-Received: by 2002:a05:6512:1591:b0:4fb:893e:8ffc with SMTP id
 bp17-20020a056512159100b004fb893e8ffcmr676854lfb.17.1690508531188; Thu, 27
 Jul 2023 18:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725130709.58207-1-gavinl@nvidia.com> <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
In-Reply-To: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jul 2023 09:42:00 +0800
Message-ID: <CACGkMEs4wUh0TydcXSMR2GdBSTk+H-Tkbhn53BywEeiK9cA9Gg@mail.gmail.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
To: Paolo Abeni <pabeni@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	jiri@nvidia.com, dtatulea@nvidia.com, gavi@nvidia.com, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Heng Qi <hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 9:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
> > Add interrupt_coalesce config in send_queue and receive_queue to cache =
user
> > config.
> >
> > Send per virtqueue interrupt moderation config to underlying device in
> > order to have more efficient interrupt moderation and cpu utilization o=
f
> > guest VM.
> >
> > Additionally, address all the VQs when updating the global configuratio=
n,
> > as now the individual VQs configuration can diverge from the global
> > configuration.
> >
> > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> FTR, this patch is significantly different from the version previously
> acked/reviewed, I'm unsure if all the reviewers are ok with the new
> one.

Good point, and I plan to review this no later than next Monday and
offer my ack if necessary. Please hold this series now.

Thanks

>
> [...]
>
> >  static int virtnet_set_coalesce(struct net_device *dev,
> >                               struct ethtool_coalesce *ec,
> >                               struct kernel_ethtool_coalesce *kernel_co=
al,
> >                               struct netlink_ext_ack *extack)
> >  {
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> > -     int ret, i, napi_weight;
> > +     int ret, queue_number, napi_weight;
> >       bool update_napi =3D false;
> >
> >       /* Can't change NAPI weight if the link is up */
> >       napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : =
0;
> > -     if (napi_weight ^ vi->sq[0].napi.weight) {
> > -             if (dev->flags & IFF_UP)
> > -                     return -EBUSY;
> > -             else
> > -                     update_napi =3D true;
> > +     for (queue_number =3D 0; queue_number < vi->max_queue_pairs; queu=
e_number++) {
> > +             ret =3D virtnet_should_update_vq_weight(dev->flags, napi_=
weight,
> > +                                                   vi->sq[queue_number=
].napi.weight,
> > +                                                   &update_napi);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (update_napi) {
> > +                     /* All queues that belong to [queue_number, queue=
_count] will be
> > +                      * updated for the sake of simplicity, which migh=
t not be necessary
>
> It looks like the comment above still refers to the old code. Should
> be:
>         [queue_number, vi->max_queue_pairs]
>
> Otherwise LGTM, thanks!
>
> Paolo
>


