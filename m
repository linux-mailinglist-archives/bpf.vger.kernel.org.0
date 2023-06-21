Return-Path: <bpf+bounces-3027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1365D73867F
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C403C2815CD
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0D18C0D;
	Wed, 21 Jun 2023 14:13:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE218AEE
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 14:13:25 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06FF269E
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 07:13:21 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621141320euoutp011b5c15f6db6ba134c582b83e1aa91037~qshHTIW6c2626026260euoutp011;
	Wed, 21 Jun 2023 14:13:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621141320euoutp011b5c15f6db6ba134c582b83e1aa91037~qshHTIW6c2626026260euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1687356800;
	bh=6RDLJI0KOrqV5jxFre7eP8/pFfxCzmuROKGIxWuJOAg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=S0e5I6jUDx7Vy+lsJ9MpNQYMXyoUiGCmGEsK1d5chOBPzQ3gswz4eI5l5UFq4l53U
	 LYRPLXco826CtJgCJUDrb9yiiDHnQ9nK9zL541hpTPfsZaCEV/eKuiKis3xV/3UYaz
	 k+kjo/Q0FIwAu0XYgUdpJugaEO/u36oPM0UtvHcg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230621141319eucas1p2b5015c7e16b7513131b14bf0031cfa1f~qshHLkBMN2929429294eucas1p2f;
	Wed, 21 Jun 2023 14:13:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.D5.42423.F7503946; Wed, 21
	Jun 2023 15:13:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230621141319eucas1p10f2f6f2ce359911b2161a65a06222490~qshGwU2CZ0561505615eucas1p1X;
	Wed, 21 Jun 2023 14:13:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230621141319eusmtrp24aa94a0328e8df274a762c3125012f41~qshGvz3DV0729007290eusmtrp2W;
	Wed, 21 Jun 2023 14:13:19 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-9c-6493057f3fda
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B8.44.14344.F7503946; Wed, 21
	Jun 2023 15:13:19 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230621141319eusmtip280425fbc6c0fadc43c17163a245dbbb5~qshGlt76v1418614186eusmtip2E;
	Wed, 21 Jun 2023 14:13:19 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 21 Jun 2023 15:13:18 +0100
