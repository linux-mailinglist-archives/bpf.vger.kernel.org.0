Return-Path: <bpf+bounces-41178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7EE993D84
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8FCB22DA3
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE9433A4;
	Tue,  8 Oct 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHzGXz+1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29A7603F;
	Tue,  8 Oct 2024 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358231; cv=none; b=EAxgphZU4ObsNpclfkFaCuIxleC0AKWh/xZRfNU7ESMAc3d48QG13tM8M4Je87h7lfTFfNjO0KgJ3dNWPdg51pKJ+e+40ZB8pBK2iYi1u0bi5siKc8TXh57L8Xdt4SeAmfmHCY++N6nEkxyxCWLVHSprCw2JXALdy93s7rqAHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358231; c=relaxed/simple;
	bh=GTnjCrymSNQfyPUDUI8WO+5RJXYknpZl8hcqnd3geZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hbyU6g3ICiKD4UWPbittiv/K4v871OlnN/P14v8RsBIccS33E+9YF3E3nPp3TfmkHMXKXbfSnog6v5dBJ/f01dyuOd79YtskQKj4uXNv99aYraD4VI31ljWj2LUUDaugmlWtmbQZQhcF4p3gKwzcPbsSKySzoQUFpBf+T7u/l5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHzGXz+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9653CC4CECC;
	Tue,  8 Oct 2024 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728358230;
	bh=GTnjCrymSNQfyPUDUI8WO+5RJXYknpZl8hcqnd3geZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MHzGXz+1QxCQh0f7Gv2ra6skqnJCFeWF/XYDz4xOBnbuFW50u6LmqRZKsURrCyzaR
	 JQY4AlK8wbLRk57feKjBYKQLLoEDal6IpYgS+u+Y1lwxs0uHCOzAJmVZxBvXJZeYKV
	 G1Ssx/BE15rhyJI08zySpdjZ4jJSwbhQXs6T+FVIgFPpvtvFs+zYT0vmfIMYQwlscw
	 EKbrYZawxFzBCeLWg0RpA4oFQjWLTb0WbuUDLenbmHLEg75CJBeV0ymnIHmKKZMoEk
	 7QnEqAxUdMODgAEzoph8yBR/udAJMqwmls0lJstF0xi/8qjJRLPFJLcZ8J4ljG/zd1
	 AMvudzN5a3A5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB42F3803262;
	Tue,  8 Oct 2024 03:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] BPF static linker: fix linking duplicate
 extern functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172835823448.66789.7596290486651516596.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 03:30:34 +0000
References: <20241002-libbpf-dup-extern-funcs-v4-0-560eb460ff90@hack3r.moe>
In-Reply-To: <20241002-libbpf-dup-extern-funcs-v4-0-560eb460ff90@hack3r.moe>
To: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 netdev@vger.kernel.org, i@hack3r.moe

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 02 Oct 2024 14:25:05 +0800 you wrote:
> Currently, if `bpftool gen object` tries to link two objects that
> contains the same extern function prototype, libbpf will try to get
> their (non-existent) size by calling bpf__resolve_size like extern
> variables and fail with:
> 
> 	libbpf: global 'whatever': failed to resolve size of underlying type: -22
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] libbpf: do not resolve size on duplicate FUNCs
    https://git.kernel.org/bpf/bpf-next/c/4b146e95da87
  - [bpf-next,v4,2/2] selftests/bpf: test linking with duplicate extern functions
    https://git.kernel.org/bpf/bpf-next/c/3c591de28543

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



