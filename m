Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B54160FDE
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2020 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgBQK0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 05:26:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33872 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729045AbgBQK0B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Feb 2020 05:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581935160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6epTaHjRmLWv9XYoFLjbZ/bw1j+jKl1wWI0BYO6CRzc=;
        b=PDG1Exc72PLTKlngg7eAwZRwHg5nDAjwD/PjHvb6tqP6Zgm3dGiI3JbM8rI4nFer/BCNbg
        rBdiFynhpETp24rPt++kayYzpGtEIXdNl8PY7j2DE3lCrjhjUA/3s6ORHKAtZcfLmXFEPx
        wrvxehkgRAuk+3OkZk+7YXXm50vtd8Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-QPaaRrxuNy6b7a66zgDAOQ-1; Mon, 17 Feb 2020 05:25:56 -0500
X-MC-Unique: QPaaRrxuNy6b7a66zgDAOQ-1
Received: by mail-wm1-f71.google.com with SMTP id a189so6046512wme.2
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2020 02:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6epTaHjRmLWv9XYoFLjbZ/bw1j+jKl1wWI0BYO6CRzc=;
        b=ZpXNbWtiFoE13K7lIYDBkbZ1ietd8hreJURFDYCtncRV4ViIxxIK6lzxfasFVw007m
         8JuC5+Ln1CSf8/EiXxrcsN1CWkAYwFAqajuzlir390Koqhk86gGefirsM/QzVhQIWD+/
         /JETFiKmrOBhuF9Cs1tstLy6VzBrviGKsrpUWtO7vl+96o0WzgdU3rXBchB6VBFyzDLZ
         6MDLoK/yEaGbJdy9Sr2dp6D9qIiqiPmH9VlkuwQbq3Nwt3btGtn/AZlUgH9f3yaQTD47
         FUW7pqmZq5IIERXMFC0tQY0ak2RHaN8V2dLJcZ/PF/HllRLLO9S9sOVMv0Ir+mAAhRPt
         Rmrw==
X-Gm-Message-State: APjAAAUfADBNUP0hGdJZd5x8z304NuyDu0isaYuQmx8Z/OiYA5h5e/gb
        AhkQHw7sdNeroRW2l6bwMOcKnPVbtJX9PStdf7+eDhmHtY2nXAaUA/cf43vpKAcvbGSgjxqravG
        G0Qme+Va370Q9
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr21178394wml.186.1581935155402;
        Mon, 17 Feb 2020 02:25:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCYPBAF1g4WsZRJGvZza5x+Y0tUMSEUKPx9O2i+pTrtH/WoxvArQ5Zggr8eqSx7An2D6AMOQ==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr21178372wml.186.1581935155149;
        Mon, 17 Feb 2020 02:25:55 -0800 (PST)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id f127sm51473wma.4.2020.02.17.02.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 02:25:53 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:25:50 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        ilias.apalodimas@linaro.org, davem@davemloft.net,
        David Ahern <dsahern@kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] net: mvneta: introduce xdp counters to
 ethtool
Message-ID: <20200217102550.GB3080@localhost.localdomain>
References: <cover.1581886691.git.lorenzo@kernel.org>
 <882d9f03a8542cceec7c7b8e6d083419d84eaf7a.1581886691.git.lorenzo@kernel.org>
 <20200217111718.2c9ab08a@carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20200217111718.2c9ab08a@carbon>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 16 Feb 2020 22:07:32 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > @@ -2033,6 +2050,7 @@ mvneta_xdp_submit_frame(struct mvneta_port *pp, s=
truct mvneta_tx_queue *txq,
> >  	u64_stats_update_begin(&stats->syncp);
> >  	stats->es.ps.tx_bytes +=3D xdpf->len;
> >  	stats->es.ps.tx_packets++;
> > +	stats->es.ps.xdp_tx++;
> >  	u64_stats_update_end(&stats->syncp);
>=20
> I find it confusing that this ethtool stats is named "xdp_tx".
> Because you use it as an "xmit" counter and not for the action XDP_TX.
>=20
> Both XDP_TX and XDP_REDIRECT out this device will increment this
> "xdp_tx" counter.  I don't think end-users will comprehend this...
>=20
> What about naming it "xdp_xmit" ?

Hi Jesper,

yes, I think it is definitely better. So to follow up:
- rename current "xdp_tx" counter in "xdp_xmit" and increment it for
  XDP_TX verdict and for ndo_xdp_xmit
- introduce a new "xdp_tx" counter only for XDP_TX verdict.

If we agree I can post a follow-up patch.

Regards,
Lorenzo

>=20
>=20
> >  	mvneta_txq_inc_put(txq);
> > @@ -2114,6 +2132,7 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvn=
eta_rx_queue *rxq,
> > =20
> >  	switch (act) {
> >  	case XDP_PASS:
> > +		stats->xdp_pass++;
> >  		return MVNETA_XDP_PASS;
> >  	case XDP_REDIRECT: {
> >  		int err;
> > @@ -2126,6 +2145,7 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvn=
eta_rx_queue *rxq,
> >  					     len, true);
> >  		} else {
> >  			ret =3D MVNETA_XDP_REDIR;
> > +			stats->xdp_redirect++;
> >  		}
> >  		break;
> >  	}
> > @@ -2147,6 +2167,7 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvn=
eta_rx_queue *rxq,
> >  				     virt_to_head_page(xdp->data),
> >  				     len, true);
> >  		ret =3D MVNETA_XDP_DROPPED;
> > +		stats->xdp_drop++;
> >  		break;
> >  	}
>=20
>=20
> --=20
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>=20

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXkpqKwAKCRA6cBh0uS2t
rPJOAQCsUD5KceDQcPI6VgvAeg8OuEyhI6OTjLlLxAgankyQkAD/QNkAyTfPEFFX
KNY6jevHKUqaOKz4B9eC82D+6KCXQAQ=
=OKl2
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

