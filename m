Return-Path: <bpf+bounces-4785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E56C74F69C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFF51C20CFE
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF31DDEB;
	Tue, 11 Jul 2023 17:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322C168CE
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 17:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36AD4C433C9;
	Tue, 11 Jul 2023 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689095421;
	bh=KuzTMEs7J5RjDnJEbEDpEyUV5/7ysZRwvN6afL+U5LE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PdQqXKZnuWXKDD3Fe1sfJ9v66Kri9C2SwsolQ7rwWYc7M4TE02pWeVr2cIqqqrXyn
	 J0uOkzpb6nw6X0pbGp4A1ejtIwa8uJ4w6I5IrswPjPxWb+NGus274rBb6n4XK5Dj4h
	 tAHFp/wReRruVOcJgsLnlbxSb/Ge6Dcn8HegE1ESWZQDgddvngdTDELODdgmPWQomj
	 S/5JxCjTTheLwq6xTuHaiIqv+4exsPV1vZSqekhaMEiIXSVG2AFe5tZzR2QQzYlTbP
	 F7smMHBF910quRsYb0lIibpeWceMjAnsPcto6eafUwXmxc3aN1CxKeyUOnvkbSfXqU
	 zYRfOmXlAMGOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1187CE5381F;
	Tue, 11 Jul 2023 17:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: syscall_tp: aarch64 no open syscall
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168909542106.17152.8261497932587649159.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jul 2023 17:10:21 +0000
References: <tencent_C6AD4AD72BEFE813228FC188905F96C6A506@qq.com>
In-Reply-To: <tencent_C6AD4AD72BEFE813228FC188905F96C6A506@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: ast@kernel.org, rongtao@cestc.cn, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 11 Jul 2023 19:14:59 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> __NR_open never exist on AArch64.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  samples/bpf/syscall_tp_kern.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [bpf-next] samples/bpf: syscall_tp: aarch64 no open syscall
    https://git.kernel.org/bpf/bpf-next/c/07018b57066e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



