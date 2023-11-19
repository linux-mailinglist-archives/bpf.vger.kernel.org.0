Return-Path: <bpf+bounces-15330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910447F08B0
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 21:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C201C204F5
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868A199C4;
	Sun, 19 Nov 2023 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btuISsfm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B34199B0
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 20:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 792F9C433C9;
	Sun, 19 Nov 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700424025;
	bh=LY+pkwLAcEc+ElIOO4CBS95Gfp2RHMXsLkanNcnKQ+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=btuISsfmuSCocr8c2/xqwi3+c2MvzRXf/Gd9S99LMyxTGvI523hky18FJa2b9hSPt
	 ZDlqdchbRiHTvXrPmf+sxmSBCzMmj8PER5ECMb8TKyhElvvFE46kMPLOws1YkfW+nv
	 9D0e3bpyzDJ3RoffDkkV2X3lHEpMGGQZ3us0WdT916M5wTNHs2nsRw33IYqnbJVys7
	 RvbdwdsNV1a7jGyRGWjidnGD6gMtVpRl0KdgyrMzCGArM1WJG4qZI3S4TsPCXTUEnO
	 YiDvis69I35TxFA81KEKLAXaYGpI7Pvb0BisA4kQI8j+3xyAlnDgdNFgOvPrNA0uUG
	 I6dJwxDYNidqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61E55C4316B;
	Sun, 19 Nov 2023 20:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] bpf: kernel/bpf/task_iter.c: don't abuse next_thread()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170042402539.15900.10514585865955411623.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 20:00:25 +0000
References: <20231114163211.GA874@redhat.com>
In-Reply-To: <20231114163211.GA874@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: ast@kernel.org, yonghong.song@linux.dev, zhouchuyi@bytedance.com,
 daniel@iogearbox.net, kuifeng@fb.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 Nov 2023 17:32:11 +0100 you wrote:
> Compile tested.
> 
> Every lockless usage of next_thread() was wrong, bpf/task_iter.c is
> the last user and is no exception.
> 
> Oleg.
> 
> [...]

Here is the summary with links:
  - [1/3] bpf: task_group_seq_get_next: use __next_thread() rather than next_thread()
    https://git.kernel.org/bpf/bpf-next/c/2d1618054f25
  - [2/3] bpf: bpf_iter_task_next: use __next_thread() rather than next_thread()
    https://git.kernel.org/bpf/bpf-next/c/5a34f9dabd9a
  - [3/3] bpf: bpf_iter_task_next: use next_task(kit->task) rather than next_task(kit->pos)
    https://git.kernel.org/bpf/bpf-next/c/ac8148d957f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



