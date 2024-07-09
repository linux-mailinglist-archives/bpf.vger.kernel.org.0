Return-Path: <bpf+bounces-34235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87092B9A9
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE1A1F259AB
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795E4158DB7;
	Tue,  9 Jul 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TKfDXVnq"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2413A25F;
	Tue,  9 Jul 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528729; cv=none; b=F2LP7/W7YlcJDPh4+quc0Pe1miWSX/C4lZsWvbc2qutr7XDGPPU9Il9m/zO4ykudUabFFMe7kIyROXnmin1XP6NrZ4Fz9M/948j8u35M+Hb+pHYeyHNdA2fg880IeoRhvo/JT13FkrTcfDO/OzQ0NOwtgnpGFB4ZGZrNUsrMQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528729; c=relaxed/simple;
	bh=1bJ6NCgfPspsT95h6nGvWSLshmlyHpGn4WwUHnbiia4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FEmVrw4YYW09yZa5yyih+4TsoJ2Qb188Tg1RVT65B+s31Cy0KoJdNyYh9s3bBCVjhBmSGmoRxrFD0ZZ+1All7T7SyCihgfRSY+YtNsrNElWSJeVS4Md4PibXrgq7d+3e0EgimZADxRP6iuMCRg5tHUpYfuW6HfDsewULomyvemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TKfDXVnq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720528725;
	bh=GmUsmLNBIQmHW+JpWrHCwH01WEhfM5xgRbqsJMF93No=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TKfDXVnq4T0Yt94cqUje8f+e8cqlm1eOR4zpw3mH0J+WJjdedfiXukVb0N0USQBzl
	 an+2rjHqTgzz0S+/C7bw91G2WylXJ1V9T+H3v99ZKbNndLSVQzKzwCcwX2PxQzxcvy
	 yWCpk9oxrmS0eKemK6VJcaNzm8zRZA+O4GQ/eqAyMrGQ1RwGGwaS4wuRxI2lkgv3BJ
	 QPxXbiLXVDgwm1kuSlAftov88xNcM5RQlSLxk0IJEcpTCjEbvGpHAtVE5rtFIODAdj
	 UvUw+ig522m7IoDZWue+Hv7OeiTGl5qKxdw02iSUSfQemOLOH+1ElGonthCgdVSUHi
	 6N+F+0H4Tspxg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJLBq3Qzqz4wcl;
	Tue,  9 Jul 2024 22:38:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Naveen N Rao
 <naveen@kernel.org>
Cc: matoro <matoro_mailinglist_kernel@matoro.tk>, bpf@vger.kernel.org, Hari
 Bathini <hbathini@linux.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, ltp@lists.linux.it,
 stable@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: WARNING&Oops in v6.6.37 on ppc64lea - Trying to vfree() bad
 address (00000000453be747)
In-Reply-To: <2024070958-plant-prozac-6a33@gregkh>
References: <20240705203413.wbv2nw3747vjeibk@altlinux.org>
 <cf736c5e37489e7dc7ffd67b9de2ab47@matoro.tk>
 <2024070904-cod-bobcat-a0d0@gregkh>
 <1720516964.n61e0dnv80.naveen@kernel.org>
 <2024070958-plant-prozac-6a33@gregkh>
Date: Tue, 09 Jul 2024 22:38:43 +1000
Message-ID: <87sewi68q4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Tue, Jul 09, 2024 at 03:02:13PM +0530, Naveen N Rao wrote:
>> Greg Kroah-Hartman wrote:
>> > On Mon, Jul 08, 2024 at 11:16:48PM -0400, matoro wrote:
>> > > On 2024-07-05 16:34, Vitaly Chikunov wrote:
>> > > > Hi,
>> > > > > There is new WARNING and Oops on ppc64le in v6.6.37 when running
>> > > LTP tests:
>> > > > bpf_prog01, bpf_prog02, bpf_prog04, bpf_prog05, prctl04. Logs excerpt
>> > > > below. I
>> > > > see there is 1 commit in v6.6.36..v6.6.37 with call to
>> > > > bpf_jit_binary_pack_finalize, backported from 5 patch mainline patchset:
>> > > > >   f99feda5684a powerpc/bpf: use
>> > > bpf_jit_binary_pack_[alloc|finalize|free]
>> > > >
>> 
>> <snip>
>> 
>> > > > > And so on. Temporary build/test log is at
>> > > > https://git.altlinux.org/tasks/352218/build/100/ppc64le/log
>> > > > > Other stable/longterm branches or other architectures does not
>> > > exhibit this.
>> > > > > Thanks,
>> > > 
>> > > Hi all - this just took down a production server for me, on POWER9 bare
>> > > metal.  Not running tests, just booting normally, before services even came
>> > > up.  Had to perform manual restoration, reverting to 6.6.36 worked.  Also
>> > > running 64k kernel, unsure if it's better on 4k kernel.
>> > > 
>> > > In case it's helpful, here's the log from my boot:
>> > > https://dpaste.org/Gyxxg/raw
>> > 
>> > Ok, this isn't good, something went wrong with my backports here.  Let
>> > me go revert them all and push out a new 6.6.y release right away.
>> 
>> I think the problem is that the series adding support for bpf prog_pack was
>> partially backported. In particular, the below patches are missing from
>> stable v6.6:
>> 465cabc97b42 powerpc/code-patching: introduce patch_instructions()
>> 033ffaf0af1f powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
>> 6efc1675acb8 powerpc/bpf: implement bpf_arch_text_copy
>> 
>> It should be sufficient to revert commit f99feda5684a (powerpc/bpf: use
>> bpf_jit_binary_pack_[alloc|finalize|free]) to allow the above to apply
>> cleanly, followed by cherry picking commit 90d862f370b6 (powerpc/bpf: use
>> bpf_jit_binary_pack_[alloc|finalize|free]) from upstream.
>> 
>> Alternately, commit f99feda5684a (powerpc/bpf: use
>> bpf_jit_binary_pack_[alloc|finalize|free]) can be reverted.
>
> I'm dropping them all now, if you want to submit a working series for
> this, I'll be glad to queue them all up.

Thanks, revert is good for now.

With the revert there will be a build warning/error, only in stable,
which I think can be fixed with the diff below. I'll get it tested and
submit it properly.

cheers

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 5f57a8ba3cc8..cdd9db8f8684 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -205,7 +205,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)

        bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + bpf_hdr->size);
        if (!fp->is_func || extra_pass) {
-               bpf_jit_binary_lock_ro(bpf_hdr);
+               if (bpf_jit_binary_lock_ro(bpf_hdr)) {
+                       fp = org_fp;
+                       goto out_addrs;
+               }
                bpf_prog_fill_jited_linfo(fp, addrs);
 out_addrs:
                kfree(addrs);

