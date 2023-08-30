Return-Path: <bpf+bounces-8990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA2A78D696
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041131C203AA
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A7863DE;
	Wed, 30 Aug 2023 14:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA1525E
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 14:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 762BBC433C9;
	Wed, 30 Aug 2023 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693406422;
	bh=QoytJa3+FvhXLPVs7I051rsxKc+4d5AOmxX+36Q38rE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/m+AyOy2ZMqASRTESImqdHu0oTmGXC8UDxCBBoRhNEQKNyESjcRZJhNzxPpqty1c
	 3nnwCLTjVIxZXse9FZSQ2TrEqWClv9JjSzN1PBS+0ocxpgz+lJIEeo2pW8xfJnefql
	 Wsc3jj5jk3dmPA39DvTPZGepWAFMPV8KEsMd/U5I5xypzLx+ofIYZDPmdVXGMik1ET
	 84CaZH6gyMhjB8s12VxQpvKmGBVhlgmgZttDeolpJSDXmipsU1m0BYvIa6XQcMsjzU
	 fNac9TD6MSCuV5m8sygwH21+u81iIMdx9o/dXlSVHNE5FHkeqoNSCGd8jObaJUxHp8
	 BvVNP2H2F5y0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 551A4E29F39;
	Wed, 30 Aug 2023 14:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Clean up some standardization stuff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169340642234.1057.1251981139768787311.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 14:40:22 +0000
References: <20230828155948.123405-1-void@manifault.com>
In-Reply-To: <20230828155948.123405-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, hch@infradead.org,
 hawkinsw@obs.cr, dthaler@microsoft.com, bpf@ietf.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 28 Aug 2023 10:59:45 -0500 you wrote:
> The Documentation/bpf/standardization subdirectory contains documents
> that will be standardized with the IETF. There are a few things we can
> do to clean it up:
> 
> - Move linux-notes.rst back to Documentation/bpf. It doesn't belong in
>   the standardization directory.
> - Move ABI-specific verbiage from instruction-set.rst into a new abi.rst
>   document. This document will be expanded significantly over time. For
>   now, we just need to get anything describing ABI out of
>   instruction-set.rst.
> - Say BPF instead of eBPF in our documents. It's just creating
>   confusion.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf,docs: Move linux-notes.rst to root bpf docs tree
    https://git.kernel.org/bpf/bpf/c/aee1720eeb87
  - [bpf-next,2/3] bpf,docs: Add abi.rst document to standardization subdirectory
    https://git.kernel.org/bpf/bpf/c/deb884072546
  - [bpf-next,3/3] bpf,docs: s/eBPF/BPF in standards documents
    https://git.kernel.org/bpf/bpf/c/7d35eb1a184a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



