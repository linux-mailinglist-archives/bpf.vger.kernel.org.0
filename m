Return-Path: <bpf+bounces-34199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A692B36B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014061F2329D
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B0154434;
	Tue,  9 Jul 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b5CS9d8E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED81DA2F;
	Tue,  9 Jul 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516560; cv=none; b=o46AuTjU/Oh2+A7B8xHMywvUTEh6lIxPcf6buc8eA1b+UWAgk3i94jb7bL0SvHuviHiq+q4yg2LTkw58Zrf4jOiEjgELNURKxioXlXegFK9Z/24bGlZXv7W3c2qx5YvvtqaFcWr3Qb+OwM5Hf8lCEjW/tfA+wyNSXd0kPEC9KxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516560; c=relaxed/simple;
	bh=hK2QUQoSLsKZsz2jegmGiISGgACqpgV+13IffX5u+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpmhwe9C7pKFype5pMQ3KhGNl+0+F0MqfREeyOD+KduE8idQ3v7UnEEBpGkJ/USUsh04/IenZrDxOqkXoPr6jB97EVzTP+1kG/SjO4XwoJMB6AqYUVIFhw/YflpcyOJ1qKZZrUZTlzAFBELz3L0fNJTaiN/L5CyzI8xVS1G/wk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b5CS9d8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E023C3277B;
	Tue,  9 Jul 2024 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720516560;
	bh=hK2QUQoSLsKZsz2jegmGiISGgACqpgV+13IffX5u+qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5CS9d8EmjYuSh4Oeec2RjoRUGGvRd0pLtlX6LmRJt4hCd5HbYeEb7JcMhMOETUiL
	 nJGOijZI7omuHyu+1Qf35faihpB0P+eHXoiC/u41ezJKQHr3qA2gW9sxBtTIXizM63
	 z1FgzWNtkl38ekbRw1GjxAc4UY7Jz4/WW8/AIhfs=
Date: Tue, 9 Jul 2024 11:15:57 +0200
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
Message-ID: <2024070908-glade-granny-1137@gregkh>
References: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
 <2024070631-unrivaled-fever-8548@gregkh>
 <B7E3B29557B78CB1+afadbaa6-987e-4db4-96b5-4e4d5465c37b@uniontech.com>
 <2024070815-udder-charging-7f75@gregkh>
 <a1dac525-4e6d-4d28-87ee-63723abbafad@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1dac525-4e6d-4d28-87ee-63723abbafad@cs-soprasteria.com>

On Mon, Jul 08, 2024 at 03:12:55PM +0000, LEROY Christophe wrote:
> 
> 
> Le 08/07/2024 à 14:36, Greg KH a écrit :
> > On Sun, Jul 07, 2024 at 03:34:15PM +0800, WangYuli wrote:
> >>
> >> On 2024/7/6 17:30, Greg KH wrote:
> >>> This makes it sound like you are reverting this because of a build
> >>> error, which is not the case here, right?  Isn't this because of the
> >>> powerpc issue reported here:
> >>>     https://lore.kernel.org/r/20240705203413.wbv2nw3747vjeibk@altlinux.org
> >>> ?
> >>
> >> No, it only occurs on ARM64 architecture. The reason is that before being
> >> modified, the function
> >>
> >> bpf_jit_binary_lock_ro() in arch/arm64/net/bpf_jit_comp.c +1651
> >>
> >> was introduced with __must_check, which is defined as
> >> __attribute__((__warn_unused_result__)).
> >>
> >>
> >> However, at this point, calling bpf_jit_binary_lock_ro(header)
> >> coincidentally results in an unused-result
> >>
> >> warning.
> >
> > Ok, thanks, but why is no one else seeing this in their testing?
> 
> Probably the configs used by robots do not activate BPF JIT ?
> 
> >
> >>> If not, why not just backport the single missing arm64 commit,
> >>
> >> Upstream commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> >> management") is part of
> >>
> >> a larger change that involves multiple commits. It's not an isolated commit.
> >>
> >>
> >> We could certainly backport all of them to solve this problem, buthas it's not
> >> the simplest solution.
> >
> > reverting the change feels wrong in that you will still have the bug
> > present that it was trying to solve, right?  If so, can you then provide
> > a working version?
> 
> Indeed, by reverting the change you "punish" all architectures because
> arm64 hasn't properly been backported, is it fair ?
> 
> In fact, when I implemented commit e60adf513275 ("bpf: Take return from
> set_memory_rox() into account with bpf_jit_binary_lock_ro()"), we had
> the following users for function bpf_jit_binary_lock_ro() :
> 
> $ git grep bpf_jit_binary_lock_ro e60adf513275~
> e60adf513275~:arch/arm/net/bpf_jit_32.c:
> bpf_jit_binary_lock_ro(header);
> e60adf513275~:arch/loongarch/net/bpf_jit.c:
> bpf_jit_binary_lock_ro(header);
> e60adf513275~:arch/mips/net/bpf_jit_comp.c:
> bpf_jit_binary_lock_ro(header);
> e60adf513275~:arch/parisc/net/bpf_jit_core.c:
> bpf_jit_binary_lock_ro(jit_data->header);
> e60adf513275~:arch/s390/net/bpf_jit_comp.c:
> bpf_jit_binary_lock_ro(header);
> e60adf513275~:arch/sparc/net/bpf_jit_comp_64.c:
> bpf_jit_binary_lock_ro(header);
> e60adf513275~:arch/x86/net/bpf_jit_comp32.c:
> bpf_jit_binary_lock_ro(header);
> e60adf513275~:include/linux/filter.h:static inline void
> bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> 
> But when commit 08f6c05feb1d ("bpf: Take return from set_memory_rox()
> into account with bpf_jit_binary_lock_ro()") was applied, we had one
> more user which is arm64:
> 
> $ git grep bpf_jit_binary_lock_ro 08f6c05feb1d~
> 08f6c05feb1d~:arch/arm/net/bpf_jit_32.c:
> bpf_jit_binary_lock_ro(header);
> 08f6c05feb1d~:arch/arm64/net/bpf_jit_comp.c:
> bpf_jit_binary_lock_ro(header);
> 08f6c05feb1d~:arch/loongarch/net/bpf_jit.c:
> bpf_jit_binary_lock_ro(header);
> 08f6c05feb1d~:arch/mips/net/bpf_jit_comp.c:
> bpf_jit_binary_lock_ro(header);
> 08f6c05feb1d~:arch/parisc/net/bpf_jit_core.c:
> bpf_jit_binary_lock_ro(jit_data->header);
> 08f6c05feb1d~:arch/s390/net/bpf_jit_comp.c:
> bpf_jit_binary_lock_ro(header);
> 08f6c05feb1d~:arch/sparc/net/bpf_jit_comp_64.c:
> bpf_jit_binary_lock_ro(header);
> 08f6c05feb1d~:arch/x86/net/bpf_jit_comp32.c:
> bpf_jit_binary_lock_ro(header);
> 08f6c05feb1d~:include/linux/filter.h:static inline void
> bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> 
> Therefore, commit 08f6c05feb1d should have included a backport for arm64.
> 
> So yes, I agree with Greg, the correct fix should be to backport to
> ARM64 the changes done on other architectures in order to properly
> handle return of set_memory_rox() in bpf_jit_binary_lock_ro().

Ok, but it looks like due to this series, the powerpc tree is crashing
at the first bpf load, so something went wrong.  Let me go revert these
4 patches for now, and then I will be glad to queue them up if you can
provide a working series for all arches.

thanks,

greg k-h

