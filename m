Return-Path: <bpf+bounces-9785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E179D9FC
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F053281B37
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 20:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B36B65C;
	Tue, 12 Sep 2023 20:20:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4FAD57;
	Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A83DC433CA;
	Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694550025;
	bh=gU/CeO6Y/T1uavamob8EZRBzi77IzZ7qj2zJ7oTQMBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=obbcqfaHsYA2dOc9urGdZ6AGLjEfPrMnjD1rNHGNmY70wJoLJkTPRIR9OLeNij+5P
	 iqVGZh1xteAPm18aaCoduzHjQXmx6cGfxvtgW3zEtZBB4crdsVfha8pqdDsnDo3lpt
	 YikCT7NTwNa0RCMkm/G7C8ikeXUFQsxB6jp/2cj4nZHFWDxyZfpvyBBHskYMbYZLAw
	 +RYMavHAGnuAEok6ewyjgam4Cwcrg9NhZ4SyDJg6y57KEDhdhDIcDBKbgWqob8VCfe
	 9LTAegjGiM0sxEN6Qd4PWd3gWSAD710n9n/mRgLdgDsZximiVDsm3DDvEDc6ucsz7I
	 ESUYFCRPmfcJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CE56E1C290;
	Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: fix unpriv_disabled check in test_verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169455002550.29579.5589738448347101961.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 20:20:25 +0000
References: <20230912120631.213139-1-asavkov@redhat.com>
In-Reply-To: <20230912120631.213139-1-asavkov@redhat.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, eddyz87@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Sep 2023 14:06:31 +0200 you wrote:
> Commit 1d56ade032a49 changed the function get_unpriv_disabled() to
> return its results as a bool instead of updating a global variable, but
> test_verifier was not updated to keep in line with these changes. Thus
> unpriv_disabled is always false in test_verifier and unprivileged tests
> are not properly skipped on systems with unprivileged bpf disabled.
> 
> Fixes: 1d56ade032a49 ("selftests/bpf: Unprivileged tests for test_loader.c")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: fix unpriv_disabled check in test_verifier
    https://git.kernel.org/bpf/bpf/c/d128860dbb29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



