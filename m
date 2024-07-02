Return-Path: <bpf+bounces-33651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C87C92439B
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 18:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173B31F25C61
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404F1BD01E;
	Tue,  2 Jul 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGWy6cnK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1614293;
	Tue,  2 Jul 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937844; cv=none; b=nL8klX6oq9Hk2my8zC9h4XaZioIPM/x5esUZBR4R2DK0SWTjVnozEPc9bvgnnIM54+75haKxPnI/3QqAQxggi/C7V+QgG4IfavOGNiE1O1KFJzM9hzWWGJpoaSukzNd5xGBBA1ISm2sBTBmoYJu8VOa9O4njC9ijUKYll62lU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937844; c=relaxed/simple;
	bh=yg4aPDBbW9uUffjVz6BgdWKqSwBFTVMjQloATSZQEXE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IXEuw8aWo4rCmF1GPvSxLZSy2F4sxKzcUdqFCuSSvw+MGreZM0HX1fZWAzaLVkK2vO4mJ6KbEynOhqocps/ZnemVueGE36J9wsZ7PaY/Vj9RSPKKCugkXbqtAPILCd4XF+qAcbBXXLktbEjHMddzsieYJXCbcQ+h2g6dSBVuymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGWy6cnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7E97C4AF0A;
	Tue,  2 Jul 2024 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937843;
	bh=yg4aPDBbW9uUffjVz6BgdWKqSwBFTVMjQloATSZQEXE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cGWy6cnKmx5K3dmAhRWrYwJF9Rb+ZvLavrD/zWZe32JY0ZkjnP0WIPF4xEEcfdBuW
	 MdUreShSMD/+D7swZ8pda+nGD2EBe8wWQVb1dn8CB1Ggg00vOLEm4uNFYmoSqdZ2Js
	 ubj6myD7Vfb6mQQqBMONfSRflvyrFU24FhW1bElghtlPcvl6ohtoDIa3Dt/gDLhSbb
	 kMkb4ZZ6auYCIl9xEozEmFFBOwFbXfmi+XaTlMpO6a5WlOirpDmxMcyAi7VAvSYP9X
	 kQpRWmDObUQCHBg/I46lWQ5tTadkU76z22h6Im3Wy5S4p3jbbnUWJ0gs9bGpnDW6po
	 PYrdlsRuY3zvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0C25C43601;
	Tue,  2 Jul 2024 16:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Mount bpffs when pinmaps path not under the
 bpffs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171993784364.9332.4670316229438625760.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 16:30:43 +0000
References: <20240702131150.15622-1-chen.dylane@gmail.com>
In-Reply-To: <20240702131150.15622-1-chen.dylane@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Jul 2024 21:11:50 +0800 you wrote:
> As qmonnet said [1], map pinning will fail if the pinmaps path not under
> the bpffs, like:
> libbpf: specified path /home/ubuntu/test/sock_ops_map is not on BPF FS
> Error: failed to pin all maps
> [1]: https://github.com/libbpf/bpftool/issues/146
> 
> Fixes: 3767a94b3253 ("bpftool: add pinmaps argument to the load/loadall")
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Mount bpffs when pinmaps path not under the bpffs
    https://git.kernel.org/bpf/bpf-next/c/da5f8fd1f0d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



