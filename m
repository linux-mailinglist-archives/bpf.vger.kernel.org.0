Return-Path: <bpf+bounces-37751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC495A428
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA711F2228D
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FEE1B2ED8;
	Wed, 21 Aug 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p53GvjLK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913A1B2516
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262630; cv=none; b=XPJMJQkLeixpnZTQpLIaF9JiN4YLet/f4ZSY318Te0vT3wndg71NZPGiQHmVzWlN1wJrhzh13Tg7YFPZ+bHI3Rb6d9f136HrbVexWq3stui1FLLOIdz1qnKYf3gRkhAGbrBnRNLSPNX5JUkw2vb5YsJIci2giG68EblfAvvMqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262630; c=relaxed/simple;
	bh=w6f3PcCHReGOcYQ1BBtB4CX+r2f5iDCeFp98ntAmxnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aqux3A1hgFv/HMDwTDsVqiYMiw4iJXNE6ZBHnpJiXrrLePaoeV7H3rPyOz7+I9EIrS2cUigfjW6UcJjO2DiEHMXl6exxj5V8w2VU3e10BTGeQcfzpci1UYOykZ0pmRF4smlJygkAE9Vsc2+oLadVo9V1qlgDLYi6LV213Of3MBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p53GvjLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674E9C4AF10;
	Wed, 21 Aug 2024 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724262630;
	bh=w6f3PcCHReGOcYQ1BBtB4CX+r2f5iDCeFp98ntAmxnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p53GvjLKzns6k7i0SK7IU5TLIyMqIXc4a6a90uX6lv64kwS6fCKYsANNBZ5bHqj1I
	 XEEj1JmQvWzvjQs7ZvTm8t+IAdLQayUS0ordw8LwdLXelFvz8qPO1rZu+Rt3I/PlYB
	 s7jgr+h2U6wDBetoD/gvGWRkZwiALUFnurIidtYnrdTNef0wvWJAY26TB4J7NYAnaY
	 /55MTZpttJMDiVG7cZmRWM8lLbHSW2Xv0v7FuEFtW5R73yJkN/NsMrkQ6dlFWnmAgV
	 RQJEQxCsQ7OxKpHFZbu9WF+/vPEYIVlPRZqxBrXuuPB62EZJ2LCUyhBKcY7dTyR29U
	 XhPxlm/Cxkk5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C773804C86;
	Wed, 21 Aug 2024 17:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Support passing BPF iterator to kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172426263000.1792219.7842087803669646661.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 17:50:30 +0000
References: <20240808232230.2848712-1-andrii@kernel.org>
In-Reply-To: <20240808232230.2848712-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, tj@kernel.org, void@manifault.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  8 Aug 2024 16:22:27 -0700 you wrote:
> Add support for passing BPF iterator state to any kfunc. Such kfunc has to
> declare such argument with valid `struct bpf_iter_<type> *` type and should
> use "__iter" suffix in argument name, following the established suffix-based
> convention. We add a simple test/demo iterator getter in bpf_testmod.
> 
> Andrii Nakryiko (3):
>   bpf: extract iterator argument type and name validation logic
>   bpf: allow passing struct bpf_iter_<type> as kfunc arguments
>   selftests/bpf: test passing iterator to a kfunc
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: extract iterator argument type and name validation logic
    https://git.kernel.org/bpf/bpf-next/c/496ddd19a0fa
  - [bpf-next,2/3] bpf: allow passing struct bpf_iter_<type> as kfunc arguments
    https://git.kernel.org/bpf/bpf-next/c/baebe9aaba1e
  - [bpf-next,3/3] selftests/bpf: test passing iterator to a kfunc
    https://git.kernel.org/bpf/bpf-next/c/b0cd726f9a82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



