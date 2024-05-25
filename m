Return-Path: <bpf+bounces-30597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415508CF096
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35E0B20FC1
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8865127B54;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNx8xB+h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AA58ABC
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659433; cv=none; b=J7QTnQlozyFaH78V42M34J2NFbHgkMnrCm2FdwxLjAozW8uhwYs1VtHDbXxhj9vos08EYzBbyg6dO1Ga8oNHDh9izRPgdm+zwKXdmBH1TN4L0V2WkwiiYgKDpRs34iQ38vXH1eYFNPxH4hsgejfO8rUqpy1mbj4p/b5WbleOVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659433; c=relaxed/simple;
	bh=eH7MQF8SqhNKTYJTQ/KCW8dc50zXPvO3JXyabW9f7+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kAvSSkLpuaN2Dsiyzi9S4Qdi8k5dQVwU+0k07gRHGBb+GfkmzPoodC3wx+YwG5Z2WhcwMa+zAO/hBrpV8UdOaUHYtWbX0whB4hbx1ZMBd2Hsn1NCEaejAMP8z31uHFtBL3z/j00a9eNmL/ZbdnvIJMTWiAvwemL88pOz9gTlqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNx8xB+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D7DC2BD11;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659433;
	bh=eH7MQF8SqhNKTYJTQ/KCW8dc50zXPvO3JXyabW9f7+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uNx8xB+hpTCe9qWm2U/Y7iOhXAswkH+uWgbmcc+6hx5CgRj9SzgMCLrR7eHYVugr7
	 aADrW+cxaQxemAiLgQR8eYm/RWbgLaF0q979z4mt+2t2uqHuBybDGTa3YNpZmaIk8T
	 nlcnSajb9QHc6+CKxwslnnVxmU+bMqPC+pM1kNYWNXI5gqOTxrwM4pXAkmRpq0qlvz
	 JrIbHvYsS5CA2q9k3LKa9zOHXqtE7h2wGvSqIuoqUriuq5QC5zI/OUZKRG40nGq5i0
	 U+WGIE+PvHPNE42HeCGx/W/wSxyB80+M1GtZ1QoWC6gt5Y9nCc4t8TKPuMwHaB4lUs
	 fsteyg5qYrRSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E171C43333;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Clarify call local offset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171665943311.11416.10113985377422205193.git-patchwork-notify@kernel.org>
Date: Sat, 25 May 2024 17:50:33 +0000
References: <20240525153332.21355-1-dthaler1968@gmail.com>
In-Reply-To: <20240525153332.21355-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 25 May 2024 08:33:32 -0700 you wrote:
> In the Jump instructions section it explains that the offset is
> "relative to the instruction following the jump instruction".
> But the program-local section confusingly said "referenced by
> offset from the call instruction, similar to JA".
> 
> This patch updates that sentence with consistent wording, saying
> it's relative to the instruction following the call instruction.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Clarify call local offset
    https://git.kernel.org/bpf/bpf-next/c/f980f13e4eb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



