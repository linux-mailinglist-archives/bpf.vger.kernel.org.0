Return-Path: <bpf+bounces-39095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4996E83C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 05:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1C9B21EE0
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E894938DE9;
	Fri,  6 Sep 2024 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7RoTCV5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16FEC2;
	Fri,  6 Sep 2024 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593456; cv=none; b=EgcEP9qdtBvKA52o2gkuXPEEodCCNpXYoTFeO/iNL9n9jhtP4sWqy60hl6dviVQXONNW0s0DrK9tBYITk64UB3NBsVaxSP0gBU2BoyevZHCRSOBnN8qr7+ndAkyruIGuOhyJ0j0WukXbKt1qsKjgiw+yi2ERWmnVWgt7uD0SGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593456; c=relaxed/simple;
	bh=zpRS6zYBsuIvf86miaQp+MV+b63pO9xGFQhCG+KzRAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MOhZp10Xp7LeRFlwt9Npi1SOFJARQfJiQD4NPgsKXDegq58HuINatf5D7OKMrXcW59H6qeEi+t26EQuyoey9UkI3K4xm3m0viMBh/ltmSVZRGMRS/V5bu4cS4MXFcXriH5l3gVPXCZ3yqA63/8Mq1ctkAkdy0SDwPdTvyWZD+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7RoTCV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F3BC4CEC3;
	Fri,  6 Sep 2024 03:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725593456;
	bh=zpRS6zYBsuIvf86miaQp+MV+b63pO9xGFQhCG+KzRAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t7RoTCV5Js1fz5k8UhH6ezIm1ZgPAO78zPWYWKl2emCs5a/tTPYYNAHwEC4k6U3fJ
	 i4KM5z1dNr/JEQV8M4MzG4p8eeASl4h5mCIeWvzKKncVHpeY2MkuUwzNAIUA6Xd4KJ
	 5Nh7FYd9So1LUSq/4DgJ0ZBcjwnMlK8RzATjay//O0YrulLmqNXjPFuw8y2s8rfUA1
	 cmjeMAKBEXnKtoqcbMVnsPt7OLqq8qE86lsVmsLpzfzmnbutmsnA7fn9tsjZs6c5kn
	 OskiYJWHBEwODYHfmb8cDgP/h98mSWKAQrfbE+17MKSmLK0WSuBPFQFlI7GxgNfG+s
	 127LDfDagjlGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0263806654;
	Fri,  6 Sep 2024 03:30:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [for-linus][PATCH 1/6] tracing: fgraph: Fix to add new fgraph_ops to
 array after
 ftrace_startup_subops()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172559345660.1921528.8553366944202298959.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 03:30:56 +0000
References: <20240904234427.612375392@goodmis.org>
In-Reply-To: <20240904234427.612375392@goodmis.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 alexei.starovoitov@gmail.com, revest@chromium.org, martin.lau@linux.dev,
 bpf@vger.kernel.org, svens@linux.ibm.com, ast@kernel.org, jolsa@kernel.org,
 acme@kernel.org, daniel@iogearbox.net, alan.maguire@oracle.com,
 peterz@infradead.org, tglx@linutronix.de, guoren@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Wed, 04 Sep 2024 19:44:12 -0400 you wrote:
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> 
> Since the register_ftrace_graph() assigns a new fgraph_ops to
> fgraph_array before registring it by ftrace_startup_subops(), the new
> fgraph_ops can be used in function_graph_enter().
> 
> In most cases, it is still OK because those fgraph_ops's hashtable is
> already initialized by ftrace_set_filter*() etc.
> 
> [...]

Here is the summary with links:
  - [for-linus,1/6] tracing: fgraph: Fix to add new fgraph_ops to array after ftrace_startup_subops()
    https://git.kernel.org/netdev/net/c/a069a22f3910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



