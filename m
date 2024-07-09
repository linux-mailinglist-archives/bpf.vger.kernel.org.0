Return-Path: <bpf+bounces-34214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75092B415
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C41F234CE
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B91515574E;
	Tue,  9 Jul 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0xAch9H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FAD13C687;
	Tue,  9 Jul 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517998; cv=none; b=T/wttiRPwAEtjYoMUCUknUEpnATYiMyhRXHjnVA3SKXaFyN1zGKuJUcf94eqooDuoMIXk8A+ByyblB/NnoAHizz/MqzdLQoPJduAI7ZktB36ABK2fLjXvO9KTNsJ4rYrIy00MteHMbFdkvC35xsxWfLsVqSIG6TsIUv3IWZ4K7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517998; c=relaxed/simple;
	bh=YLLKXO9LQyBdruxsLrFG2iexGd+6cQarJN2FYHNbX38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXoHrfhRdf1RRmaNFgrH+vd13uxYrPZ+mjZ/PYX8+ghTUtO7L90URrBEvVlEXdzGy3VAxdHFgm27aBxyCpRW9141fZILeS2raySdkj+9Xvof4P0Qe1VtQfv/CumNNsFxVj6TPLILzmMnBny9odSa/6z2/huE5l6xSegY5znhJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0xAch9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F152AC3277B;
	Tue,  9 Jul 2024 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720517998;
	bh=YLLKXO9LQyBdruxsLrFG2iexGd+6cQarJN2FYHNbX38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0xAch9HsB+cVsJef7JG/fDYr42ZEaIKrFRNruViCD5ylCrIiteelaBz2b8FedJ8p
	 NipKOtQN5ToBUmNA6d4AsMNKBDv6T8ZDJGIx2sKFmG2iihW9J6R2wC2cVhXT7+JMPV
	 2J4gVGdws9ioh2PbFbGo4yczJ+mRLATvUN1CTBKU=
Date: Tue, 9 Jul 2024 11:39:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: WangYuli <wangyuli@uniontech.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"song@kernel.org" <song@kernel.org>,
	"puranjay12@gmail.com" <puranjay12@gmail.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@google.com" <sdf@google.com>,
	"haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"illusionist.neo@gmail.com" <illusionist.neo@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"johan.almbladh@anyfinetworks.com" <johan.almbladh@anyfinetworks.com>,
	"paulburton@kernel.org" <paulburton@kernel.org>,
	"tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"deller@gmx.de" <deller@gmx.de>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"iii@linux.ibm.com" <iii@linux.ibm.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>,
	"gor@linux.ibm.com" <gor@linux.ibm.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"guanwentao@uniontech.com" <guanwentao@uniontech.com>,
	"baimingcong@uniontech.com" <baimingcong@uniontech.com>
Subject: Re: [PATCH] Revert "bpf: Take return from set_memory_rox() into
 account with bpf_jit_binary_lock_ro()" for linux-6.6.37
Message-ID: <2024070953-sepia-protozoan-86a0@gregkh>
References: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
 <2024070631-unrivaled-fever-8548@gregkh>
 <B7E3B29557B78CB1+afadbaa6-987e-4db4-96b5-4e4d5465c37b@uniontech.com>
 <2024070815-udder-charging-7f75@gregkh>
 <a1dac525-4e6d-4d28-87ee-63723abbafad@cs-soprasteria.com>
 <2024070908-glade-granny-1137@gregkh>
 <4d07cfa3-031c-45f4-aec1-9f0a54dd22b2@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d07cfa3-031c-45f4-aec1-9f0a54dd22b2@cs-soprasteria.com>

