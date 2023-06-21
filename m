Return-Path: <bpf+bounces-3014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773BB7383EF
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4076F1C2040B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1881079B;
	Wed, 21 Jun 2023 12:38:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10BDDA1
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 12:38:23 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C140E122
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:38:21 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621123819euoutp0141c5f889d6a2ee99d4706f9f96543ce9~qrOJ714uz1644916449euoutp01M;
	Wed, 21 Jun 2023 12:38:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621123819euoutp0141c5f889d6a2ee99d4706f9f96543ce9~qrOJ714uz1644916449euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1687351099;
	bh=pdNH1liUnM4neeF9MuzdeK35+7+83N9w3uz4DIx4xRI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=l3Exk1T0Tmti9xEabVLnoF/Y0xxrBuKGZfnG2a52QbIplPTmit7t6lqWJoNOoyVhz
	 9jbbHyobBd1hPovvI/goT8REN5V3jIQYt/6JGMSsUpkgPFLF/c8vSSbqJfCYPcte/R
	 P+8e28jSJ/byMdyw90vYgwexveJg1hK3QKqxz5Oc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230621123818eucas1p2745203c3003d0aafd5a948bd9345404f~qrOJrdhm80692106921eucas1p2c;
	Wed, 21 Jun 2023 12:38:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FA.DB.11320.A3FE2946; Wed, 21
	Jun 2023 13:38:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230621123818eucas1p20052852dc392aecaedb56f15e13f6fd2~qrOJavSV30669806698eucas1p2Y;
	Wed, 21 Jun 2023 12:38:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230621123818eusmtrp26d9edb2a9ce3dfe4104764544757e2a5~qrOJaJ7jl1612116121eusmtrp2C;
	Wed, 21 Jun 2023 12:38:18 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-85-6492ef3a9550
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.A3.14344.A3FE2946; Wed, 21
	Jun 2023 13:38:18 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230621123818eusmtip10b690583b624ff946e13e3265397b263~qrOJPDX7W2746627466eusmtip1Q;
	Wed, 21 Jun 2023 12:38:18 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 21 Jun 2023 13:38:17 +0100
