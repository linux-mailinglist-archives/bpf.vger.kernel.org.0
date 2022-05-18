Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9052C577
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 23:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243052AbiERVJN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiERVJK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 17:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 216FD1DB5A5
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652908148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SK3LHOwd4s7ENi68YVOL1YMs+cgWM1wV21fTUwnsebk=;
        b=Cl1UDpdvxXGiNse/6uS/fRgYZfXl0nqYfMuxAEqtSy5IeUNLN1SdUKI0r6zWme0h+XDLJ4
        nJXX81BjDZ7RgMoOBQj/3hs4OHhIrT5PXc8APkftpBW1t2rhiFZBNURHka1oU55feOd7OU
        ns+kC3GdPRu/ShHMW5zAvkq1Vfesm4Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-B_xWQiweM_mi1o21AlpURw-1; Wed, 18 May 2022 17:08:59 -0400
X-MC-Unique: B_xWQiweM_mi1o21AlpURw-1
Received: by mail-wm1-f69.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so3463691wmq.3
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SK3LHOwd4s7ENi68YVOL1YMs+cgWM1wV21fTUwnsebk=;
        b=g0J9bvho1Nuk39VL0uWybnU6eWovHmyM2eB8Qhle6xITXPTPfBEM5AHA9/BlDWbVQk
         5VT2Gh0DqN97ouEU8qeSwCq/iNTQ/SLaCYLRL5J4P4WtrwcgpD9nspky7JRZW/T1uRMx
         Zj8MUxhq2zUgy6kwexa5TRhTEjsYTtQSvLxgX4GLm51i4DTPwza1B5kOu2H3PMO72wuI
         kWwUg4SFDKGDKir2ptzU+cM0iXpZa4nL3xdpjAbfxeROJyUkUpaPVvNVYIS4rUwEZRTV
         8yc6wDGP+/UzAjCeFahAD1yeqkIvbMdpb7gGS9+WpTiv8KwMteN2mVyvxO4YFxMyYp3P
         Pm+Q==
X-Gm-Message-State: AOAM531C+fH+UzrhWyndY+x9570MkZW+tyC+LPrnt2A01642UvHeadu4
        O9uW/cvTm6n8w6VNkcksg8IixcDA4+CnLX41IoUO9mEXaBMQM5qNaTYHeRUumpozvvbP7VCMDlm
        4vkDpl4AAyB9r
X-Received: by 2002:adf:ec8b:0:b0:20d:483:f271 with SMTP id z11-20020adfec8b000000b0020d0483f271mr1268119wrn.555.1652908137833;
        Wed, 18 May 2022 14:08:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznnERUusD/tYswUCi6C74pLll6bYj/WYaSP+u6wPuCrAMipEWRrnW/fNSZ0aJJx9tlZwJWyg==
X-Received: by 2002:adf:ec8b:0:b0:20d:483:f271 with SMTP id z11-20020adfec8b000000b0020d0483f271mr1268094wrn.555.1652908137585;
        Wed, 18 May 2022 14:08:57 -0700 (PDT)
Received: from localhost (net-93-71-56-156.cust.vodafonedsl.it. [93.71.56.156])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0020c5253d8edsm3194439wrc.57.2022.05.18.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 14:08:57 -0700 (PDT)
Date:   Wed, 18 May 2022 23:08:55 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, pablo@netfilter.org,
        fw@strlen.de, netfilter-devel@vger.kernel.org, brouer@redhat.com,
        memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 4/5] net: netfilter: add kfunc helper to add
 a new ct entry
Message-ID: <YoVgZ8OHlF/OpgHq@lore-desk>
References: <cover.1652870182.git.lorenzo@kernel.org>
 <40e7ce4b79c86c46e5fbf22e9cafb51b9172da19.1652870182.git.lorenzo@kernel.org>
 <87y1yy8t6j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ijSSQFIglunMLS0I"
