Return-Path: <bpf+bounces-26405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B710E89F02B
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAB5283022
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B6915956F;
	Wed, 10 Apr 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q72fi20q"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957C158204;
	Wed, 10 Apr 2024 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746238; cv=none; b=sVRC7XOxzELep2EaiOsL5jgJ7mE6pWQZFlAj1ScuS4fCVSVrV0uq2bbdeEVDGY8R+Sv5pdAQiF4orcGlGm+MGlZJvvYqcGpfIOWRvfOERrBhxGhOT/kANyJFR/bAAG9rOgo9dMMB8DNBXt5Al/7NaLjH+AX8DdVvwUtfTDlHEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746238; c=relaxed/simple;
	bh=/YywXtF9/Y3wiiyz6ltVThQhdF7VPhNZOR1NMwIJeN0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=LZfPexbmzdaRRiHHuQPxEs9EUJgYpRJqKIIeZq5k/WDwxe0Uzw7dEhxyJQgZWSw3ZJNDxP2lbsBr7ifp+bSp0mNBqxDpj1llxapEmwrVRBc2XMOreX2G5LntS209N5dehWd+Z4C5ySgJbI4wbYimnBcx/zKACnDpV9e7DMvS48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q72fi20q; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712746228; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=WN5WB0WEa8dAeRdWZXLnQSRMXDu6e8q9bd/onI3XvpU=;
	b=Q72fi20qS882d1Tag1zlNPzVmFda/4w0autdiJgNJaGanjZxTp/7N8K8OKLnaMpu/ukvU/nvBcpEXpfg6P6Jq6X5dC5leXEhaLp8jKyqTgHak0ClteFEMQM/3wb/fGjFAHmPCZbAlBczN4cmU9hzyiLO+u8GWvCotR76N+2Xw/A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W4HisqE_1712746226;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4HisqE_1712746226)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 18:50:27 +0800
Message-ID: <1712746219.1494555-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 2/9] virtio_net: virtnet_send_command supports command-specific-result
Date: Wed, 10 Apr 2024 18:50:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <20240318110602.37166-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEt_RYQMLpZOYe6MhhxeH8xpzKUJE-UCthBCr+7JgD6V1g@mail.gmail.com>
In-Reply-To: <CACGkMEt_RYQMLpZOYe6MhhxeH8xpzKUJE-UCthBCr+7JgD6V1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 10 Apr 2024 14:09:11 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f38998982=
3039724f95bbbd243291ab0064f82
> >
> > The virtnet cvq supports to get result from the device.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 47 +++++++++++++++++++++++-----------------
> >  1 file changed, 27 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..af512d85cd5b 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2512,10 +2512,11 @@ static int virtnet_tx_resize(struct virtnet_inf=
o *vi,
> >   * never fail unless improperly formatted.
> >   */
> >  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8=
 cmd,
> > -                                struct scatterlist *out)
> > +                                struct scatterlist *out,
> > +                                struct scatterlist *in)
> >  {
> > -       struct scatterlist *sgs[4], hdr, stat;
> > -       unsigned out_num =3D 0, tmp;
> > +       struct scatterlist *sgs[5], hdr, stat;
> > +       u32 out_num =3D 0, tmp, in_num =3D 0;
> >         int ret;
> >
> >         /* Caller should know better */
> > @@ -2533,10 +2534,13 @@ static bool virtnet_send_command(struct virtnet=
_info *vi, u8 class, u8 cmd,
> >
> >         /* Add return status. */
> >         sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
> > -       sgs[out_num] =3D &stat;
> > +       sgs[out_num + in_num++] =3D &stat;
> >
> > -       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> > -       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATO=
MIC);
> > +       if (in)
> > +               sgs[out_num + in_num++] =3D in;
> > +
> > +       BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
> > +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GF=
P_ATOMIC);
> >         if (ret < 0) {
> >                 dev_warn(&vi->vdev->dev,
> >                          "Failed to add sgs for command vq: %d\n.", ret=
);
> > @@ -2578,7 +2582,8 @@ static int virtnet_set_mac_address(struct net_dev=
ice *dev, void *p)
> >         if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> >                 sg_init_one(&sg, addr->sa_data, dev->addr_len);
> >                 if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> > -                                         VIRTIO_NET_CTRL_MAC_ADDR_SET,=
 &sg)) {
> > +                                         VIRTIO_NET_CTRL_MAC_ADDR_SET,
> > +                                         &sg, NULL)) {
> >                         dev_warn(&vdev->dev,
> >                                  "Failed to set mac address by vq comma=
nd.\n");
> >                         ret =3D -EINVAL;
> > @@ -2647,7 +2652,7 @@ static void virtnet_ack_link_announce(struct virt=
net_info *vi)
> >  {
> >         rtnl_lock();
> >         if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
> > -                                 VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL))
> > +                                 VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL, N=
ULL))
>
> Nit: It might be better to introduce a virtnet_send_command_reply()
> and let virtnet_send_command() call it as in=3DNULL to simplify the
> changes.

OK.

Thanks.


>
> Others look good.
>
> Thanks
>

