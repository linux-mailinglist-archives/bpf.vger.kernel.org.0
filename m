Return-Path: <bpf+bounces-26848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 577EC8A5916
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC68B20EF6
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E84839E5;
	Mon, 15 Apr 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsKrcUQc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF68811EB;
	Mon, 15 Apr 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201990; cv=none; b=PpRXSktmuUwL9Q+wPzC3MN7SV+HlcDQN6QCmEIm3nEfU0wY9xtY0t9igjg2RiPLqQgCmyTovmwebc6QHFT+gcVvIpkzH3UGtcanhINuxeQg5xmHMgN5HJLP7zDn0/10/Nl8XinzHyAZFveXFOiFo3z0qEfne71G8r1aBSE2YwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201990; c=relaxed/simple;
	bh=e3LUBSmQZQUFCOfS0arhOZflBaVH3oMdq/D1XyzmOvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2SgwIfIjkikeeTmWZA6PkSeHje6uAOOohixJTvdKHvBhfwwCjR24EqQg+l58IXpxLDN30050o4JfyoH6lze4ij7GuunnSRx3pvEJMbWLYhu/znya4mkFEpn5G4b2xxniiDf3Njzz5bEjiSTqIMLel3C/A3Mq29HlIydIVakbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsKrcUQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6880C113CC;
	Mon, 15 Apr 2024 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713201989;
	bh=e3LUBSmQZQUFCOfS0arhOZflBaVH3oMdq/D1XyzmOvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsKrcUQcxPWtOypFfZQiLydX3m3L16McWE4MJG7VL9ZfmAKXI0LzsDNAesOJA3PqV
	 5vLyNQHa/xcAajv9VFu9ncbOwU1PD1dyr6RAbyEmWcEP8PToEQXBCgd7KRfCPfvTVc
	 Xe6Fv0IlZYv6ThHYARMvTEXSh+xkrZkV++0oFnjeFS0Z8evIOlnBMwdkDcDM0fAUey
	 PHuzFfmUjsf57glWTR0m3f7p0WhHhQskHOFwwjlN5rS5VsBe3/2gkgPUx+BRM3ZMn+
	 Q/8+v5koutcoUcDWOooE2TKgvV3fJa0Qg2lUo4VHLGzhzGYUfGvz+HlpzwWa2SBg9V
	 nZiVcPp4gyEdg==
Date: Mon, 15 Apr 2024 14:26:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 12/12] tests: Add a BTF reproducible generation test
Message-ID: <Zh1jQc-0edRk4y99@x1>
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

Right, I'm doing that now.

Suggested-by: Alan Maguire <alan.maguire@oracle.com>

⬢[acme@toolbox pahole]$ tests/reproducible_build.sh 
Please specify a vmlinux file to operate on
⬢[acme@toolbox pahole]$ tests/reproducible_build.sh vmlinux1
vmlinux1 file not available, please specify another
⬢[acme@toolbox pahole]$ tests/reproducible_build.sh vmlinux
Parallel reproducible DWARF Loading/Serial BTF encoding: ^C
⬢[acme@toolbox pahole]$

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index 9c72d548c2a21136..b821e28e7ce7bf8c 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -5,6 +5,17 @@
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
 vmlinux=$1
+
+if [ -z "$vmlinux" ] ; then
+	echo "Please specify a vmlinux file to operate on"
+	exit 1
+fi
+
+if [ ! -f "$vmlinux" ] ; then
+	echo "$vmlinux file not available, please specify another"
+	exit 1
+fi
+
 outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
 
 echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "

