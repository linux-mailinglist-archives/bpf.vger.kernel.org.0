Return-Path: <bpf+bounces-42580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C49A5D8B
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42CF1F21975
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 07:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9691E0DF3;
	Mon, 21 Oct 2024 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW5CK+u9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F231E0E03;
	Mon, 21 Oct 2024 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497021; cv=none; b=rAfekjDghBIZfLbSWSWP0BHEKhnm6qNdCIM42j4C+pJCGZyScl+QKSKahFldSAZGfhkGyo5+HmucUG8iY+zr2ZA07spy3vTx5DmsgLKbBLqkiOZzVgz1X4JnXHxhWGCSfxCthjbheTgad6EdxWAim7vVKAQG8B1B2+AGDuognpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497021; c=relaxed/simple;
	bh=fMXZNDhTJ3a25vRC03OitapOcwZERwIMfCZMvNGOYoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FjkZXLMOOI52UXMuzCdi5YX+ctqOu7euDUXucdqYldbP/vgnjurkwU9uBJgL192yEyS4ECHf7XR1RF8h7+CauHAGRqiMjbiZfdg52n4K/F2UWuWMXUQCOHif48mMrCdh+ZxGPhFCiuzV3qMz8ZwqR4k8d7FI9aN9Y3fEZtoqhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW5CK+u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C637C4CEC3;
	Mon, 21 Oct 2024 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729497021;
	bh=fMXZNDhTJ3a25vRC03OitapOcwZERwIMfCZMvNGOYoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cW5CK+u9HeccA9BXIEya4aZPkPCNdPjJZDSPP0cGi0gqzgqebmWpTaCC17hbbHfDq
	 N/6Bvo5QjvbHF8lisFuMnbREvQkXJqDBDOSpK4whMIOmjMTtHtOkXm09toY+GbaNjG
	 dyAmNe2/JaOxcHQsHRUkAgfPg/YJowR+1NTHMSM3D6TBX8vUlSfVb/GTROpegbH15N
	 19o7IGBfIuDT5IdSBq+I9wHmuwZLjp0YPy0IegRprD+d+FmT3d7PXWWaxSkwYdaEn6
	 Bl8NZXHk45z1o3lssg1dnYcsDnGAeN5XxF8gFfm+GqyC+8cHLwG7vf0FV4hL7RTke6
	 Q2opLBf4ewpzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2C3809A8A;
	Mon, 21 Oct 2024 07:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, arm64: Fix address emission with tag-based KASAN enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172949702701.158018.10159023960239041535.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 07:50:27 +0000
References: <20241018221644.3240898-1-pcc@google.com>
In-Reply-To: <20241018221644.3240898-1-pcc@google.com>
To: Peter Collingbourne <pcc@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay12@gmail.com,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 jean-philippe@linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 glider@google.com, andreyknvl@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 18 Oct 2024 15:16:43 -0700 you wrote:
> When BPF_TRAMP_F_CALL_ORIG is enabled, the address of a bpf_tramp_image
> struct on the stack is passed during the size calculation pass and
> an address on the heap is passed during code generation. This may
> cause a heap buffer overflow if the heap address is tagged because
> emit_a64_mov_i64() will emit longer code than it did during the size
> calculation pass. The same problem could occur without tag-based
> KASAN if one of the 16-bit words of the stack address happened to
> be all-ones during the size calculation pass. Fix the problem by
> assuming the worst case (4 instructions) when calculating the size
> of the bpf_tramp_image address emission.
> 
> [...]

Here is the summary with links:
  - bpf, arm64: Fix address emission with tag-based KASAN enabled
    https://git.kernel.org/bpf/bpf/c/a552e2ef5fd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



