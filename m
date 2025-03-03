Return-Path: <bpf+bounces-53002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F25A4B61E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 03:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451CB16A892
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E9185E4A;
	Mon,  3 Mar 2025 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgUAJaJN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C3155336;
	Mon,  3 Mar 2025 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740969002; cv=none; b=J+4DSOCDbbN8HSX4Fk2LLaluEM8I2jthuJebwGUWaVct3WMYys7XiSPShmDevvwuQhVtEVy48+XDjbq0wf2jB2I14ldksk7yboAxcFI+O4KPysxz9sUCZv4MFVew7fnU/I418tArl990wOVKRiLBmcibxEJ907qlnlVojp6tdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740969002; c=relaxed/simple;
	bh=gYDv6VHFzCh/bELt4lBENpI5/5kEzpS/cYqmU/2T7Gg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2BJDSjfZ0ELKH9ohy/TJ6GAAdj1DvDaXArjfXRLVJRXSFgCL7DLN/R9sNdpckwSIp4jGXc9d4rlPS7R+AKVWnfTfuXdRNzuVQYdY9chlZMm0R/AKPdWVjB4pxHvsadY9D5QeeNndJnA2UTSm5MdIHUHQRflqEa7xlCGIPaz5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgUAJaJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BA0C4CED6;
	Mon,  3 Mar 2025 02:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740969001;
	bh=gYDv6VHFzCh/bELt4lBENpI5/5kEzpS/cYqmU/2T7Gg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qgUAJaJNYxz5Vn2foCmhoOsHyNp+LGTJtKZ/C73hUTd5b9Nx6K3RHg76SUIGweu9D
	 x9TnKDz0V+1gWtMww2JsKQoqCBaktE0CquDY9sZKGKSfo7zZmnzS4g/bRZaokklzGa
	 sblFLl7chmi71QK7nsl6/HyKqZEGPFLLD0OArN2BGtQwuO7CcvGAkf7NCCxTrsiwxL
	 BWW/prisrc5YXBMd2VHyfF1Vgm6cLyv7L6HgRhfSNOsQDEFRM3NAEdy0jN3X+aXFOV
	 Q5c/UMb4cA2hwOEAy9quOQEuLnrVjRAUn7ehz+qKy91eeBiD0rKLrYjvl3QX92h59P
	 5TnWxYwO9DkEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7175C380CFE8;
	Mon,  3 Mar 2025 02:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: no longer acquire map_idr_lock in
 bpf_map_inc_not_zero()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174096903429.3067520.8581639829502148937.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 02:30:34 +0000
References: <20250301191315.1532629-1-edumazet@google.com>
In-Reply-To: <20250301191315.1532629-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, bpf@vger.kernel.org,
 eric.dumazet@gmail.com, kuifeng@meta.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  1 Mar 2025 19:13:15 +0000 you wrote:
> bpf_sk_storage_clone() is the only caller of bpf_map_inc_not_zero()
> and is holding rcu_read_lock().
> 
> map_idr_lock does not add any protection, just remove the cost
> for passive TCP flows.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kui-Feng Lee <kuifeng@meta.com>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: no longer acquire map_idr_lock in bpf_map_inc_not_zero()
    https://git.kernel.org/bpf/bpf-next/c/17a82ed98f62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



