Return-Path: <bpf+bounces-9749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F75B79D1CC
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC55E281DC4
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA218048;
	Tue, 12 Sep 2023 13:10:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F128F60
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 13:10:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D8CF10CB
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694524209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg/rNf++wD8Y02FvFACHwQQxrzUkc/5hNrI/xJW6U/0=;
	b=QLTVoYWMltE9884gbQiwWkRW9Wu19jm3UVYCKjqm3z4C6YqZddTTsiUtWz8vpsjtkVJj8n
	9ecIPPLR1uhzDw5TWee6C/EDd0f92k1eR5LavQYRlt/uPXX12PPB2MlDHg0vZAAa0+NueQ
	+Q0+ebwYunB9LR9hM9aG9Wq1huZXFNw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-yWiRDd6HP4iG9pyTR0vH-g-1; Tue, 12 Sep 2023 09:10:07 -0400
X-MC-Unique: yWiRDd6HP4iG9pyTR0vH-g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a9cd09610dso54441466b.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524206; x=1695129006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg/rNf++wD8Y02FvFACHwQQxrzUkc/5hNrI/xJW6U/0=;
        b=teWqhJd/ujKi1q3sUttvT2sQ6OCoxj4cBCf1OvwnEzD5fr2CXvOLbVPPCk8Fwu6/Cv
         8JGyF6deSxaSt6CnSt2mhxlhdpWIjvK27eIYHsFHOAiY6gIDbBTVW0FkN7JZyGCIOnZJ
         6qv+x3ttvf7KPKqqXjyy/SknutAYdbzwoD68j/dM+vJHq5xRwcWorl/52xRBaDxAkDNr
         7B8g6JSDUtU2TTNE/vFbCqqGOXzX/AHcQNdkNP0ky2IpdlWaHjX5Gr8ijgh/Mtyt6/l1
         /MN90Oz5VgFPj5KnkC1B8abH44qhCZiZLJqEky2uw5ooDMAviy38ck6NToySYTWKuJmK
         R5/w==
X-Gm-Message-State: AOJu0YwlhK1c0UZOEzxoIA6lk6jumhu6O710yTOvl/QhwiuuiGUPxLky
	IgpxGC+mCvzcX/W0jZL/DUoMtDOqcvNoOl5j6IWgvTA3DsrzM6H+xAsbLN8rHOi1f9IzZm5Uy8X
	GzgmPWubFQiCn
X-Received: by 2002:a17:906:1091:b0:9a1:eb67:c0d2 with SMTP id u17-20020a170906109100b009a1eb67c0d2mr9805258eju.6.1694524205934;
        Tue, 12 Sep 2023 06:10:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIbnXkFImcS52M68Q5rl1ySs8av9rC6nSQ93Pzg7SN9Wqy8ilGbJ4T+obrB6cVljjjXYrYIw==
X-Received: by 2002:a17:906:1091:b0:9a1:eb67:c0d2 with SMTP id u17-20020a170906109100b009a1eb67c0d2mr9805223eju.6.1694524205529;
        Tue, 12 Sep 2023 06:10:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090652c500b0099bd453357esm6760531ejn.41.2023.09.12.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:10:04 -0700 (PDT)
Message-ID: <05c3dcacfd80076bcb09bb701eab88769818c80f.camel@redhat.com>
Subject: Re: [PATCH net] veth: Update XDP feature set when bringing up device
From: Paolo Abeni <pabeni@redhat.com>
To: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Stanislav
 Fomichev <sdf@google.com>, Gerhard Engleder
 <gerhard@engleder-embedded.com>, Simon Horman <horms@kernel.org>
Cc: Marek Majtyka <alardam@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Tue, 12 Sep 2023 15:10:03 +0200
In-Reply-To: <8734zjlfg9.fsf@toke.dk>
References: <20230911135826.722295-1-toke@redhat.com>
	 <155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com>
	 <8734zjlfg9.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 14:54 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>=20
> > Hi,
> >=20
> > On Mon, 2023-09-11 at 15:58 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wro=
te:
> > > There's an early return in veth_set_features() if the device is in a =
down
> > > state, which leads to the XDP feature flags not being updated when en=
abling
> > > GRO while the device is down. Which in turn leads to XDP_REDIRECT not
> > > working, because the redirect code now checks the flags.
> > >=20
> > > Fix this by updating the feature flags after bringing the device up.
> > >=20
> > > Before this patch:
> > >=20
> > > NETDEV_XDP_ACT_BASIC:		yes
> > > NETDEV_XDP_ACT_REDIRECT:	yes
> > > NETDEV_XDP_ACT_NDO_XMIT:	no
> > > NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
> > > NETDEV_XDP_ACT_HW_OFFLOAD:	no
> > > NETDEV_XDP_ACT_RX_SG:		yes
> > > NETDEV_XDP_ACT_NDO_XMIT_SG:	no
> > >=20
> > > After this patch:
> > >=20
> > > NETDEV_XDP_ACT_BASIC:		yes
> > > NETDEV_XDP_ACT_REDIRECT:	yes
> > > NETDEV_XDP_ACT_NDO_XMIT:	yes
> > > NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
> > > NETDEV_XDP_ACT_HW_OFFLOAD:	no
> > > NETDEV_XDP_ACT_RX_SG:		yes
> > > NETDEV_XDP_ACT_NDO_XMIT_SG:	yes
> > >=20
> > > Fixes: fccca038f300 ("veth: take into account device reconfiguration =
for xdp_features flag")
> > > Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
> > > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > ---
> > >  drivers/net/veth.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > index 9c6f4f83f22b..0deefd1573cf 100644
> > > --- a/drivers/net/veth.c
> > > +++ b/drivers/net/veth.c
> > > @@ -1446,6 +1446,8 @@ static int veth_open(struct net_device *dev)
> > >  		netif_carrier_on(peer);
> > >  	}
> > > =20
> > > +	veth_set_xdp_features(dev);
> > > +
> > >  	return 0;
> > >  }
> >=20
> > The patch LGTM, thanks!
> >=20
> > I think it would be nice to add some specific self-tests here. Could
> > you please consider following-up with them?
>=20
> Sure! Do you want me to resubmit this as well, or are you just going to
> apply it as-is and do the selftest as a follow-up?

I think the latter is simpler and works for me. The self-test could
target net-next, the fix is going to land there shortly after -net.

Thanks!

Paolo


