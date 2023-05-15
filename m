Return-Path: <bpf+bounces-566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190CA703D9A
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6492810A5
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 19:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E8A1950B;
	Mon, 15 May 2023 19:20:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B9FBF9
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED4E7C433EF;
	Mon, 15 May 2023 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684178420;
	bh=vKsm3KJE4Pc8bAPjGw9JQkvMfeeC1QWklL9aVzWSRhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HxkBd4d6XV1sJM65dJkULvL2hARpkx1xSH+3zXM2ySTGtpgAdeXU7U3xLJe/lP3I7
	 d5vRbaRmBXGsebR1i2Wbmrtj5li6UUQ/PgjtIZNr87NlEDuu0AasPH3VLzMCa73IJb
	 UtUBOO/UV06+DnECFZWETdClhx2qpHSzHyEckf5ZqUq6V1fzdYpLbDW6MKDoq2kE6n
	 btj/c7AdPTLUp3PwDGpovS2wU/fy9FgTFBDPwy7f2X8IqpysQcaKCuJOdnb/OCKfUD
	 tCsfAUTjd+vlWUiyRY2Et4iHR97Bvsr0fUeQBw59N6j2ymifdbTOT+dnI6TEZm0rmD
	 oRjI8jQ62M99g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D00EBE5421D;
	Mon, 15 May 2023 19:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] tools: bpftool: JIT limited misreported as negative value
 on aarch64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168417841984.1340.3668794611019645770.git-patchwork-notify@kernel.org>
Date: Mon, 15 May 2023 19:20:19 +0000
References: <20230512113134.58996-1-alan.maguire@oracle.com>
In-Reply-To: <20230512113134.58996-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, bpf@vger.kernel.org,
 nicky.veitch@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 May 2023 12:31:34 +0100 you wrote:
> On aarch64, "bpftool feature" reports an incorrect BPF JIT limit:
> 
> $ sudo /sbin/bpftool feature
> Scanning system configuration...
> bpf() syscall restricted to privileged users
> JIT compiler is enabled
> JIT compiler hardening is disabled
> JIT compiler kallsyms exports are enabled for root
> skipping kernel config, can't open file: No such file or directory
> Global memory limit for JIT compiler for unprivileged users is -201326592 bytes
> 
> [...]

Here is the summary with links:
  - [bpf] tools: bpftool: JIT limited misreported as negative value on aarch64
    https://git.kernel.org/bpf/bpf-next/c/04cb8453a91c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



