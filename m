Return-Path: <bpf+bounces-21159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749CC848FDB
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A787C1C20FA0
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA3A24A0D;
	Sun,  4 Feb 2024 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XF7Kx1tL"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5323755
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707070259; cv=none; b=myYF9Utzc8yHoBq3vAwfV5vQINPkbWK6mttgcPtfsbl15wXMymqPlnzJN9tSa/WIUc7X/nuySaYRLBS66bsg7P/KM3hw3YRY2r1G5XX6eL5GBpCUjd+U+UiLRnBdMq+eF5b3CmDRte/XdcbjGTDDqZ5w93jCppPLX/uUUfe0Uv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707070259; c=relaxed/simple;
	bh=hP0Ll959tT8Te+dyQQNc1DXup/dUvQLfx4r90vM0POQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMC7jDObCDloE4rAYYcSBi1K2Gak3QfOwB2tS7RhtOX+MG8vUsE4QmBLsfjFyfkl1lrFirBWOCqn131OTocteQL2NK4Xbr5de9p7XYQXK6FgJI51W8+c8ui0nhQ5F8JWdPIwpcMxO/FIAAHp2MBHO79hVbY2KizXPHSudm8FGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XF7Kx1tL; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25615f41-a725-4276-bc0a-a3e7fe47b864@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707070255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iz4PfovZcdeRAA9dKaW7fvX3NpdAJ0oqEaz5XE4ra+A=;
	b=XF7Kx1tLk0sYZATKNXag1AGwdRKhrtoIPRcN01AKLdUJ+5e2NvgoavK6ZKdlrZMlMx+fdh
	Jaribgjke2QvFGGBX0t2TSgsXPa5aj0MLh1s0SdGlBfuzABtwYHpEydrI5kWKUnLafn+Eg
	PRhXrlgM+jGmjBaBjnGfyFg9yug/CRY=
Date: Sun, 4 Feb 2024 10:10:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: merge two CONFIG_BPF entries
Content-Language: en-GB
To: Masahiro Yamada <masahiroy@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, linux-kernel@vger.kernel.org
References: <20240204075634.32969-1-masahiroy@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240204075634.32969-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/3/24 11:56 PM, Masahiro Yamada wrote:
> 'config BPF' exists in both init/Kconfig and kernel/bpf/Kconfig.
>
> Commit b24abcff918a ("bpf, kconfig: Add consolidated menu entry for bpf
> with core options") added the second one to kernel/bpf/Kconfig instead
> of moving the existing one.
>
> Merge them together.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>   init/Kconfig       | 5 -----
>   kernel/bpf/Kconfig | 1 +
>   2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 8d4e836e1b6b..46ccad83a664 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1457,11 +1457,6 @@ config SYSCTL_ARCH_UNALIGN_ALLOW
>   config HAVE_PCSPKR_PLATFORM
>   	bool
>   
> -# interpreter that classic socket filters depend on
> -config BPF
> -	bool
> -	select CRYPTO_LIB_SHA1
> -
>   menuconfig EXPERT
>   	bool "Configure standard kernel features (expert users)"
>   	# Unhide debug options, to make the on-by-default options visible
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index 6a906ff93006..bc25f5098a25 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -3,6 +3,7 @@
>   # BPF interpreter that, for example, classic socket filters depend on.
>   config BPF
>   	bool
> +	select CRYPTO_LIB_SHA1

Currently, the kernel/bpf directory is guarded with CONFIG_BPF
   obj-$(CONFIG_BPF) += bpf/
in kernel/bpf/Makefile.

Your patch probably works since there are lots of some other BPF related
configurations which requires CONFIG_BPF. But maybe we sould
keep 'config BPF' in init/Kconfig and remove 'config BPF'
in kernel/bpf/Kconfig. This will be less confusing?

>   
>   # Used by archs to tell that they support BPF JIT compiler plus which
>   # flavour. Only one of the two can be selected for a specific arch since

