Return-Path: <bpf+bounces-34993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C471A934864
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 08:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F44F1F21F8E
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C26F312;
	Thu, 18 Jul 2024 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="C/RX5UTN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lbYoRHqY"
X-Original-To: bpf@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC7548F7;
	Thu, 18 Jul 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285730; cv=none; b=UAQ3Wwrbt4fwv7+8xJUAZA7qf9ELIUIAZgR1107j0Vo9JsfT+7LjwIWZIp9BZqkb62i4Zai1Arc2bHVB+p8EjgCaSzqwF/lhfrUA9RnWo07RX+fD7cG3JUq13ZNNmFAVbAXGwBYlgvVoVSPArx11pkLgNJMkB7isAvsv+ljjaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285730; c=relaxed/simple;
	bh=c3vf1Ob8TbBJBt5qFMzm6P7On7KTmAa6ZXsJUixATnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJdh3QKgVEQimCo05OH0GUaoCklGAYzdZ3dyfDOdWQXeInFKtVOd2vpR+0i/dsEcj2c0ZBhtHFVPvj8ZLWmgcyMAkkoYUcD7/iTr4/etatNGxcmqC5aq+xIanbwIfswDxuctO+mW490uXjvMQRRXxto0mwHbBZVT9/6AlrLFhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=C/RX5UTN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lbYoRHqY; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id 3AE1C200381;
	Thu, 18 Jul 2024 02:55:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Jul 2024 02:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721285727; x=1721292927; bh=ibaD26rgnG
	JKK+UYgp8DF2BUsJMsG0N3OOtXuR99+38=; b=C/RX5UTNTnGBXcLjedzK2xjZgw
	7zO7Wgby1jfLD4rRkaD3/60GV9S58fzFXwkv6wG6qgAjitza+ByLq7cxR40d6aTR
	ca0CYRKGg82DWwuxVh7OZM3BRmWAryA81pCjQhfYVn0pCsOpancPcQYWhOgwvtvz
	K6vizjL0sNCBJ5fHiYN+VYxttzh4brj8YJjMP+XndMOhMh5yYNRa2z4NGXrifYkd
	l6G5MtbCStBurh6/T9XsAVm/BPwsO6P73jUs7Ywq79wfKE0iQ0cErJs4CUl75Gf1
	r2Sbxs9n9JetGccJY98VnKSJhOrdiQnBWaxSeqi12fMxImWwNeMSQ99LHwig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721285727; x=1721292927; bh=ibaD26rgnGJKK+UYgp8DF2BUsJMs
	G0N3OOtXuR99+38=; b=lbYoRHqYftmk+z9LyW2uhfkIkl8o1SNvakDr90Wo1Z+h
	P23TTfmGLCjornyRGwDE1z1KSc0o5Fj4h6H9Mb5LNqkYoolsqtMxJGz63F6JQ2uM
	0yMCqm73Wi/7j/sLhv8bwFTYRVD1QWw506/t0BmmYyaDMAH2pRVsMYOoJPA//q6O
	WQM6LLzoDpZp2VO2bNA7tz4NGW2JhyJv+iAmktpv9l1Ib7szKUwvtwHf1ATCTzfo
	RnzZnauh7yS+qYJ0nZV673Qe+6slg2tPUnn6Uys4vveEhFrSW3XkwENXrO1QkjBJ
	KZcBk4iffO0Q4/N4nwZmiKBLsT0k9YonJFGttBQo+g==
X-ME-Sender: <xms:XbyYZtcW4DPQR-82wU5fhFJfYRvb5ai7ILVEmpFyiTVlGKuzdKRQ6g>
    <xme:XbyYZrP_GDNuVsAfNN1soh7cZcgrIfJWzE6zBylGao8m6HQzz9xV2zR3sEwDMjYCS
    hc-sK-tr7EcRQ>
