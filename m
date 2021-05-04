Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7967372BF6
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhEDOZ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 10:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhEDOZ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 10:25:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD51A61139;
        Tue,  4 May 2021 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620138271;
        bh=ycWmHLZjK6dBz/CdYVAAPEioACpMjp23uaaK/mz8nGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBDeDGOY6Rypqd5DRRCWrXFYPTAYIIst+QK6QDTL1xeA2S+E5erqgD0gsn6+dNkur
         P1bSlDSSUZUzKPGHcfeoPAegcg7ftfbfb4qITPdceAO+fUIqxe6bauwmOPD2B2OX/g
         pH3atu5DylpNJclmPEZUlXnsKngAxbgkUnrObGGU=
Date:   Tue, 4 May 2021 16:24:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Zack Weinberg <zackw@panix.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
Message-ID: <YJFZHW2afbAMVOmE@kroah.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com>
 <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 04, 2021 at 07:12:01AM -0700, Alexei Starovoitov wrote:
> On Tue, May 4, 2021 at 4:05 AM Alejandro Colomar <alx.manpages@gmail.com> wrote:
> >
> > Some manual pages are already using C99 syntax for integral
> > types 'uint32_t', but some aren't.  There are some using kernel
> > syntax '__u32'.  Fix those.
> >
> > Some pages also document attributes, using GNU syntax
> > '__attribute__((xxx))'.  Update those to use the shorter and more
> > portable C11 keywords such as 'alignas()' when possible, and C2x
> > syntax '[[gnu::xxx]]' elsewhere, which hasn't been standardized
> > yet, but is already implemented in GCC, and available through
> > either --std=c2x or any of the --std=gnu... options.
> >
> > The standard isn't very clear on how to use alignas() or
> > [[]]-style attributes, so the following link is useful in the case
> > of 'alignas()' and '[[gnu::aligned()]]':
> > <https://stackoverflow.com/q/67271825/6872717>
> >
> > Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> > Cc: LKML <linux-kernel@vger.kernel.org>
> > Cc: glibc <libc-alpha@sourceware.org>
> > Cc: GCC <gcc-patches@gcc.gnu.org>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: bpf <bpf@vger.kernel.org>
> > Cc: David Laight <David.Laight@ACULAB.COM>
> > Cc: Zack Weinberg <zackw@panix.com>
> > Cc: Joseph Myers <joseph@codesourcery.com>
> > ---
> >  man2/bpf.2 | 49 ++++++++++++++++++++++++-------------------------
> >  1 file changed, 24 insertions(+), 25 deletions(-)
> >
> > diff --git a/man2/bpf.2 b/man2/bpf.2
> > index 6e1ffa198..04b8fbcef 100644
> > --- a/man2/bpf.2
> > +++ b/man2/bpf.2
> > @@ -186,41 +186,40 @@ commands:
> >  .PP
> >  .in +4n
> >  .EX
> > -union bpf_attr {
> > +union [[gnu::aligned(8)]] bpf_attr {
> >      struct {    /* Used by BPF_MAP_CREATE */
> > -        __u32         map_type;
> > -        __u32         key_size;    /* size of key in bytes */
> > -        __u32         value_size;  /* size of value in bytes */
> > -        __u32         max_entries; /* maximum number of entries
> > -                                      in a map */
> > +        uint32_t    map_type;
> > +        uint32_t    key_size;    /* size of key in bytes */
> > +        uint32_t    value_size;  /* size of value in bytes */
> > +        uint32_t    max_entries; /* maximum number of entries
> > +                                    in a map */
> 
> For the same reasons as explained earlier:
> Nacked-by: Alexei Starovoitov <ast@kernel.org>

I agree, the two are not the same type at all, this change should not be
accepted.

thanks,

greg k-h
