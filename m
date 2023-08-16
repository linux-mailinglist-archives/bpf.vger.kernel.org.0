Return-Path: <bpf+bounces-7902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6C77E420
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A99281A5A
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9B012B7C;
	Wed, 16 Aug 2023 14:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75D10957
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0DFEC433C7;
	Wed, 16 Aug 2023 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692197421;
	bh=cktBqxiJp9Ln2FwN8Njb5OTmzoQUxQYKBWjuKOGkgOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ScvPeQEy1rNVrDMlNYqhX4p803QqVbJieFgWp3mXpjVrTp0wUbJmBTkXAehK0nWqT
	 iruScea6Iw+6c+qi0XHBUcOEC6FH3iN9vwpkyq8XIWlFK59u/S7VRcoczT+D/Oqi0M
	 7kmUz23gPouhKYTXB41aMvsKQgOyER0qJQO/BkLeX7+YoeXojYuqNVf1pWnfSkfQ9t
	 E2YhPdrCzj5S2tr/rquD/VL0I7a/L2LI8LNXoevjpyjcliyTmEpw4yMGGsJuEYtzBc
	 PEWJ+Iou3AJJDlrQEKMW9O9/NzrWxSN4w1I7IIj3YBApwC7lRc9YgQErNRCvfmJJf8
	 R9UhY1boE7+8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5252C691E1;
	Wed, 16 Aug 2023 14:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 0/2] bpf: Fix fill_link_info and add selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169219742167.13455.2580251797431652897.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 14:50:21 +0000
References: <20230813141900.1268-1-laoar.shao@gmail.com>
In-Reply-To: <20230813141900.1268-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 13 Aug 2023 14:18:58 +0000 you wrote:
> Patch #1: Fix an error in fill_link_info reported by Dan
> Patch #2: Add selftest for #1
> 
> v5->v6:
>   - Fix BPF CI failure on aarch64
> 
> v4->v5:
>   - Comments from Yonghong
>     - Replace 'offset' with '0'
>     - Set err=-1 for default case
>     - Only check return value of verify_kmulti_link_info
>   - Comments from Jiri
>     - Avoid retprobe argument
>     - Use bpf_fentry_test* instead
>     - Rename verify_kmulti_user_buffer
>   - Define some variables as global value to simplify the code
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/2] bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
    https://git.kernel.org/bpf/bpf-next/c/0aa35162d2a1
  - [v6,bpf-next,2/2] selftests/bpf: Add selftest for fill_link_info
    https://git.kernel.org/bpf/bpf-next/c/23cf7aa539dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



