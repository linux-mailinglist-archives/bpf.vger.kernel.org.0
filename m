Return-Path: <bpf+bounces-15778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77FE7F68C8
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 23:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14071C20BAE
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404618054;
	Thu, 23 Nov 2023 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGeBtrP0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F9179AE
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 22:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1999C433CB;
	Thu, 23 Nov 2023 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700776824;
	bh=ILMNdzXvIaD5Nl2vAaCyuzouxMVeGp2j2HHt0MLLm0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CGeBtrP0Il5TviyM5L1OYzu+bneCuBZTVNd/+AuYvTtVplaWx6h+xMQaRgwyd7RDA
	 ec/QpGJ/8rZqVdwNLKWYif+1dtkeVp6OoNcp5Qxn7N9uAZcoXldclCFydtNlGMSVGm
	 diylGxWML9U0cF0CVjXrA1gBXYQ3uLjYRIp7k/T8Mc9vZXEpBCiHTrvZfIRkfxHEoU
	 83p5lOGHNvAHMJ3o6VZRDGvJ5On/e3lq2O/gXfs/Kn1+xetku2gM7253PAh1vZd1bc
	 dyJ52msD/VCreyV4T7HVaTN0EIxlvxwveU3MjosepqxLzhsxBwvzPmefyn3jUNIouu
	 PhDaFG12pzPaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB7A4E00087;
	Thu, 23 Nov 2023 22:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Start v1.4 development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170077682482.26955.9726970992534157058.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 22:00:24 +0000
References: <20231123000439.12025-1-eddyz87@gmail.com>
In-Reply-To: <20231123000439.12025-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 23 Nov 2023 02:04:39 +0200 you wrote:
> Bump libbpf.map to v1.4.0 to start a new libbpf version cycle.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.map       | 3 +++
>  tools/lib/bpf/libbpf_version.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: Start v1.4 development cycle
    https://git.kernel.org/bpf/bpf-next/c/b8d78cb2e24d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



