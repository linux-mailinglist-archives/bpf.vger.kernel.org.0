Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31EC372D8C
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhEDQHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 12:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhEDQHZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 12:07:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB4E2611AC;
        Tue,  4 May 2021 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620144389;
        bh=0w+6C5wwK3LnQowLff2lTzTaIJ5/k8OLw4g4htaeX20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0/l0e3XVcgVaTjJYnSzIw9otGJky9YANGvZYfeyo4Bsbopca3CvjATNoPKOqI7reb
         5CjiLNeiBiu7PtaIxNEZrumzFSFsiINN43Zc8ouzykUjVs8P4K1vYaB7qu5TXByOeT
         WaUp4HAAIQDPQbk7XjqXoVkmTcBSPDEhgO59QTVY=
Date:   Tue, 4 May 2021 18:06:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Zack Weinberg <zackw@panix.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
Message-ID: <YJFxArfp8wN3ILJb@kroah.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com>
 <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com>
 <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 04, 2021 at 05:53:29PM +0200, Alejandro Colomar (man-pages) wrote:
> Hi Greg and Alexei,
> 
> > On Tue, May 04, 2021 at 07:12:01AM -0700, Alexei Starovoitov wrote:
> > > For the same reasons as explained earlier:
> > > Nacked-by: Alexei Starovoitov <ast@kernel.org>
> 
> Okay, I'll add that.
> 
> 
> On 5/4/21 4:24 PM, Greg KH wrote:> I agree, the two are not the same type at
> all, this change should not be
> > accepted.
> 
> I get that in the kernel you don't use the standard fixed-width types (with
> some exceptions), probably not to mess with code that relies on <stdint.h>
> not being included (I hope there's not much code that relies on this in
> 2021, but who knows).
> 
> But, there is zero difference between these types, from the point of view of
> the compiler.  There's 100% compatibility between those types, and you're
> able to mix'n'match them.  See some example below.
> 
> Could you please explain why the documentation, which supposedly only
> documents the API and not the internal implementation, should not use
> standard naming conventions?  The standard is much easier to read for
> userspace programmers, which might ignore why the kernel does some things in
> some specific ways.
> 
> BTW, just to clarify, bpf.2 is just a small sample to get reviews; the
> original intention was to replace __uNN by uintNN_t in all of the manual
> pages.

There's a very old post from Linus where he describes the difference
between things like __u32 and uint32_t.  They are not the same, they
live in different namespaces, and worlds, and can not always be swapped
out for each other on all arches.

Dig it up if you are curious, but for user/kernel apis you HAVE to use
the __uNN and can not use uintNN_t variants, so don't try to mix/match
them, it's good to just follow the kernel standard please.

So consider this my:

Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

as well.

thanks,

greg k-h
