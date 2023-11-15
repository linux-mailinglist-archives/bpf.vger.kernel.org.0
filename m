Return-Path: <bpf+bounces-15131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6487ED35F
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 21:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01C51C209A7
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6B943AD2;
	Wed, 15 Nov 2023 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrRFVubu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061C1FCF
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7FAFC4AF7B;
	Wed, 15 Nov 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700081422;
	bh=1y5oWCNtCHL3uMIbr3vozcvY7bGYDWsi1IsJQNnbL0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OrRFVubuLgBk+nVOQV6Bykc2IyskVKJvfX4Xhd4ljN1XRlWjWAzX3XnpaMxR/oluj
	 m2eQnPycrVDhqcQMxJptFzm6AwDa64bo8djeIqoHnaWLk2ku2SZbUJjssmYmiB330X
	 TvQxK8EGBxAjuGb7lZ/aEegvjm1IAmRsnnqPYhkPQUPR382zcKwuHpDk4WxpBmfFor
	 PXPP9clnxvL5XT0Bb88BRHsMwGFp4nuqQkh/tDYToUjmfgXzuhG0VMKAA1JpjBYyiP
	 oBmANGcDzAaBo0hmIFAvPaVDNThmkJXUZvDZge4Lfr9U9+GP6IohQMCL4mP+VybaWP
	 mYzU4ha1uUtKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB6E9E270EF;
	Wed, 15 Nov 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf/tests: Remove test for MOVSX32 with offset=32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170008142276.12596.14625966790181172770.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 20:50:22 +0000
References: <20231110175150.87803-1-puranjay12@gmail.com>
In-Reply-To: <20231110175150.87803-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Nov 2023 17:51:50 +0000 you wrote:
> MOVSX32 only supports sign extending 8-bit and 16-bit operands into 32
> bit operands. The "ALU_MOVSX | BPF_W" test tries to sign extend a 32 bit
> operand into a 32 bit operand which is equivalent to a normal BPF_MOV.
> 
> Remove this test as it tries to run an invalid instruction.
> 
> Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.sang@intel.com
> 
> [...]

Here is the summary with links:
  - [bpf] bpf/tests: Remove test for MOVSX32 with offset=32
    https://git.kernel.org/bpf/bpf-next/c/5fa201f37c2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



