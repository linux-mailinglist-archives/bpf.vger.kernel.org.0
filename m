Return-Path: <bpf+bounces-41176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28FB993D7D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F008283AD9
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664A3FB9F;
	Tue,  8 Oct 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXq3T64K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82D38F82
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358228; cv=none; b=tFeYjv2RMeBiqtbR2Eyb1OBUdCwonaxgI6vlm0z/9jObIcZDNNyhRkRi8J2xeEobkFtx34W1LqEsh4Z8HDJqPEBHBqEPc7tHpfccKGji5La7T5vGk8RhntO5/TpY3h3zmuqll740OgLaABE6qy1e+dX8epMfMPyvR+57bINkCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358228; c=relaxed/simple;
	bh=5KUdm2258iJ0ke+PGoUI6M3OZsLe0dVrR+5Cb/SXZKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KYYdz9n00byOr1uok/ughPIqg2Yb/JAECMpJYst+2g5Ie9QUmC8TYu/WUifBeGP4C3evGdYenWbWgyAYds7MeaPE8xlnR7rsSAPpadNTXrvj+e0I84anbZw0P36BIbpOtk9EOuK5LAN8nMAmSkQQArAj68qBJp5+Fe7u/k4Ta7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXq3T64K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1234C4CEC6;
	Tue,  8 Oct 2024 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728358227;
	bh=5KUdm2258iJ0ke+PGoUI6M3OZsLe0dVrR+5Cb/SXZKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uXq3T64K8h7AzETPCzyFn9jfSXUkupnp8mKA94C5qMKRLe+OrVNmsCqydxyY26TGJ
	 QuMrHMmja+0dXCojm4Xe2jnHhKDIyDeGZ2Ac/eITjRESOsL277305gx8krM3N498fC
	 ALuMiG2JS/y5SPPstJtDsM3tZhA/z6xqAo7d1k1Twe1AfRT1wuv9v6PIQhlMPIixoS
	 AyWtbqt+uvg2MujIZw3cpQHASlq5EXT54XRNhqeg6L1LHQR7ytTqIHCygomo8NpPls
	 DIN6nvwybzd9Ms/fIqWoWkQzlifJF7s3Q85RwumSsv6lHAvMT/mqwodvyuSG+JgJ5R
	 i2gbUaW7tWzbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16C3803262;
	Tue,  8 Oct 2024 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: syscall_nrs: disable no previous prototype
 warnning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172835823174.66789.8286250638359363782.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 03:30:31 +0000
References: <20241001233242.98679-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241001233242.98679-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 andrii.nakryiko@gmail.com, kernelxing@tencent.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  2 Oct 2024 07:32:42 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In some environments (gcc treated as error in W=1, which is default), if we
> make -C samples/bpf/, it will be stopped because of
> "no previous prototype" error like this:
> 
>   ../samples/bpf/syscall_nrs.c:7:6:
>   error: no previous prototype for ‘syscall_defines’ [-Werror=missing-prototypes]
>    void syscall_defines(void)
>         ^~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: syscall_nrs: disable no previous prototype warnning
    https://git.kernel.org/bpf/bpf-next/c/c50fc1cbfd71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



