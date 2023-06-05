Return-Path: <bpf+bounces-1879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4E723269
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E8F281490
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B827216;
	Mon,  5 Jun 2023 21:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49970BE59
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7002C4339B;
	Mon,  5 Jun 2023 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686001220;
	bh=IB7S+x6apCeB08zbrKpq2dL/Tw8U/IuTZ7etXp14aOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qmhcgXwaze6Z6FT08juIRgkYDU20lCZBBLhaPqOGyWdCugHVd+gNu8mbQ7UGksgmo
	 gqLnOr7LICeJpppIe6KzuIlEnMV8krT9LrudTKMjd9k4z+7/ugSjzlZP2FLdJrVl1G
	 BfHDa/7o6K8CTZi41vIUx88F9+TmRaulNDnvTOLnsru2YwecLa8q4wkXtTwaGQiLiq
	 ECHgQ4fSWJM3DRyYqSXlYjzDV3GFYQjiGVUbzF1NNH/9We/39/H5NK3xxaYBX4oG87
	 BRgM6IbfuKoeq3c4i7s74J1ENSkWtZnL5mpF31hWLqQ8F6Oz01cX96X04A4bpe5ojB
	 PohyIcFPAO0gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7634E87231;
	Mon,  5 Jun 2023 21:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: replace open code with for allocated object
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168600122068.24826.11624326531846760051.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jun 2023 21:40:20 +0000
References: <20230527122706.59315-1-danieltimlee@gmail.com>
In-Reply-To: <20230527122706.59315-1-danieltimlee@gmail.com>
To: Daniel T. Lee <danieltimlee@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
 john.fastabend@gmail.com, sdf@google.com, kpsingh@kernel.org, yhs@fb.com,
 song@kernel.org, martin.lau@linux.dev, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 27 May 2023 21:27:06 +0900 you wrote:
> From commit 282de143ead9 ("bpf: Introduce allocated objects support"),
> With this allocated object with BPF program, (PTR_TO_BTF_ID | MEM_ALLOC)
> has been a way of indicating to check the type is the allocated object.
> 
> commit d8939cb0a03c ("bpf: Loosen alloc obj test in verifier's
> reg_btf_record")
> From the commit, there has been helper function for checking this, named
> type_is_ptr_alloc_obj(). But still, some of the code use open code to
> retrieve this info. This commit replaces the open code with the
> type_is_alloc(), and the type_is_ptr_alloc_obj() function.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: replace open code with for allocated object check
    https://git.kernel.org/bpf/bpf-next/c/503e4def5414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



