Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8445AB5E
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhKWSkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232492AbhKWSkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 13:40:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 570C860F51;
        Tue, 23 Nov 2021 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637692646;
        bh=CPp+EZzvht2UJuG3JAmmdvF/axVrYgpUWpHqf/YqpYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oC/3OeS/Lcp9RHr5Zd07yQdbSTFmAbQks3s3QF2h1MFV110EfTkrUc3LD0/I32cF4
         TAIozCZM8LCV+jiVw99wlyh+Z/OnHcquy5ruseHAWF5jC9c871IKikV1Fbz8X0xuBy
         pZmrpNWfaMWkzLeK+Go2PCtcr3xzxfZjUxUoQ2ByCsFOd8FM2R4l+az0RoD8wCmum6
         NDVAWL5jiShWE5EC8mZ5jiEvNH8ioLqxy/4mFq89APdWdrIpsf21he3s/jN+2IOI/z
         XSVV63+ABDP4DXcUDZUYyDzI+NTPPCV2sMMqU4ZsimBhu+TSzvmqyebUlMXz3auNoH
         9gJJWilfUo6rA==
Date:   Tue, 23 Nov 2021 10:37:25 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        bpf <bpf@vger.kernel.org>, james.morse@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@linux.intel.com, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf] cacheinfo: move get_cpu_cacheinfo_id() back out
Message-ID: <20211123103725.204a854c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
References: <20211120165528.197359-1-kuba@kernel.org>
        <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Nov 2021 07:45:41 -1000 Song Liu wrote:
> > x86 resctrl folks, does this look okay?
> >
> > I'd like to do some bpf header cleanups in -next which this is blocking.
> > How would you like to handle that? This change looks entirely harmless,
> > can I get an ack and take this via bpf/netdev to Linus ASAP so it
> > propagates to all trees?  
> 
> Does this patch target the bpf tree, or the bpf-next tree? If we want to unblock
> bpf header cleanup in -next, we can simply include it in a set for bpf-next.

No strong preference. Since this is very much not a bpf patch and
should be safe my intuition is to ship it to Linus ASAP and avoid 
any potential conflicts with other -next trees. Also riscv people 
may appreciate it getting fixed sooner rather than later. If they 
trip up the same dependency later on in the cycle and we've already
committed this patch to bpf-next they'd have to duplicate the patch
in their tree.
