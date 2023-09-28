Return-Path: <bpf+bounces-11052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595FD7B2293
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 18:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4ED18282CA3
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 16:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF521450EA;
	Thu, 28 Sep 2023 16:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2411401F
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDA16C433C9;
	Thu, 28 Sep 2023 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695919222;
	bh=rdeHiGruccsW2FepdK9oLCUBprpJ7z4OKVhhWlk6WSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tf6G9uGXYVF4I8khUpu84kFAusfCEDuM9J95oGk3yLYqMljRDWCSLAYGEsESjVWuN
	 P13OAHozaIwy+/dqcnq3aCSeJpHp4yIypT83tHTceIKJoCcplmqSt3DFhYN6CGze+b
	 d5NY2S1oOm5Vzs7vW68JCX/yG9WZUXQaBS6awCnfnBtTThs2AvSgsWfyiUPSmVdyzK
	 R8VpyS0YfiSkCtpkF5Kp77JmHIGzBvtFFQKtCG/hYw9UJB2/PEKMO43XpFlDJsVRDo
	 xMLiWh3g27gbAJf2HU0RIZr0cShwx7r0dXRUixNp7W7Pnac0HubiTVo1eif4mbN0WQ
	 M0xZrtuTfSyeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2A07C595D7;
	Thu, 28 Sep 2023 16:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/1] samples/bpf: syscall_tp_user: Refactor and
 fix array index out-of-bounds bug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169591922279.30419.2592606842232540042.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 16:40:22 +0000
References: <20230927045030.224548-1-ruowenq2@illinois.edu>
In-Reply-To: <20230927045030.224548-1-ruowenq2@illinois.edu>
To: None <ruowenq2@illinois.edu>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jinghao7@illinois.edu, keescook@chromium.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 26 Sep 2023 23:50:29 -0500 you wrote:
> From: Ruowen Qin <ruowenq2@illinois.edu>
> 
> Thanks to Alexei, patch 2/3 and 3/3 from v2 have been upstreamed. v3
> primarily addresses scenarios where the compiler lacks ubsan support.
> 
> There are currently 6 BPF programs in syscall_tp_kern but the array to
> hold the corresponding bpf_links in syscall_tp_user only has space for 4
> programs, given the array size is hardcoded. This causes the sample
> program to fail due to an out-of-bound access that corrupts other stack
> variables:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/1] samples/bpf: Add -fsanitize=bounds to userspace programs
    https://git.kernel.org/bpf/bpf-next/c/9e09b75079e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



