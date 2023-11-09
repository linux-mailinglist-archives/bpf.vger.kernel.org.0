Return-Path: <bpf+bounces-14618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75F7E714D
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3541C208BA
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D28C347C9;
	Thu,  9 Nov 2023 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ias7VQ2g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8B32C94
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56DA4C433C7;
	Thu,  9 Nov 2023 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699554025;
	bh=ZWUYk1hWcIL6BC1lJxLuY/48C4hYdKovl8MKqNzryUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ias7VQ2g/UFO4gv2Qx605j+/Pc0v3oFgu6Vu+3sERZfejZ8SgGv2UxOk6aGi0ilzM
	 WkVIe7OKDiPYFd58YxVyibbDtzWOKTJXbTSoe3itOFFuP4o6JWOt5QMAr2G6y6PYD4
	 RwNTfyi5N2zboRt/NeD4PM5QDf5bPFz9sFaBMTBvSfaILymxnTEGXrrFdiUF1cL3Aa
	 NKMqev8M1h6bCKy6cX8SzVH0HSbr791ypV37XwOQNRSLMtHacS/NdRg8LfBTHnPz6Y
	 Ho6PPHPYbqM7mLRiXarByljHmaeLNencLb9+qlxvKS+90xyDeB9/1B6M7xDwR0NjKo
	 qoZLESbLPemAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 366C9C561EE;
	Thu,  9 Nov 2023 18:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] veristat: add ability to sort by stat's absolute
 value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169955402521.6918.2024940155187955055.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 18:20:25 +0000
References: <20231108051430.1830950-1-andrii@kernel.org>
In-Reply-To: <20231108051430.1830950-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 7 Nov 2023 21:14:29 -0800 you wrote:
> Add ability to sort results by absolute values of specified stats. This
> is especially useful to find biggest deviations in comparison mode. When
> comparing verifier change effect against a large base of BPF object
> files, it's necessary to see big changes both in positive and negative
> directions, as both might be a signal for regressions or bugs.
> 
> The syntax is natural, e.g., adding `-s '|insns_diff|'^` will instruct
> veristat to sort by absolute value of instructions difference in
> ascending order.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] veristat: add ability to sort by stat's absolute value
    https://git.kernel.org/bpf/bpf-next/c/dae6c6b3b79f
  - [bpf-next,2/2] veristat: add ability to filter top N results
    https://git.kernel.org/bpf/bpf-next/c/0ca98fca84b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



