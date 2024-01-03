Return-Path: <bpf+bounces-18880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE1823445
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D081F252F6
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7291C69F;
	Wed,  3 Jan 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLk6wSlJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AA1C69C
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3FEDC433C9;
	Wed,  3 Jan 2024 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704306027;
	bh=8w0Nvd1ELbOqw80wG0/as0qKKWEpX/2G9Pr+I4Oht9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HLk6wSlJjkfPPowIm88DjPNH/6rz4Ul6/HklurR35+MF+W7NcTFYeOKA1kwqFeWYl
	 BRAE2+vDcUDlSmzfRaNa1SEcOgoSlM9d8JZXmW61MQHkNoqyMQWP2x1HX/xJUpWREk
	 S7zSrw+IHFwF02WMXgKyjQ2Nbbp+NYQAI/MVqKYAuWu8Xe0DOZunn+kSv65CwgIKqK
	 /ZrNRBNs2CiEhayRWVZ7Qdnpmiqr6stbwrian9VP4f2+PW1UvtIiUIyaxQCcdpShDi
	 1zk12xgFlghLX4pLmtKzc6L7ucLxYuAd3Mz00sQdIPbPzdmAdnlluIrWj0T9xaLLdY
	 1JuyucecTNNEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CD84DCB6FE;
	Wed,  3 Jan 2024 18:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Simplify checking size of helper
 accesses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170430602757.21278.8763472170745604411.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 18:20:27 +0000
References: <20231221232225.568730-1-andreimatei1@gmail.com>
In-Reply-To: <20231221232225.568730-1-andreimatei1@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 21 Dec 2023 18:22:23 -0500 you wrote:
> v3->v4:
> - kept only the minimal change, undoing debatable changes (Andrii)
> - dropped the second patch from before, with changes to the error
>   message (Andrii)
> - extracted the new test into a separate patch (Andrii)
> - added Acked by Andrii
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Simplify checking size of helper accesses
    https://git.kernel.org/bpf/bpf-next/c/da0391947c10
  - [bpf-next,v4,2/2] bpf: add a possibly-zero-sized read test
    https://git.kernel.org/bpf/bpf-next/c/faf05f4d56a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



