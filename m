Return-Path: <bpf+bounces-18232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA3817966
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 19:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A59D283284
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F85D72E;
	Mon, 18 Dec 2023 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXQfXDCu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287737896
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 18:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 013DBC433C9;
	Mon, 18 Dec 2023 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702923024;
	bh=2KXEmhhDmIyWvspOyaQDzCkWJrYh0P1+8lLdD4/kIrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VXQfXDCu59m9QKWXO9ZkG56iJY36tSEZuxPxxd6yDpGhapQAl1v2SkbMDMQSgcbiT
	 payJmrve8BUJqBB7pQI4rrjr5VoU9T629zcvQbPz/QCkk9HEZFGRpwVRgNneBgfZck
	 TPEJXWXSM8Sxhu+n5Kyi2jiTDdDEgFYA24mywAHNYeU151EuNVGe7cuK3FZHknQsIq
	 YCQxAsZ6saYUkAQThxY+R3QlChK8I+WQUeiove0p0lBNkStkKTh2eKKUXcUJ8jofZA
	 RT1Qzis/LS0Mb3Of0hoU2oNVVoVZLUzYHeyR2KyEl5LszLHj3T9ZQDPiHMBQ341kca
	 5cJFaxM9BG95Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAEE2C595D1;
	Mon, 18 Dec 2023 18:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next 0/2] bpf: Add check for negative uprobe multi
 offset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170292302389.20983.13395967238198421768.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 18:10:23 +0000
References: <20231217215538.3361991-1-jolsa@kernel.org>
In-Reply-To: <20231217215538.3361991-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 17 Dec 2023 22:55:36 +0100 you wrote:
> hi,
> adding the check for negative offset for uprobe multi link.
> 
> v2 changes:
> - add more failure checks [Alan]
> - move the offset retrieval/check up in the loop to be done earlier [Song]
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next,1/2] bpf: Fail uprobe multi link with negative offset
    https://git.kernel.org/bpf/bpf-next/c/3983c00281d9
  - [PATCHv2,bpf-next,2/2] selftests/bpf: Add more uprobe multi fail tests
    https://git.kernel.org/bpf/bpf-next/c/f17d1a18a3dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



