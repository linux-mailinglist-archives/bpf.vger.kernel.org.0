Return-Path: <bpf+bounces-7634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C2779D14
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 06:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C951C20BC7
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 04:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028015D4;
	Sat, 12 Aug 2023 04:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3DC15B6
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 04:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54A2BC433C8;
	Sat, 12 Aug 2023 04:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691812824;
	bh=ue+snlIX4zjFx4LV+8dSlcT7RGFvi/zxMAf5BH9WENg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PC9p5wjZ+vSg3PwCTw9qV12/41r/+w/e8QnoT2QfGBvf9M4ut4BrC7t5Q1nlILWXC
	 pF1+b18yK7yUj7dIGkmZxulAVlu390MHbnk8/L5zTrCPM83lkXOIOBqWL4sodOK0SA
	 FH9KIuB/mqFqTXWLkg/V+0fh1WEGMMdcFVJ8IIOC5rQ6rj87IzOddXjx4NY+ggGV4J
	 ysWxF3oKg8hnW2MT9U1jmGizLn0GhrBI8LIW7Jzp264v3CHawmjSfmLh4p74QgVC8T
	 1DiRln9DkKm/MjeH5xUgCZ5Dqag67SLzfHHqGrE5oyYK3zaTasvCqRy7SkilVnjC6n
	 Prea2qJeBQtZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A6A2C64459;
	Sat, 12 Aug 2023 04:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: fix perf help message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169181282423.29765.3877301454049447481.git-patchwork-notify@kernel.org>
Date: Sat, 12 Aug 2023 04:00:24 +0000
References: <20230811121603.17429-1-danieltimlee@gmail.com>
In-Reply-To: <20230811121603.17429-1-danieltimlee@gmail.com>
To: Daniel T. Lee <danieltimlee@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 11 Aug 2023 21:16:03 +0900 you wrote:
> Currently, bpftool perf subcommand has typo with the help message.
> 
>     $ tools/bpf/bpftool/bpftool perf help
>     Usage: bpftool perf { show | list }
>            bpftool perf help }
> 
> Since this bpftool perf subcommand help message has the extra bracket,
> this commit fix the typo by removing the extra bracket.
> 
> [...]

Here is the summary with links:
  - bpftool: fix perf help message
    https://git.kernel.org/bpf/bpf-next/c/6da4fea89d25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



