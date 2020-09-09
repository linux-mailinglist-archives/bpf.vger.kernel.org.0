Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BDA263329
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgIIQ6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730656AbgIIPvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0429C215A4;
        Wed,  9 Sep 2020 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599661673;
        bh=3QKU+0GVeB+96nroBMgZ91EUK9wdQehsjmiYIqtH7tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPNLSBCa6BNOy67iY1Xp2gyqEo18XLg11tYEJvqhQnEHVDAj2Ob/mhiQjCUALDEBX
         7nt9hBIYM2LFaEoStBq1pNgpwRcQhA3P6LKbJKi6kRlvyEHP8eZ+eqCeFezbmk1JOi
         3ZIucEJDBz3ZVwRQFMq5Z5x9eU3aiPl1ByOE/aac=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0AC6340D3D; Wed,  9 Sep 2020 11:27:51 -0300 (-03)
Date:   Wed, 9 Sep 2020 11:27:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tony Ambardar <tony.ambardar@gmail.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
Message-ID: <20200909142750.GC3788224@kernel.org>
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Sep 09, 2020 at 11:02:24AM +0200, Ilya Leoshkevich escreveu:
> On Tue, 2020-09-08 at 13:18 -0700, Andrii Nakryiko wrote:
> > On Mon, Sep 7, 2020 at 9:02 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > > On Sat, 2020-09-05 at 21:16 -0700, Tony Ambardar wrote:

> > > > I'm using GCC 8.4.0, binutils 2.34 and pahole 1.17, compiling on
> > > > an Ubuntu/x86_64 host and targeting both little- and big-endian
> > > > mips running on malta/qemu. When cross-compiling Linux 5.4.x LTS
> > > > and testing bpftool/BTF functionality on the target, I encounter
> > > > errors on big-endian targets:

> > > > > root@OpenWrt:/# bpftool btf dump file /sys/kernel/btf/vmlinux
> > > > > libbpf: failed to get EHDR from /sys/kernel/btf/vmlinux Error:
> > > > > failed to load BTF from /sys/kernel/btf/vmlinux: No error
> > > > > information
>
> > > > After investigating, the problem appears to be that "pahole -J"
> > > > running on the x86_64 little-endian host will always generate
> > > > raw BTF of native endianness (based on BTF magic), which causes
> > > > the error above on big-endian targets.

> > > > Is this expected? Is DEBUG_INFO_BTF supported in general when
> > > > cross-compiling? How does one generate BTF encoded for the
> > > > target endianness with pahole?

The BTF loader has support for endianness, its just the encoder that
doesn't :-\

I.e. pahole can grok a big endian BTF payload on a little endian machine
and vice-versa, just can't cross-build BTF payloads ATM.

> > Yes, it's expected, unfortunately. Right now cross-compiling to a
> > different endianness isn't supported. You can cross-compile only if
> > target endianness matches host endianness.

I agree that having this in libbpf is better, it should be done as part
of producing the result of the deduplication phase.

> > > > Thanks for any feedback or suggestions,
> > > > Tony
> > > 
> > > We have the same problem on s390, and I'm not aware of any solution
> > > at
> > > the moment. It would be great if we could figure out how to resolve
> > > this.
> > 
> > I'm working on extending BTF APIs in libbpf at the moment. Switching
> > endianness would be rather easy once all that is done. With these new
> > APIs it will be possible to switch pahole to use libbpf APIs to
> > produce BTF output and support arbitrary endianness as well. Right
> > now, I'd rather avoid implementing this in pahole, libbpf is a much
> > better place for this (and will require ongoing updates if/when we
> > introduce new types and fields to BTF).

Right, we could do it right after btf_dedup() and before
btf_elf__write(), doing the same process as in btf_loader.c, i.e.
checking if the ELF target arch is different in endianness and doing the
reverse of the loader.

> > Hope this plan works for you guys.
> 
> That sounds really good to me, thanks!

- Arnaldo
