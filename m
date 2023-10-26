Return-Path: <bpf+bounces-13320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2307D83DC
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 15:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C83B211E4
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62F2E3FE;
	Thu, 26 Oct 2023 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKOhrYby"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C012DF92
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 13:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC15AC433CA;
	Thu, 26 Oct 2023 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698328223;
	bh=Jv9b2mo3aAMhgWZP/BtRGsCmrQg8Q7vlFK6mGw1gy60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BKOhrYbyb4ovbQAWMz8917KfFY48w335whntHOgTgCCZJCJbz8glW7VLhdSNpKOh+
	 J5ThNoKAqtd8UaEnm2jew+DPEFuvWy9RvPMc2i7TiDK8BmkGNo1FBx0cohz83JqI2i
	 cY65rnYHRwNybKR77BLTvtRxrG/MhJI+fOkS3qYAyxzaV4CN3N2IxYNynS7bfyzCOr
	 5Xkw6G9OJuhsQtmWkah8jwBiwNaDkwAl8pvqZf3Tl4E1Jxfnuyokgo8ZncVEjmLvtR
	 Cm0nKhPpx1PNPZWsd02BtHK1nqdZ+buRmRiRaYA2Z2k2Z+vbCQvjt4ikhwEWNLtQjY
	 MIp2gsMauhEcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD2EDC41620;
	Thu, 26 Oct 2023 13:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Fix selftests broken by
 mitigations=off
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169832822370.10132.14421003032015190310.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 13:50:23 +0000
References: <20231025031144.5508-1-laoar.shao@gmail.com>
In-Reply-To: <20231025031144.5508-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, gerhorst@cs.fau.de,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, martin.lau@linux.dev, sdf@google.com, song@kernel.org,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 25 Oct 2023 03:11:44 +0000 you wrote:
> When we configure the kernel command line with 'mitigations=off' and set
> the sysctl knob 'kernel.unprivileged_bpf_disabled' to 0, the commit
> bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
> causes issues in the execution of `test_progs -t verifier`. This is because
> 'mitigations=off' bypasses Spectre v1 and Spectre v4 protections.
> 
> Currently, when a program requests to run in unprivileged mode
> (kernel.unprivileged_bpf_disabled = 0), the BPF verifier may prevent it
> from running due to the following conditions not being enabled:
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: Fix selftests broken by mitigations=off
    https://git.kernel.org/bpf/bpf-next/c/399f6185a1c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



