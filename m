Return-Path: <bpf+bounces-10074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC027A0CA3
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA9FB20B50
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40A266BA;
	Thu, 14 Sep 2023 18:20:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97EFBE7;
	Thu, 14 Sep 2023 18:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 454ECC433CB;
	Thu, 14 Sep 2023 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694715627;
	bh=aHat3lPagD1lJh2u5n1uXfTagE3HjmSAph/K1MeerU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GoLhDexlEqVljRk0RGkc/Abft+Fkrqer+PJq2pBEQg16CrfH5pkLUrqic2VR6LM8v
	 wqc0mFrv0YawfLxyeE/HBktVEpkE43dM3fIDuPT26WW+yfgKemlrqDlX8uUJGE426Q
	 TlEiv1SnqIBetmLnQ/QsGQYFBtgW4lf4IahU+DcR3zIF3K2NJfMeZuqyJPWEWL62vP
	 aptAVYvrAySA210ZygC4Fz23tkDcumQPU9jOdc79nW8XtMkew57cfQCqLLqknObcS8
	 3bKBjDpMMQuYzG/sXialD9bI9xyqsrzE1XgmiQn8UzVls4FX77tekjPrPlAfZcDuwG
	 axcbimpVIa6zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B1A4E1C28E;
	Thu, 14 Sep 2023 18:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: skip module_fentry_shadow test when
 bpf_testmod is not available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169471562717.30611.2026366361358349772.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 18:20:27 +0000
References: <20230914124928.340701-1-asavkov@redhat.com>
In-Reply-To: <20230914124928.340701-1-asavkov@redhat.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, vmalik@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Sep 2023 14:49:28 +0200 you wrote:
> This test relies on bpf_testmod, so skip it if the module is not available.
> 
> Fixes: aa3d65de4b900 ("bpf/selftests: Test fentry attachment to shadowed functions")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  .../testing/selftests/bpf/prog_tests/module_fentry_shadow.c  | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [bpf-next] selftests/bpf: skip module_fentry_shadow test when bpf_testmod is not available
    https://git.kernel.org/bpf/bpf-next/c/971f7c32147f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



