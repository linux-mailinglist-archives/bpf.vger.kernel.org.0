Return-Path: <bpf+bounces-75287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D0C7C25B
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 03:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C25C4E14E7
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D59156C6A;
	Sat, 22 Nov 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY5BF+ML"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB12744F
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763776847; cv=none; b=VBOJMsIr4p8Y4+G6jCLL0k49rjzq6F97WVz4xijtWBB0cqnLRLDVCOSH4DCovD70ukr7g7F6EhgX09uFKeDUrbX1bLGpPTsnuefg7BEO8PWK00GkfmJUT+U/ze6/5IiNWSxbdS7pnA4DxoL0zxPbkj7CuLZcjvW6bmyVdyiawGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763776847; c=relaxed/simple;
	bh=TxShgYcHewWnWGUsdLCGRApSD4MgNQsD5mjR1ki+lA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lLsRgyfC1oAuYcnfN0Hb5Viy+exjNgg6hgmRkFtHz0hon5ae3mMFknxvRukFwuyo86RgNTG2tuh0SluUykPrK6OL7LdZXorxVwg31d+2ayitjmjXScYGW7eKazwwYU+d/lss00wmZ6ApW2Km8Ojfa8b3OEkl0FyGnf34pDEk8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY5BF+ML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E61C4CEF1;
	Sat, 22 Nov 2025 02:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763776847;
	bh=TxShgYcHewWnWGUsdLCGRApSD4MgNQsD5mjR1ki+lA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MY5BF+MLDwZtH3HhVvTgyiyDPtTnQiEeVu3Bs+0n+abq/NJYwTIowwaeOohZLRryb
	 TjrRJV/ol+bwET7WJ9otD/Lu8gum48zMEw3oxo0MJvxhXvLP41sMZLJWaebr3/X8Rt
	 Nifw7zGjAsSTTphYBxtq9lED2STugbAz0bLqS8V3swp1kxuffAr62XOQHrpl6CgJKT
	 Sk+l3nrFWTnkLwY6FVksLkrEYP97/MAplBZn+La3hYlYcFf50yq5ntZcDDU3yEllku
	 H2Lwy5aFtftVGKN71PGZE1B+m+LGR32UURDrx9Q29GcYSkWIjdc/jBpdW0YmPrJntj
	 /gw0kjXLsouFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE06C3A78B25;
	Sat, 22 Nov 2025 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 1/4] bpf: properly verify tail call behavior
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377681153.2652870.3268591682948216307.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 02:00:11 +0000
References: <20251119160355.1160932-2-martin.teichmann@xfel.eu>
In-Reply-To: <20251119160355.1160932-2-martin.teichmann@xfel.eu>
To: Martin Teichmann <martin.teichmann@xfel.eu>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, ast@kernel.org, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Nov 2025 17:03:52 +0100 you wrote:
> A successful ebpf tail call does not return to the caller, but to the
> caller-of-the-caller, often just finishing the ebpf program altogether.
> 
> Any restrictions that the verifier needs to take into account - notably
> the fact that the tail call might have modified packet pointers - are to
> be checked on the caller-of-the-caller. Checking it on the caller made
> the verifier refuse perfectly fine programs that would use the packet
> pointers after a tail call, which is no problem as this code is only
> executed if the tail call was unsuccessful, i.e. nothing happened.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/4] bpf: properly verify tail call behavior
    https://git.kernel.org/bpf/bpf-next/c/e3245f899043
  - [v6,bpf-next,2/4] bpf: test the proper verification of tail calls
    https://git.kernel.org/bpf/bpf-next/c/978da762ea45
  - [v6,bpf-next,3/4] bpf: correct stack liveness for tail calls
    https://git.kernel.org/bpf/bpf-next/c/e40f5a6bf88a
  - [v6,bpf-next,4/4] bpf: test the correct stack liveness of tail calls
    https://git.kernel.org/bpf/bpf-next/c/8f7cf305a15e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



