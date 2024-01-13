Return-Path: <bpf+bounces-19514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F37E82CF5A
	for <lists+bpf@lfdr.de>; Sun, 14 Jan 2024 00:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3549B2217F
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D774618040;
	Sat, 13 Jan 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OseL9Nl4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB851802B
	for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 23:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAF0DC433F1;
	Sat, 13 Jan 2024 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705187424;
	bh=TQSsf9IqR/KJo/Vbr5PBBU2Ravd2vf5uyUP3BGlF7HE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OseL9Nl4wEGbU8nAGtOxOhhzUq+eO0x2j9WyV/PorKBcEqBFJZUzmuT15gNqb0kCK
	 KkTzif85Hi3oJLofym3e+/VZzpGVIrWRHr6VyRKj899iZ61GNRdq+rAM2Uw/MDfVcW
	 vHS3tLR3DlxH5kAmC8KVogg2Gbm/oXSLAziNDM37j5HNlik71k8AV+2M59FiLngxlU
	 tid4Ot7wr05NHZ/0sfoVpChbw5CRwIoqmQcuWF47J1uavftotFZW2B2upXZ6ypUA5C
	 2onG1LNWxFhuxOYzcWI79zGfY+mm8DU3C684cmU0zo9qcwbzOun0Jy3KMrNrPk2sI5
	 9l+dh+YRvUtAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C080ED8C972;
	Sat, 13 Jan 2024 23:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] docs/bpf: Fix an incorrect statement in verifier.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170518742478.5569.5068332991308877128.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 23:10:24 +0000
References: <20240111052136.3440417-1-yonghong.song@linux.dev>
In-Reply-To: <20240111052136.3440417-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Jan 2024 21:21:36 -0800 you wrote:
> In verifier.rst, I found an incorrect statement (maybe a typo) in section
> 'Liveness marks tracking'. Basically, the wrong register is attributed
> to have a read mark. This may confuse the user.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  Documentation/bpf/verifier.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] docs/bpf: Fix an incorrect statement in verifier.rst
    https://git.kernel.org/bpf/bpf-next/c/90bde89658fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



