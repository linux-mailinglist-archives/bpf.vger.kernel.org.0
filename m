Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2274F319E7B
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 13:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBLMf7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 07:35:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhBLMf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 07:35:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC0F064DEE;
        Fri, 12 Feb 2021 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613133317;
        bh=PkjiyYDEIIEaUPRoldQ+83sx6Bw5EEIkOQmAxX8EC/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+gSkRdGAno6NoXhrmR/WYXEytwYlMJOGyoTRDR7QkwqlQJKolM9BEDpggi3QkyC3
         UkGiWMx2z7bdRiD2egr6tEnC0DqVsjgE/ptqAGu4ZAYWyVSyccC1kjSb1KKSbLDTeB
         BAiqBV0TRKzKJTVOv4uM8aEVIsuSg3LNZs8z+l2vtO7UalxJd7EX8340s1gPi0942T
         2Ix/99ZfF329/DGmT6ynH06mnwMdEW6aZz6ZbROSXK4jBNtw8sbLgePXsyck+2Feza
         56/oxdfkaNbZ8YGnu+f0uhAe7G/NeyidzQ1ID6/1USQo+NajlypAR8r7TJaStVSADG
         YMYr5DhitbIdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E99F040513; Fri, 12 Feb 2021 09:35:14 -0300 (-03)
Date:   Fri, 12 Feb 2021 09:35:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] dwarf_loader: use a better hashing function
Message-ID: <20210212123514.GD1398414@kernel.org>
References: <20210210232327.1965876-1-morbo@google.com>
 <CAEf4BzYrWe4N28JjM6na=sNvq5214zs5yHra_fCuE1KA24KQ0A@mail.gmail.com>
 <CAGG=3QW0zuXUcpkcZqnaZS77EABEshhPtUCTr71dDDMuL1oMZQ@mail.gmail.com>
 <CAEf4Bzap_SYhtQdLF8bMwVeag=8CGqpcnRFb=MtZX7CB7FwSYQ@mail.gmail.com>
 <20210211130109.GD1131885@kernel.org>
 <CAGG=3QWADRX158cM-wMWG4Gf4NxN+bpJTnRNwesV5JPnL9-PWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QWADRX158cM-wMWG4Gf4NxN+bpJTnRNwesV5JPnL9-PWw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 11, 2021 at 10:55:32PM -0800, Bill Wendling escreveu:
> On Thu, Feb 11, 2021 at 5:01 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Feb 10, 2021 at 05:31:48PM -0800, Andrii Nakryiko escreveu:
> > > On Wed, Feb 10, 2021 at 5:24 PM Bill Wendling <morbo@google.com> wrote:
> > > > On Wed, Feb 10, 2021 at 4:00 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > > On Wed, Feb 10, 2021 at 3:25 PM Bill Wendling <morbo@google.com> wrote:
> > > > > > This hashing function[1] produces better hash table bucket
> > > > > > distributions. The original hashing function always produced zeros in
> > > > > > the three least significant bits.
> >
> > > > > > The new hashing funciton gives a modest performance boost.
> >
> > > > > >       Original      New
> > > > > >        0:11.41       0:11.38
> > > > > >        0:11.36       0:11.34
> > > > > >        0:11.35       0:11.26
> > > > > >       -----------------------
> > > > > >   Avg: 0:11.373      0:11.327
> >
> > > > > > for a performance improvement of 0.4%.
> >
> > > > > > [1] From Numerical Recipes, 3rd Ed. 7.1.4 Random Hashes and Random Bytes
> >
> > > > > Can you please also test with the one libbpf uses internally:
> >
> > > > > return (val * 11400714819323198485llu) >> (64 - bits);
> >
> > > > > ?
> >
> > > > It's giving me a running time of ~11.11s, which is even better. Would
> > > > you like me to submit a patch?
> >
> > > faster is better, so yeah, why not? :)
> >
> > Yeah, I agree, faster is better, please make it so :-)
> >
> Your wish is my command! :-) Done.

Thanks, looking for the patch and applying!

No go think about something else to make it faster 8-)

- Arnaldo
