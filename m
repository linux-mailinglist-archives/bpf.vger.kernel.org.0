Return-Path: <bpf+bounces-79351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5AD38994
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 00:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46FAE305058E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62CB30EF69;
	Fri, 16 Jan 2026 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD6VcarL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA03019B2
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768604617; cv=none; b=Dz6XJOicMcAdPGvV+HmPWPy9U+lCXQBDWbHY0HJtws69/L/bSv9HLQV9bZCxJUQxILbsuZ+HCsjZLAsm740MVtT4yD+ONvU8F5K3qUkpWH2oDqdTU/bhfQHT5sbWGqjGqg8MtB0TlfyDbUWEjggB7aq/lEIaGAPhaPZxhPzwQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768604617; c=relaxed/simple;
	bh=s1zEGshFUt6G1bOii5o4Tw/CeTMGiLEnMdw0PkutbN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MC6Nuxhs2KMSFp+J6PC70PRveyskmwI+JqrxzKAJMS8ztTLtlkZ76C8oQ4VlXdyscwcdw9dBPyZfgSlVBj9BP43t4yu47gl1i+lLezC8rC+xYje17/hgRTHh1wSXdvhl4zNcO0mMQky8N3+JQ5C4XUNyHtwFXREkYJRmLq4FlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD6VcarL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C2FC116C6;
	Fri, 16 Jan 2026 23:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768604616;
	bh=s1zEGshFUt6G1bOii5o4Tw/CeTMGiLEnMdw0PkutbN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OD6VcarLz+81lm0l7e4+Puf+/u1JVbdc1NYtG0ibjjxEsKX1HL8ddt93O/xkuLlVA
	 obPBb1p+AEReKZRw9q04yoybuK2YFJKYat1tu/TkRx4YEcl0bxA+6ooLX/6XdgdgGD
	 xPnnzdmrFz9cQOmPKDN0PO4nq1eIfqrmsLdHRjIvcVkGJOtr3HFQ1EK06W5g8VzESY
	 VguvCprfiVG87lq3JkHs6EPSB5Yl5C2EpDXM07p+oOJo1nRiDMPW2XVC9mBPUG5ZSg
	 vGjjejTFxO4yopYXIXT0/hbKJZ0fptwjqSnm6Q10IjxiIVU7YS60sQJf1yRVDa1cjG
	 c3w1ef00VOLPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78975380CECB;
	Fri, 16 Jan 2026 23:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix map_kptr test failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176860440829.828763.15143009427668744208.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 23:00:08 +0000
References: <20260116052245.3692405-1-yonghong.song@linux.dev>
In-Reply-To: <20260116052245.3692405-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 15 Jan 2026 21:22:45 -0800 you wrote:
> On my arm64 machine, I get the following failure:
>   ...
>   tester_init:PASS:tester_log_buf 0 nsec
>   process_subtest:PASS:obj_open_mem 0 nsec
>   process_subtest:PASS:specs_alloc 0 nsec
>   serial_test_map_kptr:PASS:rcu_tasks_trace_gp__open_and_load 0 nsec
>   ...
>   test_map_kptr_success:PASS:map_kptr__open_and_load 0 nsec
>   test_map_kptr_success:PASS:test_map_kptr_ref1 refcount 0 nsec
>   test_map_kptr_success:FAIL:test_map_kptr_ref1 retval unexpected error: 2 (errno 2)
>   test_map_kptr_success:PASS:test_map_kptr_ref2 refcount 0 nsec
>   test_map_kptr_success:FAIL:test_map_kptr_ref2 retval unexpected error: 1 (errno 2)
>   ...
>   #201/21  map_kptr/success-map:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix map_kptr test failure
    https://git.kernel.org/bpf/bpf-next/c/efad162f5a84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



