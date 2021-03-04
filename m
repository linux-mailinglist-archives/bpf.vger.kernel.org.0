Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6949532D3EF
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 14:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhCDNLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 08:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241130AbhCDNLL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 08:11:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06D2260200;
        Thu,  4 Mar 2021 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614863431;
        bh=vdRb5razE0qOwmRPvftUP6xWiEU/tRx0rzw0t5jt6gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLLHlG80sA8CMrnsZ+JnkTCHlZed/sdstmhErFLOH51+tsk3QvDPJcFD7H3uNNd+b
         EhVLJdUra5J2LXfC9WROBC02XOSfkQvg36jLjGi0VYf8m4toNwIcFuTM0eNKmuxcBg
         IDUwIdx/x8f/abasRVJKPEnR+ijWsfN72K8DpgEnMLJE+VwCGmfidCOpIGn/Z8tp9j
         Wz7vFYoPhYsgF5DrXOO0tGHoKpYdEhp4od8AaMJEl4kpv+8l6Ms1p0K+mA1Ib2Hv0l
         qO70I35qIDbVdHVSIYyLX9F+B3VRhrgj93TVyEaVNAk8fcX5gW7Q/xjhEmdSkEto/0
         QOetdQ2EO3KOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 540134038F; Thu,  4 Mar 2021 10:10:28 -0300 (-03)
Date:   Thu, 4 Mar 2021 10:10:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        rafaeldtinoco@gmail.com, bpf <bpf@vger.kernel.org>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
Message-ID: <YEDcRMwRAD3Pxwhw@kernel.org>
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 03, 2021 at 11:05:44PM -0800, Andrii Nakryiko escreveu:
> On Wed, Mar 3, 2021 at 10:15 AM Rafael David Tinoco
> <rafaeldtinoco@ubuntu.com> wrote:
> >
> > > > From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
> > > > Date:   Thu, 7 Jan 2021 17:31:11 -0800
> > > > To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc:     bpf <bpf@vger.kernel.org>
> > > >
> > > >
> > > > Right. Libbpf only supports a newer and safer way to attach to
> > > > kprobes. For your experiments, try to stick to tracepoints and you'll
> > > > have a better time.
> > > >
> > > > But it's another thing I've been meaning to add to libbpf for
> > > > supporting older kernels. I even have code written to do legacy kprobe
> > > > attachment, just need to find time to send a patch to add it as a
> > > > fallback for kernels that don't support new kprobe interface.
> >
> > Initially I'd like to thank you *a lot* for this thread, it helped me
> > creating:
> >
> > https://github.com/rafaeldtinoco/portablebpf
> >
> > showing up exactly what was discussed here AND I could run the same
> > binary in v4.15 and v.5.8 kernels as long as BTF was generated with:
> >
> > https://github.com/rafaeldtinoco/portablebpf/blob/master/patches/link-vmlinux.sh.patch
> 
> I was wondering if it might be useful to have a script that would use
> pahole to do DWARF to BTF conversion for existing vmlinux image (e.g.,
> from /boot/vmlinux-$(uname -r)), assuming DWARF is in that vmlinux (or
> could be found somewhere nearby), and then would spit out only .BTF
> contents as a binary file, which can be passed to libbpf on
> bpf_object__open(). That seems useful and there have been at least a
> few cases where people tried to use CO-RE on old kernels
> pre-CONFIG_DEBUG_INFO_BTF, but were always confused by how to get that
> BTF data.
> 
> [cc Arnaldo]
> It would also simplify things a bunch if pahole had an option to emit
> .BTF into a separate non-ELF file, instead of modifying vmlinux
> in-place. WDYT?

Sure, that is a nice addition, makes it more flexible to cover this
usecase.

- Arnaldo
 
> >
> > Specially the attach_kprobe_legacy() function:
> >
> > https://github.com/rafaeldtinoco/portablebpf/blob/master/mine.c#L31
> >
> > I wanted to reply here in case others also face this.
> 
> Great, glad it worked out. It would be great if you could contribute
> legacy kprobe support for libbpf as a proper patch, since it probably
> would be useful for a bunch of other people stuck with old kernels.
> 
> >
> > Only bad thing was kernel v4.15 missed global data support as showed in:
> >
> > https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md
> >
> > But using perf event was good enough for an example.
> >
> > - rafaeldtinoco
