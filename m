Return-Path: <bpf+bounces-9693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D079C122
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 02:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FBD1C20A9B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62D65C;
	Tue, 12 Sep 2023 00:30:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FF14F97
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E668C4163C;
	Tue, 12 Sep 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694478627;
	bh=KLjjVVXmrgBmEYHg8q0teeOp/4ipFC3Ut+Hc/DdQYJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VAySSY4mMiMZYRJHEcY/SeAXt1eTatYYhbR4d9ucanu8xrlQ6auObN0yW9kWrPWTs
	 a3xuQGUcqxIWLW9s3ry/6MTjh7j+Yw+iyAj2RAL3g1HfqCEufKny7xRqrYwFmDx1yk
	 X36fGggv/o+FvMGqZtsga5AMWM+G8bBdYKjkjp0j60a7vGanxdHbJXloZvlzQorcuQ
	 j5WrcQN6wAzTZCOFQ4mJfBrZ29s3drZ1I2mq1ZJiPyCq/S5S9BWWomgAPnzgRuSm6v
	 0++/8cmWjRS0UmlJNiygiSllQaugGOq+fBNzYitKQxAPMLwiXE5Y/C7PCki8EQt90c
	 YkSj0ZDNneM+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03E07E1C280;
	Tue, 12 Sep 2023 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Correct map_fd to data_fd in
 tailcalls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169447862701.16556.10767524281745060375.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 00:30:27 +0000
References: <20230906154256.95461-1-hffilwlqm@gmail.com>
In-Reply-To: <20230906154256.95461-1-hffilwlqm@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, maciej.fijalkowski@intel.com, jakub@cloudflare.com,
 kernel-patches-bot@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  6 Sep 2023 23:42:56 +0800 you wrote:
> Get and check data_fd. It should not check map_fd again.
> 
> Meanwhile, correct some 'return' to 'goto out'.
> 
> Thank the suggestion from Maciej in "bpf, x64: Fix tailcall infinite
> loop"[0] discussions.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Correct map_fd to data_fd in tailcalls
    https://git.kernel.org/bpf/bpf-next/c/96daa9874211

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



