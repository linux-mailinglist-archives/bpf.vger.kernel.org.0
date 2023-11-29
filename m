Return-Path: <bpf+bounces-16111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC157FCE96
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02606281C62
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39094748E;
	Wed, 29 Nov 2023 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZHyidK5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00D7475
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 06:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 096DCC433CA;
	Wed, 29 Nov 2023 06:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701237628;
	bh=LahCR0HBVUDEVmd7AvY1Wlr0e6eIe5Q4S3p9ay5Oemk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bZHyidK5STGuLU5J/7EF9+XOUhmUu00d5AyyqdRfkiP5I6CKyBct/QiRy/4TeyxsI
	 3+tMfqBcgnTWhoEhMRzCzhGe1WQX65TiLI7QcSkcuDbjeg/S3OTfV5S5Tirjqx7wFn
	 J1I+gKSxqy6i9jqSZ93P/39z7OHLXGdX7YMhVkQTVxF5KuLnkxKTWl6UrO6jL+AWma
	 xNdV1qamiQpu1wKIinS17Yn4P+jv0z3BucLqEo/7S6plDs+xaywb2qNcu8hHES2ti5
	 6zMT2wr+6lC3RORpqXRfuH93hDCJtfGPPhmJ9taTmHChidR56VfELgm50zMSJIiEKN
	 LckjnQtNOJgug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2920DFAA89;
	Wed, 29 Nov 2023 06:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 bpf-next 0/6] bpf: Add link_info support for uprobe multi
 link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170123762792.21448.1297874484231140065.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 06:00:27 +0000
References: <20231125193130.834322-1-jolsa@kernel.org>
In-Reply-To: <20231125193130.834322-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, laoar.shao@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 25 Nov 2023 20:31:24 +0100 you wrote:
> hi,
> this patchset adds support to get bpf_link_info details for
> uprobe_multi links and adding support for bpftool link to
> display them.
> 
> v4 changes:
>   - move flags field up in bpf_uprobe_multi_link [Andrii]
>   - include zero terminating byte in path_size [Andrii]
>   - return d_path error directly [Yonghong]
>   - use SEC(".probes") for semaphores [Yonghong]
>   - fix ref_ctr_offsets leak in test [Yonghong]
>   - other smaller fixes [Yonghong]
> 
> [...]

Here is the summary with links:
  - [PATCHv4,bpf-next,1/6] libbpf: Add st_type argument to elf_resolve_syms_offsets function
    https://git.kernel.org/bpf/bpf-next/c/48f0dfd8d3e2
  - [PATCHv4,bpf-next,2/6] bpf: Store ref_ctr_offsets values in bpf_uprobe array
    https://git.kernel.org/bpf/bpf-next/c/4930b7f53a29
  - [PATCHv4,bpf-next,3/6] bpf: Add link_info support for uprobe multi link
    https://git.kernel.org/bpf/bpf-next/c/e56fdbfb06e2
  - [PATCHv4,bpf-next,4/6] selftests/bpf: Use bpf_link__destroy in fill_link_info tests
    https://git.kernel.org/bpf/bpf-next/c/170361288572
  - [PATCHv4,bpf-next,5/6] selftests/bpf: Add link_info test for uprobe_multi link
    https://git.kernel.org/bpf/bpf-next/c/147c69307bcf
  - [PATCHv4,bpf-next,6/6] bpftool: Add support to display uprobe_multi links
    https://git.kernel.org/bpf/bpf-next/c/a7795698f8b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



