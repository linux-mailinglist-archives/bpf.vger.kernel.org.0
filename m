Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14B4365E37
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhDTRKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 13:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhDTRKT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Apr 2021 13:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618938586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SRf/Tph3L3NAvNbWzjfk07FIkQyOeKwYwW/14Laa07M=;
        b=LhbAO+DCVrf5gJ+wqxibKz5YjBIVOsOHkx5ah1oAEKcppahMIxFgtc1m8EudVfYV3aPT1s
        DYtdU30c9Gk2wiritPNA5gsW4ArlIJCuk1QNLtpQM6FT82UGZvdCrfWxieSEtcx6tm6s9a
        xkJYk5tK4WUN1zv6Ja6vkqeib1lkJg4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-yrv673iPMyKQyR3TIxqZtA-1; Tue, 20 Apr 2021 13:09:43 -0400
X-MC-Unique: yrv673iPMyKQyR3TIxqZtA-1
Received: by mail-ed1-f69.google.com with SMTP id l22-20020a0564021256b0290384ebfba68cso9643208edw.2
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 10:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SRf/Tph3L3NAvNbWzjfk07FIkQyOeKwYwW/14Laa07M=;
        b=eW35CQ6vvMlBdSfsQjQRbDJHfwm6q6yJ9OsK/S6Z2ixnGpdttZV4RLJsnFxvkJRG5D
         TDvDTPmf8TOTWx+ji+NcEKoS3q4MM6XrMp/FtedHiRA7/tliOPqD1nbrzP8zsdfo/pNV
         WLmVn/XIpt6dcPxW7o2eMxNsmzq2rbTmhkNzWwyWCWO4/J9sgkjsTVqKBS/1+wcg3/Ry
         TaqXENI7jbTVj3PjYg/bvjLVmZlgQ1Wxu4g9of9IohR2JjVkfaYlrPfUrndX03YnoS8V
         ml5iTK67KlXqRgE0hn2oXdGyOzWWlNy/CUfHMJj0H5tvsZrw1XPipWIea3Q6l7CkpG4T
         xJAw==
X-Gm-Message-State: AOAM532tI/Hs79oSQxxkhcT+3LogHv/IOaxeQ4ck4pEq/BC2HPe2hxeU
        nyvTVMJGhAzBFTxTvnBAeLNrxGKtPMHS9TQ28x7zWX3aZCfWotif8m2aRxUyek+bVx/RbyoMko6
        cKIXjj+wuANS5
X-Received: by 2002:a17:906:77c5:: with SMTP id m5mr27364259ejn.201.1618938582563;
        Tue, 20 Apr 2021 10:09:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6gn2isDw3WqUDXHO63YDx5KhOxC+YyfUal3meuEXKHwTt4Ve781FuwcvJ5bPN0AapIjE8qg==
X-Received: by 2002:a17:906:77c5:: with SMTP id m5mr27364232ejn.201.1618938582404;
        Tue, 20 Apr 2021 10:09:42 -0700 (PDT)
Received: from localhost ([151.66.28.185])
        by smtp.gmail.com with ESMTPSA id r19sm12913751ejr.55.2021.04.20.10.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:09:41 -0700 (PDT)
Date:   Tue, 20 Apr 2021 19:09:38 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
        toke@redhat.com
Subject: Re: [PATCH v3 bpf-next] cpumap: bulk skb using netif_receive_skb_list
Message-ID: <YH8K0gkYoZVfq0FV@lore-desk>
References: <01cd8afa22786b2c8a4cd7250d165741e990a771.1618927173.git.lorenzo@kernel.org>
 <20210420185440.1dfcf71c@carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X48EGoxOSC8+66zO"
Content-Disposition: inline
In-Reply-To: <20210420185440.1dfcf71c@carbon>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--X48EGoxOSC8+66zO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > +	TP_ARGS(map_id, processed, sched, xdp_stats),
> > =20
> >  	TP_STRUCT__entry(
> >  		__field(int, map_id)
> >  		__field(u32, act)
> >  		__field(int, cpu)
> > -		__field(unsigned int, drops)
> >  		__field(unsigned int, processed)
>=20
> So, struct member @processed will takeover the room for @drops.
>=20
> Can you please test how an old xdp_monitor program will react to this?
> Will it fail, or extract and show wrong values?

Ack, right. I think we should keep the struct layout in order to maintain
back-compatibility. I will fix it in v4.

>=20
> The xdp_mointor tool is in several external git repos:
>=20
>  https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/samp=
les/bpf/xdp_monitor_kern.c
>  https://github.com/xdp-project/xdp-tutorial/tree/master/tracing02-xdp-mo=
nitor
>=20
> Do you have any plans for fixing those tools?

I update xdp_monitor_{kern,user}.c and xdp_redirect_cpu_{kern,user}.c in the
patch. Do you mean to post a dedicated patch for xdp-project tutorial?

Regards,
Lorenzo

>=20
>=20
>=20
>=20
> --=20
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>=20

--X48EGoxOSC8+66zO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYH8K0AAKCRA6cBh0uS2t
rNYJAQCb772jtidNWS9ZSDM5wbswkXCz6KJpLOFAehcLc5flGAEAhCs+jMvOs1hI
GWt2R3oUmF1T3uv6Hx14tzIAeUmb1Qk=
=obBe
-----END PGP SIGNATURE-----

--X48EGoxOSC8+66zO--

