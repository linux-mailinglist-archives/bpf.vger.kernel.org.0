Return-Path: <bpf+bounces-44186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE409BFAC6
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 01:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4134BB219E8
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430E4A31;
	Thu,  7 Nov 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehn4Gv3N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6904A1A;
	Thu,  7 Nov 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939428; cv=none; b=Qb2e5hzKgpJ46BbVJD0timmlr4cAV/wlObn5wyXHKPDBhIy5PAtplbaL1ebOoz4dICPtDGNiIaPcN0LpBcVV4ddywcoZSosR3qrnJm7lKXXeOskojVhJdO5oewR3nQEEhReq9XIviV3vlmyM1atFsvpriKitrXTWy9znitNq4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939428; c=relaxed/simple;
	bh=778QP5/P9mFGE1hg/t+ngsuku2V0q3PZbltM160twyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/joyLOKJOx0uamuwzr8CX/pb5OI3dBwLvn58DzJnxJ4ZN8yOzyYFkA+5VLyHc8/3tCcBxDdpw6Eyd8tG9BenR1Pk/ENgpcvLui3yCn5M4dtuTPyItR499gp5C0Y4Jcui9dI8fQGIRlQnc36zjh3GEUtg2yG/3R2v/Rcen9Eq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehn4Gv3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B157C4CED0;
	Thu,  7 Nov 2024 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730939425;
	bh=778QP5/P9mFGE1hg/t+ngsuku2V0q3PZbltM160twyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ehn4Gv3NGwk5hApQ9v38S4SWBmo0hSke9pYHRMSI8aLAQ/T4kktW/8qFuGPkyYxtG
	 jthn3DKj2+M1gSJqh+j3KJXrzb0ATbDd7aShrvlvfb++lFqc9VdMx9HMD2zZkpdaeJ
	 xsdBBqE3AtsZKdjyXjVhmc4z/IctyUoJujNPBFSHTWvyf11FyzxTvliGT7+O1wLC4J
	 eDu1MbddwTD6s0RCS08XvpaLQWG3JfeDIuBfUvAVri5QAO9BKufNapcPry89Rq/nrS
	 YJmhzkexxKmEnWbK5jlXi+zUSbWbDdhqAtD6hN9mk4f6yIjceIvQeNgbpAAZATE2dR
	 9GU749xn7Zs5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE53809A80;
	Thu,  7 Nov 2024 00:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/8] Fixes to bpf_msg_push/pop_data and
 test_sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173093943451.1468976.4489026455212430103.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 00:30:34 +0000
References: <20241106222520.527076-1-zijianzhang@bytedance.com>
In-Reply-To: <20241106222520.527076-1-zijianzhang@bytedance.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mykolal@fb.com,
 shuah@kernel.org, jakub@cloudflare.com, liujian56@huawei.com,
 cong.wang@bytedance.com, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  6 Nov 2024 22:25:12 +0000 you wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Several fixes to test_sockmap and added push/pop logic for msg_verify_data
> Before the fixes, some of the tests in test_sockmap are problematic,
> resulting in pseudo-correct result.
> 
> 1. txmsg_pass is not set in some tests, as a result, no eBPF program is
> attached to the sockmap.
> 2. In SENDPAGE, a wrong iov_length in test_send_large may result in some
> test skippings and failures.
> 3. The calculation of total_bytes in msg_loop_rx is wrong, which may cause
> msg_loop_rx end early and skip some data tests.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/8] selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/66c54c20408d
  - [v2,bpf-next,2/8] selftests/bpf: Fix SENDPAGE data logic in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/4095031463d4
  - [v2,bpf-next,3/8] selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/523dffccbade
  - [v2,bpf-next,4/8] selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/862087c3d362
  - [v2,bpf-next,5/8] selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/47eae080410b
  - [v2,bpf-next,6/8] bpf, sockmap: Several fixes to bpf_msg_push_data
    https://git.kernel.org/bpf/bpf-next/c/15ab0548e310
  - [v2,bpf-next,7/8] bpf, sockmap: Several fixes to bpf_msg_pop_data
    https://git.kernel.org/bpf/bpf-next/c/5d609ba26247
  - [v2,bpf-next,8/8] bpf, sockmap: Fix sk_msg_reset_curr
    https://git.kernel.org/bpf/bpf-next/c/955afd57dc4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



