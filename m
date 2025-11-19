Return-Path: <bpf+bounces-75017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE462C6C228
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 01:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 733112C5ED
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF261DF27F;
	Wed, 19 Nov 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeOzBcdb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB9513D891;
	Wed, 19 Nov 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512250; cv=none; b=ZnqSYfTzaWqi0/rqB7fYgKOMZ0jeXmyijAv6deiseeS8R9OZ/wgtAv6vvF8wyc0ENjT4bJqwfIOYExQqs/+wNaLh56+v5GmEM+wj0uw5D7fOu1+n6qPl//afNyc6AP6wU5czAd86fXF/Fqjqpy5tPyULpfodhwsCMcQDYS18I6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512250; c=relaxed/simple;
	bh=jJrVAPzCdiRtfgezaX7MvBOr9eNzWAqSUxcyKGMn8B0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r40NpZre/y1YVWCQhiXeRCT88Bx25y/DDMcXSb6AVpu7WtPhQHKBXXasEV5xuYVpdjdBC1F9Ox1DzsaUmnULwsUzr9Q1/FeO89rhTldGzldlM8YejBiKSwvUPtVIGkdNmVG/35vbQXcyWtD26VM3dZumciljhcSOGbi87qirV+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeOzBcdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E05C16AAE;
	Wed, 19 Nov 2025 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763512247;
	bh=jJrVAPzCdiRtfgezaX7MvBOr9eNzWAqSUxcyKGMn8B0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MeOzBcdbIcCbAxsSlurZSeJNjBli6zg261tWM4qHlefa+w8Hmyyy0X2em99W519WV
	 8algJkBKVLcl++yLYKHfP0AB9UMtgWoJf8G4zkutlChrIDf0WPSN7x3f/8Zz6En7gS
	 CApKKCDBvswiFRAWqmOUDnPYzIcaPC1w5WazAUOnpIZBmdNo1FUGMkiJ0PSOHJHvoM
	 sXmYswRYPLekQkshC0Jhb4MkX/Oclwq8OHvAdDsxlBfW5JT2LwkMAE1tAMIsj86bST
	 /T1zISLap2pHgTbDCNOd57lMpt9UlbmnFY9YjZTid+fImngoRbvhBYaqBP6gGXqcZ2
	 Q01bIIhii4RMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E25380A94B;
	Wed, 19 Nov 2025 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] Replace BPF memory allocator with
 kmalloc_nolock() in local storage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176351221301.159336.2037240417385610881.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 00:30:13 +0000
References: <20251114201329.3275875-1-ameryhung@gmail.com>
In-Reply-To: <20251114201329.3275875-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 memxor@gmail.com, kpsingh@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 14 Nov 2025 12:13:22 -0800 you wrote:
> Hi,
> 
> This patchset tries to simplify bpf_local_storage.c by adopting
> kmalloc_nolock(). This removes memory preallocation and reduces the
> dependency of smap in bpf_selem_free() and bpf_local_storage_free().
> The later will simplify a future refactor that replaces
> local_storage->lock and b->lock [1].
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] bpf: Always charge/uncharge memory when allocating/unlinking storage elements
    https://git.kernel.org/bpf/bpf-next/c/0e854e553569
  - [v2,bpf-next,2/4] bpf: Remove smap argument from bpf_selem_free()
    https://git.kernel.org/bpf/bpf-next/c/e76a33e1c718
  - [v2,bpf-next,3/4] bpf: Save memory alloction info in bpf_local_storage
    https://git.kernel.org/bpf/bpf-next/c/39a460c4253e
  - [v2,bpf-next,4/4] bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage
    https://git.kernel.org/bpf/bpf-next/c/f484f4a3e058

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



