Return-Path: <bpf+bounces-3421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59073D949
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E680A280D51
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E18146BD;
	Mon, 26 Jun 2023 08:12:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1ED46A0;
	Mon, 26 Jun 2023 08:12:42 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D63E76;
	Mon, 26 Jun 2023 01:12:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqLDc5xCyz4wZr;
	Mon, 26 Jun 2023 18:12:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1687767154;
	bh=YL4WtG8LHm8HUihCvX1m65X1iguc/Lla+C+qJnkgHSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l/0v/jqK+E4RhCKLhMKi2A2cfLf7MEG/IjT47KrFbvNwUcc/ak2DcL4RwaSXDX5HU
	 32GcpNT4wkfyYrOboPEi/MBWW99W9Hs4wuyupj1wBRh9zSyX1B4QhqA96VXrhyfuG9
	 wZANibg/LWtdko5+N4iG4gJ8/GrLEK186mgGG4z3akt2rQTtTq5Xw3tUOGoIsuO+Ub
	 4JIZZmUIHPUjc4KZoHW2y8iin8mA5M4WHvkRIW0+vcWGxPxQOqKrG37PR8lxBH/Mq7
	 DpOn27+D47aUPU6eNxX6RONJ2cLF8/RpY47ESCplSGpmtbCldGCdPLzG+wWdHUteUZ
	 tqaKUnDV2rudw==
Date: Mon, 26 Jun 2023 18:12:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, David Miller <davem@davemloft.net>,
 Networking <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20230626181231.70405c1f@canb.auug.org.au>
In-Reply-To: <2947430.1687765706@warthog.procyon.org.uk>
References: <20230626112847.2ef3d422@canb.auug.org.au>
	<2947430.1687765706@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1Ge+Wr0ku4FcBxMax3jOKWi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/1Ge+Wr0ku4FcBxMax3jOKWi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 26 Jun 2023 08:48:26 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > After merging the net-next tree, today's linux-next build (native perf)
> > failed like this:
> >=20
> > In file included from builtin-trace.c:907:
> > trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags=
':
> > trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (f=
irst use in this function) =20
>=20
> I tried applying the attached patch, but it doesn't make any difference.

I wonder if it is using the system headers?  Or depends on "make headers-in=
stall"?

--=20
Cheers,
Stephen Rothwell

--Sig_/1Ge+Wr0ku4FcBxMax3jOKWi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSZSG8ACgkQAVBC80lX
0Gxg/ggAkTZ+/82QjJe4wJrDgQ+zyJhq4vhN3TFH56b9I64FB9blMUZicISKfQte
O/y63r6wPVD5Tsjc8v81egJO+i4/jXd/jp4i+ce7xSNDk0uSIjeRoXr8wMD3R793
Z0925rEhClPbyGwjhNZulvAOEcNZOyN/2A8z+zFSN/3ie6bTNxWNrVXkN1P25RTd
FAQYiT+YtY5taSmAnmO+O7ckJl69o3K8xUPct4a0oeEWxgNnjrXfKlhAUyFZzLzv
TjYK7Vk3KfGKJ2rGrLEw2RlgaIMMJ5/3NupwFqbpa6UMHtyMfv+5Z2EzHVs8BqFJ
G9IHURBU29V9G16Lrjo2uPr0UBOIaw==
=IP/A
-----END PGP SIGNATURE-----

--Sig_/1Ge+Wr0ku4FcBxMax3jOKWi--

