Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5374A9F08
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 19:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377540AbiBDSaz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 13:30:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237456AbiBDSaz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 13:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643999454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hky5DV8TETGJOkKLGTwiJ+rckhbkE1SoswbmzyRxFIg=;
        b=Khey4xciJL0UehHBhJSPvgaDSEoRuyUQ2eC4Ua3BCc+E+l1YNiNtYf4jn5bNEPO0pNThhT
        w8A1W40giUQvm7hMvCSZRtE7ZZSevgQjnlvvCtDlRWF2SqCcRxQVPJr0yZ18DQ82VvtBgu
        Ob7I/qV8nERx1C7KbPgkaDG3XTfh2l4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-zdC2wMwmOmOdbWZjOSeXKw-1; Fri, 04 Feb 2022 13:30:53 -0500
X-MC-Unique: zdC2wMwmOmOdbWZjOSeXKw-1
Received: by mail-qt1-f197.google.com with SMTP id g18-20020ac84b72000000b002cf274754c5so5289036qts.14
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 10:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hky5DV8TETGJOkKLGTwiJ+rckhbkE1SoswbmzyRxFIg=;
        b=YP6kjqoTG03fo1o0d8jdwaMY5YR7hkYSxrvKLBCylSFsP050DTtpAvnuBog6PYwbOa
         6ADGeBd95jXCYuVc7s25daJBWPuEK6+xW9lcM+B7MWen5kr3sUsM2ky3cE3Msz1rCbmt
         98nbov17aYqn4+Pp4olrKkcsOCB4Zo9LL4ZJY6PoY77hpy1l4gb+7y6xrl3QqtVSTvKu
         HcylNDm3hT8fCE4Y0xFKEugfJ9ZulkERWLyZ+X9eyOC6tyN7o0HlEqwUGvJLFikIIBJW
         rBh53uKL49d/MEn3KoKKbux1S8XRGLmJHFY42JWsx5XXNISt4FprjTUcdlxVudNTT+CF
         cvkw==
X-Gm-Message-State: AOAM530WBL7ULpJ8aXoOzdgdeMsnM/jJbuJeEhafL7BdfuYj0CwxxaiU
        MPcCAvpacjOQ7lI8fOReYRG98bEbfowsbThz+Pu0BOWeTvIU0N12+R0SLnBYHabfhDuFHM/K42l
        qRl7B6AGo5KNR
X-Received: by 2002:a37:a1c5:: with SMTP id k188mr247390qke.461.1643999452518;
        Fri, 04 Feb 2022 10:30:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOPY3yoAy87MjHfNDO5xeTaMZyBuP8HYYSVda3BgG9lYhwByyZHrg0XNpqwLCpf5WqlwSz0g==
X-Received: by 2002:a37:a1c5:: with SMTP id k188mr247369qke.461.1643999452261;
        Fri, 04 Feb 2022 10:30:52 -0800 (PST)
Received: from localhost (net-37-182-17-113.cust.vodafonedsl.it. [37.182.17.113])
        by smtp.gmail.com with ESMTPSA id c14sm1585342qtc.31.2022.02.04.10.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:30:51 -0800 (PST)
Date:   Fri, 4 Feb 2022 19:30:48 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        toke@redhat.com, andrii@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftest/bpf: check invalid length in
 test_xdp_update_frags
Message-ID: <Yf1w2HRokiYBg8w9@lore-desk>
References: <aff68ca785cae86cd6263355010ceaff24daee1f.1643982947.git.lorenzo@kernel.org>
 <c3858f6b-43d5-18ef-2fc8-b58c13c12b05@fb.com>
 <Yf1nxMWEWy4DSwgN@lore-desk>
 <15f829a2-8556-0545-7408-3fca66eb38b7@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="irYz3dtSM2qqlyd7"
Content-Disposition: inline
In-Reply-To: <15f829a2-8556-0545-7408-3fca66eb38b7@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--irYz3dtSM2qqlyd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20

[...]

> > >=20
> > > In kernel, the nr_frags checking is against MAX_SKB_FRAGS,
> > > but if /proc/sys/net/core/max_skb_flags is 2 or more less
> > > than MAX_SKB_FRAGS, the test won't fail, right?
> >=20
> > yes, you are right. Should we use the same definition used in
> > include/linux/skbuff.h instead? Something like:
> >=20
> > if (65536 / page_size + 1 < 16)
> > 	max_skb_flags =3D 16;
> > else
> > 	max_skb_flags =3D 65536/page_size + 1;
>=20
> The maximum packet size limit 64KB won't change anytime soon.
> So the above should work. Some comments to explain why using
> the above formula will be good.

ack, I will do in v2.

Regards,
Lorenzo

>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > > +
> > > > +	num =3D fscanf(f, "%d", &max_skb_frags);
> > > > +	fclose(f);
> > > > +
> > > > +	if (!ASSERT_EQ(num, 1, "max_skb_frags read failed"))
> > > > +		goto out;
> > > > +
> > > > +	/* xdp_buff linear area size is always set to 4096 in the
> > > > +	 * bpf_prog_test_run_xdp routine.
> > > > +	 */
> > > > +	buf_size =3D 4096 + (max_skb_frags + 1) * sysconf(_SC_PAGE_SIZE);
> > > > +	buf =3D malloc(buf_size);
> > > > +	if (!ASSERT_OK_PTR(buf, "alloc buf"))
> > > > +		goto out;
> > > > +
> > > > +	memset(buf, 0, buf_size);
> > > > +	offset =3D (__u32 *)buf;
> > > > +	*offset =3D 16;
> > > > +	buf[*offset] =3D 0xaa;
> > > > +	buf[*offset + 15] =3D 0xaa;
> > > > +
> > > > +	topts.data_in =3D buf;
> > > > +	topts.data_out =3D buf;
> > > > +	topts.data_size_in =3D buf_size;
> > > > +	topts.data_size_out =3D buf_size;
> > > > +
> > > > +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > > > +	ASSERT_EQ(err, -ENOMEM, "unsupported buffer size");
> > > > +	free(buf);
> > > >    out:
> > > >    	bpf_object__close(obj);
> > > >    }
> > >=20
>=20

--irYz3dtSM2qqlyd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYf1w2AAKCRA6cBh0uS2t
rCxbAP4sAKdKzKqmJ6s28ObVC75VJ40wpNS+Dk8eqCmFaVM4AAD9FV+GejVCGHut
Uro6CvBap+3Dw5XbOuC0jJ8JxzGoCg0=
=vDVZ
-----END PGP SIGNATURE-----

--irYz3dtSM2qqlyd7--

