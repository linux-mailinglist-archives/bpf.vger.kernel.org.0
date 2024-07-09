Return-Path: <bpf+bounces-34215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C292B41E
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EBBB21AC9
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A2615574D;
	Tue,  9 Jul 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B7Jhoz0b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4C1534FC;
	Tue,  9 Jul 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518023; cv=none; b=s408RfnbvkDjtaPYdZsjtfl3kWl3NnXAd2Quj6G29Z2dS5/T/u4pL/i0hyWeA0bLOYxIV1LjP1wwpa9Aok9K9x4wIKKDKviwi+0vFJKo4XjdBvyGynlR1QVsVery94ESI50NSy10vh0sadUtCYeIS3aDVHqGkKTHR0Ow/PIdnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518023; c=relaxed/simple;
	bh=zDQMeE37biW7ERmyjD/Ec9NvHO+hvzgb1NmDdJv4Pic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK7aPo34sUaawKy8rmLOB6NogTFxNySSCt84YF58xG7bY5Q0F/lVD8NZqKp2hklXEXgr9bv5e4ttAp+NIHjdKB/beNXm51zrlIJSwYsC7uhOSKa6ukkfr00mX2tfSwChoHOCM0riNRYhVWb6b+ocrdijeJWMwzXjqy+m/tKLTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B7Jhoz0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3933C32786;
	Tue,  9 Jul 2024 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720518022;
	bh=zDQMeE37biW7ERmyjD/Ec9NvHO+hvzgb1NmDdJv4Pic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7Jhoz0bHAUt5hHwJtGldKeFjGjaOfySM/ZjXWWGO1FoZ0/IbAlAxbAptHEMDoBqM
	 7DNHn//Nl7rJjGue9y/sRNTFc8f+jXuOjuCNBz5KewiY0JO0GTyCgjiNsk3OAb3Z0f
	 tXGu1Bfjy3rKly/jK5SbR7Q1/g8ea9Vi/6dh1ffU=
Date: Tue, 9 Jul 2024 11:40:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: matoro <matoro_mailinglist_kernel@matoro.tk>, bpf@vger.kernel.org,
	Hari Bathini <hbathini@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ltp@lists.linux.it,
	stable@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: WARNING&Oops in v6.6.37 on ppc64lea - Trying to vfree() bad
 address (00000000453be747)
Message-ID: <2024070958-plant-prozac-6a33@gregkh>
References: <20240705203413.wbv2nw3747vjeibk@altlinux.org>
 <cf736c5e37489e7dc7ffd67b9de2ab47@matoro.tk>
 <2024070904-cod-bobcat-a0d0@gregkh>
 <1720516964.n61e0dnv80.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720516964.n61e0dnv80.naveen@kernel.org>

On Tue, Jul 09, 2024 at 03:02:13PM +0530, Naveen N Rao wrote:
> Greg Kroah-Hartman wrote:
> > On Mon, Jul 08, 2024 at 11:16:48PM -0400, matoro wrote:
> > > On 2024-07-05 16:34, Vitaly Chikunov wrote:
> > > > Hi,
> > > > > There is new WARNING and Oops on ppc64le in v6.6.37 when running
> > > LTP tests:
> > > > bpf_prog01, bpf_prog02, bpf_prog04, bpf_prog05, prctl04. Logs excerpt
> > > > below. I
> > > > see there is 1 commit in v6.6.36..v6.6.37 with call to
> > > > bpf_jit_binary_pack_finalize, backported from 5 patch mainline patchset:
> > > > >   f99feda5684a powerpc/bpf: use
> > > bpf_jit_binary_pack_[alloc|finalize|free]
> > > >
> 
> <snip>
> 
> > > > > And so on. Temporary build/test log is at
> > > > https://git.altlinux.org/tasks/352218/build/100/ppc64le/log
> > > > > Other stable/longterm branches or other architectures does not
> > > exhibit this.
> > > > > Thanks,
> > > 
> > > Hi all - this just took down a production server for me, on POWER9 bare
> > > metal.  Not running tests, just booting normally, before services even came
> > > up.  Had to perform manual restoration, reverting to 6.6.36 worked.  Also
> > > running 64k kernel, unsure if it's better on 4k kernel.
> > > 
> > > In case it's helpful, here's the log from my boot:
> > > https://dpaste.org/Gyxxg/raw
> > 
> > Ok, this isn't good, something went wrong with my backports here.  Let
> > me go revert them all and push out a new 6.6.y release right away.
> 
> I think the problem is that the series adding support for bpf prog_pack was
> partially backported. In particular, the below patches are missing from
> stable v6.6:
> 465cabc97b42 powerpc/code-patching: introduce patch_instructions()
> 033ffaf0af1f powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
> 6efc1675acb8 powerpc/bpf: implement bpf_arch_text_copy
> 
> It should be sufficient to revert commit f99feda5684a (powerpc/bpf: use
> bpf_jit_binary_pack_[alloc|finalize|free]) to allow the above to apply
> cleanly, followed by cherry picking commit 90d862f370b6 (powerpc/bpf: use
> bpf_jit_binary_pack_[alloc|finalize|free]) from upstream.
> 
> Alternately, commit f99feda5684a (powerpc/bpf: use
> bpf_jit_binary_pack_[alloc|finalize|free]) can be reverted.

I'm dropping them all now, if you want to submit a working series for
this, I'll be glad to queue them all up.

thanks,

greg k-h

