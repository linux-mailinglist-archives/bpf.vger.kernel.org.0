Return-Path: <bpf+bounces-4822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9C74FDA2
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2711C20EC4
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839E3A45;
	Wed, 12 Jul 2023 03:20:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A757F9
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 03:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F39C433C7;
	Wed, 12 Jul 2023 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689132022;
	bh=F7zMyx3aH9jKFqn5rNstvLEZXffJQsD6L1W2GzOvV68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AtEcwj95cMMEAbx6po7hdIOO0YeY196A/SQFYhFP7gji4ysQQGRUMw26NFWQAocuO
	 NUme4Dugvp3bBT0N0pHRNINVS/oNqtxzXqL7QeGkbvOhacK+NxGPLktJiLyZFYL7UP
	 MJAiE/GZCl1gzTsCQ+hwfgJ4U4uCoHmhz1TVETGax0tyXSqrnnWfbKxMFabgBpSZiO
	 lqK9+PUMfuAP65g3lQZmw0NKf3Y6hvpSX9o7m/ic9sXVza3RfXo8FcQJT0AIDQrAnM
	 kJDPQO3mD9jl0rAgWxNJlA1ATL+lnqxInxT/RrlWKtFtIJuNVyXZYK63Sy+2MaF+ur
	 A577Cp/MZWmxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8048E49BBF;
	Wed, 12 Jul 2023 03:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 bpf-next 00/11] bpf: Support ->fill_link_info for
 kprobe_multi and perf_event links
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168913202268.22051.12454098463424761810.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 03:20:22 +0000
References: <20230709025630.3735-1-laoar.shao@gmail.com>
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  9 Jul 2023 02:56:20 +0000 you wrote:
> This patchset enhances the usability of kprobe_multi program by introducing
> support for ->fill_link_info. This allows users to easily determine the
> probed functions associated with a kprobe_multi program. While
> `bpftool perf show` already provides information about functions probed by
> perf_event programs, supporting ->fill_link_info ensures consistent access
> to this information across all bpf links.
> 
> [...]

Here is the summary with links:
  - [v7,bpf-next,01/10] bpf: Support ->fill_link_info for kprobe_multi
    https://git.kernel.org/bpf/bpf-next/c/7ac8d0d26192
  - [v7,bpf-next,02/10] bpftool: Dump the kernel symbol's module name
    https://git.kernel.org/bpf/bpf-next/c/dc6519445b33
  - [v7,bpf-next,03/10] bpftool: Show kprobe_multi link info
    https://git.kernel.org/bpf/bpf-next/c/edd7f49bb884
  - [v7,bpf-next,04/10] bpf: Protect probed address based on kptr_restrict setting
    https://git.kernel.org/bpf/bpf-next/c/f1a414537ecc
  - [v7,bpf-next,05/10] bpf: Clear the probe_addr for uprobe
    https://git.kernel.org/bpf/bpf-next/c/5125e757e62f
  - [v7,bpf-next,06/10] bpf: Expose symbol's respective address
    https://git.kernel.org/bpf/bpf-next/c/cd3910d00505
  - [v7,bpf-next,07/10] bpf: Add a common helper bpf_copy_to_user()
    https://git.kernel.org/bpf/bpf-next/c/57d485376552
  - [v7,bpf-next,08/10] bpf: Support ->fill_link_info for perf_event
    https://git.kernel.org/bpf/bpf-next/c/1b715e1b0ec5
  - [v7,bpf-next,09/10] bpftool: Add perf event names
    https://git.kernel.org/bpf/bpf-next/c/62b57e3ddd64
  - [v7,bpf-next,10/10] bpftool: Show perf link info
    https://git.kernel.org/bpf/bpf-next/c/88d6160737fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



