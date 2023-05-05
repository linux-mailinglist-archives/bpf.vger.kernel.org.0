Return-Path: <bpf+bounces-123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428286F85C2
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759671C218F0
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16276C2D7;
	Fri,  5 May 2023 15:30:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1C5383
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9E8AC433EF;
	Fri,  5 May 2023 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683300619;
	bh=rHaU7KqMxed209LXms3Aicehv4KgnEC78Y1T3Uu9y+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d3ZkGgBJ4hS4KsqDLMvJ9N7P7PpR7nbNewFdkZ69bDgAeJPsZPzq0deGCrnvbjwzB
	 R+j0CUQaunyAeSV7J8zUwPhuB4uQzIFNS3SX9qINjOsXLDJgKRsll6LqyzKVWPu62+
	 AZG9UExRYTXmexZRiboKb417zrDtsrRLeKl7MmmrSTqZ9KpsveyThYwyroKhyo54Pc
	 gV0aeJBq7fHLpWVEavjYkGwdxvCSNiO1M/BJDqWGQCp2hEcdfpXcTpYDt6u/1pUM+n
	 SsfGKeso2ytakPKaEX3XfcGCiKCjaRhYATYv0XWdfKHva+3nsixkwf7ODR63+2FQze
	 GI6vH5D0sCRPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFAB2C73FF3;
	Fri,  5 May 2023 15:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] bpf, docs: Update llvm_relocs.rst with typo fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168330061971.16633.1427431996905511309.git-patchwork-notify@kernel.org>
Date: Fri, 05 May 2023 15:30:19 +0000
References: <20230428023015.1698072-1-hawkinsw@obs.cr>
In-Reply-To: <20230428023015.1698072-1-hawkinsw@obs.cr>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 27 Apr 2023 22:30:14 -0400 you wrote:
> Thank you all for donating your valuable time to maintaining such an
> incredible piece of technology.
> 
> I found a few typos that I thought I could help correct while I was
> reading the LLVM relocation documentation. I hope that they are helpful
> to a future newcomer.
> 
> [...]

Here is the summary with links:
  - [1/1] bpf, docs: Update llvm_relocs.rst with typo fixes
    https://git.kernel.org/bpf/bpf-next/c/69535186297b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



