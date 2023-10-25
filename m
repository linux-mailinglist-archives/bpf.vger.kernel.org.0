Return-Path: <bpf+bounces-13261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921CB7D7309
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 20:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4ACC1C20E0A
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AD630FBB;
	Wed, 25 Oct 2023 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/Qd/RrS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0030F86
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 18:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD9DC433C9;
	Wed, 25 Oct 2023 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698257571;
	bh=xY2rrgxU1BMG2PGPODjdrO22ck/Wo1AtLqB6Adj6/Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/Qd/RrSvgIhHPdAYFrrOVyTzK5IMFvSOQbXYxmnyK6F53YhT0JOY5xkK63abxW6l
	 6FdyHEr4jz5onnbNRkgwgwIGWwSuB9WbEHDXf1d5eNQpn/pMfjsC4jz42SfjNXx8Eq
	 5m3VDkWNb5DpEvxPeY45An4vK0MoYyVDA41ACMfYVxenuSxt838rx1r/vzJLwiN7qo
	 Vrktz0VEcOYLAkH28sCfPlJdm6M0fhpXtw+blamPDa7G/DBj8CPwAA0rQfKGLO+0Uj
	 wO3ah7U7UAtbYT4VJtSjag79x/8bXVOnw7lSqvG9vepNu7X0ShWAYTKpJeJQqdzcnc
	 8c4m2TAy6OKQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id F0D424035D; Wed, 25 Oct 2023 15:12:48 -0300 (-03)
Date: Wed, 25 Oct 2023 15:12:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii.nakryiko@gmail.com, jolsa@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v4 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
Message-ID: <ZTlaoGDkALO2h95p@kernel.org>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
 <ZTlTpYYVoYL0fls7@kernel.org>
 <ZTlVAtFw7oKaFrvl@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlVAtFw7oKaFrvl@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 25, 2023 at 02:48:50PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Oct 25, 2023 at 02:43:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> > But 'bpftool bpf' doesn't like it:
>  
> >   $ bpftool btf dump file vmlinux.v5.19.0-rc5+.enum64 raw
> >   Error: failed to load BTF from vmlinux.v5.19.0-rc5+.enum64: Invalid argument
> >   $
>  
> > But it doesn't like it even when not using --btf_features :-\
> > 
> >   $ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.default_btf_encode ; pahole --btf_encode vmlinux.v5.19.0-rc5+.default_btf_encode
> >   $ bpftool btf dump file vmlinux.v5.19.0-rc5+.default_btf_encode raw | wc -l
> >   Error: failed to load BTF from vmlinux.v5.19.0-rc5+.default_btf_encode: Invalid argument
> >   0
> >   $ 
>  
> > I'll try to root cause this problem...
> 
> Random old bpftool on this notebook was the cause, nevermind, I'm back
> testing this, sorry for the noise :-)

Now things look better:

$ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.default_btf_encode ; pahole --btf_encode vmlinux.v5.19.0-rc5+.default_btf_encode
$ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.enum64 ; pahole --btf_encode --btf_features=enum64 vmlinux.v5.19.0-rc5+.enum64
$ bpftool btf dump file vmlinux.v5.19.0-rc5+.enum64 format raw > vmlinux.v5.19.0-rc5+.dump.enum64
$ bpftool btf dump file vmlinux.v5.19.0-rc5+.default_btf_encode format raw > vmlinux.v5.19.0-rc5+.dump.original.default_btf_encode
$ grep '^\[' vmlinux.v5.19.0-rc5+.dump.enum64 | cut -d ' ' -f 2 | sort | uniq -c | sort -k2 > enum64
$ grep '^\[' vmlinux.v5.19.0-rc5+.dump.original.default_btf_encode | cut -d ' ' -f 2 | sort | uniq -c | sort -k2 > original.default_btf_encode
$
$ diff -u original.default_btf_encode enum64
--- original.default_btf_encode	2023-10-25 14:56:45.027645981 -0300
+++ enum64	2023-10-25 14:54:15.024317995 -0300
@@ -1,6 +1,5 @@
    3677 ARRAY
    3362 CONST
-      1 DATASEC
    2109 ENUM
      11 ENUM64
   54147 FUNC
@@ -12,5 +11,4 @@
   10788 STRUCT
    2394 TYPEDEF
    1806 UNION
-    386 VAR
      23 VOLATILE
$

Now with just "var"

$ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.var ; pahole --btf_encode --btf_features=var vmlinux.v5.19.0-rc5+.var
$ bpftool btf dump file vmlinux.v5.19.0-rc5+.var format raw > vmlinux.v5.19.0-rc5+.dump.var
$ grep '^\[' vmlinux.v5.19.0-rc5+.dump.var | cut -d ' ' -f 2 | sort | uniq -c | sort -k2 > var
$ diff -u original.default_btf_encode var
--- original.default_btf_encode	2023-10-25 14:56:45.027645981 -0300
+++ var	2023-10-25 15:04:24.231228667 -0300
@@ -1,8 +1,7 @@
    3677 ARRAY
    3362 CONST
       1 DATASEC
-   2109 ENUM
-     11 ENUM64
+   2120 ENUM
   54147 FUNC
   29055 FUNC_PROTO
     111 FWD
$

vars/datasecs are not removed and enum64 is not encoded, remaining as
enum, so adding the 11 enum64 to the 2109 enums to get 2120 enums.

$ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.float ; pahole --btf_encode --btf_features=float vmlinux.v5.19.0-rc5+.float
$ bpftool btf dump file vmlinux.v5.19.0-rc5+.float format raw > vmlinux.v5.19.0-rc5+.dump.float
$ grep '^\[' vmlinux.v5.19.0-rc5+.dump.float | cut -d ' ' -f 2 | sort | uniq -c | sort -k2 > float
$ diff -u original.default_btf_encode float
--- original.default_btf_encode	2023-10-25 14:56:45.027645981 -0300
+++ float	2023-10-25 15:06:57.441315272 -0300
@@ -1,16 +1,14 @@
    3677 ARRAY
    3362 CONST
-      1 DATASEC
-   2109 ENUM
-     11 ENUM64
+   2120 ENUM
+      2 FLOAT
   54147 FUNC
   29055 FUNC_PROTO
     111 FWD
-     17 INT
+     15 INT
   15345 PTR
       4 RESTRICT
   10788 STRUCT
    2394 TYPEDEF
    1806 UNION
-    386 VAR
      23 VOLATILE
$

vars/datasecs are gone, enums combined, and floats are produced out of ints.

I'll try to script all this so that we we can have it in btfdiff or
another script to compare BTF from two files and then use in another
script to check that the differences are the ones expected for the
combinations of btf_features.

But I guess the acks/reviews + my tests are enough to merge this as-is,
thanks for your work on this!

- Arnaldo

