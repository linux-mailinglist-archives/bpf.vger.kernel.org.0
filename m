Return-Path: <bpf+bounces-28283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303038B7F9E
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99E61F2494C
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2421836C8;
	Tue, 30 Apr 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPQcfOxV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA89181B9D;
	Tue, 30 Apr 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501231; cv=none; b=HEdPbVQ5s6ePAOoQfYv6aXt/bE27adGYpLDCir+H4vQs6vI9CDBJop4Yw8AL3SIHVXTlIxoawKGCaAlPE/zAdmrfjdlVJebb+YFLJvIBs4RomHpSAf39WgehbeQDaUdUspCtzsRnEQZVA33Q8ohVwVWuNr/FL1lMFwkELq4gWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501231; c=relaxed/simple;
	bh=Gph9OZJ5MSqO5n8WVm+N4eurk/Ndi7bUW37HdqdrJmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oGucj++bYtPzyxzGoWEm+ZUD8LsMTs5Ls155HMwanXzXRq8cyzcxYdrRE+pvsVUwaN8+LG/n3lkqfMAaIE3fY82x+fgCvVzhDJujV/9WHk8VxxuUCeFovpAOyXEn8Ys5z5IgORWDI9RM5RXLfq09kMJKxkpkFF9JjVbhXcqZrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPQcfOxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A46BCC4AF17;
	Tue, 30 Apr 2024 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714501230;
	bh=Gph9OZJ5MSqO5n8WVm+N4eurk/Ndi7bUW37HdqdrJmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GPQcfOxVJ4OLGs5mFhfGXL0EyeKwMdLcSSUQ4y17/Iy1jYVGaknKBmCi/7dldoCy9
	 i4WU5zRgvXUAcwjE8UUB+xeYNN5CvwbKvtQecaE9pJwUjHmXvA03rgFqqsMO6dqBP1
	 uy9ZyHpQOxhT8xTW+86U1WlEH+QicFSUgKtrI6x/96Yu+Afh5LKDj06VoSjzH+L4Kl
	 Pqe0D5S4B/+VUSwlQxIjZUX+c4hMZEPb/vuUSYtXM5pAeghY4Xjzz+7doeKs6f8YXy
	 D1fgzSZi8YM66mP/fOwEXBdTVKuwVAwyf3T4H3rmp/5AxNrExyRut5SOn2BT2fj91D
	 P2XDCfzauekkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B7EAC43616;
	Tue, 30 Apr 2024 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171450123056.11426.7177996325592706387.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 18:20:30 +0000
References: <20240426231621.2716876-1-sdf@google.com>
In-Reply-To: <20240426231621.2716876-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 26 Apr 2024 16:16:17 -0700 you wrote:
> Syzkaller found a case where it's possible to attach cgroup_skb program
> to the sockopt hooks. Apparently it's currently possible to do that,
> but only when using BPF_LINK_CREATE API. The first patch in the series
> has more info on why that happens.
> 
> Stanislav Fomichev (3):
>   bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in
>     BPF_LINK_CREATE
>   selftests/bpf: Extend sockopt tests to use BPF_LINK_CREATE
>   selftests/bpf: Add sockopt case to verify prog_type
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE
    https://git.kernel.org/bpf/bpf/c/543576ec15b1
  - [bpf,2/3] selftests/bpf: Extend sockopt tests to use BPF_LINK_CREATE
    https://git.kernel.org/bpf/bpf/c/d70b2660e75b
  - [bpf,3/3] selftests/bpf: Add sockopt case to verify prog_type
    https://git.kernel.org/bpf/bpf/c/095ddb501b39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



