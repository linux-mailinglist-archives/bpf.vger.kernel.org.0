Return-Path: <bpf+bounces-9580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C667992FD
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBFE1C20D52
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3FF7486;
	Sat,  9 Sep 2023 00:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81B6FA8
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF6D5C433C7;
	Sat,  9 Sep 2023 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694217623;
	bh=SY5HqVl6vzf2DY6JRXwG/yT139bO6hklB5plKgi+eWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yb2P/B+v7ZY0CeBYfVtU/NjTCNkiB7ECr7YZYNyovMmDpmNZO73syZCLgr5SjGukh
	 OG4CJ1RAxzk3C5rjWcJachfqyhOiXl2gSoM/KqCckf6eonsKQ18LAhdHKYCBKJWtnA
	 XX0iRadtWdb9R0ogVxLUrKzkGYzY71MW/flJr9+NGJHlQbXpV4+6WK3u/j8oarDGU0
	 V86VdbXGIyelWla+gxcI/s6AodETbEdh6IQwYDItqQ5S4k059tcMEhBMpKtI0QU4i9
	 g94xacjXq01B+btyuNNrtjJXrKVR/NPJewYeOgQui5/gz+cb/2ViKcENH97xA8A6Zv
	 2BeSmcXXJuiuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1B98E53807;
	Sat,  9 Sep 2023 00:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Add override check to kprobe multi link attach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169421762372.9366.5282819170421075658.git-patchwork-notify@kernel.org>
Date: Sat, 09 Sep 2023 00:00:23 +0000
References: <20230907200652.926951-1-jolsa@kernel.org>
In-Reply-To: <20230907200652.926951-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 stable@vger.kernel.org, bpf@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@google.com, haoluo@google.com, tixxdz@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Sep 2023 22:06:51 +0200 you wrote:
> Currently the multi_kprobe link attach does not check error
> injection list for programs with bpf_override_return helper
> and allows them to attach anywhere. Adding the missing check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Add override check to kprobe multi link attach
    https://git.kernel.org/bpf/bpf/c/41bc46c12a80
  - [bpf,2/2] selftests/bpf: Add kprobe_multi override test
    https://git.kernel.org/bpf/bpf/c/7182e56411b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



