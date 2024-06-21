Return-Path: <bpf+bounces-32772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA697912F91
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06A11C2237E
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1102417B513;
	Fri, 21 Jun 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2t4kkbc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA6208C4
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005430; cv=none; b=Lko4pshC/z/j5vly7MUzzjPV4t6GXaeuM30IH0akcOvKfGfMV4hsKYgK3jqydtTfXouFO2CErK0GlPRS0EQ7Q4RPgW27cBtdQy7EqDH7GXsjb6A35FklEzmY+8h7aV/Z+EebomqWC8hqP0lOgR6cLEvJsVK7HVPeAkV6pa6kfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005430; c=relaxed/simple;
	bh=sKoRLaQ9ofB5RIkr/xE6ReVLlIT/lA6CVN4yYqng0tI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QuhkhKnlJoLaplCfzHnk+nQURHGUrDtWCp3/VTfEyzqh3Pt4mE/yPWlhoyO+pyW8k52nXecS9Z7jkXG8xtpPg7xJ4MisFw66cxx3iSKIHrcnRu7/jI81gJmms2fMZP2kAqc8mV/qZt91fhoEVtmOA2XSmLM+JMqRHsq9VUZ7d2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2t4kkbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04904C4AF07;
	Fri, 21 Jun 2024 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719005430;
	bh=sKoRLaQ9ofB5RIkr/xE6ReVLlIT/lA6CVN4yYqng0tI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q2t4kkbcXy7KeHDNs5J29Gv9QR05EyXoUdMMx1Yp7wLNb5NMNOWPaDaYbPcjhO8qc
	 2VaogxJuyr2+Tf5Q3Jxu9y+4Ah63dBSUJnIazqNhu3xcukzRbgKfIYsJXR1ZE5iS+X
	 ooMlbVRYjSQnKEXLgdv0FyvOMvhzdK/cUsgZ2C9xsz72JrNZKdy9AJ+xoDA6yf7stC
	 TDyKb18Q0nniBDmGC+Il0eYKpP4TEKU6allrm1Gm0KvoePmTuErvBqDNtcPPZo2p1Q
	 0YsUwbeGn1MRMk3A9zn76swNDgk/1xkwYgmk8qXAkYCUqzPXeTTcsWwF6bKCDY9ru3
	 nfntQk7G7SB5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5AC9C4167D;
	Fri, 21 Jun 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix may_goto with negative offset.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171900542993.18811.7456455981671416318.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 21:30:29 +0000
References: <20240619235355.85031-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240619235355.85031-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 zacecob@protonmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 19 Jun 2024 16:53:54 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Zac's syzbot crafted a bpf prog that exposed two bugs in may_goto.
> The 1st bug is the way may_goto is patched. When offset is negative
> it should be patched differently.
> The 2nd bug is in the verifier:
> when current state may_goto_depth is equal to visited state may_goto_depth
> it means there is an actual infinite loop. It's not correct to prune
> exploration of the program at this point.
> Note, that this check doesn't limit the program to only one may_goto insn,
> since 2nd and any further may_goto will increment may_goto_depth only
> in the queued state pushed for future exploration. The current state
> will have may_goto_depth == 0 regardless of number of may_goto insns
> and the verifier has to explore the program until bpf_exit.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix may_goto with negative offset.
    https://git.kernel.org/bpf/bpf/c/635c7a3cb3bf
  - [bpf,2/2] selftests/bpf: Add tests for may_goto with negative offset.
    https://git.kernel.org/bpf/bpf/c/d3a2cbf6e4e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



