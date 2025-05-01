Return-Path: <bpf+bounces-57155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB9AA656B
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 23:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2371BC136E
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C926157E;
	Thu,  1 May 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2JXC1RU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73821C18D;
	Thu,  1 May 2025 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746134813; cv=none; b=BVvrB0yVK2yJCPpC2e36u3hG9hYIhpegQrEv6KLqjWDkcYunyNJ/V7MXfFeLjzfYuO8Sgv6rfMWoGaKbJP9psRj1RJB+IzSP2OJJpKbvaPAcrnHLTH/Ib2gqPf0coe1UsOsmZ8BM7fU9d7DzLXNt4gp1VAG7ZXBMhExICsWtNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746134813; c=relaxed/simple;
	bh=5a6iYKMZP0e8zdYj8kunSotenfvp2hS2NChe9i2pkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6ATrWsqURFLLhmhIRP/Y1ig3Dy5Hrk1Ev4vgorJo0bEobL1ZCHUL73QHSLQZxcKSNW0/uZ7TrcXjx7F6doum7wL1KaCwYZPlbYpmvICBqp7/QtPqYeIwKQa3ClBKbG8KIBDFpwu3E1gsc5vqNZcDYX8Il2Twir6Z1x3CAIUnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2JXC1RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A452DC4CEE3;
	Thu,  1 May 2025 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746134812;
	bh=5a6iYKMZP0e8zdYj8kunSotenfvp2hS2NChe9i2pkIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2JXC1RU/MAlATfUJiGcr2iai8Qz0pZL74Fku2wXAYRo54BJa2BykzgDrZ6df/Cb4
	 ovehe37wCJ75lzNzMa3qm3bgvytpg/FN3+KQVkksNl80e6nOE6lP/a3msBnGory+sy
	 vNrqWwyjsS19iCtbCRLRIupC2bH1fX+vYqAtYIOnrR92Va9xEe9JyJ3lRkZ8kR4TMK
	 YkL2YB3VL8qGQhNI12oIylvV18x2Mh4pAg3EpdpWP5cakS+spveNB9jqeRBFf+xem3
	 W/BZMPJkQ8zSDZjmVD/orS7psM9CQTtkIpSXecqnDrfRdzd7v4e/bVVN53Ddf9f6Z2
	 LnLHgkKRn0fLQ==
Date: Thu, 1 May 2025 23:26:46 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	David Laight <David.Laight@aculab.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 22/22] man2: Add uprobe syscall page
Message-ID: <cqih4qscx5jslfaq46bjcldt3dqoiyqg2dgbnif5eqa7ioygem@lorictjx3jrb>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-23-jolsa@kernel.org>
 <42yzod7olktnj4meijj57j5peiojywo2d47d5gefnbmbwxfz4b@5ek6puondmck>
 <aAehVOlj-W5kVyW3@krava>
 <6rauz4mwgjpcmdbpny3pnh632t3wbequxni2iqdvs3bmjbzqzt@7cykilsvoggn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gzestemhmsuve7zo"
Content-Disposition: inline
In-Reply-To: <6rauz4mwgjpcmdbpny3pnh632t3wbequxni2iqdvs3bmjbzqzt@7cykilsvoggn>


--gzestemhmsuve7zo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	David Laight <David.Laight@aculab.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 22/22] man2: Add uprobe syscall page
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-23-jolsa@kernel.org>
 <42yzod7olktnj4meijj57j5peiojywo2d47d5gefnbmbwxfz4b@5ek6puondmck>
 <aAehVOlj-W5kVyW3@krava>
 <6rauz4mwgjpcmdbpny3pnh632t3wbequxni2iqdvs3bmjbzqzt@7cykilsvoggn>
MIME-Version: 1.0
In-Reply-To: <6rauz4mwgjpcmdbpny3pnh632t3wbequxni2iqdvs3bmjbzqzt@7cykilsvoggn>

Hi Jiri,

On Tue, Apr 22, 2025 at 10:45:41PM +0200, Alejandro Colomar wrote:
> On Tue, Apr 22, 2025 at 04:01:56PM +0200, Jiri Olsa wrote:
> > > > +is an alternative to breakpoint instructions
> > > > +for triggering entry uprobe consumers.
> > >=20
> > > What are breakpoint instructions?
> >=20
> > it's int3 instruction to trigger breakpoint (on x86_64)
>=20
> I guess it's something that people who do that stuff understand.
> I don't, but I guess your intended audience will be okay with it.  :)
>=20
> > > The pages are almost identical.  Should we document both pages in the
> > > same page?
> >=20
> > great, I was wondering this was an option, looks much better
> > should we also add uprobe link, like below?
>=20
> Yep, sure.  Thanks for the reminder!

=46rom what I see, I should not yet merge the patch, right?  The kernel
code is under review, right?


Have a lovely night!
Alex

>=20
>=20
> Have a lovely night!
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--gzestemhmsuve7zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgT5xYACgkQ64mZXMKQ
wqldaw/9GeFsRHndA9QnooP0EUAvXo9kh1+Pbs4G0ivMw/9tK4gffq+VxVykad5s
27u3Ue739vh+GQJTkYGR6RL0I9AxSWF38DGGCXbXLvpPT+ALjT4NxvcbP+RXAK62
yg05eKcniviBTMmDkFp0nX5Zr81UQeIGfjE68CKvL2AlwXOn56VcUeTuRcLXiRAS
wtWWHmvlJ+TRGNqNaLU7bAxxeJSeZau5XkngB72Kc/1M1Z1X42yadwthEH2bZC7r
XdnC0/+TS5A5K4t1ylp/MBp7gwnxy4Nv29fpt2mlxVexHg9MB12m32Jk9VsVPBOG
JTJ4Q+XGASjbxqd331zNQKcA7zfrdr602Yf5Rs1wNTNV/ia/AQqL5ReMd+I36bcr
7hNb4ychE2344hgKdOr2s8y7NLKBogCdcrWqSBldiQLZ7sAllcZfXQngiSQ4wqyI
1TXoV1tFBJ3Bg8Ec9iDJITPp7KcHhY34C1lurGTjQWny+ONpqoSDTTdoyb5+9gk5
+Ryed603G7J5pT2P+GCaqH9s5L63ZeAqx1ayFTmndnqRDh3yFI5SbqiqjxRkWk93
IM0GZmvgfxjWbBaP5Hl51Ki1NcHptXsuVNKMsJO4aSpMUJTdzbmHdRZJVSMBnJDq
suv2SaQMze4oAkrSlN8BwE5tbIqbs6558UVH+z0IbwO5vbI89QI=
=oQPl
-----END PGP SIGNATURE-----

--gzestemhmsuve7zo--

