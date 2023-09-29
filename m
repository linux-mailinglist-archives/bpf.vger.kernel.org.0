Return-Path: <bpf+bounces-11145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD67B3CD5
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 01:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 24B0D2827AE
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A496727C;
	Fri, 29 Sep 2023 23:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC547369
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 23:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F13CFC433C8;
	Fri, 29 Sep 2023 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696028427;
	bh=snGYSDjiC08byKgO2srunsxnbiFie/HWQ78PlKDcors=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R1zpPwU4/8K8/LPdMMQqR8bGQYx5dSVVuBbGtx+TSMn2AddHjaptIKre1s7XwcWj2
	 o2WMTWIeAqek4P4GGTOoWldk1mlSCyZ6W9CkAV5JP9Yy7ROJfFIohFaQu31sW9rOhg
	 JqfyTjxfZhxgO9fbiHZQL/cJlseNN210X8zRVN4fXxKe+i82iOXtMD9FfYe6/3Xe26
	 sjXsRRyaK3tKCXbnb7d7swmT+UZhTea6M68eLXQtp7G+P2JRZddiaZ9hQ1R2AGQ6LE
	 KipN0jBxDwC343lyV0U4Z2T1MhqnNqzUibK/n9s77+VVhx0qIrVOk+C1WyJ7KXaSse
	 7Jfax2FBLboxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D526EC43158;
	Fri, 29 Sep 2023 23:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf,
 mprog: Fix maximum program check on mprog attachment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169602842686.5238.5579305423276755854.git-patchwork-notify@kernel.org>
Date: Fri, 29 Sep 2023 23:00:26 +0000
References: <20230929204121.20305-1-daniel@iogearbox.net>
In-Reply-To: <20230929204121.20305-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, martin.lau@kernel.org, razor@blackwall.org,
 syzbot+baa44e3dbbe48e05c1ad@syzkaller.appspotmail.com,
 syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com,
 syzbot+2558ca3567a77b7af4e3@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 29 Sep 2023 22:41:20 +0200 you wrote:
> After Paul's recent improvement to syzkaller to improve coverage for
> bpf_mprog and tcx, it hit a splat that the program limit was surpassed.
> What happened is that the maximum number of progs got added, followed
> by another prog add request which adds with BPF_F_BEFORE flag relative
> to the last program in the array. The idx >= bpf_mprog_max() check in
> bpf_mprog_attach() still passes because the index is below the maximum
> but the maximum will be surpassed. We need to add a check upfront for
> insertions to catch this situation.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf, mprog: Fix maximum program check on mprog attachment
    https://git.kernel.org/bpf/bpf/c/f9b0e1088bbf
  - [bpf,2/2] selftest/bpf: Add various selftests for program limits
    https://git.kernel.org/bpf/bpf/c/4cb893e89221

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



