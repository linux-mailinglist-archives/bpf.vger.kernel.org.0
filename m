Return-Path: <bpf+bounces-72133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E20E8C0765E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BCE535892F
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1553376A9;
	Fri, 24 Oct 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkiuFa0v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA3330D36
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324635; cv=none; b=LPNhh6yYvT86PMl9j79amx/Dzaq+DRUi4qejoTf/95n3bwE04e7WFVjjbbDgqDKUERbaY+IEukQoHDCDEjlTZ8tgrliXWXcXD8hmxOQMD6m/Rg02a+QZDuWoMi4G6V78cFOGtOzmwsyjIniA0Z62BeXO6CCGlrlfQ2Ju9NIF6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324635; c=relaxed/simple;
	bh=ou6jcUuSe+vmeaaUTDeDEsFnq4TwijSHhf/NZDCKEpc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AXBjluGNT3BwH3JD/ySbA5FkLM1Ljgh3iOnXNHGFkkvp21nokIBGGoa2GisIciV0akW3WCu/Wfy2XycKMtTpymzwxf1tDTwuSW2NR9D4U5AI3yHGPL44VIv/UFdvPcpv1Khhufge+KtHqPcEm+e0inCvmdHBe6Ejgfg4Iq6hFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkiuFa0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAA5C4CEF7;
	Fri, 24 Oct 2025 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761324635;
	bh=ou6jcUuSe+vmeaaUTDeDEsFnq4TwijSHhf/NZDCKEpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dkiuFa0vA4DHuAiB5tUB+eOmXkNbL2J+teATqEot/miXA6sX06U+KLSu1P4c79B31
	 ktlvC00uLn9x6KnmhgrOl3/mtaRJwwWu5VL/JJreytyhqHF7yzeRuOp+wtN2iJzh3t
	 Xc4OFS05yjuuT047j5T8VYc9uIQEWiyUYDgYr2d1cwOOm19HasOwT/CfgD18givYfw
	 e+rat4R2hk/yF/gACOlXno4tIMgwR7jm/vDpb6ys8aaY5OiGbxfk2GK9X4gmU+5x9K
	 nmi4T2/xHCaGKHlEjmC2wS5L+viyenUZTsGBHd4I9L6mAnN17Z5IqjDcE7pxpdFW9q
	 OK7o+iZ9PPJtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2F380AA45;
	Fri, 24 Oct 2025 16:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Conditionally include dynptr copy kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176132461474.3987170.17674040474712090517.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 16:50:14 +0000
References: <20251024151436.139131-1-malin.jonsson@est.tech>
In-Reply-To: <20251024151436.139131-1-malin.jonsson@est.tech>
To: Malin Jonsson <malin.jonsson@est.tech>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, yong.g.gu@ericsson.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 24 Oct 2025 17:14:36 +0200 you wrote:
> Since commit a498ee7576de ("bpf: Implement dynptr copy kfuncs"), if
> CONFIG_BPF_EVENTS is not enabled, but BPF_SYSCALL and DEBUG_INFO_BTF are,
> the build will break like so:
> 
>   BTFIDS  vmlinux.unstripped
> WARN: resolve_btfids: unresolved symbol bpf_probe_read_user_str_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_probe_read_user_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_probe_read_kernel_str_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_probe_read_kernel_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_task_str_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_task_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_str_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_dynptr
> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> make[2]: *** Deleting file 'vmlinux.unstripped'
> make[1]: *** [/repo/malin/upstream/linux/Makefile:1242: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> [...]

Here is the summary with links:
  - bpf: Conditionally include dynptr copy kfuncs
    https://git.kernel.org/bpf/bpf/c/8ce93aabbf75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



