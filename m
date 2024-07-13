Return-Path: <bpf+bounces-34723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA719303D0
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 07:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A96BB22772
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 05:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762D1CA84;
	Sat, 13 Jul 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUy7bt5C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190BE4C8E;
	Sat, 13 Jul 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720849841; cv=none; b=IU+7I/66h4gYakKu+U869AchmB39tLUpj+vrEWTANBzdaI6ajlTCQHsJse9qO7Yp+z4N/rSjMkYNjcpfR9ov5eRhgpMCaRGvQRMzvCGqcctR2w25rlqWYq1ZXN2DZPhQSop7Cipktpz1+lg9f3XQgjupqN9Fh/PfbQI0n62J72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720849841; c=relaxed/simple;
	bh=4qsZalvQdVCplYoTbkKGrpD1b/HVopEBvVBlov+/N7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LbLFne/pHm44L0CO+9R2rUjOO6+NJT45dC2p15Np6vTpY3wU3hAUIsYL0K19006S4UO2KbB6aw6HhQAUKKfCFE6vKqIBdIm5QGBsra64qhN2u5HUAzPYF4Cv+vtnEchFQ+YQsWyoqQN9DjnMY0TX6OmIoAz7Yze8i+9u6OH01XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUy7bt5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE593C32786;
	Sat, 13 Jul 2024 05:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720849840;
	bh=4qsZalvQdVCplYoTbkKGrpD1b/HVopEBvVBlov+/N7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TUy7bt5Cs3THz7m/o6SYWEbvXLGIX0kLvOwcebtaEPTcHT2DhFzq3JWBi4SYSuj9k
	 91aGbrCNdU8zCKzLVGUFNJM0bcPNsAHPRxEqlWHshstdrA5N2I0LO1Jk/0z3D9DynO
	 4BrKEs5+B2Jrjo1v/fyWpDsqvtPqMDOyh9dlsfOFFSXFF0JEs2BcACdXv+LVWlOMxT
	 obRShCBXzh7+TZaCMoSUjcAeZSBj7iLhiBeoKJUvFjWJEWba7UREYhlLfi/fUocJdr
	 dl10dgMZbjzn7dMFXeSd/9mfaH+TuiXjD5japNsCb70gjEkYnuS4Ii6lLe8zYi8no4
	 0zVF6NWxIe5Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98983C43153;
	Sat, 13 Jul 2024 05:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-07-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172084984061.15436.4052967483289832988.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 05:50:40 +0000
References: <20240712212448.5378-1-daniel@iogearbox.net>
In-Reply-To: <20240712212448.5378-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 23:24:48 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 23 non-merge commits during the last 3 day(s) which contain
> a total of 18 files changed, 234 insertions(+), 243 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-07-12
    https://git.kernel.org/netdev/net-next/c/26f453176a66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



