Return-Path: <bpf+bounces-12163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E6E7C8DD6
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F237282FCD
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06721A0A;
	Fri, 13 Oct 2023 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD8LmCdV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462C23764
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BFEAC43397;
	Fri, 13 Oct 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697226023;
	bh=lsh1fU6p0+JHhCl5bLlCJ5zOKuvVIF53P7e+Seu7WQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hD8LmCdVSMNi0E9r0RrGIa7+KD5NtwhdWOF1KDHcn745DfJ6of7eqyKiWT0GP430y
	 E/fXt1o+7ANjVjHufLThJj4A2hyHdyEs/n0aBdgZoKrCN705/1dQpDoiY6tlez4S34
	 UOWhESHGDb501FzZ8fpMRK9YHIyWz3u6GNHP2BmMDIXCzu6kgxLbp9W/3ADDo1bsUB
	 pZbiZsDPC6CuIOQTUGA16q/ZnRGdIAMA/fUYb0qc3qotM7YzVJsBd7s76caclKFxpO
	 rTT6w/utueL1ILZ0JBG36+bUhx9b9T5QhPjbeqo4bqjvWI70/IQuJduLKI88opf/pT
	 4iOy2eHToYs+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F530C691EF;
	Fri, 13 Oct 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Avoid unnecessary audit log for CPU security
 mitigations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169722602312.5697.7407014423519491804.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 19:40:23 +0000
References: <20231013083916.4199-1-laoar.shao@gmail.com>
In-Reply-To: <20231013083916.4199-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Oct 2023 08:39:16 +0000 you wrote:
> Check cpu_mitigations_off() first to avoid calling capable() if it is off.
> This can avoid unnecessary audit log.
> 
> Fixes: bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
> Link: https://lore.kernel.org/bpf/CAEf4Bza6UVUWqcWQ-66weZ-nMDr+TFU3Mtq=dumZFD-pSqU7Ow@mail.gmail.com/
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Avoid unnecessary audit log for CPU security mitigations
    https://git.kernel.org/bpf/bpf-next/c/236334aeec0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



