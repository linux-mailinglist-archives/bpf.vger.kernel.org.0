Return-Path: <bpf+bounces-58740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D7CAC1149
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B4E3A58B7
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95498283695;
	Thu, 22 May 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBJgh6vQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FA15ECDF
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931995; cv=none; b=sGcf3JL5t/ckIOkHJjEou3E52SJw0UOSQXoZHPKsZEICnubrUdK20a1jBan5OyBCN5HdKQsT6hZrHcOcpWveeK6JDMXprjZpUoeodkXYFjI5M8QumMiExwFEfQnbrfB3DWYCTNhQlbhrv/bJzsGOZdqCqxv1ziKUdTi14PydkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931995; c=relaxed/simple;
	bh=jhqqL6gdzB88+dJK6TcLYP09VvsTSYQNxw8zQ+jlSSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iM7JvJlxj57zDiAqsedCOLMK93UjzdULZ5LB6ua5Lwk+wzv5Nd7+NKuCXXKOVDeGf+/pt34jK7DLtAiulki/2z1kembaXl971lgcga3admuu3FC1Mma5fQRPVmgEyndqO81fv5ChMyLOZn/GG/VnwA1BNg2M2VEiYBOjjWNZD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBJgh6vQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBE2C4CEE4;
	Thu, 22 May 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747931994;
	bh=jhqqL6gdzB88+dJK6TcLYP09VvsTSYQNxw8zQ+jlSSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DBJgh6vQfJ/0El3bc+lBGUMqhTg5IZWU58dij9WMIyEeVw/u7BiZyJtdn+U5Jr7NU
	 izoQbFV5+U+Wl3XdSHvgUlMsIUV7/EtxgTs4bK22SgHjG653HrUbnQeptRAqo5C3Ox
	 LOPIDGgXFVpnRFiqKhrbCaC0pqrKdLE5Q/u8mW2dNqrDb6o9vR5OBYHBxFwNiNodBs
	 nN0lxc/P0+62HodcZZtcURUaXG6akaspqFzftL3tNnHb6kqK8TYyLv6QY+zYZhUSy6
	 bDpgJZZbQql/V+3JHaH48EzwZIdmK8jgoTMQAy6PIYmis4WKgc3MuNaTVIv/4T4c6h
	 0AzFcNGIzS/Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D603805D89;
	Thu, 22 May 2025 16:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: add SKIP_LLVM makefile variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174793203001.2944092.3096401610824678778.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 16:40:30 +0000
References: <20250522013813.125428-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250522013813.125428-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 22 May 2025 02:38:13 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Introduce SKIP_LLVM makefile variable that allows to avoid using llvm
> dependencies when building BPF selftests. This is different from
> existing feature-llvm, as the latter is a result of automatic detection
> and should not be set by user explicitly.
> Avoiding llvm dependencies could be useful for environments that do not
> have them, given that as of now llvm dependencies are required only by
> jit_disasm_helpers.c.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: add SKIP_LLVM makefile variable
    https://git.kernel.org/bpf/bpf-next/c/5ead949920c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



