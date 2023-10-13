Return-Path: <bpf+bounces-12166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4B7C8DEE
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E3FB20C4B
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 19:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C724207;
	Fri, 13 Oct 2023 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al6hiEek"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE49C23751;
	Fri, 13 Oct 2023 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 769A4C433C9;
	Fri, 13 Oct 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697226623;
	bh=nU3lfWuOBJCCDbTdLJSxPtsWLHy5KsIcr+GcaO3kyFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=al6hiEekNz3FwJh7qBx/C21CQop2AauBSfo0RIxca8ASDX9XnCxSBR0P6NOBk4Jwy
	 ++ViioRDyeOh9ZEtu20m3JwHdQLVeksJF+R1Hekf20Ce+fpEC+321324JjKIbRR0CX
	 UfiC26O8Ung901hdhCfbHVNtASMwy6DlsJ/fdjbe2itGfO8brbvCPqsP3oHhVdFnnu
	 h7kDz44LOtHw47UStZDP+ZhBKbp+MGEcL+ggZ2DLLF9yvBaiZZrW9ldWRGKDSKp7hY
	 GJpVXq+BEO6Em97Tm18Gd5+7FbLNjLOQoBNnOTyqyz8AJQT0Gdc1Nfwve9sNHW2sRv
	 +1mSOKLVRE3Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EA11E1F669;
	Fri, 13 Oct 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: change syscall_nr type to int in struct
 syscall_tp_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169722662338.10738.1648512697831961767.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 19:50:23 +0000
References: <20231013054219.172920-1-asavkov@redhat.com>
In-Reply-To: <20231013054219.172920-1-asavkov@redhat.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, tglx@linutronix.de,
 linux-rt-users@vger.kernel.org, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Oct 2023 07:42:19 +0200 you wrote:
> linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add support
> for lazy preemption")) that adds an extra member to struct trace_entry.
> This causes the offset of args field in struct trace_event_raw_sys_enter
> be different from the one in struct syscall_trace_enter:
> 
> struct trace_event_raw_sys_enter {
>         struct trace_entry         ent;                  /*     0    12 */
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: change syscall_nr type to int in struct syscall_tp_t
    https://git.kernel.org/bpf/bpf-next/c/ba8ea72388a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



