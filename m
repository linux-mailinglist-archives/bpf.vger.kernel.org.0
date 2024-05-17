Return-Path: <bpf+bounces-29973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F08C8D1B
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 21:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB84B1F25598
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D1414039E;
	Fri, 17 May 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HESN657N"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B57140E2E
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975674; cv=none; b=BB2XoOBTbAmascsk5vOHyetdsl6Wh1ykpqrNx1sSsgzYlmsrhF/z1eKPcYRjeyOXZuXQG8Vykd40h1oL0+axms9fL7gg0fl8gLaTT0ca+3PslUVqmE+eYfRQE0g671vH7l9j+O4/3DEXNKpP2hv2CpeVrdsEwxlunwF7xKmvVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975674; c=relaxed/simple;
	bh=qfAsuOWl0hC/dGi12IhGHukk3mZo3M46eg6IvViHdmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqY/qNQXkhJNUkz3H9KJvOjla+AWsN79nL8bhXaZBRhlaJs9GW+O7itgtt2Vxg7y0SEJ3ISGezQnh7e3yNojfLDcvXj7zdLMeZ3XqNMDDAl4LUUbz4/OvF4nV8LPGP/DDx4SlISPwBXhMMjc7PHJNyB/SULUTg+UH92coE3ANS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HESN657N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715975671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGcVskiD6pxYjXs3xmYrHWr55wsmHpoyxvnk3YO92e0=;
	b=HESN657N/yJYCRO2NoynlIAUDw8SuGiFJsPJHptmJDq+rjbTkYlj1Vb8CyEgCvkPCUX4fj
	nSPLshZ14A8QMQRTajAHXBePkXerxsdRuvILptgA37WO4jTDYdMOhyK4ENBqVsHPJV0xos
	teNXdmeVWRaAclwDf0rshDBEAIhD1UU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-pwGHqsTJOC6v130V5nQwLQ-1; Fri, 17 May 2024 15:54:27 -0400
X-MC-Unique: pwGHqsTJOC6v130V5nQwLQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34ffd710a31so5774796f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 12:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715975666; x=1716580466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGcVskiD6pxYjXs3xmYrHWr55wsmHpoyxvnk3YO92e0=;
        b=O4e2ZsEwmE5dvPyrkGqZ4+5aEtwgIWVibSDwbxCSN9NPok0ENCz/f5iap5gS3EX9w3
         GAbRXLoXuq/G+WLarbOq4UXFViVMq0LeuCqBdxPNopiDAqa6C+BMKzPTo+lOq67Q7/88
         oHtkLD55E762/3UqnXV5DhJWHIdjirfr07afzv8ky6i4kZveyCCeHsxzMkqEOJjQoqVJ
         7ibnweTe/NsiyAiQk1BGe/grRXcGgRUu4FN6ConAI9XbSVMPycwSofsVth8izxEXWKa/
         wdw11lXPahEQ9SkPV/uHGuePDfDKHB7M17D9gEyKdf3c/uds3o2F/jUQO0XK+Ic1h16W
         NyRw==
X-Forwarded-Encrypted: i=1; AJvYcCW6o1Gf+Omvr/pOtXRyja7y5vVwWfzO1TfKMsqpHbmAm17f0SRQLOeRE40HKe8jIhNNermZf7hmjH3o5IMP/TZh8fOM
X-Gm-Message-State: AOJu0YxsWb6O7Mue+lDYcCj0e+ilD9M9pK9lsfkmudnBlTrgtMvgG8hg
	cx5Ez0+DAOG3sHXksg3qHeF+/FSpPIh39pdo+xsrFbSlInuZweVJiaymKdHFgx8WmvSYwEZTv14
	W8RrbKpOXiIposCKHz+z8s5qG9ODrh+a+8A+KD0w79qeWUl1LNg==
X-Received: by 2002:a05:600c:1914:b0:420:112e:6c1 with SMTP id 5b1f17b1804b1-420112e06d1mr144292915e9.13.1715975666278;
        Fri, 17 May 2024 12:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj51XinY4vjmIEc/h1fzu4OdgZGt/HVOyIF5sT2vpojTz8FL4AiIG4vUyn8td6j40vq7ZobQ==
X-Received: by 2002:a05:600c:1914:b0:420:112e:6c1 with SMTP id 5b1f17b1804b1-420112e06d1mr144292615e9.13.1715975665642;
        Fri, 17 May 2024 12:54:25 -0700 (PDT)
