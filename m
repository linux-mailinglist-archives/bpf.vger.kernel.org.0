Return-Path: <bpf+bounces-9737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26179CD6A
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B27C1C21C06
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E771775E;
	Tue, 12 Sep 2023 10:07:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBE1774B
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 10:07:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5B5C10E7
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 03:07:33 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-79-D2m7SNHyKDGXonkWRCQ-1; Tue, 12 Sep 2023 06:07:30 -0400
X-MC-Unique: 79-D2m7SNHyKDGXonkWRCQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bcc0c073ffso9399581fa.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 03:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513249; x=1695118049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXAsEx53roHbjXgU/fW2WoeQROrWdmdzDO7kKXSOpxA=;
        b=kki8l6DqZXIo3gsDWsw0Qb0Wqdsvd3xmgVLggIrj0cT4nXlV4c8jpP+f0gQfH5qvYP
         ux8xVbxzZtoImv3btJzYBzXpG5FwgWxkEmRWkvdTATNMW8uk8YosWKA+mWhwtHA7bDRg
         NcN10FDsEk1TBq9P0CnTb0lhj87MDAM1C+U/9Vlk8NVaCO/ymDzjZPgAdlx3fWxlk8Lg
         0px1drKGmW++JVgkdPjV63gM6xh4RfcNhO3YHK0xJ7iLUBgWxGq/4h4jhrKpIRJ9iGnT
         Qd8ISAnXLT83wXQupdOLPs5b/bT9k9wb7n6W4CKhs/ayN1e7rlN2gjua4dFTzGfaBpPC
         DmEg==
X-Gm-Message-State: AOJu0YyHU9QyXqaZKgpgrR5bmVzsjsbNIRVmlHtYUkjW1PjmSRnDCnLD
	Bc4OT3NdQKFOpsdGbXOpg1fmrkOQXzxFc1+cNNKXP/4HH5JAxKB78joShjuXxmF/YfmMN9xT1qv
	nBRpMrn8dK+tq
X-Received: by 2002:a2e:b4b8:0:b0:2bc:d505:2bf3 with SMTP id q24-20020a2eb4b8000000b002bcd5052bf3mr7834226ljm.1.1694513249328;
        Tue, 12 Sep 2023 03:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVXuZArVyVBfC/ZkfL9Dcs41TWZcM2AMy0lWn8fejr7PdIYjG+1y1NiXPGtb9+cWQ6YJUPhw==
X-Received: by 2002:a2e:b4b8:0:b0:2bc:d505:2bf3 with SMTP id q24-20020a2eb4b8000000b002bcd5052bf3mr7834209ljm.1.1694513248993;
        Tue, 12 Sep 2023 03:07:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id lj16-20020a170906f9d000b00992d0de8762sm6580732ejb.216.2023.09.12.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:28 -0700 (PDT)
Message-ID: <155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com>
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
Date: Tue, 12 Sep 2023 12:07:26 +0200
In-Reply-To: <20230911135826.722295-1-toke@redhat.com>
References: <20230911135826.722295-1-toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2023-09-11 at 15:58 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> There's an early return in veth_set_features() if the device is in a down
> state, which leads to the XDP feature flags not being updated when enabli=
ng
> GRO while the device is down. Which in turn leads to XDP_REDIRECT not
> working, because the redirect code now checks the flags.
>=20
> Fix this by updating the feature flags after bringing the device up.
>=20
> Before this patch:
>=20
> NETDEV_XDP_ACT_BASIC:		yes
> NETDEV_XDP_ACT_REDIRECT:	yes
> NETDEV_XDP_ACT_NDO_XMIT:	no
> NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
> NETDEV_XDP_ACT_HW_OFFLOAD:	no
> NETDEV_XDP_ACT_RX_SG:		yes
> NETDEV_XDP_ACT_NDO_XMIT_SG:	no
>=20
> After this patch:
>=20
> NETDEV_XDP_ACT_BASIC:		yes
> NETDEV_XDP_ACT_REDIRECT:	yes
> NETDEV_XDP_ACT_NDO_XMIT:	yes
> NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
> NETDEV_XDP_ACT_HW_OFFLOAD:	no
> NETDEV_XDP_ACT_RX_SG:		yes
> NETDEV_XDP_ACT_NDO_XMIT_SG:	yes
>=20
> Fixes: fccca038f300 ("veth: take into account device reconfiguration for =
xdp_features flag")
> Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  drivers/net/veth.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 9c6f4f83f22b..0deefd1573cf 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1446,6 +1446,8 @@ static int veth_open(struct net_device *dev)
>  		netif_carrier_on(peer);
>  	}
> =20
> +	veth_set_xdp_features(dev);
> +
>  	return 0;
>  }

The patch LGTM, thanks!

I think it would be nice to add some specific self-tests here. Could
you please consider following-up with them?

Thanks,

Paolo


