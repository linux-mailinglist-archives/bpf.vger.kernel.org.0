Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB32318B7A
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 14:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhBKNEg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 08:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhBKNCW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 08:02:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7399A64E8A;
        Thu, 11 Feb 2021 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613048471;
        bh=zS4avv2o1APlIXmAq0+u1+rFzMMY8p1oVsIzafSjaY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OV3MXdXHDQQhlnxRu9TUGwa3ZICviaa6YQ1SuXl6y5sa0R+buELx254q5rqFBPocZ
         Q7SybenYQ/AX4Okt7UJJ4/G66YyZZ+LdpDQfJFNUpW1+OTW/tDdigDWizQs1kJR8UL
         ecv3VFABzKlGidLPTdPyWfnH02nsfXI7wxxTliglst3nC0pvFjE1CTzh93l/zm+zdw
         cMTMQ6ig1p38GdVrRGzCJmCglkEP19g0unAnl/1Bnh+liKexSbxkp3rfSzDSQOX4Lw
         h++9QGjCK5lH80auO4yIsp5q5JrTw22O629ZORdGd4DWW2XkPN5MJAO8UCOo1uH2fX
         kHu5jAnq0N/Jw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 316B340513; Thu, 11 Feb 2021 10:01:09 -0300 (-03)
Date:   Thu, 11 Feb 2021 10:01:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Bill Wendling <morbo@google.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] dwarf_loader: use a better hashing function
Message-ID: <20210211130109.GD1131885@kernel.org>
References: <20210210232327.1965876-1-morbo@google.com>
 <CAEf4BzYrWe4N28JjM6na=sNvq5214zs5yHra_fCuE1KA24KQ0A@mail.gmail.com>
 <CAGG=3QW0zuXUcpkcZqnaZS77EABEshhPtUCTr71dDDMuL1oMZQ@mail.gmail.com>
 <CAEf4Bzap_SYhtQdLF8bMwVeag=8CGqpcnRFb=MtZX7CB7FwSYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzap_SYhtQdLF8bMwVeag=8CGqpcnRFb=MtZX7CB7FwSYQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 10, 2021 at 05:31:48PM -0800, Andrii Nakryiko escreveu:
> On Wed, Feb 10, 2021 at 5:24 PM Bill Wendling <morbo@google.com> wrote:
> > On Wed, Feb 10, 2021 at 4:00 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > On Wed, Feb 10, 2021 at 3:25 PM Bill Wendling <morbo@google.com> wrote:
> > > > This hashing function[1] produces better hash table bucket
> > > > distributions. The original hashing function always produced zeros in
> > > > the three least significant bits.

> > > > The new hashing funciton gives a modest performance boost.

> > > >       Original      New
> > > >        0:11.41       0:11.38
> > > >        0:11.36       0:11.34
> > > >        0:11.35       0:11.26
> > > >       -----------------------
> > > >   Avg: 0:11.373      0:11.327

> > > > for a performance improvement of 0.4%.

> > > > [1] From Numerical Recipes, 3rd Ed. 7.1.4 Random Hashes and Random Bytes

> > > Can you please also test with the one libbpf uses internally:

> > > return (val * 11400714819323198485llu) >> (64 - bits);

> > > ?

> > It's giving me a running time of ~11.11s, which is even better. Would
> > you like me to submit a patch?

> faster is better, so yeah, why not? :)

Yeah, I agree, faster is better, please make it so :-)

- Arnaldo
