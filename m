Return-Path: <bpf+bounces-3170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6994673A7AF
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22924281A89
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DFB200DF;
	Thu, 22 Jun 2023 17:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA93200CA
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF8DAC433C9;
	Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687456220;
	bh=mecX4VsAue/U5mGaZYaeZjDfxNsXiRLEKNUKCBGBf9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UVQwAGwL9AJBkCoCU77NSU5DqR2nJ9N2id/uHHygN85XkOFAchKj7ShUlbuboUCy3
	 k77NRcil3kvmmYSZLyIxng7heNokI39It2xXZrqMNuardOxFVKntmg//xpVdBamASA
	 lGyUkDp8eA540/CzXeL+VydggQ697XaqENuCOcvqW9OHjm9LiILCX53dYGSRVgWtkq
	 uW9NBt27hsrvMq732fWxpukk/vWR0lbzM6xObuJ625PnZEM0ybDTAdn5uyl+rRpEg7
	 p72TRqIqDlkVnOpuo3YltXLvD2BJN/Z1f5U3Tg31nnkrqBNNdniImlf3M/2l2syI4u
	 cnXGhmzy7teFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ABEEC691EF;
	Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: BPF Iterator Document
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168745622062.7216.11212431697621652773.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 17:50:20 +0000
References: <20230622095407.1024053-1-aspsk@isovalent.com>
In-Reply-To: <20230622095407.1024053-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, void@manifault.com, psreep@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 corbet@lwn.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 22 Jun 2023 09:54:07 +0000 you wrote:
> Fix the description of the seq_info field of the bpf_iter_reg structure which
> was wrong due to an accidental copy/paste of the previous field's description.
> 
> Fixes: 8972e18a439d ("bpf, docs: BPF Iterator Document")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  Documentation/bpf/bpf_iterators.rst | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: BPF Iterator Document
    https://git.kernel.org/bpf/bpf-next/c/2404dd01b534

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



