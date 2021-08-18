Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E83F03F0
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 14:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhHRMsM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 08:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233634AbhHRMsM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 08:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629290857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bdfCsij/iWUWWLQYzI7XEIMeIs0Se0vc/fjMAaeTG8Q=;
        b=S1YgFl9wDJ/gaT3u41Y2YRjVyiIk5ca2/yv3tazEk0MZsyU33hD3fa53Stmvwn8qCHY96i
        TghrHL/u4CmYIfNbdDrbcyz3Q03EDI0x0cuLXihVg/Q0UycN97t5yCGE3gQ3yBLToGiGMR
        gtAimSYIVRMbNb2rxNlEv1LtxdpV27U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-J5L4P_p6Oq2S6OSH_HHCIg-1; Wed, 18 Aug 2021 08:47:35 -0400
X-MC-Unique: J5L4P_p6Oq2S6OSH_HHCIg-1
Received: by mail-wr1-f72.google.com with SMTP id q19-20020adfbb93000000b00156a96f5178so547747wrg.11
        for <bpf@vger.kernel.org>; Wed, 18 Aug 2021 05:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdfCsij/iWUWWLQYzI7XEIMeIs0Se0vc/fjMAaeTG8Q=;
        b=S/0R/T4PLGd3DiHqLCnKCfq+eNn/U5H4ReFphOz+bWsFpLFLjF6Uq/brbBHQyCwLO5
         yms9hcfgqU15O+6Qaa3Zy41MZdFAO3FwQh5ZANgC8DEpMftH1cXqF4Nhr9ch5ItvbkBN
         9O7s4CwSFTcXU9B1958EMLTOW9LbHusotOodBwhrq6/3i/Ra5Cya0wnLNGzBZu6XBRLO
         Zsi/+kYorkn1UTqqTFWJTdrvopOcKj1ZahtoPP4GXgUGgoPo9YUdSYXWsK5uiGCMH7e/
         RSC9vywhdYLzMniODidx9KysfduRF70UVm4GtPacD2KKJ7/Nk5E57qfyuFnRisAA+IUw
         pnew==
X-Gm-Message-State: AOAM5301mbQuMJC09/jGw8XtO5aSvr+KuHne5nOsm56vSOGbH+lhM5Jr
        Z8ncM0OZxxHWZBjsEbrSav1qbdulosydJh2Jl2GD4lC1/IdKIokFtLAYn/dg17CEq7bJFRz+yVh
        2a1jUwSOfFOvi
X-Received: by 2002:adf:b1cd:: with SMTP id r13mr10145706wra.78.1629290854327;
        Wed, 18 Aug 2021 05:47:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVGzIN2qTD60NeiLCDBkw+kAVWMqa9x+l5K9INCquKZ0X3DfqsEcJATHjBf8R2I8KbhIBsxg==
X-Received: by 2002:adf:b1cd:: with SMTP id r13mr10145671wra.78.1629290854044;
        Wed, 18 Aug 2021 05:47:34 -0700 (PDT)
Received: from localhost (net-47-53-237-136.cust.vodafonedsl.it. [47.53.237.136])
        by smtp.gmail.com with ESMTPSA id 7sm5205227wmk.39.2021.08.18.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:47:33 -0700 (PDT)
Date:   Wed, 18 Aug 2021 14:47:30 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v11 bpf-next 17/18] net: xdp: introduce
 bpf_xdp_adjust_data helper
Message-ID: <YR0BYiQFvI8cmOJU@lore-desk>
References: <cover.1628854454.git.lorenzo@kernel.org>
 <9696df8ef1cf6c931ae788f40a42b9278c87700b.1628854454.git.lorenzo@kernel.org>
 <87czqbq6ic.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2VYlOkOjArDpYxIY"
Content-Disposition: inline
In-Reply-To: <87czqbq6ic.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--2VYlOkOjArDpYxIY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
[...]
> > + *	Description
> > + *		For XDP frames split over multiple buffers, the
> > + *		*xdp_md*\ **->data** and*xdp_md *\ **->data_end** pointers
> > + *		will point to the start and end of the first fragment only.
> > + *		This helper can be used to access subsequent fragments by
> > + *		moving the data pointers. To use, an XDP program can call
> > + *		this helper with the byte offset of the packet payload that
> > + *		it wants to access; the helper will move *xdp_md*\ **->data**
> > + *		and *xdp_md *\ **->data_end** so they point to the requested
> > + *		payload offset and to the end of the fragment containing this
> > + *		byte offset, and return the byte offset of the start of the
> > + *		fragment.
>=20
> This comment is wrong now :)

actually we are still returning the byte offset of the start of the fragment
(base_offset).

Lorenzo

>=20
> -Toke
>=20

--2VYlOkOjArDpYxIY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYR0BYAAKCRA6cBh0uS2t
rDZAAQD4zlk/ZnUHVLGjRgogjb108NhQ8VXI1OEvz2qnjndbyAD/VxzZtqd1fFdN
IOVpKdR7lmo6cNVB6gjiTfwmg8u/HAs=
=lbP4
-----END PGP SIGNATURE-----

--2VYlOkOjArDpYxIY--

