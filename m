Return-Path: <bpf+bounces-39640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E85B97596C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519D11C2264F
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED91B143E;
	Wed, 11 Sep 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkSviR1T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3519CC15;
	Wed, 11 Sep 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075832; cv=none; b=sBBB4wdR8Uvz/N8IMi1nsKHPH+b4W8O1+7EVEu49IBlVI7W/xwy3bEz/oIV+mdWw+43iZeAraFTQSRP3SKkWYnHKX9Osy0iJerWTWtt7wOwHf5Ob6jvjII5iyX5xRyupswN+UYruOaJGkNE9dM86J3YuZkO/pjjVGtIMOuCDLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075832; c=relaxed/simple;
	bh=c3HlCa0MZz9c3Y32yBjg1oCfbAppYtUD2omXcGpxbwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gj5oXB8+6AvQSwe2ARwo/+fI7r9P7VqlQgRrqPBnIf0DLua5Xu/7Atv6u4eZDjtbhRcs9K1fLvCFALsbkO39SY+/uICoy8uhCwXbSejucO86wQaZbZgig9JXBfQbHZjxfiQPa9Dq/kdzn5rpiiyHRUpJzu5GLY0YR63hgJgY0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkSviR1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC93DC4CEC0;
	Wed, 11 Sep 2024 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726075831;
	bh=c3HlCa0MZz9c3Y32yBjg1oCfbAppYtUD2omXcGpxbwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LkSviR1T4TCfnNX7pbwsMF56XJprFfWWCdn73A1c2i4jQnuxYXlympy+O/zn4lvC9
	 bbWMuBbW9ATm+ZcrVJm5br3zMcBZJbklJjDkIqbny3obqMF0dkc8i2rDb/aLLnRiKr
	 GygstytR99bLMVWLzJAgyMYNgL3xdEnR1vW7kK03I+Zb8kp4mZUISrgiBYLJ4mni1Z
	 px0OicMhvrZpqcCs1BoUH8kiJixiZAAw/gZgNrL9DcN1/nHqbRwu2ud4hlolNniPuv
	 R6bYuelfmTXDaQPgPHDbZ5lh6viZZHifvgH5WY27xd0IDlQR0mbQgLBtobkmtPsJtu
	 3ZoRAug7T5gKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0363806656;
	Wed, 11 Sep 2024 17:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] bpf: Allow skb dynptr for tp_btf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172607583276.994220.12802097721316207371.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 17:30:32 +0000
References: <20240911033719.91468-1-lulie@linux.alibaba.com>
In-Reply-To: <20240911033719.91468-1-lulie@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 thinker.li@gmail.com, juntong.deng@outlook.com, jrife@google.com,
 alan.maguire@oracle.com, davemarchevsky@fb.com, dxu@dxuuu.xyz,
 vmalik@redhat.com, cupertino.miranda@oracle.com, mattbobrowski@google.com,
 xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 11 Sep 2024 11:37:14 +0800 you wrote:
> This makes bpf_dynptr_from_skb usable for tp_btf, so that we can easily
> parse skb in tracepoints. This has been discussed in [0], and Martin
> suggested to use dynptr (instead of helpers like bpf_skb_load_bytes).
> 
> For safety, skb dynptr shouldn't be used in fentry/fexit. This is achieved
> by add KF_TRUSTED_ARGS flag in bpf_dynptr_from_skb defination, because
> pointers passed by tracepoint are trusted (PTR_TRUSTED) while those of
> fentry/fexit are not.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: Support __nullable argument suffix for tp_btf
    https://git.kernel.org/bpf/bpf-next/c/8aeaed21befc
  - [bpf-next,v3,2/5] selftests/bpf: Add test for __nullable suffix in tp_btf
    https://git.kernel.org/bpf/bpf-next/c/2060f07f861a
  - [bpf-next,v3,3/5] tcp: Use skb__nullable in trace_tcp_send_reset
    https://git.kernel.org/bpf/bpf-next/c/edd3f6f7588c
  - [bpf-next,v3,4/5] bpf: Allow bpf_dynptr_from_skb() for tp_btf
    https://git.kernel.org/bpf/bpf-next/c/ffc83860d8c0
  - [bpf-next,v3,5/5] selftests/bpf: Expand skb dynptr selftests for tp_btf
    https://git.kernel.org/bpf/bpf-next/c/83dff601715b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



