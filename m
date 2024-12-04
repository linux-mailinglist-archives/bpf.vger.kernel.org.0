Return-Path: <bpf+bounces-46084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4F9E400E
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2D283639
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3720CCD2;
	Wed,  4 Dec 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVjn0MxO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC220C474
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331021; cv=none; b=Z+03fk8He09CtiJM1nbjSzfX5OctA1JZkjpV60DZqnOapo6Pb8NiBxKpW6BOcaYh2c5sbZa0Gd3xM9ur39CNXrwOSY9W1JxRP2ZxTlobtNb7Zj1tAN4K9qmQiZKQ0vNeZQU+wfAFB66kfTxmay6/K8eZWsWptAZ7CA2F2A4OT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331021; c=relaxed/simple;
	bh=vp+gJBUVFC+nVaMd5CAqxUuQnkmdHeRuxXHHLwzWvME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U9xgVwpAA9LmWddQYtUQ9un6x2xl+V1vpBNih4YkosHQuwaJQpILrror1EldjSRrs0zvK3uW/FtAIXk8Pc2ci/zR8lci7U/74DASHcuX2Hv+nEAwX6DP1ftC9rYP6YPVPBxOPnW2qEN4G1Ulr7hxa4Oi+gUqi6rF48FV6SRXX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVjn0MxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD93C4CECD;
	Wed,  4 Dec 2024 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331019;
	bh=vp+gJBUVFC+nVaMd5CAqxUuQnkmdHeRuxXHHLwzWvME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sVjn0MxONOOXe4r/tLk5yS026wtfJmeawzQJsUEamNTjva+6uEevgq1JuZ/iXuz4t
	 csxawzLsIBzT1QalvgSjkZzMB0YBG1dznE8AF/i6mudYzKcviP+royS6sfwKvB9ljf
	 e/dfG/MeF5C3KcpBopWrAJLorsMz14CsU9ohgHTNVWl/Yt9NOcCzlbaUVQ+22Pg/6t
	 p0peiMT4pFjE18rdJZH5nIJ0Dit9tNZJIxDLnqMkV0nkLEnxjCTKmwID8VCuZWTE9C
	 IE7Wh+DmMS7Vv3rWCa73mWn9vuxTsIeHJzVzmwdOVvUZqDq9LMn/RvcK2smW74tE6w
	 ommCBfRPS6TCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3413B3806658;
	Wed,  4 Dec 2024 16:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/7] IRQ save/restore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173333103407.1261085.15986829219846341808.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 16:50:34 +0000
References: <20241204030400.208005-1-memxor@gmail.com>
In-Reply-To: <20241204030400.208005-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Dec 2024 19:03:53 -0800 you wrote:
> This set introduces support for managing IRQ state from BPF programs.
> Two new kfuncs, bpf_local_irq_save, and bpf_local_irq_restore are
> introduced to enable this functionality.
> 
> Intended use cases are writing IRQ safe data structures (e.g. memory
> allocator) in BPF programs natively, and use in new spin locking
> primitives intended to be introduced in the next few weeks.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/7] bpf: Consolidate locks and reference state in verifier state
    https://git.kernel.org/bpf/bpf-next/c/1995edc5f908
  - [bpf-next,v6,2/7] bpf: Refactor {acquire,release}_reference_state
    https://git.kernel.org/bpf/bpf-next/c/769b0f1c8214
  - [bpf-next,v6,3/7] bpf: Refactor mark_{dynptr,iter}_read
    https://git.kernel.org/bpf/bpf-next/c/b79f5f54e1dc
  - [bpf-next,v6,4/7] bpf: Introduce support for bpf_local_irq_{save,restore}
    https://git.kernel.org/bpf/bpf-next/c/c8e2ee1f3df0
  - [bpf-next,v6,5/7] bpf: Improve verifier log for resource leak on exit
    https://git.kernel.org/bpf/bpf-next/c/cbd8730aea8d
  - [bpf-next,v6,6/7] selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
    https://git.kernel.org/bpf/bpf-next/c/e8c6c80b76e5
  - [bpf-next,v6,7/7] selftests/bpf: Add IRQ save/restore tests
    https://git.kernel.org/bpf/bpf-next/c/4fec4c22f046

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



