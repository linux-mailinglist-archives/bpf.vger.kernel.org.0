Return-Path: <bpf+bounces-73560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD6C33B98
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 03:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B20189707F
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91CC156C40;
	Wed,  5 Nov 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4laig/Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04C13D891
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308036; cv=none; b=cBrO75vsI0jdrY93n3DXOe/1tcyNR7STWEcWPx6znid4WKSCvflvE1V0Pi+y9m6RoQ1fEmbqZZpH7JnDMJ4/gKa7lGtLPF0jJ5MDzRvvssuaDDC9eagGP6sfW7tDvYBHPIAvavA/jD7ArawTp3uzSN8bcj7hSgrNDEs/UafgIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308036; c=relaxed/simple;
	bh=5wuWdzp9qpsm7LBSr6dIskLFqBnoI2KLh5qDpPyNBjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VIbFFZgd8Q+/283+a2lwxVkMpGl2S9YEOT9Rziac6athdGy5s/D2OlWkzL8scmCVVjosXLwO1H7R3/wAMTN30Yk9YXIa0jzqG15YlhV0yZou7CQjOnnavO1EY3H1fgDieU0F9eBQmvTCzhtGJIhFhkLY37quSHigsdbea/GSM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4laig/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AF0C4CEF7;
	Wed,  5 Nov 2025 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762308035;
	bh=5wuWdzp9qpsm7LBSr6dIskLFqBnoI2KLh5qDpPyNBjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e4laig/ZOirGXqnpVGHZ7wi8myylGpzz5v2moAEjKZrOcheL8ZR4ByfP652Ci2dCo
	 l58MW4WK3rvvFYwgMvbNe4sM6shOumTKE723BsIdjrK8HEyCElrGvet2qcTpGUUYQN
	 tcC6MNSHU+zJfAzIXgML/EqVAY21HoGm+Wc+/JZep+6XtM/XUdOc1RykANvgBh+fHK
	 J18pNbNabwgabcpGCW7NfssYdu6h1geGYscxkWzdHOPRsKktB4oFGVIQ++pf8ABBcA
	 LRVdEitl45gPhozlEYS8PJ9ozdufADbRLGwf/WHRrVjWg/4dDNhjVh7FZeuApCxluS
	 /BaJsxcRMdY1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C9AB1380AA57;
	Wed,  5 Nov 2025 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: add _impl suffix for kfuncs with implicit
 args
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230800954.3058815.2709221007373602170.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 02:00:09 +0000
References: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
In-Reply-To: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 04 Nov 2025 22:54:24 +0000 you wrote:
> We have established a pattern of function naming win "_impl" suffix;
> those functions accept verifier-provided bpf_prog_aux argument.
> Following uniform convention will allow for transparent backwards
> compatibility with the upcoming KF_IMPLICIT_ARGS feature. This patch
> set aims to fix current deviation from the convention to eliminate
> unnecessary backwards incompatibility in the future.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
    https://git.kernel.org/bpf/bpf/c/ea0714d61dea
  - [bpf,v3,2/2] bpf: add _impl suffix for bpf_stream_vprintk() kfunc
    https://git.kernel.org/bpf/bpf/c/137cc92ffe2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



