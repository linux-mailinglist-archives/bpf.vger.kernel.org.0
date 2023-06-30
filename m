Return-Path: <bpf+bounces-3794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3037437A0
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3761C20340
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E17101C7;
	Fri, 30 Jun 2023 08:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92A5238
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07DC8C433D9;
	Fri, 30 Jun 2023 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114421;
	bh=bfKdgJluiGi1Mg+hlbGdlgoeN70P3uorZ3y74A9xcgU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TidK/GKtbgm78dLt/kIsMMYdBC9wuFb9+lgGwJN7iaoOTGBaCxRTo3QdctB/WYtXQ
	 mmUSVSjJqPjBX8AAowx889nHmF1+VtZ2tdP3f9SwwjOHUCwPOSdnFBZRKaE9bmpL7+
	 U3ivUZ/KGa4MMlBO0ij8HF3atDbjRH9bZJnQIhlnPFgZkYxOPFDvbjqY3mDLVJtbNl
	 q9H5w27FtUyocwAiDNtdXeOfXCDSFQaoZBp2CXIKgRngB7MFh8qcHhkk9Kl6dSyEYa
	 IDcyU+Ztzt/I72+h/Jg1K8oJugL2Z6rWt980+IGpN7S8tBCoOKjKhc75GFFLdwav3L
	 Czt4Bu87vzdIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1B87C561EE;
	Fri, 30 Jun 2023 08:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix bpf_nf failure upon test rerun
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168811442092.9995.14897152899237267542.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 08:40:20 +0000
References: <20230626131942.5100-1-daniel@iogearbox.net>
In-Reply-To: <20230626131942.5100-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, ast@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 26 Jun 2023 15:19:42 +0200 you wrote:
> Alexei reported:
> 
>   After fast forwarding bpf-next today bpf_nf test started to fail when
>   run twice:
> 
>   $ ./test_progs -t bpf_nf
>   #17      bpf_nf:OK
>   Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix bpf_nf failure upon test rerun
    https://git.kernel.org/bpf/bpf-next/c/17e8e5d6e09a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