Date: Wed, 21 Jun 2023 16:13:17 +0200
From: Joel Granados <j.granados@samsung.com>
To: Greg KH <greg@kroah.com>
CC: <mcgrof@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/11] Remove the end element in sysctl table arrays.
Message-ID: <20230621141317.bt3hfagvtusni65p@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="vrwqbjuytbw6dnjk"
Content-Disposition: inline
In-Reply-To: <2023062102-letdown-roving-921d@gregkh>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87r1rJNTDE5NNLD4fOQ4m8W5BTMY
	LW5MeMrowOyxaVUnm8fbhwEenzfJBTBHcdmkpOZklqUW6dslcGXc7e1iK9imU7HqyBzGBsbp
	yl2MnBwSAiYSLy/OYO1i5OIQEljBKPH5yAdmCOcLo8SjF2eYIJzPjBJv5+1nhmn5cuwiVGI5
	o8T9tT+Z4apW/bnMCFIlJLCVUaLpeRSIzSKgKnG9YSlYN5uAjsT5N3fAbBEBGYmOJXvYQWxm
	AT2JVe2LmEBsYQFPia/v9oDZvALmEh1TprBC2IISJ2c+YYGor5BYvuoX0BwOIFtaYvk/DpAw
	J9Bxm84tZII4VFni+r7FbBB2rcSpLbfAjpYQeMIhsXjmC0aIhIvEq4YOqCJhiVfHt7BD2DIS
	/3fOh2qYzCix/98HdghnNaPEssavUCusJVquPIHqcJT49u8WG8hFEgJ8EjfeCkIcyicxadt0
	Zogwr0RHmxBEtZrE6ntvWCYwKs9C8tosJK/NQngNIqwjsWD3JzYMYW2JZQtfM0PYthLr1r1n
	WcDIvopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwHZ3+d/zTDsa5rz7qHWJk4mA8xKgC
	1Pxow+oLjFIsefl5qUoivLKbJqUI8aYkVlalFuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKa
	nZpakFoEk2Xi4JRqYOo8lXNDSO7I+bQlH3Js9MJPq+uqasyT5JlSzhfQ1Zmzr5D/OY/+0vde
	p2vn/Glx+hOZqDVxC+9+yx1HHb+su35iSeoN39P70x3ZpXQKnCO7j61e/02/oUHzvrOVxmaf
	wj/TPI+fj2kqXPPOfpdEsfoy76epm1k+nJcokrvUwianudDonXiB74QtP29P612pVZ4su6TD
	atuTPOtyVh417y2Ne+WXloqcPFGU83B5WnyCyY+EfzUmt6V/zTQ+ke5Ud3n2iqlFwWceh3N3
	9twvYktq7ZnHd7/pjEnN+peNqlVzrop9rImVt43rl2RgWvJAsufYwvenXm19GK/earJ0t9z5
	zwHawjE91vM7C20mKLEUZyQaajEXFScCAL8mw6vCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7r1rJNTDJp/i1l8PnKczeLcghmM
	FjcmPGV0YPbYtKqTzePtwwCPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3N
	Y62MTJX07WxSUnMyy1KL9O0S9DK29+9jK9iiU9G4tomxgXGqchcjJ4eEgInEl2MXmboYuTiE
	BJYySmyaOosdIiEjsfHLVVYIW1jiz7UuNoiij4wS9yasZIZwtjJKfHh7hBmkikVAVeJ6w1Iw
	m01AR+L8mztgtgjQpI4le8CmMgvoSaxqX8QEYgsLeEp8fbcHzOYVMJfomDIFbJuQwAQmiW+/
	7CHighInZz5hgegtk9jxYBvQHA4gW1pi+T8OkDAn0Aebzi1kgjhUWeL6vsVsEHatxOe/zxgn
	MArPQjJpFpJJsxAmQYS1JG78e8mEIawtsWzha2YI21Zi3br3LAsY2VcxiqSWFuem5xYb6RUn
	5haX5qXrJefnbmIExuS2Yz+37GBc+eqj3iFGJg7GQ4wqQJ2PNqy+wCjFkpefl6okwiu7aVKK
	EG9KYmVValF+fFFpTmrxIUZTYCBOZJYSTc4HJou8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB
	9MSS1OzU1ILUIpg+Jg5OqQYm1VbJ0+kNM1vrLumENZxM/tU+29mBXVT43tzpYicunu9PUTNs
	S4veGnbkabm9oq+OirzUuotLTYu6jaf4SfYLa7HOl9HTyqmalM197qaOWcnfK0IeM+12FmUr
	xAfPWbYs9MWd57xL7RQuf9wl/l6mis3ASn37kk/LpPz5Zs1qzjww/Z7X+sr94aJRT2yY2R/c
	ZZM5FPvn2OY+6ymf90pELv+/8KrpIp/3acX3/xyIY+e1Oqf5qsyxSj3j1fOqB/ca7y3SOa5w
	O/Pax4CbNzYdeX8n9na2VeXv3ZkL753PC+x2kxHOiTvIOpmvLZ13/fW41zNXdt66wbpbxX3+
	TfmJmZcD1U9OFBXh3yz4tCFMiaU4I9FQi7moOBEA/bUaYV4DAAA=
X-CMS-MailID: 20230621141319eucas1p10f2f6f2ce359911b2161a65a06222490
X-Msg-Generator: CA
X-RootMTR: 20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038
References: <CGME20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038@eucas1p2.samsung.com>
	<20230621091000.424843-1-j.granados@samsung.com>
	<2023062117-federal-dash-cf50@gregkh>
	<20230621123816.ufqbob6qthz4hujx@localhost>
	<2023062102-letdown-roving-921d@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--vrwqbjuytbw6dnjk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 03:10:57PM +0200, Greg KH wrote:
> On Wed, Jun 21, 2023 at 02:38:16PM +0200, Joel Granados wrote:
> > On Wed, Jun 21, 2023 at 12:46:47PM +0200, Greg KH wrote:
> > > On Wed, Jun 21, 2023 at 11:09:49AM +0200, Joel Granados wrote:
> > > > This is part of the effort to remove the empty element from the ctl=
_table
> > > > structures (used to calculate size) and replace it with the ARRAY_S=
IZE macro.
> > > > The "sysctl: Remove the end element in sysctl table arrays" commit =
is the one that
> > > > actually removes the empty element. With a "yesall" configuration t=
he bloat-o-meter
> > > > says that 9158 bytes where saved (report at the end of the cover le=
tter).
> > >=20
> > > 9k in ram or read-only memory?
> > AFAIK its ro as I'm removing all the "empty" end elements from ctl_table
> > array that are hardcoded all over the place.
> > >=20
> > > > Main changes:
> > > > 1. Add the ctl_table size into the ctl_table_header
> > > > 2. Remove the empty element at the end of all ctl_table arrays
> > > >=20
> > > > Commit Overview:
> > > > 1. There are preparation commits that make sure that we have the
> > > >    ctl_table_header in all the places that we need to have the arra=
y size.
> > > >       sysctl: Prefer ctl_table_header in proc_sysct
> > > >       sysctl: Use the ctl header in list ctl_table macro
> > > >       sysctl: Add ctl_table_size to ctl_table_header
> > > >=20
> > > > 2. Add size to relevant register calls. Calculate the ctl_table arr=
ay size
> > > >    where register_sysctl is called. Add a table_size argument to th=
e relevant
> > > >    sysctl register functions (init_header, __register_sysctl_table,
> > > >    register_net_sysctl, register_sysctl and register_sysctl_init). =
Important to
> > > >    note that these commits do NOT change the way we calculate size;=
 they plumb
