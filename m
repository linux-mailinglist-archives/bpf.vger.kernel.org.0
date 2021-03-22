Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFA334500F
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 20:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhCVTjM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 15:39:12 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38102 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhCVTjK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 15:39:10 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A0DCF92009C; Mon, 22 Mar 2021 20:39:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9C84A92009B;
        Mon, 22 Mar 2021 20:39:07 +0100 (CET)
Date:   Mon, 22 Mar 2021 20:39:07 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS
 again
In-Reply-To: <f36f4ca6-a3bb-8db9-01e6-65fec0916b58@loongson.cn>
Message-ID: <alpine.DEB.2.21.2103222037450.21463@angie.orcam.me.uk>
References: <1616034557-5844-1-git-send-email-yangtiezhu@loongson.cn> <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk> <f36f4ca6-a3bb-8db9-01e6-65fec0916b58@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Mar 2021, Tiezhu Yang wrote:

> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -6,6 +6,7 @@ config MIPS
> > >   	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
> > >   	select ARCH_HAS_FORTIFY_SOURCE
> > >   	select ARCH_HAS_KCOV
> > > +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> >   Hmm, documentation on ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE seems rather
> > scarce, but based on my guess shouldn't this be "if !EVA"?
> 
> I do not quite know what the effect if MIPS EVA (Enhanced Virtual Addressing)
> is set, I saw that ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE should be restricted
> to archs with non-overlapping address ranges.
> 
> I wonder whether MIPS EVA will generate overlapping address ranges?

 The architecture specification has it all.

  Maciej
