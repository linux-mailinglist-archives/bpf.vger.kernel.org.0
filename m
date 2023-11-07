Return-Path: <bpf+bounces-14450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B347E4D8B
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171B628131D
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB8C34571;
	Tue,  7 Nov 2023 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrO6FD5Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639B34567
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 23:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26A9DC433C9;
	Tue,  7 Nov 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699400425;
	bh=8dzdiSmEEtTvO1+PWORtK+vBe8DaaSBWL5A8uIMPx0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HrO6FD5ZlxfL41Wf8sFkJnjECH6GMOq+C0z/Wlf87176Y5qlEAUBAUH05qUdYebuU
	 CbYKZSMjn+JG8E0Q2LG1EnDXWXsOii+iTCpRswLhdW4UkgavWgOmNeS32EheQuz7UO
	 il1/5BSQCxjf1KvzyET0CI4XmLAUYJZ21vRT355JxpkBje+bVtRlbx62vFAOAPgqwe
	 1bZeruw8D4echZyKlWL2fODfWpYVNKiBERq8bQGT/de2GPIUeo5jNgYmI5+DfhpuiT
	 v5p7r37AQ2YpHHKW6PuGr8wW6BSabrvtOTvozqYARozVRBE/+3ynfJNDFBlUXBrEze
	 peMrzpAa3uDuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CC5BE00083;
	Tue,  7 Nov 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Let BPF verifier consider {task,cgroup} is trusted
 in bpf_iter_reg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169940042504.5976.3079173874531115924.git-patchwork-notify@kernel.org>
Date: Tue, 07 Nov 2023 23:40:25 +0000
References: <20231107132204.912120-1-zhouchuyi@bytedance.com>
In-Reply-To: <20231107132204.912120-1-zhouchuyi@bytedance.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  7 Nov 2023 21:22:02 +0800 you wrote:
> Hi,
> The patchset aims to let the BPF verivier consider
> bpf_iter__cgroup->cgroup and bpf_iter__task->task is trused suggested by
> Alexei[1].
> 
> Please see individual patches for more details. And comments are always
> welcome.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Let verifier consider {task,cgroup} is trusted in bpf_iter_reg
    https://git.kernel.org/bpf/bpf/c/0de4f50de25a
  - [bpf,v2,2/2] selftests/bpf: get trusted cgrp from bpf_iter__cgroup directly
    https://git.kernel.org/bpf/bpf/c/3c5864ba9cf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



