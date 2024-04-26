Return-Path: <bpf+bounces-27947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F568B3D73
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BF31C244A3
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0D715AACD;
	Fri, 26 Apr 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhPFt+jM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AB2F874;
	Fri, 26 Apr 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150833; cv=none; b=BTi7vXC3wPlLUhKJwfqcPOBmK/7Ioca3GA/4Dl8FXAHs7EALNx18AKiWXs1VLbZDziNdGDuD1ZS1t4gUjRBg8xEveBBlcdWV+3ElEBsd/cVQnHHKTDOimnhW/1iGpMApD09bdwtobhjWGrFwliXQAVEA6n8jxrGxHoZGKwbJavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150833; c=relaxed/simple;
	bh=D31HKf9xNwf4ZljzcZN/RLqrIKBUyLlxBwINP7IllWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eUqf0hq/jWFKjhrn7VPW3KaQdakZ9vx3kRPrCfNzhzz1BbQIP8RXgOkh/mYbKhRux09iUtdiPk/N1EtwRYBISvgMz1na79tcUpyNAtYqW+882/pmrQLInDHE1CxDbwv+B1CIVIfUiOH3Zq8vJadaQodejU6u8Km5Ei5JNZ+uuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhPFt+jM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60DA0C116B1;
	Fri, 26 Apr 2024 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714150832;
	bh=D31HKf9xNwf4ZljzcZN/RLqrIKBUyLlxBwINP7IllWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lhPFt+jMM3YX0oCkFWNuyeLtjZcllJLh2VshUJ70rlK8J66dyiqhSXWS5hOGu1T6j
	 0Rbgu6bD3Wz2VfQsvYsiGzBsIUCKUW+aTHjlKFacaDLec0vyNsF+oXN0LMme1WuGZF
	 KKaRRyknDPT6iR8pWxvmVnmNgJ2kwZOdaEuyZGwPxTQDMvjKv5pc8NzmuheABfTG68
	 HnbSve2BTsFyfUMUBh61c9cJHBgXdjfVNBA7fi2ydd18FPskGYbfp/6ksR7EHb6AZk
	 1qaHv6hW4GQHalM3S2+yqbXHZs59gu4Yk1GUH5Y1XPUAdOfMPxvt3vYFgJX32eo20R
	 4QpO7Em9EbVSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DCEDDF3C9D;
	Fri, 26 Apr 2024 17:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v6 0/3] bpf: prevent userspace memory access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171415083231.31232.17589661506846576735.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 17:00:32 +0000
References: <20240424100210.11982-1-puranjay@kernel.org>
In-Reply-To: <20240424100210.11982-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, iii@linux.ibm.com, puranjay12@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 24 Apr 2024 10:02:07 +0000 you wrote:
> V5: https://lore.kernel.org/bpf/20240324185356.59111-1-puranjay12@gmail.com/
> Changes in V6:
> - Disable the verifier's instrumentation in x86-64 and update the JIT to
>   take care of vsyscall page in addition to userspace addresses.
> - Update bpf_testmod to test for vsyscall addresses.
> 
> V4: https://lore.kernel.org/bpf/20240321124640.8870-1-puranjay12@gmail.com/
> Changes in V5:
> - Use TASK_SIZE_MAX + PAGE_SIZE, VSYSCALL_ADDR as userspace boundary in
>   x86-64 JIT.
> - Added Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v6,1/3] bpf: verifier: prevent userspace memory access
    https://git.kernel.org/bpf/bpf/c/66e13b615a0c
  - [bpf,v6,2/3] bpf, x86: Fix PROBE_MEM runtime load check
    https://git.kernel.org/bpf/bpf/c/b599d7d26d6a
  - [bpf,v6,3/3] selftests/bpf: Test PROBE_MEM of VSYSCALL_ADDR on x86-64
    https://git.kernel.org/bpf/bpf/c/7cd6750d9a56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



