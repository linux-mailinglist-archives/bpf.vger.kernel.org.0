Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B49348E01
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 11:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYK3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 06:29:03 -0400
Received: from elvis.franken.de ([193.175.24.41]:58945 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhCYK2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 06:28:48 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lPNEM-0007Ug-00; Thu, 25 Mar 2021 11:28:46 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CCBECC1C81; Thu, 25 Mar 2021 11:17:12 +0100 (CET)
Date:   Thu, 25 Mar 2021 11:17:12 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS again
Message-ID: <20210325101712.GA6893@alpha.franken.de>
References: <1616034557-5844-1-git-send-email-yangtiezhu@loongson.cn>
 <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk>
 <f36f4ca6-a3bb-8db9-01e6-65fec0916b58@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36f4ca6-a3bb-8db9-01e6-65fec0916b58@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 03:12:59PM +0800, Tiezhu Yang wrote:
> On 03/22/2021 12:46 PM, Maciej W. Rozycki wrote:
> > On Thu, 18 Mar 2021, Tiezhu Yang wrote:
> > 
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 160b3a8..4b94ec7 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -6,6 +6,7 @@ config MIPS
> > >   	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
> > >   	select ARCH_HAS_FORTIFY_SOURCE
> > >   	select ARCH_HAS_KCOV
> > > +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> >   Hmm, documentation on ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE seems rather
> > scarce, but based on my guess shouldn't this be "if !EVA"?
> > 
> >    Maciej
> 
> I do not quite know what the effect if MIPS EVA (Enhanced Virtual
> Addressing)
> is set, I saw that ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE should be
> restricted
> to archs with non-overlapping address ranges.
> 
> I wonder whether MIPS EVA will generate overlapping address ranges?

they can overlap in EVA mode.

> If yes, it is better to make ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE depend
> on !EVA on MIPS.

Could please add the change ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
