Return-Path: <bpf+bounces-8964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733E78D368
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D17128138A
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CDF185A;
	Wed, 30 Aug 2023 06:48:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BF15C8
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 707C7C433C9;
	Wed, 30 Aug 2023 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693378107;
	bh=FskavHGIhy/jOwY26zYGOOyZm05VSyDznOwLaPjg4bw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TTu+ehAWNXkX9i4ICvX73foYKIGI0WMh+B4g9A9kLZvKq3ds3iPnVxXHI1Q0+TsTm
	 DujB66ntKdnuipFBKCt2kLFda8+pfCDIceqpO1lysFaU6cJyApqiOnXerZtFjAMx83
	 GKyjmsk8IgJFBzwb+dAOawE13Sitxh59ePZ6/28kdpv3h1gzdO4ta/yQzQ3QoE5a3b
	 ZSQmJ33kNfXt7ZMH/MFAqPpZsbayWBJJbq6/7nI3B5OUeVoI4NHn/tHkNzqssU0NIa
	 qGOoyxVt7p6hPTj6DAaVjU7NRjRvks6yJOIDdXMdR4eGRhCUMjaLQpJUzf48ia+sso
	 au6crSGwMdjWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55913E29F39;
	Wed, 30 Aug 2023 06:48:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpftool: Fix build warnings with -Wtype-limits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169337810734.20679.4965878338537447031.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 06:48:27 +0000
References: <20230830030325.3786-1-laoar.shao@gmail.com>
In-Reply-To: <20230830030325.3786-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: quentin@isovalent.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 martin.lau@linux.dev, sdf@google.com, song@kernel.org, yhs@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 30 Aug 2023 03:03:25 +0000 you wrote:
> Quentin reported build warnings when building bpftool :
> 
>     link.c: In function ‘perf_config_hw_cache_str’:
>     link.c:86:18: warning: comparison of unsigned expression in ‘>= 0’ is always true [-Wtype-limits]
>        86 |         if ((id) >= 0 && (id) < ARRAY_SIZE(array))      \
>           |                  ^~
>     link.c:320:20: note: in expansion of macro ‘perf_event_name’
>       320 |         hw_cache = perf_event_name(evsel__hw_cache, config & 0xff);
>           |                    ^~~~~~~~~~~~~~~
>     [... more of the same for the other calls to perf_event_name ...]
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpftool: Fix build warnings with -Wtype-limits
    https://git.kernel.org/bpf/bpf/c/6a8faf107091

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



