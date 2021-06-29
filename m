Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2254E3B723F
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 14:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhF2MqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 08:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232894AbhF2MqF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 08:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624970617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yyNLaQOoPGIq71zJhTuanVIUejq6DWASK6M626mU0CM=;
        b=BX0CEXbZRTrFpV4zpGKNksd/jxjJ+GQ/ZIX/tp4/4wtfCGsj9piyyO2UuCn3xoGN+DaV13
        CiL392LabuOxKoqe4ESuhKFFRwV+JHFQJprcex0/RvDalHL4sb2Xj6eKZZ9ejOdxqNXyBs
        Bq6IaTFzyYdm+WdFmTS6FYDYkU2rrqY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-blsR7fnHPuOFNPSXnCKJOQ-1; Tue, 29 Jun 2021 08:43:35 -0400
X-MC-Unique: blsR7fnHPuOFNPSXnCKJOQ-1
Received: by mail-wm1-f70.google.com with SMTP id o3-20020a05600c5103b02901aeb7a4ac06so1248235wms.5
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 05:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yyNLaQOoPGIq71zJhTuanVIUejq6DWASK6M626mU0CM=;
        b=hs38N47aWcql888bF8yfEK/801FnGTxrXn/woRbMJEXfLfUHwkXXvC1J+U0w2bGvkO
         qjouIniR51KUYFnoFCep2zoM3f3LgR8NjC7+eo0/qPpGRdnWBIm3wuUbeMqv2CmT/9x7
         Hsp6Nmw5BlWw2Bx9qwETupXbmAaxImjd8e8Yr0hWJik5CHaBeHs5nOOhIWS+qiukAg1r
         NK/CoheudP/rnMs7K0rtQL8w9sI5VFE65mP/34wPd9c8tC5IO75VgeCNIiQ3sSc7wkUc
         NjnIgUSOrMz8Ngm/1DeJXSEbcc2kuwQ5GiVBVtIvdzb78T2ldRw/mXtJqxfNi1y4IRRK
         Af0w==
X-Gm-Message-State: AOAM531gPFhYYlyyaxgqIseKdvMhXm20JB/6+WsDIZhkOgd3wQ+WJHXW
        KCAyNRRNru2eIhjAmV+W84jkdmE18CzQqb/vytOYoIWISnlGtFUxisVpmtdqRrRetQKM/3w+vIe
        R09OIkk8s2oiw
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr12518476wrc.183.1624970614755;
        Tue, 29 Jun 2021 05:43:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsf0VMED12h7fYp2HlnA99Tk63UyMm41linO8I665c5thVC9jLaMZBoREbYWJo2NopfwWRQw==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr12518451wrc.183.1624970614615;
        Tue, 29 Jun 2021 05:43:34 -0700 (PDT)
Received: from localhost (net-130-25-105-72.cust.vodafonedsl.it. [130.25.105.72])
        by smtp.gmail.com with ESMTPSA id t17sm16519941wmi.47.2021.06.29.05.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:43:34 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:43:31 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        "Jubran, Samih" <sameehj@amazon.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Tirthendu <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH v9 bpf-next 02/14] xdp: introduce flags field in
 xdp_buff/xdp_frame
Message-ID: <YNsVcy8e4Mgyg7g3@lore-desk>
References: <cover.1623674025.git.lorenzo@kernel.org>
 <1316f3ef2763ff4c02244fb726c61568c972514c.1623674025.git.lorenzo@kernel.org>
 <CAKgT0Ue7TsgwbQF+mfeDB-18Q-R29YZWe=y6Kgeg0xxbwds=vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/WJaeTxyp07KkM0F"
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue7TsgwbQF+mfeDB-18Q-R29YZWe=y6Kgeg0xxbwds=vw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--/WJaeTxyp07KkM0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jun 14, 2021 at 5:50 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > Introduce flags field in xdp_frame/xdp_buffer data structure
> > to define additional buffer features. At the moment the only
> > supported buffer feature is multi-buffer bit (mb). Multi-buffer bit
> > is used to specify if this is a linear buffer (mb =3D 0) or a multi-buf=
fer
> > frame (mb =3D 1). In the latter case the shared_info area at the end of
> > the first buffer will be properly initialized to link together
> > subsequent buffers.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Instead of passing this between buffers and frames I wonder if this
> wouldn't be better to place in something like the xdp_mem_info
> structure since this is something that would be specific to how the
> device is handling memory anyway. You could probably split the type
> field into a 16b type and a 16b flags field. Then add your bit where 0
> is linear/legacy and 1 is scatter-gather/multi-buffer.
>=20

ack, this should be fine but I put the flag field in xdp_buff/xdp_frame
in order to reuse it for some xdp hw-hints (e.g rx checksum type).
We can put it in xdp_mem_info too but I guess it would be less intuitive, w=
hat
do you think?

Regards,
Lorenzo

--/WJaeTxyp07KkM0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYNsVcAAKCRA6cBh0uS2t
rOBMAP0QuANCEfNrUHQieXmXcMC+YQjXw8MI4YP+VcEiWVtNMwD/blc9x9QPmb+b
UZUgAMV3XFYBY6qo0gER2PyEmoQdnww=
=mvKO
-----END PGP SIGNATURE-----

--/WJaeTxyp07KkM0F--

