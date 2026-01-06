Return-Path: <bpf+bounces-77923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48CCF6B94
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 06:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1493036CA4
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 05:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8682DF138;
	Tue,  6 Jan 2026 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT/6EEeI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A324503B;
	Tue,  6 Jan 2026 05:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767675813; cv=none; b=ATc7jsaMysGC/aZPob6fws+bYdoeRn2PgooTnaO9gaPOMnNIlmsBoNrdHd02UectrslxpKRI7bjur0rM58oVm1komIrlayKSRu+QxGzg8/LLDTt2NsYL0LHxusRDPV8A892hz5wRVbxWDxGE+SjBKk+2meYTsxpr1igigFtPpiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767675813; c=relaxed/simple;
	bh=JvnsPFzgdpuJbwNkNOh7OjJ5Da6sHmBA8uij6Y+5XGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VX9kzuZMFqEnVJ3Ztwv/D+beohDrSqd1lnq8rS90qdDdeWNQ0VxoGB9GZrvZPIz4eBdqSyjZvms0ikVuGvx0LEYp5BQT1mjyGWKe1PXMPII24i4ql9+dgv88rC9Rvy+8utzSqcd+C615nMjub/qq2nQauFzOk6QDzD+Bz0JaOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT/6EEeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1669C116C6;
	Tue,  6 Jan 2026 05:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767675812;
	bh=JvnsPFzgdpuJbwNkNOh7OjJ5Da6sHmBA8uij6Y+5XGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CT/6EEeI/nkYrnOfqMzybUOr3yT9jLjNv8kdex6higPXsuuWsSQITytU3RVx1kDwA
	 hc6bqh2gxysqsmPpEvnGYDlfbyFhPbX7lgoLHioLyid5TRYhHxZDuIbmshJ5qv1xxo
	 4CStB15d5SdMuMaaeanQGt3USu7+GA6DmPoQ42QYT3X5ZLKstzk/03jirLcQXNqNAB
	 VjO6YvPt++Kn8cim4Uub9QFAkCeYl3dbepJ97y0PMoOCCv+9Mx13+EBGzoJoaP+HQq
	 gPXshDc1DLV4BP9bAXmU1RRqKpWO3wCTy+RN2pf2czkRnHAoKNmhITQPwUAreoeOmo
	 ugoUla7xa+vkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B64380AAD0;
	Tue,  6 Jan 2026 05:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] mm: drop mem_cgroup_usage() declaration from
 memcontrol.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176767561079.1822645.1463406009745390513.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 05:00:10 +0000
References: <20260106042313.140256-1-roman.gushchin@linux.dev>
In-Reply-To: <20260106042313.140256-1-roman.gushchin@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: alexei.starovoitov@gmail.com, sfr@canb.auug.org.au, daniel@iogearbox.net,
 andrii@kernel.org, akpm@linux-foundation.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 Jan 2026 20:23:13 -0800 you wrote:
> mem_cgroup_usage() is not used outside of memcg-v1 code,
> the declaration was added by a mistake.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/memcontrol.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] mm: drop mem_cgroup_usage() declaration from memcontrol.h
    https://git.kernel.org/bpf/bpf-next/c/ea180ffbd27c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



