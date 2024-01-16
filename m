Return-Path: <bpf+bounces-19612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F382F182
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 16:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56C41F21E01
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CBC1C29B;
	Tue, 16 Jan 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffDwVzuU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5C2563;
	Tue, 16 Jan 2024 15:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C923C43390;
	Tue, 16 Jan 2024 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705419025;
	bh=au7Vv0YVe9jBCpigQHBl3gX/TdZHJ4nEa6OGC0H16A8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ffDwVzuU3G5g0DY9ukdU7eTpVDJZDVF+F5h4OQn4N65mHzPlA/sD70114j3inCHhD
	 5loAc8G8ODAtjRr/9Ih++ApIiyAzgMj6MSgLmfqDmnpQs8ytwYOp2h63PeuGfLjFsY
	 TwaSRkFcrTuU9R0oPROnrl50K6EzVRx7xpIEchto6UXHkBfeHgxQrbvRBK2R/4TgdJ
	 048ZhcqpXfEVC+CBgMgj0MiGOSbYxp1+UBNt3FXq+0AUBldjBUvqHEzjcQuXORawSh
	 xkkCSaBsv5S2NcPiUTg9erHQ17w2pCogjNeMDSEFkb1ev9dgaBIOKbHqBAntGn8BZw
	 xkIx33M0Sa2sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BA03D8C984;
	Tue, 16 Jan 2024 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpftool: Silence build warning about calloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170541902543.7600.3198212618804627500.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 15:30:25 +0000
References: <20240116061920.31172-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240116061920.31172-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 quentin@isovalent.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 16 Jan 2024 14:19:20 +0800 you wrote:
> There exists the following warning when building bpftool:
> 
>   CC      prog.o
> prog.c: In function ‘profile_open_perf_events’:
> prog.c:2301:24: warning: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>  2301 |                 sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
>       |                        ^~~
> prog.c:2301:24: note: earlier argument should specify number of elements, later size of each element
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpftool: Silence build warning about calloc()
    https://git.kernel.org/bpf/bpf-next/c/d2729bb2c7e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