On Tue, Jul 09, 2024 at 09:24:54AM +0000, LEROY Christophe wrote:
> 
> 
> Le 09/07/2024 à 11:15, Greg KH a écrit :
> > On Mon, Jul 08, 2024 at 03:12:55PM +0000, LEROY Christophe wrote:
> >>
> >>
> >> Le 08/07/2024 à 14:36, Greg KH a écrit :
> >>> On Sun, Jul 07, 2024 at 03:34:15PM +0800, WangYuli wrote:
> >>>>
> >>>> On 2024/7/6 17:30, Greg KH wrote:
> >>>>> This makes it sound like you are reverting this because of a build
> >>>>> error, which is not the case here, right?  Isn't this because of the
> >>>>> powerpc issue reported here:
> >>>>>      https://lore.kernel.org/r/20240705203413.wbv2nw3747vjeibk@altlinux.org
> >>>>> ?
> >>>>
> >>>> No, it only occurs on ARM64 architecture. The reason is that before being
> >>>> modified, the function
> >>>>
> >>>> bpf_jit_binary_lock_ro() in arch/arm64/net/bpf_jit_comp.c +1651
> >>>>
> >>>> was introduced with __must_check, which is defined as
> >>>> __attribute__((__warn_unused_result__)).
> >>>>
> >>>>
> >>>> However, at this point, calling bpf_jit_binary_lock_ro(header)
> >>>> coincidentally results in an unused-result
> >>>>
> >>>> warning.
> >>>
> >>> Ok, thanks, but why is no one else seeing this in their testing?
> >>
> >> Probably the configs used by robots do not activate BPF JIT ?
> >>
> >>>
> >>>>> If not, why not just backport the single missing arm64 commit,
> >>>>
> >>>> Upstream commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> >>>> management") is part of
> >>>>
> >>>> a larger change that involves multiple commits. It's not an isolated commit.
> >>>>
> >>>>
> >>>> We could certainly backport all of them to solve this problem, buthas it's not
> >>>> the simplest solution.
> >>>
> >>> reverting the change feels wrong in that you will still have the bug
> >>> present that it was trying to solve, right?  If so, can you then provide
> >>> a working version?
> >>
> >> Indeed, by reverting the change you "punish" all architectures because
> >> arm64 hasn't properly been backported, is it fair ?
> >>
> >> In fact, when I implemented commit e60adf513275 ("bpf: Take return from
> >> set_memory_rox() into account with bpf_jit_binary_lock_ro()"), we had
> >> the following users for function bpf_jit_binary_lock_ro() :
> >>
> >> $ git grep bpf_jit_binary_lock_ro e60adf513275~
> >> e60adf513275~:arch/arm/net/bpf_jit_32.c:
> >> bpf_jit_binary_lock_ro(header);
> >> e60adf513275~:arch/loongarch/net/bpf_jit.c:
> >> bpf_jit_binary_lock_ro(header);
> >> e60adf513275~:arch/mips/net/bpf_jit_comp.c:
> >> bpf_jit_binary_lock_ro(header);
> >> e60adf513275~:arch/parisc/net/bpf_jit_core.c:
> >> bpf_jit_binary_lock_ro(jit_data->header);
> >> e60adf513275~:arch/s390/net/bpf_jit_comp.c:
> >> bpf_jit_binary_lock_ro(header);
> >> e60adf513275~:arch/sparc/net/bpf_jit_comp_64.c:
> >> bpf_jit_binary_lock_ro(header);
> >> e60adf513275~:arch/x86/net/bpf_jit_comp32.c:
> >> bpf_jit_binary_lock_ro(header);
> >> e60adf513275~:include/linux/filter.h:static inline void
> >> bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> >>
> >> But when commit 08f6c05feb1d ("bpf: Take return from set_memory_rox()
> >> into account with bpf_jit_binary_lock_ro()") was applied, we had one
> >> more user which is arm64:
> >>
> >> $ git grep bpf_jit_binary_lock_ro 08f6c05feb1d~
> >> 08f6c05feb1d~:arch/arm/net/bpf_jit_32.c:
> >> bpf_jit_binary_lock_ro(header);
> >> 08f6c05feb1d~:arch/arm64/net/bpf_jit_comp.c:
> >> bpf_jit_binary_lock_ro(header);
> >> 08f6c05feb1d~:arch/loongarch/net/bpf_jit.c:
> >> bpf_jit_binary_lock_ro(header);
> >> 08f6c05feb1d~:arch/mips/net/bpf_jit_comp.c:
> >> bpf_jit_binary_lock_ro(header);
> >> 08f6c05feb1d~:arch/parisc/net/bpf_jit_core.c:
> >> bpf_jit_binary_lock_ro(jit_data->header);
> >> 08f6c05feb1d~:arch/s390/net/bpf_jit_comp.c:
> >> bpf_jit_binary_lock_ro(header);
> >> 08f6c05feb1d~:arch/sparc/net/bpf_jit_comp_64.c:
> >> bpf_jit_binary_lock_ro(header);
> >> 08f6c05feb1d~:arch/x86/net/bpf_jit_comp32.c:
> >> bpf_jit_binary_lock_ro(header);
> >> 08f6c05feb1d~:include/linux/filter.h:static inline void
> >> bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> >>
> >> Therefore, commit 08f6c05feb1d should have included a backport for arm64.
> >>
> >> So yes, I agree with Greg, the correct fix should be to backport to
> >> ARM64 the changes done on other architectures in order to properly
> >> handle return of set_memory_rox() in bpf_jit_binary_lock_ro().
> >
> > Ok, but it looks like due to this series, the powerpc tree is crashing
> > at the first bpf load, so something went wrong.  Let me go revert these
> > 4 patches for now, and then I will be glad to queue them up if you can
> > provide a working series for all arches.
> >
> 
> Fair enough, indeed I think for powerpc it probably also relies on more
> changes, so both ARM and POWERPC need a carefull backport.
> 
> I can look at it, but can you tell why it was decided to apply that
> commit on stable at the first place ? Is there a particular need ?

Based on the changelog text itself, it fixes an issue and was flagged as
something to be backported.

If this isn't needed in 6.6.y, then no worries at all, we can just drop
them and be happy :)

thanks,

greg k-h

