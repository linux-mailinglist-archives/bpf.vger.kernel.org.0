Return-Path: <bpf+bounces-20425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772FA83E25B
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3317D28305F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771F224DA;
	Fri, 26 Jan 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuhGNL8R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4AB224C2;
	Fri, 26 Jan 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296826; cv=none; b=I89KEs56z9BWfRqiARZJUIBgxa5WZG+KwIPPIciWbNJyLiy/86v49oy+rmmyUQCpR31G7vR+6gAffsdEeNBR9hOgJxFEvbr4G5HL2bulARuWvEuN9RI4zDBKM68FtXxBiOyL0i3hveYemKBUvCFOGS/8Q7Rjbxa2VlzIuLrUcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296826; c=relaxed/simple;
	bh=wBHTKfWSi+/4I4h65nrACTgHp4mc8/p/Rp6g+T7YDuM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HPUix5jlFGzrsG4eF/uPPqnaltyionDNeVTZQ+u8R8JR1vVOsrzip660+kqKrBJ5ZR45qby09e00qG2cRJSmOmL5Gkw1YOzpdpmBB4LcHYmiMYse2UendnHH+A1zMSibrLU8NRdj6BOD96iv2gqMEAwBLqbyXxMIM8T40ZNVP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuhGNL8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB42FC43394;
	Fri, 26 Jan 2024 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706296825;
	bh=wBHTKfWSi+/4I4h65nrACTgHp4mc8/p/Rp6g+T7YDuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KuhGNL8R5cT+uN5LclMRH1WGu2VBMAxz/gKePdy25BoDkwd3n/YgelMpydWA3KHjg
	 b2ftehftmXVNjIU1dkURBW1qhs7J6/sRzrW2z8DiLrBACr+5cE0yQG+X4iOpV3tUfH
	 LKKFjx37izTWywoEgsvkqW/QrfEfQ4VxesPg0ZC/CnIzSlMbMoZvy8V3LpxrhG1D0+
	 ONK1Utkk9TezonXO459b6/A9NQkvKzfIMI5rSpjPUPB1tVfQmevWBpzB4bhlIFe+59
	 VAibQjFnLUudOCXlRXHWVrJEdNuYdZsWZQMgoykFOJP9h46OlLRKbVZSjdA2Pltw1E
	 4EF/7+0/5GH+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C38DDD8C962;
	Fri, 26 Jan 2024 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add missing line break in
 test_verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170629682579.29810.16491106487245161634.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 19:20:25 +0000
References: <20240126015736.655-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240126015736.655-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 26 Jan 2024 09:57:36 +0800 you wrote:
> There are no break lines in the test log for test_verifier #106 ~ #111
> if jit is disabled, add the missing line break at the end of printf()
> to fix it.
> 
> Without this patch:
> 
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# ./test_verifier 106
>   #106/p inline simple bpf_loop call SKIP (requires BPF JIT)Summary: 0 PASSED, 1 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add missing line break in test_verifier
    https://git.kernel.org/bpf/bpf-next/c/fa7178b0f12e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



