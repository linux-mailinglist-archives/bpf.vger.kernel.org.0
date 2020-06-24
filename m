Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98C3207A2E
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405444AbgFXRXx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 13:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405318AbgFXRXx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 13:23:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83052078D;
        Wed, 24 Jun 2020 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593019433;
        bh=miVQth6ABM24hU+hhLIcj8DIJS2NZK9J6PN4sLx3d5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0UtHl7xpO5+H9Bza1SBwpN5hUENsJBWNKz27FCpXBObRJ3o+wCMhbkB0CLDnhZ78
         GGBq/xheEbQiB03YvlD16PAgZpOZlEN0UpOD4vExzkY/yLZKbzKU3QX8hfIuSXlLPa
         HPpMdflauza7R7KcfogG9T4/ldeYh2gNOR+V6Ptw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 097D5405FF; Wed, 24 Jun 2020 14:23:50 -0300 (-03)
Date:   Wed, 24 Jun 2020 14:23:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
Message-ID: <20200624172350.GB20203@kernel.org>
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <20200624160659.GA20203@kernel.org>
 <CACAyw9-zLLDJ4vXo7jGS_XoYsiiv4c5NmUCjCnAf0eZBXU3dVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw9-zLLDJ4vXo7jGS_XoYsiiv4c5NmUCjCnAf0eZBXU3dVA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 24, 2020 at 05:22:59PM +0100, Lorenz Bauer escreveu:
> On Wed, 24 Jun 2020 at 17:07, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Wed, Jun 24, 2020 at 12:05:50PM +0100, Lorenz Bauer escreveu:
> > > Hi,
> > >
> > > If pahole -J is used on an ELF that has BTF info from clang, it
> > > produces an invalid
> > > output. This is because pahole rewrites the .BTF section (which
> > > includes a new string
> > > table) but it doesn't touch .BTF.ext at all.
> >
> > > To demonstrate, on a recent check out of bpf-next:
> > >     $ cp connect4_prog.o connect4_pahole.o
> > >     $ pahole -J connect4_pahole.o
> > >     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> > > --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
> > >     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> > > .BTF.ext=btf-ext.bin connect4_prog.o
> > >     $ sha1sum *.bin
> > >     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
> > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
> > >     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
> > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> > >
> > > This problem crops up when compiling old kernels like 4.19 which have
> > > an extra pahole
> > > build step with clang-10.

> > > I think a possible fix is to strip .BTF.ext if .BTF is rewritten.
> >
> > Agreed.

> > Longer term pahole needs to generate the .BTF.ext from DWARF, but then,
> > if clang is generating it already, why use pahole -J?
 
> Beats me, but then sometimes you don't have control over the workflow, see
> my v4.19 kernel example.
 
> > Does clang do deduplication for multi-object binaries?

> > Also its nice to see that the BTF generated ends up with the same
> > sha1sum, cool :-)
 
> Unfortunately it's the .BTF.ext section that has the same sha1, because
> pahole doesn't touch it ;(

My bad... I guess I saw what I wanted to see... ;-\

- Arnaldo
