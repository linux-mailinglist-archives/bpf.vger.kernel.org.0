Return-Path: <bpf+bounces-8296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A300784AED
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63211C20B38
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ECA20197;
	Tue, 22 Aug 2023 20:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5D20180
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43AA3C433C8;
	Tue, 22 Aug 2023 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692734424;
	bh=S5D4egWQoAcq/ccRRPgsdkaZM0iEC15tWCmSOhYpxZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rsgqoZICO+Zgfz/WpD9UHT2Jw1uZc+W0apRUv9ZWg77l6/Rq5S7d6IcLqnUtct2YI
	 gacEFFhoieYcZ6K6TbrzpKC2FlCGk9dDz9MSqTy9Yzsh3vi4XKBxKSg35Afd1+3Thv
	 VAJJfM0ibxkRKbY4oOX7C78b9GUYtXURvWz4d3t7H40vATvZbPb7sa+EqUeADoFOHw
	 0CpjmHmlICY/NuCnxvHbS39bg7LSTgcHv0RQzKPepHH9At1d6JGJafvJCFTqZIs1Cx
	 bTKX63mrCd8HHIeVScLnuiPgox9m+HDOAXoG2QDJMPDKBjt0UA40vnfyBSdtOMBEI1
	 iWr+joAN31N3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2308BE21ECD;
	Tue, 22 Aug 2023 20:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Fix for check_func_arg_reg_off
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169273442414.14630.2899573532504343892.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 20:00:24 +0000
References: <20230822175140.1317749-1-memxor@gmail.com>
In-Reply-To: <20230822175140.1317749-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davemarchevsky@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Aug 2023 23:21:38 +0530 you wrote:
> Remove a leftover hunk in check_func_arg_reg_off that incorrectly
> bypasses reg->off == 0 requirement for release kfuncs and helpers.
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Fix check_func_arg_reg_off bug for graph root/node
>   selftests/bpf: Add test for bpf_obj_drop with bad reg->off
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Fix check_func_arg_reg_off bug for graph root/node
    https://git.kernel.org/bpf/bpf-next/c/6785b2edf48c
  - [bpf-next,v1,2/2] selftests/bpf: Add test for bpf_obj_drop with bad reg->off
    https://git.kernel.org/bpf/bpf-next/c/fbc5bc4c8e6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



