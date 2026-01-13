Return-Path: <bpf+bounces-78642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D34D16637
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0822F304794E
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E830DD1C;
	Tue, 13 Jan 2026 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQsTzIvF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A083043CF;
	Tue, 13 Jan 2026 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273420; cv=none; b=tAgFYUbkc1zkroWnVfmUD96dQmWJ8dxdZxVBBDT9B36Et8JTf69Z+p8pZNaqWIakDlowWX/Qjo5mdg+pgsBGvnJMhmb3tYp6UCh0h/nniXQHCkTFIm34NiLWQ7dK45EWe04Jt6geELOWE6mJyrt98kYiXQARfUCyJKxhJpeO6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273420; c=relaxed/simple;
	bh=4JRMa76NweON3mRK8GoFfXX+90YbJ9sOal6xDnvFQEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AYcdNQBTENal7NcVWe/e+hbjnnifhMIs+fDePmlq5DvrRgOt8PsDp1yiQWulGjlrSRq5vVVQ5HsK1MZKUr8gJqn2FsPZlwi/a92RrB9VAkLrtg190+qWzObGXItB0evhGbumL3vZm04RvNQSZIywPyOR0Ky6TToJSw1RDrqioKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQsTzIvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87813C116D0;
	Tue, 13 Jan 2026 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768273419;
	bh=4JRMa76NweON3mRK8GoFfXX+90YbJ9sOal6xDnvFQEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KQsTzIvFehvtewPeIcXQtSVRz/caj3qubn0378rAUyBQYBxxi8luHmZYPjlZcQhCc
	 +Q4Ws1/Zy56/dvAy5IvMouaahHq1cHpXjbl8lSy/SjehrS4GKM75+no7U7WYs9feDs
	 /GqWhypLdxNBSeGHThOHX4B0ncz8L7FO0uG1LnG8undLerSHMQAiHkSDgsq2+mFv+j
	 0hzmzWmC9oAR5m5ineQZwKjJ1wMgrLtr8Vy8GWXITggazh70Vw+p5LzN5yTBFe+poQ
	 7gGCpmAx7fgQ0XNKvs5OuOv/Ezg8c+ZmVg1+0AT2iB7GO0CzvzZPoTZOMZ/J14CfjK
	 FBPl1fLhdUpmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788A3380CFE0;
	Tue, 13 Jan 2026 03:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/4] Use correct destructor kfunc types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827321329.1651449.11456880793258426338.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:00:13 +0000
References: <20260110082548.113748-6-samitolvanen@google.com>
In-Reply-To: <20260110082548.113748-6-samitolvanen@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, vadim.fedorenko@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, vmalik@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 10 Jan 2026 08:25:49 +0000 you wrote:
> Hi folks,
> 
> While running BPF self-tests with CONFIG_CFI (Control Flow
> Integrity) enabled, I ran into a couple of failures in
> bpf_obj_free_fields() caused by type mismatches between the
> btf_dtor_kfunc_t function pointer type and the registered
> destructor functions.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/4] bpf: crypto: Use the correct destructor kfunc type
    https://git.kernel.org/bpf/bpf-next/c/b40a5d724f29
  - [bpf-next,v5,2/4] bpf: net_sched: Use the correct destructor kfunc type
    https://git.kernel.org/bpf/bpf-next/c/c99d97b46631
  - [bpf-next,v5,3/4] selftests/bpf: Use the correct destructor kfunc type
    https://git.kernel.org/bpf/bpf-next/c/ba7f1024a102
  - [bpf-next,v5,4/4] bpf, btf: Enforce destructor kfunc type with CFI
    https://git.kernel.org/bpf/bpf-next/c/99fde4d06261

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