Content-Disposition: inline
In-Reply-To: <87y1yy8t6j.fsf@toke.dk>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--ijSSQFIglunMLS0I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Introduce bpf_xdp_ct_add and bpf_skb_ct_add kfunc helpers in order to
> > add a new entry to ct map from an ebpf program.
> > Introduce bpf_nf_ct_tuple_parse utility routine.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/netfilter/nf_conntrack_bpf.c | 212 +++++++++++++++++++++++++++----
> >  1 file changed, 189 insertions(+), 23 deletions(-)
> >
> > diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntr=
ack_bpf.c
> > index a9271418db88..3d31b602fdf1 100644
> > --- a/net/netfilter/nf_conntrack_bpf.c
> > +++ b/net/netfilter/nf_conntrack_bpf.c
> > @@ -55,41 +55,114 @@ enum {
> >  	NF_BPF_CT_OPTS_SZ =3D 12,
> >  };
> > =20
> > -static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
> > -					  struct bpf_sock_tuple *bpf_tuple,
> > -					  u32 tuple_len, u8 protonum,
> > -					  s32 netns_id, u8 *dir)
> > +static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
> > +				 u32 tuple_len, u8 protonum, u8 dir,
> > +				 struct nf_conntrack_tuple *tuple)
> >  {
> > -	struct nf_conntrack_tuple_hash *hash;
> > -	struct nf_conntrack_tuple tuple;
> > -	struct nf_conn *ct;
> > +	union nf_inet_addr *src =3D dir ? &tuple->dst.u3 : &tuple->src.u3;
> > +	union nf_inet_addr *dst =3D dir ? &tuple->src.u3 : &tuple->dst.u3;
> > +	union nf_conntrack_man_proto *sport =3D dir ? (void *)&tuple->dst.u
> > +						  : &tuple->src.u;
> > +	union nf_conntrack_man_proto *dport =3D dir ? &tuple->src.u
> > +						  : (void *)&tuple->dst.u;
> > =20
> >  	if (unlikely(protonum !=3D IPPROTO_TCP && protonum !=3D IPPROTO_UDP))
> > -		return ERR_PTR(-EPROTO);
> > -	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
> > -		return ERR_PTR(-EINVAL);
> > +		return -EPROTO;
> > +
> > +	memset(tuple, 0, sizeof(*tuple));
> > =20
> > -	memset(&tuple, 0, sizeof(tuple));
> >  	switch (tuple_len) {
> >  	case sizeof(bpf_tuple->ipv4):
> > -		tuple.src.l3num =3D AF_INET;
> > -		tuple.src.u3.ip =3D bpf_tuple->ipv4.saddr;
> > -		tuple.src.u.tcp.port =3D bpf_tuple->ipv4.sport;
> > -		tuple.dst.u3.ip =3D bpf_tuple->ipv4.daddr;
> > -		tuple.dst.u.tcp.port =3D bpf_tuple->ipv4.dport;
> > +		tuple->src.l3num =3D AF_INET;
> > +		src->ip =3D bpf_tuple->ipv4.saddr;
> > +		sport->tcp.port =3D bpf_tuple->ipv4.sport;
> > +		dst->ip =3D bpf_tuple->ipv4.daddr;
> > +		dport->tcp.port =3D bpf_tuple->ipv4.dport;
> >  		break;
> >  	case sizeof(bpf_tuple->ipv6):
> > -		tuple.src.l3num =3D AF_INET6;
> > -		memcpy(tuple.src.u3.ip6, bpf_tuple->ipv6.saddr, sizeof(bpf_tuple->ip=
v6.saddr));
> > -		tuple.src.u.tcp.port =3D bpf_tuple->ipv6.sport;
> > -		memcpy(tuple.dst.u3.ip6, bpf_tuple->ipv6.daddr, sizeof(bpf_tuple->ip=
v6.daddr));
> > -		tuple.dst.u.tcp.port =3D bpf_tuple->ipv6.dport;
> > +		tuple->src.l3num =3D AF_INET6;
> > +		memcpy(src->ip6, bpf_tuple->ipv6.saddr, sizeof(bpf_tuple->ipv6.saddr=
));
> > +		sport->tcp.port =3D bpf_tuple->ipv6.sport;
> > +		memcpy(dst->ip6, bpf_tuple->ipv6.daddr, sizeof(bpf_tuple->ipv6.daddr=
));
> > +		dport->tcp.port =3D bpf_tuple->ipv6.dport;
> >  		break;
> >  	default:
> > -		return ERR_PTR(-EAFNOSUPPORT);
> > +		return -EAFNOSUPPORT;
> >  	}
> > +	tuple->dst.protonum =3D protonum;
> > +	tuple->dst.dir =3D dir;
> > +
> > +	return 0;
> > +}
> > =20
> > -	tuple.dst.protonum =3D protonum;
> > +struct nf_conn *
> > +__bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tu=
ple,
> > +			u32 tuple_len, u8 protonum, s32 netns_id, u32 timeout)
> > +{
> > +	struct nf_conntrack_tuple otuple, rtuple;
> > +	struct nf_conn *ct;
> > +	int err;
> > +
> > +	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, protonum,
> > +				    IP_CT_DIR_ORIGINAL, &otuple);
> > +	if (err < 0)
> > +		return ERR_PTR(err);
> > +
> > +	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, protonum,
> > +				    IP_CT_DIR_REPLY, &rtuple);
> > +	if (err < 0)
> > +		return ERR_PTR(err);
> > +
> > +	if (netns_id >=3D 0) {
> > +		net =3D get_net_ns_by_id(net, netns_id);
> > +		if (unlikely(!net))
> > +			return ERR_PTR(-ENONET);
> > +	}
> > +
> > +	ct =3D nf_conntrack_alloc(net, &nf_ct_zone_dflt, &otuple, &rtuple,
> > +				GFP_ATOMIC);
> > +	if (IS_ERR(ct))
> > +		goto out;
> > +
> > +	ct->timeout =3D timeout * HZ + jiffies;
> > +	ct->status |=3D IPS_CONFIRMED;
> > +
> > +	memset(&ct->proto, 0, sizeof(ct->proto));
> > +	if (protonum =3D=3D IPPROTO_TCP)
> > +		ct->proto.tcp.state =3D TCP_CONNTRACK_ESTABLISHED;
>=20
> Hmm, isn't it a bit limiting to hard-code this to ESTABLISHED
> connections? Presumably for TCP you'd want to use this when you see a
> SYN and then rely on conntrack to help with the subsequent state
> tracking for when the SYN-ACK comes back? What's the usecase for
> creating an entry in ESTABLISHED state, exactly?

I guess we can even add a parameter and pass the state from the caller.
I was not sure if it is mandatory.

Regards,
Lorenzo

>=20
> (Of course, we'd need to be able to update the state as well, then...)
>=20
> -Toke
>=20

--ijSSQFIglunMLS0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYoVgZwAKCRA6cBh0uS2t
rMM+AP9fgEsC4eSk0dP5H/I34n0fHYrQK33/GGGzkNYJON2PFAD9GGW/Ms+r0W4P
5yZaJs1x8hd0lvUaeMM/cxhEkVhxuww=
=WPxO
-----END PGP SIGNATURE-----

--ijSSQFIglunMLS0I--