X-ME-Received: <xmr:XbyYZmgJxCHwwzdhC9V7oN3V-iQ1yJHJK7RVLygM9N_R9XqsNVG7gYnkDZHgRam66M2sJtoQemPReep2IP2NzvWMBdIe14hzMRrhuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeekgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:XbyYZm_drqFM142R-Ih0Tl16DM-utEtFIze5bSDxJZSQcGcFGTrk5w>
    <xmx:XbyYZpvG_ZI02-soZ-PHlsnol-dzHJNaL68uveRIowGg1RBxObtlNQ>
    <xmx:XbyYZlFuR5gBjwl2K6SOWYqXCz7OrN1jGHdOOU8nFI6k1hftk6PjAw>
    <xmx:XbyYZgNQ0GbYq-uoGvlrWEiZIRN8P-pdu25GaXDd_IiUJ_6CUpouKw>
    <xmx:X7yYZtTBaQO3eLU1h7vSHy2MaJfI-48KuiUgtXSOA9GJtRzF7E6t8PJL>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jul 2024 02:55:25 -0400 (EDT)
Date: Thu, 18 Jul 2024 08:55:23 +0200
From: Greg KH <greg@kroah.com>
To: Puranjay Mohan <pjy@amazon.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Russell King <russell.king@oracle.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, stable@vger.kernel.org,
	puranjay@kernel.org, puranjay12@gmail.com
Subject: Re: [PATCH 5.10] arm64/bpf: Remove 128MB limit for BPF JIT programs
Message-ID: <2024071834-chalice-renewal-3412@gregkh>
References: <20240701114659.39539-1-pjy@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701114659.39539-1-pjy@amazon.com>

On Mon, Jul 01, 2024 at 11:46:59AM +0000, Puranjay Mohan wrote:
> From: Russell King <russell.king@oracle.com>
> 
> [ Upstream commit b89ddf4cca43f1269093942cf5c4e457fd45c335 ]
> 
> Commit 91fc957c9b1d ("arm64/bpf: don't allocate BPF JIT programs in module
> memory") restricts BPF JIT program allocation to a 128MB region to ensure
> BPF programs are still in branching range of each other. However this
> restriction should not apply to the aarch64 JIT, since BPF_JMP | BPF_CALL
> are implemented as a 64-bit move into a register and then a BLR instruction -
> which has the effect of being able to call anything without proximity
> limitation.
> 
> The practical reason to relax this restriction on JIT memory is that 128MB of
> JIT memory can be quickly exhausted, especially where PAGE_SIZE is 64KB - one
> page is needed per program. In cases where seccomp filters are applied to
> multiple VMs on VM launch - such filters are classic BPF but converted to
> BPF - this can severely limit the number of VMs that can be launched. In a
> world where we support BPF JIT always on, turning off the JIT isn't always an
> option either.
> 
> Fixes: 91fc957c9b1d ("arm64/bpf: don't allocate BPF JIT programs in module memory")
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Russell King <russell.king@oracle.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Link: https://lore.kernel.org/bpf/1636131046-5982-2-git-send-email-alan.maguire@oracle.com
> [Replace usage of in_bpf_jit() with is_bpf_text_address()]
> Signed-off-by: Puranjay Mohan <pjy@amazon.com>
> ---
>  arch/arm64/include/asm/extable.h | 9 ---------
>  arch/arm64/include/asm/memory.h  | 5 +----
>  arch/arm64/kernel/traps.c        | 2 +-
>  arch/arm64/mm/extable.c          | 3 ++-
>  arch/arm64/mm/ptdump.c           | 2 --
>  arch/arm64/net/bpf_jit_comp.c    | 7 ++-----
>  6 files changed, 6 insertions(+), 22 deletions(-)
> 

This is reported to cause problems:
	https://lore.kernel.org/r/CA+G9fYtfAbfcQ9J9Hzq-e6yoBVG3t_iHZ=bS2eJbO_aiOcquXQ@mail.gmail.com
so I will drop it now.

How did you test this?

And if you really need this feature, why not move to a more modern
kernel version?

thanks,

greg k-h

