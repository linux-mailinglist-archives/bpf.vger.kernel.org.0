Return-Path: <bpf+bounces-18561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB0981C077
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 22:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6814A287253
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AAA7764A;
	Thu, 21 Dec 2023 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXmK22sa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD776DB6;
	Thu, 21 Dec 2023 21:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 064D8C433C8;
	Thu, 21 Dec 2023 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703195439;
	bh=BVt/fwdQj/md7LwddMATtzSGv1U/fmfWiSSpa2xxJ9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXmK22sarq5w97AXfj8xxEBGxdIQxWagbRWNYVDB+80lwLNJrutt2HyYieSXCA/32
	 ocx/eBaDBm76KNBY9lIsEW1XgRG2MSVElp9EDjU/WJMRJWgu2QyKbOwCUrJpga4NsJ
	 0rKXziTcLhNfHEkMkS4uYH239J5OTiFkfDKGoFbf0fuRXEtzzS9dvS33gQdqiEo69v
	 i10ooVve4mpFVM7EJkjb3jU+X+aVahdYYHbuB17rmGxsFj9WL0C+Cpa5GALZpPg51A
	 l6k33kg7KMxpuCG715q5evOFqFEnnMIGNlGK1WW7WM/ufLekLaj/wzi3+l7JvohOVw
	 oRFVvZEpcmfuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEA9DD8C98B;
	Thu, 21 Dec 2023 21:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Avoid unnecessary use of comma operator in
 verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170319543890.6692.13624656826771663357.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 21:50:38 +0000
References: <20231221-bpf-verifier-comma-v1-1-cde2530912e9@kernel.org>
In-Reply-To: <20231221-bpf-verifier-comma-v1-1-cde2530912e9@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 21 Dec 2023 18:03:52 +0100 you wrote:
> Although it does not seem to have any untoward side-effects,
> the use of ';' to separate to assignments seems more appropriate than ','.
> 
> Flagged by clang-17 -Wcomma
> 
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Avoid unnecessary use of comma operator in verifier
    https://git.kernel.org/bpf/bpf-next/c/5abde6246522

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