> > > >    things in preparation for the empty element removal commit. Care=
 is taken to
> > > >    leave the tree in a state where it can be compiled which is the =
reason to
> > > >    not separate the "big" commits (like "sysctl: Add size to the
> > > >    register_net_sysctl function"). If you have an alternative way o=
f dealing
> > > >    with such a big commit while leaving it in a compilable state, p=
lease let me
> > > >    know.
> > > >       sysctl: Add size argument to init_header
> > > >       sysctl: Add a size arg to __register_sysctl_table
> > > >       sysctl: Add size to the register_net_sysctl function
> > > >       sysctl: Add size to register_sysctl
> > > >       sysctl: Add size to register_sysctl_init
> > >=20
> > > Why not make these calls automatically calculate the size based on the
> > > structure passed into them by using a #define instead of having to to=
uch
> > > the code everywhere?  That would make this much simpler AND make it
> > > impossible for future people to get this wrong.
> > I considered this at the outset, but it will not work with callers that
> > use a pointer instead of the actual array.
>=20
> Then make 2 functions, one a "normal" one where you can't get it wrong
> as you pass in the structure that you can compute ARRAY_SIZE() and one
> that you have to do it manually.
Yes. And I actually think that there is a patch somewhere (I can't find
it in my history) that does something similar. Additionally, when the
call that does not have the size is used with a non-array, then the
developer gets a warning.

Still unsure about the indirection calls. But I'm guessing that they can
have the same define.

>=20
> Don't force developers to think about stuff like this as now you are
> going to have to constantly audit the code to verify that the array size
> is correct.  Right now it always "just works" due to the null
> termination, and now you are going to add complexity to the author in
> order to save a trivial amount of memory that no one is asking for :)
>=20
> > Additionally, we would not avoid big commits as we would have to go
> > looking in all the files where register is called directly or indirectly
> > and make sure the logic is sound.
>=20
> Then you need to think about how this could be done better, having "flag
> days" like this just doesn't work, sorry.  There are ways to evolve
> common apis, and it's not like this patch set :)
>=20
> I'm all for saving space, but do NOT do it at the expense of making apis
> harder to use and easier to get incorrect.  That will just cause more
> long-term problems and bugs, which is NOT a good trade off you ever want
> to make.

All good points. thx for the feedback, let me see if my V2 can be less
invasive :)

Best
>=20
> thanks,
>=20
> greg k-h

--=20

Joel Granados

--vrwqbjuytbw6dnjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSTBXsACgkQupfNUreW
QU9EqQv5Ae3Hv/193FQ8ZYTeUMizpG2XTZ48F3SJS2PxNQaR8Ay7mb9FFGNaC9Au
VnvxnqaSArZG5PUM/IKhG99fCSngJqxKOYl6MaO4p6nIaJ8fuDFE/464/Lzk9QTr
tXgbUfFCoQYQWKn/qVn0kBmIzlq4Lmsz9/yRu+cPIcF4IHdwTtBbEcjMVGSS//XD
xKlwu+l8ENQnFmNrzXs3GoKw1RUy5Su61+eq2qNJEDCpjRyK50G0Ox8qLP7s97ew
qZIQfcidXQX9hT4+WeFiNEq2p3yzc1Q7HguuhjCaGB7oSfSlUlhx4Nn/LeWSoTYH
Ur2OJy9TRMIO+qhrCdGBEMctpF5pXbcuwUVliWMKashYIq1j1ZMMBfXDmTef8eSX
zvf+j7L3jlSLTyy+ktd5B76VvNeDbkvGohM8ypRzr7rvv8VnzlEs5fX0pf7wNKMx
Z1ivp65qhfISSe3zOlmNlYNjIpokBXQkN+MQDA2ngEeBqnJ36V5/a4G7kveCceCg
8E1kGutl
=tVTk
-----END PGP SIGNATURE-----

--vrwqbjuytbw6dnjk--

