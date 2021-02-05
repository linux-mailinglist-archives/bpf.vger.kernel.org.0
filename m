Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13374311980
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 04:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhBFDIZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 22:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231778AbhBFDB4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 22:01:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7AFB65004;
        Fri,  5 Feb 2021 23:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612569341;
        bh=0P6pwFokTlete3UUYGQyoT3xzrdD6XTV5ru+9jGjN3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3y2028x8xKqEclrmbsTWWda+aJdHPDUP82f3zzKDI7+6S3rfs0+hLmoX4N5b/7iF
         jOmpN7+DnyULwSXFxwSqHd9XVVZIpsp7qHFdBM4N3zCXLOr7iv2YcMwgxZy4Cc/Djp
         jr+5xhjGFbOEjAd0xg1ibnBB01f/IPwgGWX8ENRpkF7JPIDOaNL3pZSdBMq6NS0CFI
         0fm3MBb+vGRRZPczB0W4Ew79ygTa6h/gXv5eFG2GlxVp9S8ikgPT8iORVWbsJcnANJ
         o1Vs2kzFi/3khxnelX3m26kkxeM1qvYNqG2uJUQMHPP72vYr7IF2rMN3E9J/Rw1JL/
         poUuG986Dg2Ow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE07240513; Fri,  5 Feb 2021 20:55:37 -0300 (-03)
Date:   Fri, 5 Feb 2021 20:55:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
Message-ID: <20210205235537.GE106434@kernel.org>
References: <20210204220741.GA920417@kernel.org>
 <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com>
 <C359F19F-29BC-4F6D-961A-79BFA47F36A7@gmail.com>
 <CAEf4BzZf_1g13dA1t6rbi1TFttufyGNaU14pPxo9uK-FVArCbQ@mail.gmail.com>
 <BFDC3C1D-F87D-4F82-BDB0-444629C484CE@gmail.com>
 <20210205162523.GF920417@kernel.org>
 <CAEf4BzaXAxOnzkuiOpdMKjQyYHjAN6Td35hDGwbYc9i9aGuj0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaXAxOnzkuiOpdMKjQyYHjAN6Td35hDGwbYc9i9aGuj0A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 05, 2021 at 02:11:44PM -0800, Andrii Nakryiko escreveu:
> On Fri, Feb 5, 2021 at 8:25 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Fri, Feb 05, 2021 at 06:33:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > On February 5, 2021 4:39:47 AM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > >On Thu, Feb 4, 2021 at 8:34 PM Arnaldo Carvalho de Melo ><arnaldo.melo@gmail.com> wrote:
> > > >> On February 4, 2021 9:01:51 PM GMT-03:00, Andrii Nakryiko
> > > ><andrii.nakryiko@gmail.com> wrote:
> > > >> >On Thu, Feb 4, 2021 at 2:09 PM Arnaldo Carvalho de
> > > >Melo><acme@kernel.org> wrote:
> > > >> >>         The v1.20 release of pahole and its friends is out, mostly
> > > >> >> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> > > >> >> available at the usual places:
> >
> > > >> >Great, thanks, Arnaldo! Do you plan to build RPMs soon as well?
> >
> > > >> It's in rawhide already, I'll do it for f33, f32 later,
> >
> > > >Do you have a link? I tried to find it, but only see 1.19 so far.
> >
> > > https://koji.fedoraproject.org/koji/buildinfo?buildID=1703678
> >
> > And now for Fedora 33, waiting for karma bumps at:
> >
> > https://bodhi.fedoraproject.org/updates/FEDORA-2021-804e7a572c
> >
> > fedpkg buidling for f32 now.
 
> Ok, imported dwarves-1.20. Had to fix two dates in changelog (in
> spec), day of week didn't match the date, tooling complained about
> that. Also had to undo cmake_build and cmake_install fanciness,
> because apparently we don't have them or the support for it is not
> great. But otherwise everything else looks to be ok.

Send patch please, I wasn't expecting this, if you could do some more
and send me tooling bits to help me in the release process, if that is
possible, I'd love to get it, otherwise I'll write it, don't want to go
thru this one more time, sigh :-(


- Arnaldo
