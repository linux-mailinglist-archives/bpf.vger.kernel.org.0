Return-Path: <bpf+bounces-32682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA49118DD
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 05:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073CD1C218B8
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC48662E;
	Fri, 21 Jun 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYcHoq0g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BF8287D
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718938831; cv=none; b=p5JVOYZqEKh7Z58kr+qVBu4hqR6KgYCrF1x4F0VJYqPCPWjlW4+ztopQ68NCHc1oZDU6ZPC+B/7IQZEG1HiAm+WpSGy6PwsDIv9ezeOU71buPKbgoLIBuBUSGCKYC/nOb0fdmQsexEM5dDXzrofwypDR1RwsIv7WKGE59f9MUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718938831; c=relaxed/simple;
	bh=6bM4iK0IIICU2lIMg56KM0g4yd/L0DVmNBLlbV73gRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p1ixgo1HJkiIRhvs9ozvso0smfb9e23aqhGSxrqwyXzixyJUCEKul7c10DgTJeDg77nvPNxpsgebJix/gQKfaIS6kUG6Jlv5cVqk3bLBZUaIr5ThQ1CaAzSWmj1x+Ua7KdsqkzYi2Ov9XmU6gLZV06Qn+CFHO0Eu5G8K3iGicgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYcHoq0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25000C32786;
	Fri, 21 Jun 2024 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718938831;
	bh=6bM4iK0IIICU2lIMg56KM0g4yd/L0DVmNBLlbV73gRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iYcHoq0gG5h3HA8CfiUN/vNsjfLk0rvAYFJd3bcT2mYRHLfq6EPf5/55x5waFPqs+
	 XkEm7Ft3hlYpg5cdmqHhnlk4TcsApewyNiFZNQcNekALShb7e2DIjfi4GmzIVH51u3
	 H42u5BBd6SabT5sjQmkoeKI2r1pTkeLTOGr4hVevf70o/9CQDbBskkKmSAaAcKVWjb
	 h2vZduQ3OXC5/PerrqVb4xPtuPz8o4WJIQuB71DLLANnEKWFyhUQgcN1aRF1qp4IfT
	 bJ2fdr9r0d/VUn337sEztMOeEQubDOiTpKO/vR5u3rbyj9t5QpLVDGPK/3mSHMDFRj
	 aed/DVqDTW7/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D311E7C4C8;
	Fri, 21 Jun 2024 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] bpf,
 verifier: Correct tail_call_reachable for bpf prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171893883105.18859.5021464725449977226.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 03:00:31 +0000
References: <20240610124224.34673-1-hffilwlqm@gmail.com>
In-Reply-To: <20240610124224.34673-1-hffilwlqm@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 10 Jun 2024 20:42:22 +0800 you wrote:
> It's confusing to inspect 'prog->aux->tail_call_reachable' with drgn[0],
> when bpf prog has tail call but 'tail_call_reachable' is false.
> 
> This patch corrects 'tail_call_reachable' when bpf prog has tail call.
> 
> Therefore, it's unnecessary to detect tail call in x86 jit. Let's remove
> it.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf, verifier: Correct tail_call_reachable for bpf prog
    https://git.kernel.org/bpf/bpf-next/c/01793ed86b5d
  - [v2,bpf-next,2/2] bpf, x64: Remove tail call detection
    https://git.kernel.org/bpf/bpf-next/c/f663a03c8e35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



