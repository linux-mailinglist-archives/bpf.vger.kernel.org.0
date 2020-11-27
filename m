Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E874B2C6CA1
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 21:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbgK0UkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 15:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgK0UjP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 15:39:15 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFED821D7F;
        Fri, 27 Nov 2020 20:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606509554;
        bh=9umCh7sd7cWMjj78c48xEUF3JxYar/FTlkO7bug0Vag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5UlVBkbnJeIVVntMGGGVFwa7iS04Jbkp+VYmQ2H4S4FrvMeXFEuojwdCeKxUzX5V
         Nk/m3+LmY5Caxa9LOg9kTvOSXrGLEKm/5exFbhqBb+9n6M/2C5YqW9mtNedVPf4NsJ
         RtIvOSA8NICp7SSF4EVD+SpnQQpm8gvEPQ4ZUvcs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A64A34079D; Fri, 27 Nov 2020 17:39:12 -0300 (-03)
Date:   Fri, 27 Nov 2020 17:39:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/2] btf_encoder: Detect kernel module ftrace addresses
Message-ID: <20201127203912.GQ70905@kernel.org>
References: <20201124161919.2152187-1-jolsa@kernel.org>
 <20201124161919.2152187-3-jolsa@kernel.org>
 <CAEf4BzbbpLkJth5HYh=a6V1+uPAcPpUTsi=JHQrOeHF5f2xALg@mail.gmail.com>
 <20201127174037.GB2767982@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127174037.GB2767982@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Nov 27, 2020 at 06:40:37PM +0100, Jiri Olsa escreveu:
> On Thu, Nov 26, 2020 at 08:18:58PM -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 24, 2020 at 8:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Add support to detect kernel module dtrace addresses and use
> > > it as filter for functions.
> > 
> > typo: dtrace -> ftrace?
> 
> heh, honest typo I swear ;-)

f comes after d ;-)

> SNIP
> > > +       /* get __mcount_loc */
> > > +       sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr_mcount,
> > > +                                 "__mcount_loc", NULL);
> > > +       if (!sec) {
> > > +               if (btf_elf__verbose) {
> > > +                       printf("%s: '%s' doesn't have __mcount_loc section\n", __func__,
> > > +                              btfe->filename);
> > > +               }

> > nit: unnecessary {} for single-statement if
 
> ah ok, I put it because kernel guys scream with multiline
> conditions without {}

You can keep it like that, or get free from 80 column constraints and
make it:

	if (btf_elf__verbose)
		printf("%s: '%s' doesn't have __mcount_loc section\n", __func__, btfe->filename);
 
- Arnaldo
