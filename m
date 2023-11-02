Return-Path: <bpf+bounces-13987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F407DF836
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640931F21AD9
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682781DDCE;
	Thu,  2 Nov 2023 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQIDcpaD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3563AD
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25F22C433C9;
	Thu,  2 Nov 2023 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698944425;
	bh=m9c5eGnIkD/UPlLneSODHhed0Gw5FKKOurqGFfYcupE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nQIDcpaDjV0QldHPeAV4uHpakHUet+IESM79vZH8bxxqIS/sah57qJArh5qiTndlH
	 Ulo/6p4i9FZQGVGxxRCfTfK7KJuW2E60HhdeN0lZZ9bgQg/rhNFSCvSKoC5sy2MMk5
	 AKnU7lzGOuY+MwJly8YTJgJ/b7//GfT/QEJVMV42SMgatj+F9FgdbuHuUonytcD7r7
	 NrYYZuviXrABNaxLCiX7I5uys9u50ac/AzpItSQyLYzgqBcMDaOIHf9pE2fqM/3RnV
	 69KKbl7Uuz7BJDNNBkzp65tSDY7ftw8faCmKiXjfv8oUe9FT81Gb2jFJwLpjFZb4ff
	 LtMxa36LCstSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 064B3C395FC;
	Thu,  2 Nov 2023 17:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next ] selftests/bpf: consolidate VIRTIO/9P configs in
 config.vm file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169894442501.23118.10322806189254441906.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 17:00:25 +0000
References: <20231031212717.4037892-1-chantr4@gmail.com>
In-Reply-To: <20231031212717.4037892-1-chantr4@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, quentin@isovalent.com, andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 31 Oct 2023 14:27:17 -0700 you wrote:
> Those configs are needed to be able to run VM somewhat consistently.
> For instance, ATM, s390x is missing the `CONFIG_VIRTIO_CONSOLE` which
> prevents s390x kernels built in CI to leverage qemu-guest-agent.
> 
> By moving them to `config,vm`, we should have selftest kernels which are
> equal in term of VM functionalities when they include this file.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: consolidate VIRTIO/9P configs in config.vm file
    https://git.kernel.org/bpf/bpf-next/c/1a119e269dc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



