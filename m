Return-Path: <bpf+bounces-14309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579237E2D35
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCAF1C20362
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A982D788;
	Mon,  6 Nov 2023 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjHUzDdA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523B2D051
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 19:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12AB9C433C9;
	Mon,  6 Nov 2023 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699300225;
	bh=wBZMPGW05QAt4q3PLR20838jqJXX9Xe3kTxLnmnGOkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JjHUzDdAIju2YfmkvIvUsaDuqv5NHttWA99vv4sLP6CRw1TJcryoFArdRFDE63TKD
	 4COLsTdMAsnKAVSHuucFG1g6nsbi0+FynscNEC9gj3rVn3CZ78OLd9kdD3A+5/WOYA
	 57lQhHeY5lYnPal/tPxA5Uzb9nZgqLaAFtWZFVxayy/3sonz/ic1WVuSG8kWu0UMmU
	 ZBwgq2IodPfKFJERbqwVnG1gmDZZgj6Y5PeUdUMpmTV7L9KSfqJKh4omlhVQu9eeTu
	 Ow8PSFQH/SDmZ1g8kOgnWRBFzkfcVZT9sC7Wie0LzExeXF22jekxqRVZxbcVwGhtvh
	 SF3CFPadvZlRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC31AC04DD9;
	Mon,  6 Nov 2023 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: bpf: config.aarch64: disable
 CONFIG_DEBUG_INFO_REDUCED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169930022496.29727.8671827068339091535.git-patchwork-notify@kernel.org>
Date: Mon, 06 Nov 2023 19:50:24 +0000
References: <20231103220912.333930-1-anders.roxell@linaro.org>
In-Reply-To: <20231103220912.333930-1-anders.roxell@linaro.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  3 Nov 2023 23:09:12 +0100 you wrote:
> Building an arm64 kernel and seftests/bpf with defconfig +
> selftests/bpf/config and selftests/bpf/config.aarch64 the fragment
> CONFIG_DEBUG_INFO_REDUCED is enabled in arm64's defconfig, it should be
> disabled in file sefltests/bpf/config.aarch64 since if its not disabled
> CONFIG_DEBUG_INFO_BTF wont be enabled.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> [...]

Here is the summary with links:
  - selftests: bpf: config.aarch64: disable CONFIG_DEBUG_INFO_REDUCED
    https://git.kernel.org/bpf/bpf-next/c/dfee93e25773

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



