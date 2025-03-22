Return-Path: <bpf+bounces-54571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF03A6CA54
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC678828EF
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256BF224AED;
	Sat, 22 Mar 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSC2RtqL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F7204689;
	Sat, 22 Mar 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742650201; cv=none; b=M863UX/T5cxHQqtWBe5jKGHJhMX1kkbAQt3mccocMTJb7z4MiVc/MEMG6rYlz36jzEfb5ePE8jmULKPKXP0tIMN9u11bpYU0UANStj3MCqPoBoleJIJYUUODkk7KXO01nGZ/CR0GoHMYfmMTdLi1KR/RoAYIwaGeIhz7p6expq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742650201; c=relaxed/simple;
	bh=W+pD+HG9kAgGkTtMqbz7Vp/7hGB99hGncJEzses1ejw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mksrzoydypcIWd+txLwn8szKichC3DmGaY4Me89ldj72vK/xQeWLc6H6zmck5YQHYLx9X/zEpud0ji/JksubgYM8++dR8ET3qkrvLJHl1wIKXdnXfgfZDCYprAiG8HEsgRyR5CPLLkPSrr5kBMBVRTyOWnMqJ3ebdQNot26qITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSC2RtqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203A7C4CEDD;
	Sat, 22 Mar 2025 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742650201;
	bh=W+pD+HG9kAgGkTtMqbz7Vp/7hGB99hGncJEzses1ejw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eSC2RtqL+9WLhCoS8tW62EPIXxHxnrW9Eh2OU8xHyOD8ANfMvTWcTpYax922fhgQN
	 xx8mMVgC5z/aBfoIppAS9y5sk5f3RYPphMk0TZ+8ILZDTE7omR3pNjiSTCpxolpup3
	 o0RkbtHFf3dPxIZKEq60l7g52hrzcXXSoittQagr72EFDWnlSpfXhrx/sQjkSv8Z5V
	 a1vF5L9+vN3hJ4bhHIOxgMdxmDm0PEGVcfmIaXd1p+QIPvk2CADNo+wZyNCWTdZw3W
	 opsfUpO3bCROKqBWnIfv/YG9pxAQQKabrKoEEpMTgI3acuxa7xKCRPN2kdPIDPDWRE
	 /M5SsNOecBXQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71BA7380665A;
	Sat, 22 Mar 2025 13:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/2] bpf: Fix OOB read and add tests for
 load-acquire/store-release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174265023729.2819850.2406782216092782664.git-patchwork-notify@kernel.org>
Date: Sat, 22 Mar 2025 13:30:37 +0000
References: <20250322045340.18010-4-enjuk@amazon.com>
In-Reply-To: <20250322045340.18010-4-enjuk@amazon.com>
To: Kohei Enju <enjuk@amazon.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, yepeilin@google.com, iii@linux.ibm.com,
 kuniyu@amazon.com, kohei.enju@gmail.com,
 syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 22 Mar 2025 13:52:54 +0900 you wrote:
> This patch series addresses an out-of-bounds read issue in
> check_atomic_load/store() reported by syzkaller when an invalid register
> number (MAX_BPF_REG or greater) is used.
> 
> The first patch fixes the actual bug by changing the order of validity
> checks, ensuring register validity is checked before atomic_ptr_type_ok()
> is called.
> It also updates some tests that were assuming the previous order of checks.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] bpf: Fix out-of-bounds read in check_atomic_load/store()
    https://git.kernel.org/bpf/bpf-next/c/c03bb2fa327e
  - [v3,bpf-next,2/2] selftests/bpf: Add selftests for load-acquire/store-release when register number is invalid
    https://git.kernel.org/bpf/bpf-next/c/5f3077d7fcd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



