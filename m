Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85E311290
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 21:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhBESwz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 13:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233087AbhBEPEk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 10:04:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F20B64DE9;
        Fri,  5 Feb 2021 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612542326;
        bh=wZa558YC1SAZ7XJtB8o9xQzpfnkrZ2VFUyJz20LiKZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqpHAakw7ZlUGpi0XalD4Wc7yxsm2VtJdHUpbKGx6CWCwdEnd4SH+GF77k2NesFg4
         nYNAkcRai83QCBXlZvHEVreJeTIEd7sfzbVhzMvcTsKvwOgY1fGh/esJnx/FuXgbcd
         yEBh36DB0eWpiGCzEchPp2ypEGxMHXfwiFum3u45UkttDky4D/yIPs2z2qLhcdMRVM
         Jqn1DTrrPAiIe7cwrjVKycv573tsO8L2jtfxVimDDSoso1CQV0Mh3LFK5kPW4RIfi2
         +YAjF1OdxjCCibURdFRZsgfV9BKNla+mzPHPiZAjv0ug6+2c1W6GLp86Dr9BjJSi1I
         4AOsQ0jIyyVsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 247D240513; Fri,  5 Feb 2021 13:25:23 -0300 (-03)
Date:   Fri, 5 Feb 2021 13:25:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Message-ID: <20210205162523.GF920417@kernel.org>
References: <20210204220741.GA920417@kernel.org>
 <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com>
 <C359F19F-29BC-4F6D-961A-79BFA47F36A7@gmail.com>
 <CAEf4BzZf_1g13dA1t6rbi1TFttufyGNaU14pPxo9uK-FVArCbQ@mail.gmail.com>
 <BFDC3C1D-F87D-4F82-BDB0-444629C484CE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFDC3C1D-F87D-4F82-BDB0-444629C484CE@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 05, 2021 at 06:33:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> On February 5, 2021 4:39:47 AM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >On Thu, Feb 4, 2021 at 8:34 PM Arnaldo Carvalho de Melo ><arnaldo.melo@gmail.com> wrote:
> >> On February 4, 2021 9:01:51 PM GMT-03:00, Andrii Nakryiko
> ><andrii.nakryiko@gmail.com> wrote:
> >> >On Thu, Feb 4, 2021 at 2:09 PM Arnaldo Carvalho de
> >Melo><acme@kernel.org> wrote:
> >> >>         The v1.20 release of pahole and its friends is out, mostly
> >> >> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> >> >> available at the usual places:

> >> >Great, thanks, Arnaldo! Do you plan to build RPMs soon as well?

> >> It's in rawhide already, I'll do it for f33, f32 later,

> >Do you have a link? I tried to find it, but only see 1.19 so far.
 
> https://koji.fedoraproject.org/koji/buildinfo?buildID=1703678

And now for Fedora 33, waiting for karma bumps at:

https://bodhi.fedoraproject.org/updates/FEDORA-2021-804e7a572c

fedpkg buidling for f32 now.

- Arnaldo
