Return-Path: <bpf+bounces-79170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11043D2970F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 01:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1BB03013339
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 00:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3B308F3A;
	Fri, 16 Jan 2026 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icTY1lTC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59A1E505;
	Fri, 16 Jan 2026 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524216; cv=none; b=h9TdJiKGU6J7j/5xTwp+mhvyt2uVAjMHwAt/x0BCEaTClNkj1DjR0+EAwAt3/kKzdtktHv/aASxJulOvVfrwbrpHoAZ7A+LHdYuBn3IBbS4HXA2edPhbrwNDIOglHWcC1CPWe40Ms5jL39lGu0hYxj9kOmNj9k/Aq1cGLjX0cFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524216; c=relaxed/simple;
	bh=9keAJjnhw1gCE+azgxtlmJQmRyzmwC1hmC4fiX8WgoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TyN6x8JEAEOB863NBLLdevPW6UDWSkEINbE6FUVoJc78UKCBJhVw1sJPfOyR+G6WQqtTAXu3I7OcVhur1SujTn/FfD+7TlSewupAg8mgUxsb4e73SNF9ywaG0ul4zoRARP7tIWET70vX2QvSm6BavHV423FxWxOpsn6nruQj3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icTY1lTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD27C116D0;
	Fri, 16 Jan 2026 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768524216;
	bh=9keAJjnhw1gCE+azgxtlmJQmRyzmwC1hmC4fiX8WgoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=icTY1lTCYROv7LHIqbjbv26JLIe+mgKxBsRtl+WzeTGDbitI8TqW6o1iF+OxMpEnw
	 rhgF4+ev+C927l9Eg30tA9s+VSZL+yQnw6/aQJDRMYRPqE7DHvITeWD058pqE8v9d/
	 UyhTU2pNYiBQ5NHPpVaAC3yXdXqE9km5MqXGJq+v+zGRRLpHIBJzXalIr43sqNCsGt
	 kPWsjTPv4fWvvK4Lb50SXDRxvmGrVcOyDWJ935mrWeC74vxSjcFU7PrlklWkXTGVhx
	 XBhMGltkz0YMyse4IzrgnMCyb+ni7qP1ufMZfG8YhLfopXnXhxOYtQSiqfIxtvky8W
	 krHkpY9bnwaww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BD0C380AA49;
	Fri, 16 Jan 2026 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176852400806.26467.15167160333849251669.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 00:40:08 +0000
References: <20260112121157.854473-1-jolsa@kernel.org>
In-Reply-To: <20260112121157.854473-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, will@kernel.org,
 mahe.tardy@gmail.com, peterz@infradead.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, yhs@fb.com, songliubraving@fb.com, andrii@kernel.org,
 mark.rutland@arm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 12 Jan 2026 13:11:56 +0100 you wrote:
> Mahe reported issue with bpf_override_return helper not working when
> executed from kprobe.multi bpf program on arm.
> 
> The problem is that on arm we use alternate storage for pt_regs object
> that is passed to bpf_prog_run and if any register is changed (which
> is the case of bpf_override_return) it's not propagated back to actual
> pt_regs object.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/2] arm64/ftrace,bpf: Fix partial regs after bpf_prog_run
    https://git.kernel.org/bpf/bpf-next/c/276f3b6daf60
  - [PATCHv3,bpf-next,2/2] selftests/bpf: Add test for bpf_override_return helper
    https://git.kernel.org/bpf/bpf-next/c/934d9746ed02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



