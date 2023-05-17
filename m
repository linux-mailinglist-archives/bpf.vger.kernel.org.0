Return-Path: <bpf+bounces-776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D6706A96
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95111C20EE7
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97031102;
	Wed, 17 May 2023 14:10:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5418B16
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5618C4339C;
	Wed, 17 May 2023 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684332619;
	bh=wL/mslmtScV65RrVXfixrozPCyEWbEtLes9zWZCTKq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hoey3Dd7QXh7YBmorT+ZQLbtVlBMX0lHyGDZZlMslNI0AVYlUT9SpjNdNPLyyxJlD
	 3x7CkvLYuZMtA3vno7WlwgJ99sd/Brt7MwR/NnXDB9ka0LuDguxMhg9jGQ2dSqgrAp
	 OF8OKIqYHWRbEQ8X3vz0rSTCPfNhoNXYgwWIE9rOv/h7rfh2z4+5FWtGLf+MrD81oW
	 bXUI63SP5HXubawoHs9IAO8ZDO0KjYdyxP17IGXQF9NtRe0lESQQo8xVuVVxVjGX5X
	 Yx+BjkHeKZS2nhlVUjR0r/ZXLiTbLKA+qrZX582W1+ZA7X5JWtcE9EbHmldNg6eIUn
	 YRvhmaPLaSfuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BE3CC4166F;
	Wed, 17 May 2023 14:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v1] selftests/bpf: Do not use sign-file as testcase
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168433261956.10644.15438316748787796174.git-patchwork-notify@kernel.org>
Date: Wed, 17 May 2023 14:10:19 +0000
References: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1684316821.git.legion@kernel.org>
In-Reply-To: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1684316821.git.legion@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 roberto.sassu@huawei.com, sdf@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 17 May 2023 11:49:46 +0200 you wrote:
> The sign-file utility (from scripts/) is used in prog_tests/verify_pkcs7_sig.c,
> but the utility should not be called as a test. Executing this utility
> produces the following error:
> 
> selftests: /linux/tools/testing/selftests/bpf: urandom_read
> ok 16 selftests: /linux/tools/testing/selftests/bpf: urandom_read
> 
> [...]

Here is the summary with links:
  - [RESEND,v1] selftests/bpf: Do not use sign-file as testcase
    https://git.kernel.org/bpf/bpf-next/c/f04a32b2c5b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



