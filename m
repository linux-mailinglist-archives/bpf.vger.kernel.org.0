Return-Path: <bpf+bounces-18177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AAF816BFC
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A0BB229E1
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BD18E2D;
	Mon, 18 Dec 2023 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2ksLpiF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1D19BC2
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 11:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D3D8C433C7;
	Mon, 18 Dec 2023 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702897823;
	bh=M9j6XvQpJPfkMBBYwXgTG/1Fa3y13GJYyLCD7TCs8Pk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i2ksLpiFBH67iC5sORhaeLfgedk+M5V0vWbG5mdc21iFkew/wsauL1pz2eh0/g5O5
	 O8KBW2PtEemqtpWQnxexrFTS7Zr69O+FlGTdkNJmp+cecZx8y+kZJg4c2+8yMU3ekS
	 PkfbfLPW5KIriq2Ml+eNbRu1R7xoeAzV78oqX/a02iGY9lmh7ywALNuppDk1p5RJDD
	 Ud3nKKOrcTRHfwM46D2djKcFSDUmwACDNilyMUKxypY+17FqTk7LGGmvb0M12MCihD
	 9fH5Jlcd/i9i4UFHcWn9UmxKPBXk63eOIImwGQONFhBBujQAOxLK63agKiogDvyGi+
	 Tqd+5GIOv6A5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 884DEC41677;
	Mon, 18 Dec 2023 11:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] s390/bpf: Fix indirect trampoline generation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170289782355.31682.4705076331217081422.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 11:10:23 +0000
References: <20231216004549.78355-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20231216004549.78355-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: iii@linux.ibm.com, andrii@kernel.org, daniel@iogearbox.net,
 peterz@infradead.org, martin.lau@kernel.org, bpf@vger.kernel.org,
 kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 15 Dec 2023 16:45:49 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The func_addr used to be NULL for indirect trampolines used by struct_ops.
> Now func_addr is a valid function pointer.
> Hence use BPF_TRAMP_F_INDIRECT flag to detect such condition.
> 
> Fixes: 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops CFI")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] s390/bpf: Fix indirect trampoline generation
    https://git.kernel.org/bpf/bpf-next/c/0c970ed2f87c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



