Return-Path: <bpf+bounces-62363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F92AF85A5
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 04:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841B4548409
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 02:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2181E2307;
	Fri,  4 Jul 2025 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsLHSdmm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9F1DF982
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751596815; cv=none; b=Us/Bs9DdzXcmy7asOHsfmFzzMFnZt3WX4Vf9VEilwTVI/wFe2ipfqzNufGyztBGKHknXStcUbr26OIjYjIZ9YuUkWBAqaU40jsPYZv6PCOfwV2T6OGAmJSTop2Q4gF9CQxVz0zKGPQMZOCAspLkUOOZQimQgql8W6zfq6PitGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751596815; c=relaxed/simple;
	bh=R8E8pOivnBND12VCASaSTi/E4dtGKEDHcWJY0SESKvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gh6U/qE0LP1FWlP5jlyB8508vgSo7SH5Sjl2/3jsOwWSPAH944w9E4U4MQyKZpJm2pYcvfGwjE0nhbX0XtcPs6xlZOJC5K9fASAK9A5mlcQ9PwkLy8Q5cldMFZ1n4Stw8CnjH7D7SFFt1Zl7UkjAiR3Dwu0reQGF6bqftwCzGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsLHSdmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BBDC4CEEE;
	Fri,  4 Jul 2025 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751596815;
	bh=R8E8pOivnBND12VCASaSTi/E4dtGKEDHcWJY0SESKvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bsLHSdmmTt/0r5HnkgNb86JkOVfsNVMyeKzMY1iIjtQEe4kJ9XsWDDC0eE52Uxkfw
	 5DxTGjNZTxNcBW2CEYDbp5+ijIlbiWIb6BLaIfxFxMGrujxiBrQHI5noETMTT9GDrZ
	 wgPrcDBF5Op1KpDpBiPBmI84tTGCkNCWOeM/4PHApCvzz6Z6ytliXyFkquOAED5cvh
	 nSkiyYV5nPfsFsKI45W6U40+9W5/qvosW/l6K2ycXsNB5FyfEoz+p1i0BbQ1QZaVeH
	 fJGpTQIzfJdujWW4DhObs3lpL/DK2Qh7NwgPIpePg6YVBuV0XeCxphfP2S+t5VTAzo
	 N5QtJwAJCFCjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B9C383BA01;
	Fri,  4 Jul 2025 02:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Reduce verifier stack frame size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175159683899.1682876.1128637938884150414.git-patchwork-notify@kernel.org>
Date: Fri, 04 Jul 2025 02:40:38 +0000
References: <20250703141101.1482025-1-yonghong.song@linux.dev>
In-Reply-To: <20250703141101.1482025-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Jul 2025 07:11:01 -0700 you wrote:
> Arnd Bergmann reported an issue ([1]) where clang compiler (less than
> llvm18) may trigger an error where the stack frame size exceeds the limit.
> I can reproduce the error like below:
>   kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds limit (1280) in 'bpf_check'
>       [-Werror,-Wframe-larger-than]
>   kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds limit (1280) in 'do_check'
>       [-Werror,-Wframe-larger-than]
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Simplify assignment to struct bpf_insn pointer in do_misc_fixups()
    https://git.kernel.org/bpf/bpf-next/c/3b87251439b2
  - [bpf-next,v3,2/3] bpf: Reduce stack frame size by using env->insn_buf for bpf insns
    https://git.kernel.org/bpf/bpf-next/c/45e9cd38aa8d
  - [bpf-next,v3,3/3] bpf: Avoid putting struct bpf_scc_callchain variables on the stack
    https://git.kernel.org/bpf/bpf-next/c/82bc4abf28d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



