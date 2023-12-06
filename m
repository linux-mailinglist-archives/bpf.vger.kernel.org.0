Return-Path: <bpf+bounces-16935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE53807AC7
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD231C20C41
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606494654B;
	Wed,  6 Dec 2023 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0ylq4Md"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0870986
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 21:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B928C433C7;
	Wed,  6 Dec 2023 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701899424;
	bh=PsC/lIKMoXmWbsqBJlAtEfXL6FJwjaTAUPXlln95oDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L0ylq4MdnhgktDYRBtWlOLU4pnWYwcIvcB3w734lFfUzuMrCyPjL7TbMHoAqMO4QX
	 CtzzzlYbNYDFTT+GZ/or1S1vBhgOJ4HoAIhD4q0iBCckUrwPC5VbdtFuDfx6acOHcq
	 U2XuPFkd6vYiWML3h5nn/D6RT/svlm0mzQwbDqknQmGaNgRYwQEbtWNoHjkilJqvXp
	 2tOJJWC2z7WAjEMvRjkH86aXc7ax13/ajCwXE5CNKFXscefMk/A8hLU54oThU1C3wF
	 X0YcpjBroaatbYHtMKSpvEnPEB/VHKpq8PP1TYlHm7iYBSm9zM3XmZFUP37TgzWc7R
	 UCfJk8K+hdnYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E36ADD4F1F;
	Wed,  6 Dec 2023 21:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 bpf 0/2] bpf: Fix map poke update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170189942405.8360.841119642770119947.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 21:50:24 +0000
References: <20231206083041.1306660-1-jolsa@kernel.org>
In-Reply-To: <20231206083041.1306660-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, xukuohai@huawei.com, will@kernel.org, nathan@kernel.org,
 pulehui@huawei.com, bjorn@kernel.org, iii@linux.ibm.com, lee@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  6 Dec 2023 09:30:39 +0100 you wrote:
> hi,
> this patchset fixes the issue reported in [0].
> 
> v4 changes:
>   - added missing bpf_arch_poke_desc_update prototype [lkp]
>   - added comments to the test
>   - moved the test under prog_tests/tailcalls.c
> 
> [...]

Here is the summary with links:
  - [PATCHv4,bpf,1/2] bpf: Fix prog_array_map_poke_run map poke update
    https://git.kernel.org/bpf/bpf/c/4b7de801606e
  - [PATCHv4,bpf,2/2] selftests/bpf: Add test for early update in prog_array_map_poke_run
    https://git.kernel.org/bpf/bpf/c/ffed24eff9e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



