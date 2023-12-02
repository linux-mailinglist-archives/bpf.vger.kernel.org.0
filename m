Return-Path: <bpf+bounces-16477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF424801853
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 01:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3E1281D70
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 00:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB026288;
	Sat,  2 Dec 2023 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLl4HoJu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424D224FD
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D6D8C433C9;
	Sat,  2 Dec 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475224;
	bh=MTYMbf9eK6ReSQ0PJLUwjvATd8h8uDDUfCj/h1/8HMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uLl4HoJunVaBmGb5f+bt2NTEdmR5zS3SBpVcMVbJGtlaoxr4sRvdLKRpX+tGF9Zmn
	 F2C++PKCAQ+y6ZxrM5/4VK8IvV7GwgwZ8v/WRYJbgU0TZCnIMW41YCFViDXYGl1zzV
	 V4EH7zTOoOa8LVRii8F6HE3CrTYi+lOabSxTbntuTIrRp4S/wkpvnuUSH15l1HJQ6B
	 DQsBMXpgVU3H7TN/mp6d2jvs87+tLSREWtkZSMr3G4wOQessWr8xC5dzFIYGqk4n4a
	 Su8YEdd0dBrhTH7YNBUxzEoRQf4yzer3WlZIFd4Qif9lDQX0RVxVGQEWDJgHX1upuv
	 1uh7YJeGS94SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83055C395DC;
	Sat,  2 Dec 2023 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf: Fix a verifier bug due to incorrect branch offset
 comparison with cpu=v4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170147522453.5829.11152285037778177975.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 00:00:24 +0000
References: <20231201024640.3417057-1-yonghong.song@linux.dev>
In-Reply-To: <20231201024640.3417057-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 30 Nov 2023 18:46:40 -0800 you wrote:
> Bpf cpu=v4 support is introduced in [1] and Commit 4cd58e9af8b9
> ("bpf: Support new 32bit offset jmp instruction") added support for new
> 32bit offset jmp instruction. Unfortunately, in function
> bpf_adj_delta_to_off(), for new branch insn with 32bit offset, the offset
> (plus/minor a small delta) compares to 16-bit offset bound
> [S16_MIN, S16_MAX], which caused the following verification failure:
>   $ ./test_progs-cpuv4 -t verif_scale_pyperf180
>   ...
>   insn 10 cannot be patched due to 16-bit range
>   ...
>   libbpf: failed to load object 'pyperf180.bpf.o'
>   scale_test:FAIL:expect_success unexpected error: -12 (errno 12)
>   #405     verif_scale_pyperf180:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: Fix a verifier bug due to incorrect branch offset comparison with cpu=v4
    https://git.kernel.org/bpf/bpf/c/dfce9cb31405

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



