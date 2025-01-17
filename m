Return-Path: <bpf+bounces-49201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F43A151A0
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE943AA4DF
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487E78F24;
	Fri, 17 Jan 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0g2Z6eO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3A70825
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123611; cv=none; b=AGaMiiNOvnyCVB0YtdUZ0enCrOKcoIPpQGJSdncQ3cUN9SbzTZtOxyiSyCIRz622WiNkKujUEo113je+aBWps5H/elVzgthLF7EqgDZNoQXbesRfdueSE5+aiIXnmE+YVunAymP+rlGfu2AXqYJ+sJ69xJ/qmcY/M42XVUYQZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123611; c=relaxed/simple;
	bh=1Ofm8m71BedXLWYWd8eByxpQww0OYGGIUB1NS1Q8gEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qEM5PrxWbW7zneMpF/2d275hTA+/6RKLhyd9qVfE1sshsHWwU9CMaA+ASdcGGLnSu8slkZUJeCncZmbuagtbYwXz1RFYgPQk9Sme6WGJIad3jDARpItEynpttTf9d7OogSgInkR0++EVb6u58Y/KFx/cYt80sLFoT9dXjvmIf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0g2Z6eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E83C4CEDD;
	Fri, 17 Jan 2025 14:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737123611;
	bh=1Ofm8m71BedXLWYWd8eByxpQww0OYGGIUB1NS1Q8gEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t0g2Z6eOXWAQ8mcN4z7EEn20BHBc/TvL7crKZk0m9DbHxJ8fPWxDmwxLWeaOaQh+s
	 /dLHw8/pAC+U3krjGnE0zvFprkd9R7RwiCbDkDhnFmX2Kr6JJU5CriZqm1P9E6+bxj
	 jS6q8ZC7xNsLqfmXfGL7A8/Gk3FsUyu/AjrN5xfjtHVv250+WiuV+8LtVpBvt5LWD5
	 2cc6RvrQL1N+DsQ+aN8mcmCcA4aGOyDYQpdv5cdj3dkaoB1Vpj0WSNwhjtIoPQd9JU
	 TtVysTCCfJaGPXtH23pJ1/AXjo3URniPyG1KAQFtqUIQTDdWzAPiCCbuNME4UvRtW6
	 gm5F6Z3bWMz3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB209380AA62;
	Fri, 17 Jan 2025 14:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: work around kernel inconsistently stripping
 '.llvm.' suffix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173712363439.2142414.17216167173134870618.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 14:20:34 +0000
References: <20250117003957.179331-1-andrii@kernel.org>
In-Reply-To: <20250117003957.179331-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 16 Jan 2025 16:39:57 -0800 you wrote:
> Some versions of kernel were stripping out '.llvm.<hash>' suffix from
> kerne symbols (produced by Clang LTO compilation) from function names
> reported in available_filter_functions, while kallsyms reported full
> original name. This confuses libbpf's multi-kprobe logic of finding all
> matching kernel functions for specified user glob pattern by joining
> available_filter_functions and kallsyms contents, because joining by
> full symbol name won't work for symbols containing '.llvm.<hash>' suffix.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: work around kernel inconsistently stripping '.llvm.' suffix
    https://git.kernel.org/bpf/bpf-next/c/f8a05692de06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



