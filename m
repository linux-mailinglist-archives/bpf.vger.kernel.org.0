Return-Path: <bpf+bounces-34237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F792B9FB
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C9A1F2264E
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDCB15A878;
	Tue,  9 Jul 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="a2eLobqo"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08314884D;
	Tue,  9 Jul 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529539; cv=none; b=YVPDH1JLMy+lHLxUEyT052B3GMze8j3LYW1053Z94sgdcxSlCE/EXqaFvm5yuF7fq1+sThY5ge5pnEcLTQdIO+xGDYxPrYv4Kw8HmhNP0SJRNFLGIcyRipRO1MRzU9mHz/mj9YMNIz344M0Wo1piZrA+BdQPZfNEdxGfRphfWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529539; c=relaxed/simple;
	bh=5lo7J4fe/FqE1ySjUzvuLvhZDS+aF4yRIOvbcSOPkbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TCesIvVO9ET34e+uLoloxaCHywDpF2BPR+V3OMlSN7d4fYdquaCYy4ABKv9cv70eU2IDlYoGeEST9qtOca6tHNsX8o2jK59tBOIcFzjzA+0Vu/PK/8Fk2B3h64LuRYnxZyjyPmRCpMHy9C/IQG310XFG/nauCyDuu0tZy7I38cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=a2eLobqo; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720529535;
	bh=9EMrWwiwjkAmc8Lp2/P3hrtiQWOommhCyJibucD2H7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a2eLobqoSmFtoLTwgo4SDAaokj7GKB8kB6fADXGo3UFNB/amLpcva0vkvZpdRfvY/
	 Y4dRSRBeM1MleK+nc/jiB8NnYpczuwPLbVlbWbfU7oZZZAC3bJftuXjOZeXQk9Sf25
	 zm9GTqy+ILWfhJ5BnSdHAsJo+nQMmJSDT8ioFWBrEfghEiALeS2ThhjnpjyzEBQ2+s
	 wUUhVzOiYPjjJERAljkAtpYWU3GqKekZ/GmqwNikKw1mcDHGriVUJA+o6fclFDwbZt
	 NOxUK42xWbJMuGmfRMdh/M2FBCDWdX5VgFei+8qOb0isoYxSC4CIl+jS6LN/jZJmV5
	 3C1yGyaZHU1AQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJLVR26bFz4wnx;
	Tue,  9 Jul 2024 22:52:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Naveen N Rao
 <naveen@kernel.org>
Cc: matoro <matoro_mailinglist_kernel@matoro.tk>, bpf@vger.kernel.org, Hari
 Bathini <hbathini@linux.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, ltp@lists.linux.it,
 stable@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: WARNING&Oops in v6.6.37 on ppc64lea - Trying to vfree() bad
 address (00000000453be747)
In-Reply-To: <87sewi68q4.fsf@mail.lhotse>
References: <20240705203413.wbv2nw3747vjeibk@altlinux.org>
 <cf736c5e37489e7dc7ffd67b9de2ab47@matoro.tk>
 <2024070904-cod-bobcat-a0d0@gregkh>
 <1720516964.n61e0dnv80.naveen@kernel.org>
 <2024070958-plant-prozac-6a33@gregkh> <87sewi68q4.fsf@mail.lhotse>
Date: Tue, 09 Jul 2024 22:52:14 +1000
Message-ID: <87msmq683l.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> On Tue, Jul 09, 2024 at 03:02:13PM +0530, Naveen N Rao wrote:
>>> Greg Kroah-Hartman wrote:
>>> > On Mon, Jul 08, 2024 at 11:16:48PM -0400, matoro wrote:
>>> > > On 2024-07-05 16:34, Vitaly Chikunov wrote:
>>> > > > Hi,
>>> > > > > There is new WARNING and Oops on ppc64le in v6.6.37 when running
>>> > > LTP tests:
>>> > > > bpf_prog01, bpf_prog02, bpf_prog04, bpf_prog05, prctl04. Logs excerpt
>>> > > > below. I
>>> > > > see there is 1 commit in v6.6.36..v6.6.37 with call to
>>> > > > bpf_jit_binary_pack_finalize, backported from 5 patch mainline patchset:
>>> > > > >   f99feda5684a powerpc/bpf: use
>>> > > bpf_jit_binary_pack_[alloc|finalize|free]
>>> > > >
>>> 
>>> <snip>
>>> 
>>> > > > > And so on. Temporary build/test log is at
>>> > > > https://git.altlinux.org/tasks/352218/build/100/ppc64le/log
>>> > > > > Other stable/longterm branches or other architectures does not
>>> > > exhibit this.
>>> > > > > Thanks,
>>> > > 
>>> > > Hi all - this just took down a production server for me, on POWER9 bare
>>> > > metal.  Not running tests, just booting normally, before services even came
>>> > > up.  Had to perform manual restoration, reverting to 6.6.36 worked.  Also
>>> > > running 64k kernel, unsure if it's better on 4k kernel.
>>> > > 
>>> > > In case it's helpful, here's the log from my boot:
>>> > > https://dpaste.org/Gyxxg/raw
>>> > 
>>> > Ok, this isn't good, something went wrong with my backports here.  Let
>>> > me go revert them all and push out a new 6.6.y release right away.
>>> 
>>> I think the problem is that the series adding support for bpf prog_pack was
>>> partially backported. In particular, the below patches are missing from
>>> stable v6.6:
>>> 465cabc97b42 powerpc/code-patching: introduce patch_instructions()
>>> 033ffaf0af1f powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
>>> 6efc1675acb8 powerpc/bpf: implement bpf_arch_text_copy
>>> 
>>> It should be sufficient to revert commit f99feda5684a (powerpc/bpf: use
>>> bpf_jit_binary_pack_[alloc|finalize|free]) to allow the above to apply
>>> cleanly, followed by cherry picking commit 90d862f370b6 (powerpc/bpf: use
>>> bpf_jit_binary_pack_[alloc|finalize|free]) from upstream.
>>> 
>>> Alternately, commit f99feda5684a (powerpc/bpf: use
>>> bpf_jit_binary_pack_[alloc|finalize|free]) can be reverted.
>>
>> I'm dropping them all now, if you want to submit a working series for
>> this, I'll be glad to queue them all up.
>
> Thanks, revert is good for now.
>
> With the revert there will be a build warning/error, only in stable,
> which I think can be fixed with the diff below.

Oh I see you also reverted the commit that introduces that warning, so
the build should be OK now.

cheers

