Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A923AE0CA
	for <lists+bpf@lfdr.de>; Sun, 20 Jun 2021 23:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFTV5r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Jun 2021 17:57:47 -0400
Received: from ozlabs.org ([203.11.71.1]:48519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhFTV5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Jun 2021 17:57:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G7RKq57Bwz9sVp;
        Mon, 21 Jun 2021 07:55:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1624226132;
        bh=tdHZKt3n8QMhM7P+AhMaV6aoHvRWZ3MqYrGNEHyCAWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JCEjcAiOxAMTbXM3XkS29q1DyvKDerVqg4nI7N1AOLBLHKUIRm4/PQGtuUhqvSRQJ
         Btr/+YTsFdO8GkLTjIJXDxxP2BKFkoqL56S0NOgxr6TyxIQ0c/eyoYaiYorm1wT5j3
         lfQWjF+A8gnKzXfl2bnNb8Rv2ceZ3vw8pVoXD06hkthj0vc7EERNBdZy7yb+5XLXk/
         r9sWFQJqRMD+LuPEveUqLqSk8X6wJ4vNffP5wV5zANN5kH9EV3b3H9XY64+fVw7iqm
         sWKT0E4ya1DOgIEznXNTUTClG+C0z95amzrBtJKENkgE9NzkCteGRUY0Hj3ek+jGTo
         X8DNFNOqF6WuA==
Date:   Mon, 21 Jun 2021 07:55:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] perf test: Fix non-bash issue with stat bpf
 counters
Message-ID: <20210621075525.128b476f@canb.auug.org.au>
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
References: <20210617184216.2075588-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zoZrJw/m85R1sYwgf=Mbt_b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--Sig_/zoZrJw/m85R1sYwgf=Mbt_b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, 17 Jun 2021 11:42:13 -0700 Ian Rogers <irogers@google.com> wrote:
>
> $(( .. )) is a bash feature but the test's interpreter is !/bin/sh,
> switch the code to use expr.

The $(( .. )) syntax is specified in POSIX (see
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#t=
ag_18_06_04),
so unless this caused an actual problem, this change is unnecessary.

--=20
Cheers,
Stephen Rothwell

--Sig_/zoZrJw/m85R1sYwgf=Mbt_b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDPuU0ACgkQAVBC80lX
0Gz49wgAmStmGqWpOagN6Ov5tTwdPk1XiTOzF7QnzPkIrSsrlb14wdiartR9A9Yi
L/xFGhRz7nlGZu2Rgsq1CVKA9maLkFpUJN5qjGVRlmBi1o6xDNhfvSoenHY6J4sI
+yUEboS8gH3C3OpSlVSj6HhGlfUFrXDjCHSaoZVZZ+S7cwP8PnaN02IkXouYbGES
fJuBjgzbxxIChC6YFa4Ws9YGlQfNAJsqok9W+mUuT2dfIj3Ymns7GzNqnxmtUTXk
+pttH+/Y1kwPca3MljuMfBxQaKWD+ogdJwOVOWnIL4DLellxoMamJ9Yg2oOBQPZe
DjM7fviURinAyv98w8kmMniXyIrZCA==
=0kaQ
-----END PGP SIGNATURE-----

--Sig_/zoZrJw/m85R1sYwgf=Mbt_b--
