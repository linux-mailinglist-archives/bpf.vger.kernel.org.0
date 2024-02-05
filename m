Return-Path: <bpf+bounces-21248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FF284A2F8
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242C9B26411
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1C487A0;
	Mon,  5 Feb 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iazE/Fxe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAA4879F
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159638; cv=none; b=N4LNt2omIbTn4e3ObAHFG6nStxIP9f+/p/CDwR0EsDtzMAygijENN9bXBEdGXXwAhOu2MWkOJZSHI6xSXKbdqvGuy7IzyLh7PNfWpVb9foFCuGuiPX/a72TXBnmkjDwq92Draj3tZKei8ilEBwSd+hH3G2ycPrEV7x0yn1KzC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159638; c=relaxed/simple;
	bh=+LCzB+JaLzeNcNb+rSRZc7WrML4cSv48qZetfbAEoes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dgzSb2hbcvIVRP+cFQB66B4JBT2DGjWQX7/kLTyq1URMtR7ti+dVRM5wiX6yrun17ettF3YLm4wivEUOzxlyo5XFe1Loa3549plPtU41tuqzMGGn878zK1w9lK+7mVhKGKxzPELIApPPTosvl6TJlPSQXNmy6rFI2A7XwlU2rOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iazE/Fxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D170C43394;
	Mon,  5 Feb 2024 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159638;
	bh=+LCzB+JaLzeNcNb+rSRZc7WrML4cSv48qZetfbAEoes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iazE/FxeufbRc+e0s6PwxALajn1FN9pHRYCKM8D46gSIjosydpbTuP8lTSElO1OWl
	 4bbyGFmSVO18B39fAsMrestAgrslWZcP4MBTfLz5lCVbHedhGoLJinMJXzvFsUV1UY
	 mhgij2P/8XhrZzGXgPHRNie9rjioBKRZkpiBnofPIG8+NRJlqgYelDKOBRT38HAkzL
	 RpEXGWm9Tr5r4iN89bNWo+isyhHqDbr1s8+xHxotGIpm1JCPG3SVZ2wtcN/EABB+nh
	 fIhWGqo/llgcU76F1aERuzvVRu9kADRbLXlBseRvGGl77iP1TidajiZst5NdvOf6TW
	 ijbe46vGSzYtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 468D4E2F2ED;
	Mon,  5 Feb 2024 19:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Suppress warning message of an unused
 variable.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170715963828.7008.13806675077261998799.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 19:00:38 +0000
References: <20240204061204.1864529-1-thinker.li@gmail.com>
In-Reply-To: <20240204061204.1864529-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat,  3 Feb 2024 22:12:04 -0800 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> "r" is used to receive the return value of test_1 in bpf_testmod.c, but it
> is not actually used. So, we remove "r" and change the return type to
> "void".
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401300557.z5vzn8FM-lkp@intel.com/
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Suppress warning message of an unused variable.
    https://git.kernel.org/bpf/bpf-next/c/169e65006964

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



