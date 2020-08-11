Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37449241961
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgHKKFQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgHKKFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 06:05:16 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C904C06174A
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3uVEn1qPyMGagyV0OlZXG7WW4nfFkV6Mw3U0YpXjGLk=; b=Zgb/o/nua+AqXsXA4ruyLSysm
        ih5B/GWRHA3U8Vu5AcbhjNS+MEQfOGhlqG9qUmDmvmPFU3fY2QJQgDQoO/QKGcuM6/d2/vzfZk271
        sLZwONEwpp8osENjA4JvUxiAHiUAny6uh2oiLf/qaCzqsgKUuMhTy2Omt86jNw0KdqoQd9T34KdMF
        mWworB3zbAIp4C8aIUhk9KxebH9UTR1MnAOrpN6qI0rBsA6yqlY5yR9HVEQCx8dGmlOJ89PeKhKiF
        PYFnDqqEwXBRPnn4Yu9c6EXr8s0C5f2DOXwlshJtWpqHlOW+Rs/B0BgL8jTDjsuJnrkFByQBfqmML
        h8HIkXRWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51100)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k5R9S-0001Fa-L6; Tue, 11 Aug 2020 11:05:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k5R9R-0002iL-2q; Tue, 11 Aug 2020 11:05:01 +0100
Date:   Tue, 11 Aug 2020 11:05:01 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jakov Petrina <jakov.petrina@sartura.hr>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
Message-ID: <20200811100500.GK1551@shell.armlinux.org.uk>
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica>
 <20200807190029.GI1551@shell.armlinux.org.uk>
 <6872df6c-c541-5b35-a07d-77b2862c5333@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6872df6c-c541-5b35-a07d-77b2862c5333@sartura.hr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 09:52:17AM +0200, Jakov Petrina wrote:
> Hi,
> 
> On 07/08/2020 21:00, Russell King - ARM Linux admin wrote:
> > 
> > For those of us not familiar with what CO-RE is, this doesn't help.
> > I assume the [0] was a reference to something that explained it,
> > but that isn't included.
> > 
> 
> the reference [0] is link to a blog post which explains the eBPF CO-RE
> concept; I have added this link as a reference below.
> 
> > 
> > What is "BTF information"?  Google suggests it's something to do with
> > the British Thyroid Foundation.
> > 
> > Please don't use three letter abbreviations unless they are widely
> > understood, or if you wish to, please ensure that you explain them.
> > TLAs otherwise are an exclusion mechanism.
> > >
> > What is this "vmlinux.h" ?  It isn't something that the kernel provides
> > afaics.  It doesn't seem to be present on my existing x86 Debian system.
> > I've seen it on Fedora systems in the dim and distant past.
> > 
> > Where do you think it comes from?  Where are you finding it?
> > 
> 
> The blog post [0] provides description and context for the references and
> abbreviations used, but in the future I will be sure to avoid using
> abbreviations unless they are commonly understood.
> 
> [0] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html

Okay, you've addressed one point I raised, but you have not addressed
any of the questions I raised.  I'll take this thread as just noise on
the mailing list since it seems to contain nothing of any relevance to
the Linux kernel, and no one seems willing to explain why they think it
is relevant.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
