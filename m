Return-Path: <bpf+bounces-30881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78528D41B7
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 01:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E031284B1F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A970200108;
	Wed, 29 May 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoaYEvih"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A2F1CB32A
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024233; cv=none; b=MbODNNWHYznFVkHOVZwvIEx1bemliXUQMKpS64A1LHDE8s0mFvzrlv2pVCGNdf+wBu+NRmyyVFy0pJjrfulLN6Ao0yXC+AsVtsjmX2jnxbcmvHluTyTj5Gb+5HDu+alfonk5ejkpLeGDBnVkF8+z7KiqHcUvWFiiE4oeeHhXFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024233; c=relaxed/simple;
	bh=oZ+K9mnzTX1al1A0UWb/vGewEoLIhLC7Xx9Q3yZ97wE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V7ZYdpWWAMuqraukGwinFGOi7zsC1ZrrKtqcfP8zwxiDMe/zpxJyv8gf0wFVzKLa6tjxLgdF8nB3xptuzbV+MuRDOdA0IqYiK90M/mmQIytJAXioWRaYotEfcn8tAPp7aSmtgRM6TxfzN6uiYyhBuNV5vwJ1vCX90bPM4Tepfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoaYEvih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 332DEC32781;
	Wed, 29 May 2024 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717024233;
	bh=oZ+K9mnzTX1al1A0UWb/vGewEoLIhLC7Xx9Q3yZ97wE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VoaYEvih3sQMcBUeMQ8GxEEo1jHSKFBqsnB5a0buzF6Ow07iX3NuJvuD28qSr85Ap
	 dnFX4i5g/+HaIVBooyHycYlwh/LRfAQy6vNI8Dw5pozpb0HuYi1Kgy0ydpHUDhME8o
	 TWrPnIoZUkmbvu0FvHWCu+6K/KgqoPPV+Zv1ogFBv1hDCD3EcJvbL+SHhgu9KUPSNz
	 pkoB4JYLth7Uhwm0+Gb/bWlNqTrvC0bQwrafk7PG3+rYLvgvgNhiEiPvMvT8Y3SkK9
	 fXExVwCMXdOvOjdwQBIuj58CF0rIV/BRiQklFAp0s2QwLy/WeEmOzDvAFSnRIdRv3d
	 gLQLSicVh1VxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20B60D40190;
	Wed, 29 May 2024 23:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 bpf-next 0/2] bpf: Add a generic bits iterator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171702423312.8806.1119954273185117827.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 23:10:33 +0000
References: <20240517023034.48138-1-laoar.shao@gmail.com>
In-Reply-To: <20240517023034.48138-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 17 May 2024 10:30:32 +0800 you wrote:
> Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
> added for the new bpf_iter_bits functionality. These kfuncs enable the
> iteration of the bits from a given address and a given number of bits.
> 
> - bpf_iter_bits_new
>   Initialize a new bits iterator for a given memory area. Due to the
>   limitation of bpf memalloc, the max number of bits to be iterated
>   over is (4096 * 8).
> - bpf_iter_bits_next
>   Get the next bit in a bpf_iter_bits
> - bpf_iter_bits_destroy
>   Destroy a bpf_iter_bits
> 
> [...]

Here is the summary with links:
  - [v8,bpf-next,1/2] bpf: Add bits iterator
    https://git.kernel.org/bpf/bpf-next/c/4665415975b0
  - [v8,bpf-next,2/2] selftests/bpf: Add selftest for bits iter
    https://git.kernel.org/bpf/bpf-next/c/6ba7acdb93b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