Date: Wed, 21 Jun 2023 14:38:16 +0200
From: Joel Granados <j.granados@samsung.com>
To: Greg KH <greg@kroah.com>
CC: <mcgrof@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/11] Remove the end element in sysctl table arrays.
Message-ID: <20230621123816.ufqbob6qthz4hujx@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="s2ki4zltndfumtvo"
Content-Disposition: inline
In-Reply-To: <2023062117-federal-dash-cf50@gregkh>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7pW7yelGNxYZ2Dx+chxNotzC2Yw
	WtyY8JTRgdlj06pONo+3DwM8Pm+SC2CO4rJJSc3JLEst0rdL4Mq4cn8LU8ENuYr32y6wNzB+
	kOhi5OSQEDCRaDnzh7mLkYtDSGAFo8ShnodMEM4XRonv81dAZT4zSpy43c0E0/Jg8VKoquWM
	Em9+tbDDVV07PBsqs5VRYtvxk4wgLSwCqhKzp8xlB7HZBHQkzr+5wwxiiwjISHQs2QMWZxbQ
	k1jVvghshbCAp8TXd3vAbF4Bc4mlL5ezQ9iCEidnPmGBqK+QeP/lGVANB5AtLbH8HwdImFPA
	SOJT031miEuVJa7vW8wGYddKnNpyC+w2CYEXHBJrvm5lhEi4SBx5/BHqNWGJV8e3sEPYMhL/
	d86HapjMKLH/3wd2CGc1o8Syxq9QHdYSLVeeQHU4Snz7d4sN5CIJAT6JG28FIQ7lk5i0bToz
	RJhXoqNNCKJaTWL1vTcsExiVZyF5bRaS12YhvAYR1pFYsPsTG4awtsSyha+ZIWxbiXXr3rMs
	YGRfxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZiQTv87/mUH4/JXH/UOMTJxMB5iVAFq
	frRh9QVGKZa8/LxUJRFe2U2TUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzatueTBYSSE8sSc1O
	TS1ILYLJMnFwSjUwKX19IfTz1eo1E4QuiJfNWpATv2nH7bQtff+Dei+fUvy7cW7yxghNuSlr
	52l+ajwu/jRS4ImhU/jCKU6us39ytrxLa4tc2bXBOEXokM3N1oo63ouFh9PusnTwfM9k+1fi
	Z/Ns/cXlnxVmrX52K9KyO4nv4IkXznN8/uWXztUwnjXtU3lwY2ngocpU+fnafHv1ta8anclx
	F3gRqujw4lfrgo1mRzbea1hRdTvfKMWpzJr5fxVzkOjvL3rKU+9+qF06kXuteGuZ7NPuEA4N
	L/MJby0vby551fR0YZfWkVPcTe9zNnN8+Z8ou97Dc8Y7o+LtTUZl3i9zbxdGMU7tVuQy2Gga
	oLf4Hn8zx3vDm0IBSizFGYmGWsxFxYkAaDqFacMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7pW7yelGPyaImfx+chxNotzC2Yw
	WtyY8JTRgdlj06pONo+3DwM8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
	j7UyMlXSt7NJSc3JLEst0rdL0Mu4NMen4JpcRXtfD3MD4zuJLkZODgkBE4kHi5cydTFycQgJ
	LGWU+LLxFDtEQkZi45errBC2sMSfa11sEEUfGSVOfTjKCuFsZZRY3dPABlLFIqAqMXvKXLBu
	NgEdifNv7jCD2CJAkzqW7AGLMwvoSaxqX8QEYgsLeEp8fbcHzOYVMJdY+nI5O8TQHYwS19+d
	YINICEqcnPmEpYuRA6i5TGLpfmEIU1pi+T8OkApOASOJT033mSEOVZa4vm8xG4RdK/H57zPG
	CYzCs5AMmoUwaBbCoFlgt2lJ3Pj3kglDWFti2cLXzBC2rcS6de9ZFjCyr2IUSS0tzk3PLTbS
	K07MLS7NS9dLzs/dxAiMx23Hfm7Zwbjy1Ue9Q4xMHIyHGFWAOh9tWH2BUYolLz8vVUmEV3bT
	pBQh3pTEyqrUovz4otKc1OJDjKbAMJzILCWanA9MFHkl8YZmBqaGJmaWBqaWZsZK4ryeBR2J
	QgLpiSWp2ampBalFMH1MHJxSDUxV01g0GKdzB086/9cx3uazVNvXd9f+7HHPfft/QcU+JekF
	fO7fShfOD/orvipT9sHsBumqKdPSPj/SjvyQP/fWaaVpXMVRKquXmUnbaJcYPJV6v9C6VoSB
	VUP69HT1zQuyd+7QbTh8JLapKsF+xQVX5XUTH9iLf97eeOqLlOnOl5oSenm1lyM43xQxJJdv
	8Mj83RexMqbYtFJfU1NCs01K4LWS5svio7Wn3/6oMfqTq8IXa2fAKPrE/+Mdzeqlf/6vrLzv
	O/GhwzHpcvYfCoHVu8yEfC7P+rl81mS7uWfn2wZdPPWN1dLIwkpjLVtQw3r5knv/1Mqnqb2t
	PnHs0eQ9XbuLei7NsRVbssKg/akSS3FGoqEWc1FxIgBJqzBFXAMAAA==
X-CMS-MailID: 20230621123818eucas1p20052852dc392aecaedb56f15e13f6fd2
X-Msg-Generator: CA
X-RootMTR: 20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038
References: <CGME20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038@eucas1p2.samsung.com>
	<20230621091000.424843-1-j.granados@samsung.com>
	<2023062117-federal-dash-cf50@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--s2ki4zltndfumtvo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 12:46:47PM +0200, Greg KH wrote:
