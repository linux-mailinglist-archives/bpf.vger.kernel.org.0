Return-Path: <bpf+bounces-26849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344018A5923
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8B01F22961
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81083A1D;
	Mon, 15 Apr 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgk5Tb8j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414211E87C;
	Mon, 15 Apr 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202383; cv=none; b=RosBIj0q146YWKucnpeAIEelKOt7qShZlTLetzFA6iSH9dfyw71f/JATXIDy+PxzRYOXGoAZ92pgZNKSN+4yXoSxdAmGNhpGv1LxbvtIEPnmTOADB9akedxVhdn5sPXgb3NZ8LvDqffTJiCK9aU8/PISlc942H05IXgZwcusRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202383; c=relaxed/simple;
	bh=xBu1qnr/1Vp4oD2YC13jV4bIWy8ruL6tad1zpwJtvFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJn1qVuITgm3v60i6u/X+xy3ksszfnMtodCHp6q9YdbyyGmTThIVWYcsAMAaLaHhgFBNQxjD6WvO/e2RyQ8yidBbaHcw61ya12ZbylWXLB/4pu/hFGuw2eM7F/CeDCCj3NOEocVnShXdZhdLmd5tY1J61PPhA7CL+XJjkp4AvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgk5Tb8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906D5C113CC;
	Mon, 15 Apr 2024 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713202383;
	bh=xBu1qnr/1Vp4oD2YC13jV4bIWy8ruL6tad1zpwJtvFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dgk5Tb8jwPbPuOZQ/puwwZ4cal6/naYzjc7PZHpPZRfzMymJetJFvzZQQOfLlf8ly
	 wiH4StRLu6QIHdN1bsJh0eD9/IWeVfdjfwYjUBbjilgYJuZ+W/fCX/7WBub5NuhZ7M
	 N9TFW9IEjmd2r8GwTA1bzmIPJB7OGCPRUleLKp34Q8XgUdzfVs3qXgyI5QEpbZtu5N
	 fGDgET5/v/uHX8etcfZTW1PSWDS1Hg5JYvqzIpjG/4YCNtyfDvKinhftli70EtFeqi
	 21irHnk3YVsRxvM4gA3eriUF6jPFh7G8DhMZiPSaSGayGYam5jqeBuIme/QhKaNNFe
	 4XF9vvI3QWakw==
Date: Mon, 15 Apr 2024 14:33:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 12/12] tests: Add a BTF reproducible generation test
Message-ID: <Zh1kzIf4C4Z8bOsb@x1>
References: <20240412211604.789632-1-acme@kernel.org>
 <20240412211604.789632-13-acme@kernel.org>
 <3817fa6d-122f-4cbc-92be-616355ec04c2@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3817fa6d-122f-4cbc-92be-616355ec04c2@oracle.com>

On Mon, Apr 15, 2024 at 11:26:44AM +0100, Alan Maguire wrote:
> On 12/04/2024 22:16, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> >   $ time tests/reproducible_build.sh vmlinux
> >   Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> > 
> >   real  1m13.844s
> >   user  3m3.601s
> >   sys   0m9.049s
> >   $
> > 
> > If the number of threads started by pahole is different than what was
> > requests via its -j command line option, it will fail as well as if the
> > output of 'bpftool btf dump' differs from the BTF encoded totally
> > serially to one of the detached BTF encoded using reproducible DWARF
> > loading/BTF encoding.
> > 
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Kui-Feng Lee <kuifeng@fb.com>
> > Cc: Thomas Weißschuh <linux@weissschuh.net>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tests/reproducible_build.sh | 56 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100755 tests/reproducible_build.sh
> > 
> 
> great to have a test for this! a few small things below but
> for the series
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 
> > diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
> > new file mode 100755
> > index 0000000000000000..9c72d548c2a21136
> > --- /dev/null
> > +++ b/tests/reproducible_build.sh
> > @@ -0,0 +1,56 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
> > +# Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
> > +
> > +vmlinux=$1
> 
> nit: might be worth having a usage check/error for the vmlinux binary here.
> 
> > +outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
> > +
> > +echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
> > +
> > +test -n "$VERBOSE" && printf "\nserial encoding...\n"
> > +
> > +pahole --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux
> 
> suggestion here; what about adding --btf_features=all as this would mean
> we'd be encoding all the standard kernel features? we'd need to do the
> same below in the thread loop. without that we're missing out on a few
> features that the kernel builds use in BTF encoding, and we probably
> want to ensure that we're testing as close to a real kernel BTF encoding
> scenario as possible.

⬢[acme@toolbox pahole]$ time tests/reproducible_build.sh vmlinux
Parallel reproducible DWARF Loading/Serial BTF encoding: Ok

real	1m24.903s
user	3m8.143s
sys	0m47.329s
⬢[acme@toolbox pahole]$ 
⬢[acme@toolbox pahole]$ time VERBOSE=1 tests/reproducible_build.sh vmlinux
Parallel reproducible DWARF Loading/Serial BTF encoding: 
serial encoding...
1 threads encoding
1 threads started
diff from serial encoding:
-----------------------------
2 threads encoding
2 threads started
diff from serial encoding:
-----------------------------
3 threads encoding
3 threads started
^X^C

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index b821e28e7ce7bf8c..8cc36fe4c75e8b75 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -22,14 +22,14 @@ echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
 
 test -n "$VERBOSE" && printf "\nserial encoding...\n"
 
-pahole --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux
+pahole --btf_features=all --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux
 bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinux.btf.serial
 
 nr_proc=$(getconf _NPROCESSORS_ONLN)
 
 for threads in $(seq $nr_proc) ; do
 	test -n "$VERBOSE" && echo $threads threads encoding
-	pahole -j$threads --reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
+	pahole -j$threads --reproducible_build --btf_features=all --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
 	pahole=$!
 	# HACK: Wait a bit for pahole to start its threads
 	sleep 0.3s

