Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3D34BF29
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 23:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhC1VGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 17:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhC1VGL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Mar 2021 17:06:11 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0650AC061756;
        Sun, 28 Mar 2021 14:06:10 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A295D92009C; Sun, 28 Mar 2021 23:06:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9B44B92009B;
        Sun, 28 Mar 2021 23:06:08 +0200 (CEST)
Date:   Sun, 28 Mar 2021 23:06:08 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS
 again
In-Reply-To: <38cf6f7c-28dd-20a0-8193-776fa7bdb83a@loongson.cn>
Message-ID: <alpine.DEB.2.21.2103282240420.18977@angie.orcam.me.uk>
References: <1616034557-5844-1-git-send-email-yangtiezhu@loongson.cn> <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk> <f36f4ca6-a3bb-8db9-01e6-65fec0916b58@loongson.cn> <20210325101712.GA6893@alpha.franken.de>
 <38cf6f7c-28dd-20a0-8193-776fa7bdb83a@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Mar 2021, Tiezhu Yang wrote:

> > > I wonder whether MIPS EVA will generate overlapping address ranges?
> > they can overlap in EVA mode.
> > 
> > > If yes, it is better to make ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE depend
> > > on !EVA on MIPS.
> > Could please add the change ?
> 
> OK, thank you, I will do it soon.

 For the record this is clearly described and accompanied with a drawing 
[1][2] in the architecture specification.  I do encourage you and anyone 
serious about contributing to the MIPS/Linux project to make yourselves 
familiar with the architecture beyond the area of your immediate interest 
so as to offload the maintainers who are often overloaded and sometimes do 
their work in their precious free time.  There are so many contributors 
and so few maintainers, so please help everyone and spread the work.

 Also please pay attention to quality change descriptions.  It's your task 
to convince the maintainer your work is worth including, and in your best 
interest to make the decision easy to make for the maintainer.  Think in 
terms of an exam at the university and what you would do to persuade your 
professor to give you a good score.  This is what the change description 
is for, beyond the quality of the change itself of course.

 This general rule of course applies to any community-maintained projects 
and not only MIPS/Linux.

References:

[1] "MIPS Architecture For Programmers, Vol. III: MIPS32/microMIPS32
    Privileged Resource Architecture", Document Number: MD00090, Revision 
    5.05, November 14, 2014, Figure 4.5 "EVA addressability", p. 51, 
    <https://wavecomp.ai/mips-technology/>

[2] "MIPS Architecture For Programmers, Volume III: The MIPS64 and 
    microMIPS64 Privileged Resource Architecture", Document Number: 
    MD00091, Revision 5.04, January 15, 2014, Figure 4.5 "EVA 
    addressability", p. 58, <https://wavecomp.ai/mips-technology/>

  Maciej
