Return-Path: <bpf+bounces-583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B72B70417F
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D071C20C82
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 23:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599619E7D;
	Mon, 15 May 2023 23:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9C19518
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 23:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9F8FC4339B;
	Mon, 15 May 2023 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684194619;
	bh=EtwSovPyQVXREa6e6IGz1o4F/zGbgM3y9Wzq1rOUoTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JsoK+6gQu5qwvo3jd5sD8uQL5QiqcHFoQXafljwCib5tM4s35txfzBwwEFEl6L72W
	 /TC7cjRKEByioIen8ch5kpymQ7YLv4kQD+BgQwa//UtOBNpJ7EJvYUDiJNm7YjMMO7
	 buNNP1mRO8a5tdm5Sd9RrJaw/9Vl/O17vu+N/afSobS4w4HbtS69ear3gCJpykvAZr
	 HaDTHX7mQd2WlU+fIIdr24mrJC7oDBG6DO5rXtlGKbnpAUMRuVWj9LlY4qDjnnCrQx
	 WUnFCTVG1c2a5syctdowEfh1DkiSv+i2dtC5CgHxcVw2KdPA0NyBQu12eOvF7F40nJ
	 0dhTKlmX3XUCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 851BCE5421B;
	Mon, 15 May 2023 23:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: improve netcnt test robustness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168419461954.3725.8939728272552775236.git-patchwork-notify@kernel.org>
Date: Mon, 15 May 2023 23:50:19 +0000
References: <20230515204833.2832000-1-andrii@kernel.org>
In-Reply-To: <20230515204833.2832000-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, sdf@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 15 May 2023 13:48:33 -0700 you wrote:
> Change netcnt to demand at least 10K packets, as we frequently see some
> stray packet arriving during the test in BPF CI. It seems more important
> to make sure we haven't lost any packet than enforcing exact number of
> packets.
> 
> Cc: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: improve netcnt test robustness
    https://git.kernel.org/bpf/bpf-next/c/fdb16e48e1c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



