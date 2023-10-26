Return-Path: <bpf+bounces-13318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9967D83BB
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC801C20F51
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6114B2E3F3;
	Thu, 26 Oct 2023 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYgvamOV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2B2E3EF
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 13:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27A5BC433C9;
	Thu, 26 Oct 2023 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698327625;
	bh=I1Mjl0XaNhpE1jobU43FmdIsZJLWMPns/XpnxjPbmRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XYgvamOVSv9dTsERo2nNzOs73AeBmnE5SYyd/OgP3wVeG9L6wrlrSk/snqxWtYPaB
	 NocpdJjXF7zEyizKIfJ/Anvq6MDa+3cLyAs/4UsYvPDHNdixes9GXzF/LdGC9jGM7b
	 VWRsntVnoWAF3d8bQGf0vH9FCkOzacD3HYk7gMoxtwDh5WdOspbl65ly7iwGF/EnZ5
	 gId6/fXpyAf7uRoPgvplP2pFSjRE4G/qUoVSP5u0GalrL71cWGo6HoHosPhPoFO7+d
	 2GPpJCYocUWqFpswVmVu643NeWAkUQiFNQesrqt2MdB2QgHeWlqAYzfhllc7QAAAvO
	 0tRqMn+TOg0Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 084D3C3959F;
	Thu, 26 Oct 2023 13:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] samples/bpf: Allow building as PIE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169832762501.4440.5459269955038255670.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 13:40:25 +0000
References: <cover.1698213811.git.vmalik@redhat.com>
In-Reply-To: <cover.1698213811.git.vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, dzickus@redhat.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 25 Oct 2023 08:19:11 +0200 you wrote:
> Hi,
> 
> when trying to build samples/bpf as PIE in Fedora, we came across
> several issues, mainly related to the way compiler/linker flags are
> handled in samples/bpf/Makefile. The first 2 commits in this patchset
> address these issues (see commit messages for details).
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] samples/bpf: Allow building with custom CFLAGS/LDFLAGS
    https://git.kernel.org/bpf/bpf-next/c/870f09f1ba30
  - [bpf-next,2/3] samples/bpf: Fix passing LDFLAGS to libbpf
    https://git.kernel.org/bpf/bpf-next/c/f56bcfadf7d6
  - [bpf-next,3/3] samples/bpf: Allow building with custom bpftool
    https://git.kernel.org/bpf/bpf-next/c/37db10bc247d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



