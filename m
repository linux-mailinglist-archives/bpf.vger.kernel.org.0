Return-Path: <bpf+bounces-77658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CDCCECB15
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C072301356A
	for <lists+bpf@lfdr.de>; Thu,  1 Jan 2026 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD02A126BF7;
	Thu,  1 Jan 2026 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rsxurj3L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAF481B1
	for <bpf@vger.kernel.org>; Thu,  1 Jan 2026 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767226406; cv=none; b=e/Aeym/Ebqeh0HgsTMBm6j3Z7lm5s53RYbSU4NYfxI3oD4pW8u0p6tkuz7aR3WR9JctM4QbrhwuD9CnuqwzpnUDnk5J65pi1sL2RpBd3AoPkgV9w0Be/Uaw2G13gDEuUa2tIPX6QgeLIVKHY37zj5jrILMXLCUK1ffA32Jd06t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767226406; c=relaxed/simple;
	bh=2FVXHWIXmiNrsM7Gl/tTQjEaUY91NW/rdX+h3kDXp7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BtIZZ8iLFfskdxXlqEw81uLf2uZs/ni6ENsg7VeFB/UqXLAJWU4P75rGQsgPZHQDbVEl+K0sCZVjpr385cDN3x3jjFM1hfglPILNghxKuCGADI9WL1np7rLysIVizDyngNQ8lH04/rpC20y4B8F0/yzCNSYgx/WUPiO6qXaC+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rsxurj3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EB6C113D0;
	Thu,  1 Jan 2026 00:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767226405;
	bh=2FVXHWIXmiNrsM7Gl/tTQjEaUY91NW/rdX+h3kDXp7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rsxurj3L5P1Dvj3L4IGfK75Wxopx/wITFgnn/Lh2KAUsjTYePwk2FWxm8aJ8Ycuti
	 R8bxOCjYaudpoUfEmYkiu3/Bz9QGqC92ZPOZC+cxE6l3YQOoEW9R9YWG30PoukOifQ
	 nNTgq3VXFq1PLndpVgi/fHT4enVmwmRjjYKZE4zAhjC0ww92r+0klhwnRwVR9Q1QDa
	 l2LVYQKOdxfAQHnhMWgAu4HouuM/GYMuveACTtfzYOLgHSC54lrb6iRf4RveH7WHUN
	 1qHzor0QMTjCx2jBmnBQVKa9sj2AQd8OAkA74M+8Gi/7ofMDHNYNYGXdftzZmo9USp
	 Y818ZSiZPJqSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9E23809A85;
	Thu,  1 Jan 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: veristat: fix printing order
 in
 output_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176722620705.3626500.11691233080198396775.git-patchwork-notify@kernel.org>
Date: Thu, 01 Jan 2026 00:10:07 +0000
References: <20251231221052.759396-1-puranjay@kernel.org>
In-Reply-To: <20251231221052.759396-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 31 Dec 2025 14:10:50 -0800 you wrote:
> The order of the variables in the printf() doesn't match the text and
> therefore veristat prints something like this:
> 
> Done. Processed 24 files, 0 programs. Skipped 62 files, 0 programs.
> 
> When it should print:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: veristat: fix printing order in output_stats()
    https://git.kernel.org/bpf/bpf-next/c/c286e7e9d1f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