Received: from localhost (net-188-152-99-152.cust.vodafonedsl.it. [188.152.99.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4202de3a79bsm53982065e9.6.2024.05.17.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 12:54:25 -0700 (PDT)
Date: Fri, 17 May 2024 21:54:23 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
	pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	toke@redhat.com, fw@strlen.de, hawk@kernel.org, horms@kernel.org,
	donhunte@redhat.com
Subject: Re: [PATCH bpf-next 2/4] netfilter: add bpf_xdp_flow_offload_lookup
 kfunc
Message-ID: <Zke172XFjqUGTE6O@lore-desk>
References: <cover.1715807303.git.lorenzo@kernel.org>
 <c87caa37757cdf6e323c89748fd0a0408fd47da2.1715807303.git.lorenzo@kernel.org>
 <CAP01T76razfX1e7BsMbbyecPF+RjtJYoZifR-Um_BAoyPNOyKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2H42TsNIWDJH9FrG"
Content-Disposition: inline
In-Reply-To: <CAP01T76razfX1e7BsMbbyecPF+RjtJYoZifR-Um_BAoyPNOyKg@mail.gmail.com>


--2H42TsNIWDJH9FrG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > +       tuplehash =3D flow_offload_lookup(flow_table, tuple);
> > +       if (!tuplehash)
> > +               return ERR_PTR(-ENOENT);
>=20
> This is fine to do, but the caller should catch it using IS_ERR_PTR
> and return NULL.
> BPF side cannot distinguish ERR_PTR from normal pointer, so this will
> cause a bad deref in the program.

ack, I will fix it in v2.

>=20
> > +
> > +       flow =3D container_of(tuplehash, struct flow_offload,
> > +                           tuplehash[tuplehash->tuple.dir]);
> > +       flow_offload_refresh(flow_table, flow, false);
> > +
> > +       return tuplehash;
> > +}
> > +
> > +__bpf_kfunc struct flow_offload_tuple_rhash *
> > +bpf_xdp_flow_offload_lookup(struct xdp_md *ctx,
> > +                           struct bpf_fib_lookup *fib_tuple,
> > +                           u32 fib_tuple__sz)
>=20
> Do you think the __sz has the intended effect? It only works when the
> preceding parameter is a void *.
> If you have a type like struct bpf_fib_lookup, I think it should work
> fine without taking a size at all.

ack, I will fix it in v2.

>=20
> > +{
> > +       struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> > +       struct flow_offload_tuple tuple =3D {
> > +               .iifidx =3D fib_tuple->ifindex,
> > +               .l3proto =3D fib_tuple->family,
> > +               .l4proto =3D fib_tuple->l4_protocol,
> > +               .src_port =3D fib_tuple->sport,
> > +               .dst_port =3D fib_tuple->dport,
> > +       };
> > +       __be16 proto;
> > +
> > +       switch (fib_tuple->family) {
> > +       case AF_INET:
> > +               tuple.src_v4.s_addr =3D fib_tuple->ipv4_src;
> > +               tuple.dst_v4.s_addr =3D fib_tuple->ipv4_dst;
> > +               proto =3D htons(ETH_P_IP);
> > +               break;
> > +       case AF_INET6:
> > +               tuple.src_v6 =3D *(struct in6_addr *)&fib_tuple->ipv6_s=
rc;
> > +               tuple.dst_v6 =3D *(struct in6_addr *)&fib_tuple->ipv6_d=
st;
> > +               proto =3D htons(ETH_P_IPV6);
> > +               break;
> > +       default:
> > +               return ERR_PTR(-EINVAL);
>=20
> Likewise. While you check IS_ERR_VALUE in selftest, direct dereference
> will be allowed by verifier, which would crash the kernel.
> It's better to do something like conntrack kfuncs, where they set
> opts->error when returning NULL, allowing better debugging in case
> lookup fails.

ack, I will fix it in v2.

>=20
> > +       }
> > +
> > +       return bpf_xdp_flow_offload_tuple_lookup(xdp->rxq->dev, &tuple,=
 proto);
> > +}
> > +
> > +__diag_pop()
> > +
> > +BTF_KFUNCS_START(nf_ft_kfunc_set)
> > +BTF_ID_FLAGS(func, bpf_xdp_flow_offload_lookup)
> > +BTF_KFUNCS_END(nf_ft_kfunc_set)
> > +
> > +static const struct btf_kfunc_id_set nf_flow_offload_kfunc_set =3D {
> > +       .owner =3D THIS_MODULE,
> > +       .set   =3D &nf_ft_kfunc_set,
> > +};
> > +
> > +int nf_flow_offload_register_bpf(void)
> > +{
> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> > +                                        &nf_flow_offload_kfunc_set);
> > +}
>=20
> We should probably also expose it to skb? We just need net_device, so
> it can work with both XDP and TC progs.
> That would be similar to how we expose conntrack kfuncs to both XDP
> and TC progs.

I think we will get very similar results to sw flowtable in this case,
don't you think?

>=20
> > +EXPORT_SYMBOL_GPL(nf_flow_offload_register_bpf);
> > diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow=
_table_inet.c
> > index 6eef15648b7b0..b13587238eceb 100644
> > --- a/net/netfilter/nf_flow_table_inet.c
> > +++ b/net/netfilter/nf_flow_table_inet.c
> > @@ -98,6 +98,8 @@ static int __init nf_flow_inet_module_init(void)
> >         nft_register_flowtable_type(&flowtable_ipv6);
> >         nft_register_flowtable_type(&flowtable_inet);
> >
> > +       nf_flow_offload_register_bpf();
> > +
>=20
> Error checking needed here? Kfunc registration can fail.

ack, I will fix it.

Regards,
Lorenzo

>=20
> >         return 0;
> >  }
> >
> > --
> > 2.45.0
> >
> >
>=20

--2H42TsNIWDJH9FrG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZke17wAKCRA6cBh0uS2t
rBRdAQCEERfoDpkBBYLgT8dxCY6w8lO1iaQ3rG5xreHO8f7EhAEA20DRSkH9tXWH
kRcvR5nmCv98ZBrvLTQtYNZ+PfeX6QM=
=90hE
-----END PGP SIGNATURE-----

--2H42TsNIWDJH9FrG--


