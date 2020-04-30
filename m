Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5B41BF494
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3Jyl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 05:54:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43248 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726453AbgD3Jyl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 05:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588240480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fCJ01yiDVJ+4nhB2iJa3qAXZnjlPnyq/CK4SQ/2FBPQ=;
        b=KjHsNVbMA0p3V3o3MSbmHoOclGIcmMTbJQvrZg8QI72gLRcLXF+7DxVB0Cayk5bO+U1UE8
        62RnV+i3iOE33ju4hgAp/0k8/X2rJ05y7eZRAK0dfZ2p/DEA8itX3voLF/ioqzLuZVIVMV
        hs0lqDnGmnGVBuDC+P0H7bEvEqII9Yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-RpNZrXO-Or2_6MJUlyXBJQ-1; Thu, 30 Apr 2020 05:54:37 -0400
X-MC-Unique: RpNZrXO-Or2_6MJUlyXBJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1816245F;
        Thu, 30 Apr 2020 09:54:35 +0000 (UTC)
Received: from carbon (unknown [10.40.208.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E991A5D787;
        Thu, 30 Apr 2020 09:54:16 +0000 (UTC)
Date:   Thu, 30 Apr 2020 11:54:15 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     sameehj@amazon.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        zorik@amazon.com, akiyano@amazon.com, gtzalik@amazon.com,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com, brouer@redhat.com
Subject: Re: [PATCH net-next 20/33] vhost_net: also populate XDP frame size
Message-ID: <20200430115415.5e4c815e@carbon>
In-Reply-To: <8ebbd5d8-e256-3d6b-7cc1-dd3d29be3504@redhat.com>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul>
        <158757174266.1370371.14475202001364271065.stgit@firesoul>
        <8ebbd5d8-e256-3d6b-7cc1-dd3d29be3504@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Apr 2020 13:50:15 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2020/4/23 =E4=B8=8A=E5=8D=8812:09, Jesper Dangaard Brouer wrote:
> > In vhost_net_build_xdp() the 'buf' that gets queued via an xdp_buff
> > have embedded a struct tun_xdp_hdr (located at xdp->data_hard_start)
> > which contains the buffer length 'buflen' (with tailroom for
> > skb_shared_info). Also storing this buflen in xdp->frame_sz, does not
> > obsolete struct tun_xdp_hdr, as it also contains a struct
> > virtio_net_hdr with other information.
> >
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > ---
> >   drivers/vhost/net.c |    1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 87469d67ede8..69af007e22f4 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -745,6 +745,7 @@ static int vhost_net_build_xdp(struct vhost_net_vir=
tqueue *nvq,
> >   	xdp->data =3D buf + pad;
> >   	xdp->data_end =3D xdp->data + len;
> >   	hdr->buflen =3D buflen;
> > +	xdp->frame_sz =3D buflen;
> >  =20
> >   	--net->refcnt_bias;
> >   	alloc_frag->offset +=3D buflen; =20
>=20
>=20
> Tun_xdp_one() will use hdr->buflen as the frame_sz (patch 19), so it=20
> looks to me there's no need to do this?

I was thinking to go the "other way", meaning let tun_xdp_one() use
xdp->frame_sz, which gets set here.  This would allow us to refactor
the code, and drop struct tun_xdp_hdr, as (see pahole below) it only
carries 'buflen' and the remaining part comes from struct
virtio_net_hdr, which could be used directly instead.

As this will be a code refactor, I would prefer we do it after this
patchseries is agreed upon.

$ pahole -C tun_xdp_hdr drivers/net/tap.o
struct tun_xdp_hdr {
	int                        buflen;               /*     0     4 */
	struct virtio_net_hdr gso;                       /*     4    10 */

	/* size: 16, cachelines: 1, members: 2 */
	/* padding: 2 */
	/* last cacheline: 16 bytes */
};

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

