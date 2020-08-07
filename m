Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531D123F2EB
	for <lists+bpf@lfdr.de>; Fri,  7 Aug 2020 21:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHGTAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Aug 2020 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTAf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Aug 2020 15:00:35 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65585C061756
        for <bpf@vger.kernel.org>; Fri,  7 Aug 2020 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nzfDWUgjvBp5zcnrjMzmPF4/F3qvqe3B+Ykejy/5sj0=; b=ImkaFR86XdiR0ArscNGPb4yzm
        ORBXUbmp24rMgPUneiipLLVZzcl7ZvFCMllSVZquZGa5bGMzGwUU4B7lgGz2/jS1C0NEK4/YpPz33
        dotrPfTXw1PcqS5upywuvc4x1yKTQV7bSHLd8Ynxz+2hB+dOSrf/h7zbAfKbj4Uc5XOC/uXSeWM1f
        ONYUfkBQYFL32/3A+3Qi2Ed0kn0zQZYzOdoOQjpdfAkzf8O+0OuYk+g92C7wxtriQDzzX1VIbfJC5
        lHSUYSYBx3lL6Vg6ng17wWBeQwSoRvX79lWVPZY+9OQpfrJFmv/yZ675jokwtZC/6eXNZqTlLxbyX
        7bFuK+djQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49596)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k47bT-00069w-4R; Fri, 07 Aug 2020 20:00:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k47bR-0007Ql-Jg; Fri, 07 Aug 2020 20:00:29 +0100
Date:   Fri, 7 Aug 2020 20:00:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jakov Petrina <jakov.petrina@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
Message-ID: <20200807190029.GI1551@shell.armlinux.org.uk>
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807172353.GA624812@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 07, 2020 at 07:23:53PM +0200, Jean-Philippe Brucker wrote:
> On Fri, Aug 07, 2020 at 04:20:58PM +0200, Jakov Petrina wrote:
> > Hi everyone,
> > 
> > recently we have begun extensive research into eBPF and related
> > technologies. Seeking an easier development process, we have switched over
> > to using the eBPF CO-RE [0] approach internally which has enabled us to
> > simplify most aspects of eBPF development, especially those related to
> > cross-compilation.

For those of us not familiar with what CO-RE is, this doesn't help.
I assume the [0] was a reference to something that explained it,
but that isn't included.

> > However, as part of these efforts we have stumbled upon several problems
> > that we feel would benefit from a community discussion where we may share
> > our solutions and discuss alternatives moving forward.
> > 
> > As a reference point, we have started researching and modifying several eBPF
> > CO-RE samples that have been developed or migrated from existing `bcc`
> > tooling. Most notable examples are those present in `bcc`'s `libbpf-tools`
> > directory [1]. Some of these samples have just recently been converted to
> > respective eBPF CO-RE variants, of which the `tcpconnect` tracing sample has
> > proven to be very interesting.
> > 
> > First showstopper for cross-compiling aforementioned example on the ARM
> > 32-bit platform has been with regards to generation of the required
> > `vmlinux.h` kernel header from the BTF information. More specifically, our
> > initial approach to have e.g. a compilation target dependency which would
> > invoke `bpftool` at configure time was not appropriate due to several
> > issues: a) CO-RE requires host kernel to have been compiled in such a way to
> > expose BTF information which may not available, and b) the generated

What is "BTF information"?  Google suggests it's something to do with
the British Thyroid Foundation.

Please don't use three letter abbreviations unless they are widely
understood, or if you wish to, please ensure that you explain them.
TLAs otherwise are an exclusion mechanism.

> > `vmlinux.h` was actually architecture-specific.

What is this "vmlinux.h" ?  It isn't something that the kernel provides
afaics.  It doesn't seem to be present on my existing x86 Debian system.
I've seen it on Fedora systems in the dim and distant past.

Where do you think it comes from?  Where are you finding it?
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
