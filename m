Return-Path: <bpf+bounces-62018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2250AF06A4
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 00:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F891C0690C
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C4C281531;
	Tue,  1 Jul 2025 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH31O3/n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A719995E
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751409583; cv=none; b=JBtJqbsAIcsFSy2IvFaVw9QluxOu36dRrWE7j+8nzTRAQyY6z4AgtAz0PE0/UDBi6oHPiUtxLqlGulF0zDLl6iTZRkzqHcWZbUeZuhsgzxruMCONBRSVpsrUNHwcKjEaJz+uKhT6BJUupPe1BfJQIntC631W10gPISYWgF4xous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751409583; c=relaxed/simple;
	bh=6uOSV79UWBpRxQbxNYdSmZnV3LXnuQFcpuFG3S+Ayl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KBu0t6KgRH13VTI/lOAelixJnflfBxZNHkKplFyEviCfTDuiKcvztxeCQ+vBXiq8ov8+vdPtFZUIkekHG2DqTcQc11OCS3CwPDoVFFWKeCuJbBMkKGGFVMcOrbYtJ99iGNYd4fWeXt1vCoBcK4Osmk5Nf7iCTb7CvuvB5FVd9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH31O3/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B68C4CEEB;
	Tue,  1 Jul 2025 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751409582;
	bh=6uOSV79UWBpRxQbxNYdSmZnV3LXnuQFcpuFG3S+Ayl0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UH31O3/nGnHAp1MaDxGjkI7E85RIGRy0TOeBStOWR0Z7+CZx3tGkkzI3HYmF4ecys
	 GBWeZ6yAKl6BmQedDSgFE8JtBkwpHhgL85le2YkuNfTcGOopDaV5kk1Fs3sXQf4b17
	 dagg37jqKWJ7alaZ3CD6zM/9bJhVdL1QOtt+RppS96dIApLbNF9eYd1eMbSiAhGIJy
	 KAyTe0jSEGmqp/Er0p2PAkGBISaJQP5km/A9xWlFfJyE2vvFhPaRL5mQJgAPipg0wC
	 XAOmBUsO0OQ3rI1BeecCKG2X/vn25CkFVoAFpwknbMK2VFEDDIN3tRnsUT2nKd+vLp
	 XV0dQolMSvFVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB0383B273;
	Tue,  1 Jul 2025 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: Reject %p% format string in bprintf-like
 helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175140960752.138502.12465421802586850998.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 22:40:07 +0000
References: 
 <a0e06cc479faec9e802ae51ba5d66420523251ee.1751395489.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <a0e06cc479faec9e802ae51ba5d66420523251ee.1751395489.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, revest@chromium.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 1 Jul 2025 21:47:30 +0200 you wrote:
> static const char fmt[] = "%p%";
>     bpf_trace_printk(fmt, sizeof(fmt));
> 
> The above BPF program isn't rejected and causes a kernel warning at
> runtime:
> 
>     Please remove unsupported %\x00 in format string
>     WARNING: CPU: 1 PID: 7244 at lib/vsprintf.c:2680 format_decode+0x49c/0x5d0
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Reject %p% format string in bprintf-like helpers
    https://git.kernel.org/bpf/bpf/c/f8242745871f
  - [bpf,v2,2/2] selftests/bpf: Add negative test cases for snprintf
    https://git.kernel.org/bpf/bpf/c/bf4807c89d8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



