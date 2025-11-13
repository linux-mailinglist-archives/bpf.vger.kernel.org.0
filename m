Return-Path: <bpf+bounces-74429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B38C59368
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C61A34A5E5
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993DD30AAD7;
	Thu, 13 Nov 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT2zvH4V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764022F0C68;
	Thu, 13 Nov 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055040; cv=none; b=FXSQxbTQzuwA4MJV/bk4f0WcLq2jwWcW4zz39/NFT1r4ZlTNQSwgayFFNgjo1eZW1gwDntJ5bfVtxZxdt4j6CrOK6bVCyG61EB0jByeM9LAe3L/OxxN7HTMzCzGvQqpA27MXJjWEZW2hierlGlIF1ZBztMM0TUbf9PzKizC5MHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055040; c=relaxed/simple;
	bh=IsyoqrzoCOJp9rocvy9Us55RNkvt8nivVRqFjtj1iV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R+VcP6MDRRyDtpbG3JhkvPeIBt6k69JySB1OwmW0F4TY+8CK+RV5uYnwpzCqEDGcmTW/VTRg5oe04KRdaoKss9Frprogjj/whNh67wRdSgRNDcC2Mzb/DYFAKjVryF7FBB8AP85LYoTQWSXQ9D4ejBCOm+LQsw7d/snhiJqsBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT2zvH4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF18C113D0;
	Thu, 13 Nov 2025 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763055039;
	bh=IsyoqrzoCOJp9rocvy9Us55RNkvt8nivVRqFjtj1iV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lT2zvH4VWtI3w+IBNwgFo9yXYEW2ce1kOtA6vPEm9zkSMCG5a4ZWMVwEYgOwNdZ7T
	 vFG6TKoHuO09SWT8oExIGO+A5zXSKZk1JOAmrTLGx/r9zJOlSKGXylNvrPQjiJuseT
	 G5Fn3niOW/Dp2RCESlNeuL9PRWuyUmhchHO/ykbSapO63ZKZxp4WiKKUuEtCl7ZiYG
	 Zs9pf7Z264ph0y8fEBHK5CRDuAhjF/lyTQ8sfFXrav3oXYvYAhAklVDVSkZzxzwSXV
	 2Kcqpi3z9hMnrwGxD6G6JhzIp+P0v6p6BQi37MIWeSKi8y7IIDA0InRVTywUalLFl7
	 IOvcvgVoOm4vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF5E3A54999;
	Thu, 13 Nov 2025 17:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Free special fields when update
 [lru_,]percpu_hash maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176305500875.938410.4075435196303800400.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 17:30:08 +0000
References: <20251105151407.12723-1-leon.hwang@linux.dev>
In-Reply-To: <20251105151407.12723-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, ameryhung@gmail.com, linux-kernel@vger.kernel.org,
 kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Nov 2025 23:14:05 +0800 you wrote:
> In the discussion thread
> "[PATCH bpf-next v9 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps"[1],
> it was pointed out that missing calls to bpf_obj_free_fields() could
> lead to memory leaks.
> 
> A selftest was added to confirm that this is indeed a real issue - the
> refcount of BPF_KPTR_REF field is not decremented when
> bpf_obj_free_fields() is missing after copy_map_value[,_long]().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpf: Free special fields when update [lru_,]percpu_hash maps
    https://git.kernel.org/bpf/bpf-next/c/6af6e49a76c9
  - [bpf-next,v6,2/2] selftests/bpf: Add test to verify freeing the special fields when update [lru_,]percpu_hash maps
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



