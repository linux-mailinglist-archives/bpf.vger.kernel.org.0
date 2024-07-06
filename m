Return-Path: <bpf+bounces-33990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB892923F
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 11:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2879CB2226A
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F653364;
	Sat,  6 Jul 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kc5x37IP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECB52F6F;
	Sat,  6 Jul 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720258204; cv=none; b=Tw+Vv4Rs16256MgebWsBIbKOY/JvtWBugAZ78PSYgt2Xo3toKXRDvmWFwnoIkIyp3fBJLmWWd0P0wbWj1phHN3kCUXldpW/ijZx0Bo6UyJLWD3hEhgUT9Fu6EFNZa5lBceWfMnKsRxvdg8D9oYEGI8xhxLLcBUxG8t25SnQq6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720258204; c=relaxed/simple;
	bh=Q+ZAuNvfo1PLDNuwb6saf6UKRg3oyUIqT65wz6VNwlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdBtXg9yQlXGfo9EB1f41eT/wAgePqLI+lr63+guBSxr/j3rooDWE5Zw7R+3fUdApbdeCJctXzagtGTD9Dk9jJTv8QNe8lnDbT9o+smpti+K+mI+Ob1TEWkr3qGpRFZBmzqcdtQ2bpAaiJ+hoN354xqgzT9cyj763LOacmLRPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kc5x37IP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC60C2BD10;
	Sat,  6 Jul 2024 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720258203;
	bh=Q+ZAuNvfo1PLDNuwb6saf6UKRg3oyUIqT65wz6VNwlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kc5x37IPXd/KXYTnyhWVxzDoXwmOXsRa5lkhUApri9j23K0WVDUdWsoChDf/QZzIn
	 nLBCT1GGHeh3IqQRpILYy+hn/QzfyHCk1qNDsE+52O4RoyRVdr3K26E82uxxYOtDvu
	 DeHaNNHlFiUxPMmQrYl3UWnAaoMEYUipQBUHvb/o=
Date: Sat, 6 Jul 2024 11:30:00 +0200
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
Message-ID: <2024070631-unrivaled-fever-8548@gregkh>
References: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>

On Sat, Jul 06, 2024 at 11:11:01AM +0800, WangYuli wrote:
> This reverts commit 08f6c05feb1db21653e98ca84ea04ca032d014c7.
> 
> Upstream commit e60adf513275 ("bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()")
> depends on
> upstream commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management").
> 
> It will cause a compilation warning on the arm64 if it's not merged:
>   arch/arm64/net/bpf_jit_comp.c: In function ‘bpf_int_jit_compile’:
>   arch/arm64/net/bpf_jit_comp.c:1651:17: warning: ignoring return value of ‘bpf_jit_binary_lock_ro’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>    1651 |                 bpf_jit_binary_lock_ro(header);
>         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This will prevent the kernel with the '-Werror' compile option from
> being compiled successfully.
> 
> We might as well revert this commit in linux-6.6.37 to solve the
> problem in a simple way.

This makes it sound like you are reverting this because of a build
error, which is not the case here, right?  Isn't this because of the
powerpc issue reported here:
	https://lore.kernel.org/r/20240705203413.wbv2nw3747vjeibk@altlinux.org
?

If not, why not just backport the single missing arm64 commit, and why
didn't this show up in testing?

confused,

greg k-h

