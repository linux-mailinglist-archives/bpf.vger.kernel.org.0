Return-Path: <bpf+bounces-34075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481492A2E0
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232A1282D50
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590F80635;
	Mon,  8 Jul 2024 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DKZMfkKI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79C3FB94;
	Mon,  8 Jul 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442203; cv=none; b=W7hDYQqiBg80f/Piyb4Q2Wm2ybCIHuCeWZUQhZtVBo2QHx83tMs6cmo2ns2n6VXCZWySlzTZrc9SIP/r/SeF40/JPtvyuhw4MJySu1337ePi4VwvyWc9rVLQNnTTNFmWi0U+U9D+PCbFnwY+yx27b4wY6bejtzAJ6pXvhmCBe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442203; c=relaxed/simple;
	bh=NWykdaXYXVK8+pVTG2FcuH3+VmdY5P2EdQq6iunNcAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPB/g9ieLjx4XOQIRUGruLb0fUq4a93PeBR3O5wQ6+kbObsEbfUQeL0YSD7VaBevzo/scHzEm3OAPeDt+Vbac8oy1qCfHp2K5uRv479oVfS0jJCoK0Pcrq4SVfGPdqzMqsGeC2zelWqzCsKbr6DQflUgAgRTCSMjmAu1Xv8V3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DKZMfkKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7941DC116B1;
	Mon,  8 Jul 2024 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720442202;
	bh=NWykdaXYXVK8+pVTG2FcuH3+VmdY5P2EdQq6iunNcAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKZMfkKIXat/MJn9ga5gS/rsVeC2r2ZMW8uFMmaqQIl+gLWharsERyViDu7MkjJqB
	 uEsU2ZvMMPoPD7Wi8sQlOhPfXsuuZiUmUaBWJ4myyoAXnhNXDznzOgoG+aF9fltUSM
	 OfglVx4gPfaSj3wbzvJWKLDE0rvD+T2frLBxNhd4=
Date: Mon, 8 Jul 2024 14:36:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, ast@kernel.org,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	christophe.leroy@csgroup.eu, catalin.marinas@arm.com,
	song@kernel.org, puranjay12@gmail.com, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, illusionist.neo@gmail.com,
	linux@armlinux.org.uk, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev,
	johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
	tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
	deller@gmx.de, linux-parisc@vger.kernel.org, iii@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	linux-s390@vger.kernel.org, davem@davemloft.net,
	sparclinux@vger.kernel.org, kuba@kernel.org, hawk@kernel.org,
	netdev@vger.kernel.org, dsahern@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, guanwentao@uniontech.com,
	baimingcong@uniontech.com
Subject: Re: [PATCH] Revert "bpf: Take return from set_memory_rox() into
 account with bpf_jit_binary_lock_ro()" for linux-6.6.37
Message-ID: <2024070815-udder-charging-7f75@gregkh>
References: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
 <2024070631-unrivaled-fever-8548@gregkh>
 <B7E3B29557B78CB1+afadbaa6-987e-4db4-96b5-4e4d5465c37b@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7E3B29557B78CB1+afadbaa6-987e-4db4-96b5-4e4d5465c37b@uniontech.com>

On Sun, Jul 07, 2024 at 03:34:15PM +0800, WangYuli wrote:
> 
> On 2024/7/6 17:30, Greg KH wrote:
> > This makes it sound like you are reverting this because of a build
> > error, which is not the case here, right?  Isn't this because of the
> > powerpc issue reported here:
> > 	https://lore.kernel.org/r/20240705203413.wbv2nw3747vjeibk@altlinux.org
> > ?
> 
> No, it only occurs on ARM64 architecture. The reason is that before being
> modified, the function
> 
> bpf_jit_binary_lock_ro() in arch/arm64/net/bpf_jit_comp.c +1651
> 
> was introduced with __must_check, which is defined as
> __attribute__((__warn_unused_result__)).
> 
> 
> However, at this point, calling bpf_jit_binary_lock_ro(header)
> coincidentally results in an unused-result
> 
> warning.

Ok, thanks, but why is no one else seeing this in their testing?

> > If not, why not just backport the single missing arm64 commit,
> 
> Upstream commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> management") is part of
> 
> a larger change that involves multiple commits. It's not an isolated commit.
> 
> 
> We could certainly backport all of them to solve this problem, but it's not
> the simplest solution.

reverting the change feels wrong in that you will still have the bug
present that it was trying to solve, right?  If so, can you then provide
a working version?

thanks,

greg k-h

