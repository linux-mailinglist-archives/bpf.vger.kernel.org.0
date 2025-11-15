Return-Path: <bpf+bounces-74616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54103C5FDAB
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EFE3B72B9
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F11DF273;
	Sat, 15 Nov 2025 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXZEW2I9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954711991B6
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172139; cv=none; b=ThDX8jPqjJmq7+Su76UGhme4MLxF64NqAmZUKIIRztNKAQqsYnFAtwNf/jJFlP1P5YPZ39eqbeEUBEoPAnFgR2C3BJjxQq+qdu/SsZuT5L8STVrucxPpv+cneKGrFZ35MfjeocvzhNosNM8XA/eq9fu3gqqeiY4MTEdzQFEOUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172139; c=relaxed/simple;
	bh=laahksX39FR+yzamh/kc4lhR5MJ0kXBayQxcHLEmHUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cntAQOU7H9a6qAbnZZQypisyRGLNj+VT4kQrT597WRtJ4gR7FI+52BTJQc7U/h7B1wWmnhGIKaBqOJO6+YljpfOfO735Qp4v9ulIakUdL+ymgfMszUdPx3Tu5vHalCbMxyW1pqZP5x3S4ib1xcPadibXBifBQVFkP15Wqg1US8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXZEW2I9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0580AC113D0;
	Sat, 15 Nov 2025 02:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763172139;
	bh=laahksX39FR+yzamh/kc4lhR5MJ0kXBayQxcHLEmHUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jXZEW2I9iLM1ZzIEqDyCjTHvQ3L8g15xvry0bok7EP388oWkL26tYScAaQB9oNW7W
	 tfqgLvR1gOnNkN/fPuYBEx4/q/UhqjmKw0BhEp9Qka91SzhpsxlJPxlN7dK4t3boi3
	 8H5iBY41K+mSwDQDQaBo5l/4VbweW93wimejjXDnK65IYNbatovAVyTnJmtWZhr0iP
	 KPAOVZJZ7j6ZgXeYlpjfKi4i4wSSDtHF01QXM7HyozkRnN9ORHDi8dc3sN+uarPWDp
	 ascGrGZ16tIoTS3E7DyHnRyWCvXjqqK+ONBfssSajni2H5Unz78lp/NJVcgHoqnK41
	 oOIPZCmmvxjJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C433A78A62;
	Sat, 15 Nov 2025 02:01:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: align kfuncs renamed in bpf
 tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317210727.1905277.5246260123359446508.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:01:47 +0000
References: <20251105132105.597344-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251105132105.597344-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Nov 2025 13:21:05 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf_task_work_schedule_resume() and bpf_task_work_schedule_signal() have
> been renamed in bpf tree to bpf_task_work_schedule_resume_impl() and
> bpf_task_work_schedule_signal_impl() accordingly.
> There are few uses of these kfuncs in selftests that are not in bpf
> tree, so that when we port [1] into bpf-next, those BPF programs will
> not compile.
> This patch aligns those remaining callsites with the kfunc renaming.
> It should go on top of [1] when applying on bpf-next.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: align kfuncs renamed in bpf tree
    https://git.kernel.org/bpf/bpf-next/c/a4d31f451d5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



