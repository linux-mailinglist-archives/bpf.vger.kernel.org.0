Return-Path: <bpf+bounces-17702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB4F811C85
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A9F1F21ACF
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B1E59B71;
	Wed, 13 Dec 2023 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlrMVCmP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3625756
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD64AC433C7;
	Wed, 13 Dec 2023 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702492223;
	bh=EnPcBGLWC7uqJgliya9J8SyQeA+Q9WREsSgc/tY7PB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UlrMVCmPEQ4G16IqJdBShbAZ0loRIG5rQTnO1KhoW8MWOTtLpOWfbagZ89LtJKHjh
	 MkKvBAYLrzGFOYCDMMwpxEnYqyRy3sOVfytLUdfesXgbgidQlLFEG++HZKHanRVW5/
	 MXkKKjfIxTNEpLItpC5achkbVpb9wCsfbEhkYFKmsW1WQBQcl+/qQ2kxbwsBwYd/sq
	 GCBG+9WYFen7k9cnjAV4iZf5nh5NDplmjPXROzbTQacJK6jx0/7+K2MU1zsptiE7Dw
	 M1COP8xK2Y7iwdUssrqhg3xjuZGWxpWtwDWsSOpSmJhDjCbYt1ikEyT4HUIblc4gnK
	 aYbrujfTNSxOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A35F9DD4EFE;
	Wed, 13 Dec 2023 18:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compiler warnings in RELEASE=1
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170249222366.30712.18076711093094768837.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 18:30:23 +0000
References: <20231212225343.1723081-1-andrii@kernel.org>
In-Reply-To: <20231212225343.1723081-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Dec 2023 14:53:43 -0800 you wrote:
> When compiling BPF selftests with RELEASE=1, we get two new
> warnings, which are treated as errors. Fix them.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/veristat.c        | 2 +-
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix compiler warnings in RELEASE=1 mode
    https://git.kernel.org/bpf/bpf-next/c/62d9a969f4a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



