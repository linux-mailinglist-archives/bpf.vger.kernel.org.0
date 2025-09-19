Return-Path: <bpf+bounces-68943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A502B8A99B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908BF3B3872
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE8320393;
	Fri, 19 Sep 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgQPwBlx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC231B82B
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300023; cv=none; b=EdB3wcGIjmJLicqEU+Tqs+bCRW/P/jXNTUFCFpsBjfTg4HDL1eHmiMlQGbck75QsPwVnP2dpRJDNpQfuoejpBp8Vm8DYkXF24T2d+Ck87TgOoeCQbLHcsMvZn0wes7gIpfwqOXTuH7XlbdZii7xtw00pjUwUw3M/Ug5yLKP6A0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300023; c=relaxed/simple;
	bh=zVxV9AYzDY3Ov2qa61F+QxkGRhwKu5ytzumd5+lN5Hs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LE0h61BPKEnSSbob912tU+FRhx4H9U8o4cPHStxoAxS6ME4ipVrqq4vLXP0H7pj2NsoXP1WRcxUYSUe1PYKfq13+IJIjJWLleTxnRzYb8q0vYbtFSew4Kx6OjYXiHhn+9ulxa5pQFunew7GRspUaM8uRBoEnBBVEVUhY2IIDOzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgQPwBlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C93BC4CEF0;
	Fri, 19 Sep 2025 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300022;
	bh=zVxV9AYzDY3Ov2qa61F+QxkGRhwKu5ytzumd5+lN5Hs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OgQPwBlxTDgAtN2KGYqxyQOJSLF7IJwZigYMYvWqpkTZMOGihMU9HUcLCLm4p46Rc
	 u4dzFWWzeFo1PzQuc/I4PpLcspfviOiavzLv2+LqRp+5yy22pacCS1bjrwI2clsJEK
	 /Y2qyQ4DlCheRZ7a+yVYcMCOQ5SC6yiY69zgKq/A3vLkrsLwGDuhY4VLUHOEEpWVwW
	 86aQ9vq9Dr7BfEQPWTztVCa4H2Q/24ehVhiH18OPuhZmJuLbEEb61QAsc3yy+ZfAck
	 RijiXq/CbPqssscSS7A47+MEz3p55A1K4+9Gek+6dJbcEtyF0X8uU99THKef3DbZ1r
	 mdQobyA5DppIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDAF39D0C20;
	Fri, 19 Sep 2025 16:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/12] bpf: replace path-sensitive with
 path-insensitive live stack analysis
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175830002150.3625099.1261707369813058491.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 16:40:21 +0000
References: 
 <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
In-Reply-To: 
 <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Sep 2025 19:18:33 -0700 you wrote:
> Consider the following program, assuming checkpoint is created for a
> state at instruction (3):
> 
>   1: call bpf_get_prandom_u32()
>   2: *(u64 *)(r10 - 8) = 42
>   -- checkpoint #1 --
>   3: if r0 != 0 goto +1
>   4: exit;
>   5: r0 = *(u64 *)(r10 - 8)
>   6: exit
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/12] bpf: bpf_verifier_state->cleaned flag instead of REG_LIVE_DONE
    https://git.kernel.org/bpf/bpf-next/c/daf4c2929fb7
  - [bpf-next,v3,02/12] bpf: use compute_live_registers() info in clean_func_state
    https://git.kernel.org/bpf/bpf-next/c/6cd21eb9adc9
  - [bpf-next,v3,03/12] bpf: remove redundant REG_LIVE_READ check in stacksafe()
    https://git.kernel.org/bpf/bpf-next/c/12a23f93a50d
  - [bpf-next,v3,04/12] bpf: declare a few utility functions as internal api
    https://git.kernel.org/bpf/bpf-next/c/3b20d3c120ba
  - [bpf-next,v3,05/12] bpf: compute instructions postorder per subprogram
    https://git.kernel.org/bpf/bpf-next/c/efcda22aa541
  - [bpf-next,v3,06/12] bpf: callchain sensitive stack liveness tracking using CFG
    https://git.kernel.org/bpf/bpf-next/c/b3698c356ad9
  - [bpf-next,v3,07/12] bpf: enable callchain sensitive stack liveness tracking
    https://git.kernel.org/bpf/bpf-next/c/e41c237953b3
  - [bpf-next,v3,08/12] bpf: signal error if old liveness is more conservative than new
    https://git.kernel.org/bpf/bpf-next/c/ccf25a67c7e2
  - [bpf-next,v3,09/12] bpf: disable and remove registers chain based liveness
    https://git.kernel.org/bpf/bpf-next/c/107e16979905
  - [bpf-next,v3,10/12] bpf: table based bpf_insn_successors()
    https://git.kernel.org/bpf/bpf-next/c/79f047c7d968
  - [bpf-next,v3,11/12] selftests/bpf: __not_msg() tag for test_loader framework
    https://git.kernel.org/bpf/bpf-next/c/34c513be3dad
  - [bpf-next,v3,12/12] selftests/bpf: test cases for callchain sensitive live stack tracking
    https://git.kernel.org/bpf/bpf-next/c/fdcecdff905c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



