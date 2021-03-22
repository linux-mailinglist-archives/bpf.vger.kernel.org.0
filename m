Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F09343A5E
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 08:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVHM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 03:12:57 -0400
Received: from verein.lst.de ([213.95.11.211]:53802 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhCVHMn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 03:12:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A19467373; Mon, 22 Mar 2021 08:12:40 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:12:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS
 again
Message-ID: <20210322071240.GD3440@lst.de>
References: <1616034557-5844-1-git-send-email-yangtiezhu@loongson.cn> <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 05:46:56AM +0100, Maciej W. Rozycki wrote:
> On Thu, 18 Mar 2021, Tiezhu Yang wrote:
> 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 160b3a8..4b94ec7 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -6,6 +6,7 @@ config MIPS
> >  	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
> >  	select ARCH_HAS_FORTIFY_SOURCE
> >  	select ARCH_HAS_KCOV
> > +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> 
>  Hmm, documentation on ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE seems rather 
> scarce, but based on my guess shouldn't this be "if !EVA"?

ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE means the any given virtual
address in a task context can either be a valid kernel or user address
space, but not both.

Note that the bpf probe really is a legacy use case and should not be
used in new code independent of that.