> On Wed, Jun 21, 2023 at 11:09:49AM +0200, Joel Granados wrote:
> > This is part of the effort to remove the empty element from the ctl_tab=
le
> > structures (used to calculate size) and replace it with the ARRAY_SIZE =
macro.
> > The "sysctl: Remove the end element in sysctl table arrays" commit is t=
he one that
> > actually removes the empty element. With a "yesall" configuration the b=
loat-o-meter
> > says that 9158 bytes where saved (report at the end of the cover letter=
).
>=20
> 9k in ram or read-only memory?
AFAIK its ro as I'm removing all the "empty" end elements from ctl_table
array that are hardcoded all over the place.
>=20
> > Main changes:
> > 1. Add the ctl_table size into the ctl_table_header
> > 2. Remove the empty element at the end of all ctl_table arrays
> >=20
> > Commit Overview:
> > 1. There are preparation commits that make sure that we have the
> >    ctl_table_header in all the places that we need to have the array si=
ze.
> >       sysctl: Prefer ctl_table_header in proc_sysct
> >       sysctl: Use the ctl header in list ctl_table macro
> >       sysctl: Add ctl_table_size to ctl_table_header
> >=20
> > 2. Add size to relevant register calls. Calculate the ctl_table array s=
ize
> >    where register_sysctl is called. Add a table_size argument to the re=
levant
> >    sysctl register functions (init_header, __register_sysctl_table,
> >    register_net_sysctl, register_sysctl and register_sysctl_init). Impo=
rtant to
> >    note that these commits do NOT change the way we calculate size; the=
y plumb
> >    things in preparation for the empty element removal commit. Care is =
taken to
> >    leave the tree in a state where it can be compiled which is the reas=
on to
> >    not separate the "big" commits (like "sysctl: Add size to the
> >    register_net_sysctl function"). If you have an alternative way of de=
aling
> >    with such a big commit while leaving it in a compilable state, pleas=
e let me
> >    know.
> >       sysctl: Add size argument to init_header
> >       sysctl: Add a size arg to __register_sysctl_table
> >       sysctl: Add size to the register_net_sysctl function
> >       sysctl: Add size to register_sysctl
> >       sysctl: Add size to register_sysctl_init
>=20
> Why not make these calls automatically calculate the size based on the
> structure passed into them by using a #define instead of having to touch
> the code everywhere?  That would make this much simpler AND make it
> impossible for future people to get this wrong.
I considered this at the outset, but it will not work with callers that
use a pointer instead of the actual array.
Additionally, we would not avoid big commits as we would have to go
looking in all the files where register is called directly or indirectly
and make sure the logic is sound.

Best

>=20
> thanks,
>=20
> greg k-h

--=20

Joel Granados

--s2ki4zltndfumtvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS7zgACgkQupfNUreW
QU8gSAwAg9Z1p080a0flWj7rJFzELoZ7IjIXyRraDE77GOHFFb5P05dEhYhqtarD
pB36RZvNIx0c9LBZkDlUn3grTYIvRtfiDEKYAQEbtog7/83NQO3e7nwvlqtC/tqm
t6hEfR91cBlrZcHO+xJlf8ShsW0O/qI+QPOjzAp57jSmj5Jrmu91KS60rBe4++Xb
QEVyGoneYsSgXWy/5RfI2WBDGYBfgXwUTXml7PLKwrE5o6nOLVM5OshFZl6BOBet
40D7zlMmO+1B0nX6hF6Mqfz9NgxkpXejh6hwikIpPo+Qa5rc4HiP0ie4urVVPf8A
B6vLBYMmCg/NVzeS6YKuwa0J4kym6xwhrdtPdkQ7Nt4TQBG/iT16BIxuQ+vqcRJY
rwHy0S31vTBcTpPab/II4YpiECx/V57ay/OeGQB6e70C/Xe79rDTPmyucUyJA7u/
q/C+MoveDwIN7/wvpihXh3tmi6lwjz8aqDzpnGYt5/FsKf8E/cf1BdvxvIQsfnIu
Moz9VXAE
=bZkp
-----END PGP SIGNATURE-----

--s2ki4zltndfumtvo--

