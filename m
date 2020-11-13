Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52332B1AAB
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 13:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKMMEk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 07:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgKMLf5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 06:35:57 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2E1207DE;
        Fri, 13 Nov 2020 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605267330;
        bh=qbcCBjPXIhbPByN1i3m7Q/cLYiJmaAEjthHF0I0KQcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBTUhCxWyLBkiF7hEGArxYx6PfcZGyNau2LTUy91Q8vLgWJymFyC6XnyIcDPym5bM
         jy2CwX63z9XF88Iaq6YmxDEVz+xCTM3wtHYhrnJ6Vyr4Iw9e2Pq26gBZQrbUTGs9Do
         BMg/S0Lv1/HyRqIGAgH8UJ3iT9nwrgiZmC26IeY8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 40A99411D1; Fri, 13 Nov 2020 08:35:28 -0300 (-03)
Date:   Fri, 13 Nov 2020 08:35:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH dwarves 4/4] btf: add support for split BTF loading and
 encoding
Message-ID: <20201113113528.GA394182@kernel.org>
References: <20201106052549.3782099-1-andrii@kernel.org>
 <20201106052549.3782099-5-andrii@kernel.org>
 <20201111115627.GB355344@kernel.org>
 <20201111121946.GD355344@kernel.org>
 <CAEf4BzajM3Pg13uTF7cKOWfASvhOPOx85ufcchuDcGLEq8d9fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzajM3Pg13uTF7cKOWfASvhOPOx85ufcchuDcGLEq8d9fQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 11, 2020 at 10:29:32AM -0800, Andrii Nakryiko escreveu:
> On Wed, Nov 11, 2020 at 4:19 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Nov 11, 2020 at 08:56:27AM -0300, Arnaldo Carvalho de Melo escreveu:
> > >
> > > The entry for btf_encode/-J is missing, I'll add in a followup patch.
> > >
> > > Also I had to fixup ARGP_btf_base to 321 as I added this, to simplify
> > > the kernel scripts and Makefiles:
> > >
> > >   $ pahole --numeric_version
> > >   118
> > >   $
> >
> > Added this:
> >
> > [acme@five pahole]$ git diff
> > diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> > index 20ee91fc911d4b39..f44c649924383a32 100644
> > --- a/man-pages/pahole.1
> > +++ b/man-pages/pahole.1
> > @@ -181,6 +181,14 @@ the debugging information.
> >  .B \-\-skip_encoding_btf_vars
> >  Do not encode VARs in BTF.
> >
> > +.TP
> > +.B \-J, \-\-btf_encode
> > +Encode BTF information from DWARF, used in the Linux kernel build process when
> > +CONFIG_DEBUG_INFO_BTF=y is present, introduced in Linux v5.2. Used to implement
> > +features such as BPF CO-RE (Compile Once - Run Everywhere).
> > +
> > +See \fIhttp://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf\fR.
> 
> Can you please point to [0] instead? That linked presentation is
> already a bit out of date and will bitrot much faster. Blog post has
> at least a chance at being updated with relevant important stuff. Plus
> it has links both to the bpfconf2019 presentation, as well as some
> other resources (including your presentation).
> 
>   [0] https://nakryiko.com/posts/bpf-portability-and-co-re/

Done, thanks for the pinter.

- Arnaldo
