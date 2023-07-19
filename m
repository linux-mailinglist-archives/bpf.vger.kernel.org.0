Return-Path: <bpf+bounces-5342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87968759BC1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15E91C21099
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807221FB41;
	Wed, 19 Jul 2023 17:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483BA1FB33;
	Wed, 19 Jul 2023 17:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D00B7C433C8;
	Wed, 19 Jul 2023 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689786022;
	bh=0QHWh0ZyANR6sFatpI3iKS3ZiOSU5OuS3djaKj/sziU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OqyU8S0M6KQ75CgbpxWGTj2LHaNSUQhp/Tai5zgIv78YVVTZqJVyvtyg8tRet1Krl
	 IUdXijrAvMhqznxgcA6B9vaqRGMt4BWdLe6gMFzQ/E3GrzE2I5ncHqHSf7S9EZ7d1g
	 11rZnQ8+PxLfa6BhrN0N7jOV3UEu+qKr2YC5+cXLyyD5CL/i3BXbIR6AGAl1xk2mT6
	 beFKbxKyIDrXescyXjB0E744cl9KvBLKK1ppO2UzvdX664tc4zvy0zmMaDvm1cWIeV
	 2nJnCbPc1e03s3N1YTgq3uhWpmcnlrPsvZpTA/k7o3v23wfm+vGQE3rNAK7cKoJS5V
	 SM5Nk6KyWyS6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8392C6445A;
	Wed, 19 Jul 2023 17:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 x86: initialize the variable "first_off" in save_args()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168978602267.22183.12710540348045539494.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 17:00:22 +0000
References: <20230719110330.2007949-1-imagedong@tencent.com>
In-Reply-To: <20230719110330.2007949-1-imagedong@tencent.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: yhs@fb.com, davem@davemloft.net, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, imagedong@tencent.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
 dan.carpenter@linaro.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Jul 2023 19:03:30 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> As Dan Carpenter reported, the variable "first_off" which is passed to
> clean_stack_garbage() in save_args() can be uninitialized, which can
> cause runtime warnings with KMEMsan. Therefore, init it with 0.
> 
> Fixes: 473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING")
> Cc: Hao Peng <flyingpeng@tencent.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/09784025-a812-493f-9829-5e26c8691e07@moroto.mountain/
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, x86: initialize the variable "first_off" in save_args()
    https://git.kernel.org/bpf/bpf-next/c/492e797fdab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



