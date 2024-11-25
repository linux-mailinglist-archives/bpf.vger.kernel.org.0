Return-Path: <bpf+bounces-45591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF209D8E6B
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E32CB235E6
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3471CD1ED;
	Mon, 25 Nov 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxS4fCYP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334E1BB6BC;
	Mon, 25 Nov 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573218; cv=none; b=LO6SMeLBzSPMh2ZsnxUejYJpT3EGAi9No6TTLqwM3T+aDYOds/vfK8BFGVRqDxFr/EA5o+59f9rrLCUfeH+PKEhHGYFK5Fv6P7fEYxSaUdGu+0QdOPf+tQpE2+bB2oedhGz1CrXF+hfbsioBuJ91pgr4eCNfBN3/cQgSINj8lyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573218; c=relaxed/simple;
	bh=7V3gZLX+JPgh4y37l0pGIiFyiCXlAjNpp65nPrfRZHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WVsGB01huM8vLCvF0jG//ITIkiZPA07uf3zCcx3RlWrBmVjyhatSuKvv8PM5NeKJvDxa7i/RWUOR0R0q0AiKA6iDmtozOZLlhJQaM+1I4gsHzAOe9L4qA6qMnYr7sNs8F7GCVwQq8cHqu027mwmeKKmDZgtQT8UGm9tHkQCCUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxS4fCYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B6AC4CECE;
	Mon, 25 Nov 2024 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732573216;
	bh=7V3gZLX+JPgh4y37l0pGIiFyiCXlAjNpp65nPrfRZHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WxS4fCYPKxm7HBvBllfZQ/Vou8kSjO1UcvjXz5+Gs7uvGoEF4FgVxDEpfDyX36HiG
	 NA4CE4jVR9Pr27gM4GGkbCtbfB36TvkyVkJyD2n4A04Tq7UTX3NFW/koG2S84NfgHt
	 s1m4/DO8Z90LxS21qJ7aGwQeAleCDiwCiyp5DExH/MeIbj5H7dNU6gCKG/31iZoHUB
	 QYXiVC5AdWKM1ItXuc2CB3cw8tVLHV5reqHT2+kz9yvjIOgey4YOoO8JMxgWwKeNMj
	 bNSUVybzRwka2TR1+TeAG0jqee23XEQwpuWbIa1usz9PT958K3BXVUJDZuHvdfECO8
	 JDVUVlfBxMp+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F0D3809A00;
	Mon, 25 Nov 2024 22:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf, lsm: Remove getlsmprop hooks BTF IDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257322926.4055688.17044385377572824899.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:20:29 +0000
References: <20241125-bpf_lsm_task_getsecid_obj-v2-1-c8395bde84e0@weissschuh.net>
In-Reply-To: <20241125-bpf_lsm_task_getsecid_obj-v2-1-c8395bde84e0@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
 jolsa@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, audit@vger.kernel.org,
 selinux@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 25 Nov 2024 20:53:07 +0100 you wrote:
> These hooks are not useful for BPF LSM currently.
> Furthermore a recent renaming introduced build warnings:
> 
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
> WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj
> 
> [...]

Here is the summary with links:
  - [v2] bpf, lsm: Remove getlsmprop hooks BTF IDs
    https://git.kernel.org/bpf/bpf/c/8618f5ffba4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



