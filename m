Return-Path: <bpf+bounces-61770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FABAEBFA5
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 21:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B25A18877A3
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ACD205513;
	Fri, 27 Jun 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjdhPNiL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F4200110
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051980; cv=none; b=h6GW2FRCrlogeBC8XvUgTjixGJJIkVSw1DfmjILgr5ExeysbwAv+ik7pfM4PRILxCvSRNrqlRC4E8VURnk7iV3Ic4YamQis1eZiZIzx9WImpGDSABtm6bsRvyxIA0Yhz71s2YdXOU/tTzleobeb2UPHp0c0NHJaD20VScw895o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051980; c=relaxed/simple;
	bh=OEaUmnzwIbzH75QW+1Ff5rUTfci38reIsXIb84NXJhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ap4B9kXI/ZN8ASBqHPX6BuXED/ZE2iN7Oi92jYQpccH8iEcjuAprDD4+YtY0ucY6w2wk0djIB63y8ar47eysF7CX0kLeJb/LpLASzldK15ros3qFPcPE6kUNBfOhCK+2HwOp9kumaXfsinqMsk3NAFxRLaLeqsd0+y9833MCq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjdhPNiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F84C4CEE3;
	Fri, 27 Jun 2025 19:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751051980;
	bh=OEaUmnzwIbzH75QW+1Ff5rUTfci38reIsXIb84NXJhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HjdhPNiLB9lWx+a+W21hrn3uZO85fHl2ULrtclJgxrvsvK88yP9N7sahxbkmbtast
	 KkERK9RHR/YrtAAU150DkRPkYO9xz1sfDCAk44dHRsbAjmfTsf9rfcWaA6srBbWJQn
	 Y5A8+C5jNNezLUzwlMebnPBm35m9LRHivyC43IkIzJWg91n57h6bdftm8BU0NytdGm
	 VQOUwWwJMBpH6q+7CxQp8p3mWSaYj0peL7uKjrPovc14luWCFiTFkiVdfVwJAWU4A5
	 KJ6qZYCnnokYFEXbAIaBEzjRquNprpuNZH00SUSckmgrk/AY5xE85nFsrIXBRLJgXF
	 begbAMeBQ8ppA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0038111CE;
	Fri, 27 Jun 2025 19:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: guard
 BTF_ID_FLAGS(bpf_cgroup_read_xattr)
 with CONFIG_BPF_LSM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175105200626.2030127.11475475906116679170.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 19:20:06 +0000
References: <20250627175309.2710973-1-eddyz87@gmail.com>
In-Reply-To: <20250627175309.2710973-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, song@kernel.org, jakehillion@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Jun 2025 10:53:09 -0700 you wrote:
> Function bpf_cgroup_read_xattr is defined in fs/bpf_fs_kfuncs.c,
> which is compiled only when CONFIG_BPF_LSM is set. Add CONFIG_BPF_LSM
> check to bpf_cgroup_read_xattr spec in common_btf_ids in
> kernel/bpf/helpers.c to avoid build failures for configs w/o
> CONFIG_BPF_LSM.
> 
> Build failure example:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: guard BTF_ID_FLAGS(bpf_cgroup_read_xattr) with CONFIG_BPF_LSM
    https://git.kernel.org/bpf/bpf-next/c/a5a7b25d7535

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



