Return-Path: <bpf+bounces-2114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C86F727EBE
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCD6281662
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3441311189;
	Thu,  8 Jun 2023 11:30:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0111182
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08F2DC4339B;
	Thu,  8 Jun 2023 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686223821;
	bh=JLPRF6/J3auy10oGToiq9sWfv2pIhC80a2ICCb5ktuY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C30MFTiPF56JEsG6UJ1BrfDt84htIuBGHqC/5d9brErt/NLHeKP1M0E9PXNt4ZYnq
	 4dl2eYZizJYDuNHsyM+iC3L5C4K+8r5ZlSX+Dppoj7UrN2Mqlm4V466schh04jYjA2
	 TtXnGyFPuJDOv4avIJBNCbWd/xTMBHlCF6IG0jmRhvieUV3KrUJUG4gP0XLLx7MOpd
	 3jfNVltFpchbBhdvyvYod5ZVm38rle4lsgQRJWwsI6PCeqa9PZlx/2hAMARerPHjvx
	 66/WqvwC0DXVDHt3qD2Cj9YAXKJSI0Yldf6mgeycHNGybgpJVUM2f7S9wOPqEKMZ9k
	 PwrxMSyhxC4Gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB0F0E4D015;
	Thu,  8 Jun 2023 11:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add missing prototypes for several
 test kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168622382089.11699.11534563556655685113.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jun 2023 11:30:20 +0000
References: <20230607224046.236510-1-jolsa@kernel.org>
In-Reply-To: <20230607224046.236510-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, lkp@intel.com,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, void@manifault.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  7 Jun 2023 15:40:46 -0700 you wrote:
> Adding missing prototypes for several kfuncs that are used by
> test_verifier tests. We don't really need kfunc prototypes for
> these tests, but adding them to silence 'make W=1' build and
> to have all test kfuncs declarations in bpf_testmod_kfunc.h.
> 
> Also moving __diag_pop for -Wmissing-prototypes to cover also
> bpf_testmod_test_write and bpf_testmod_test_read and adding
> bpf_fentry_shadow_test in there as well. All of them need to
> be exported, but there's no need for declarations.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add missing prototypes for several test kfuncs
    https://git.kernel.org/bpf/bpf-next/c/67faabbde36b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



