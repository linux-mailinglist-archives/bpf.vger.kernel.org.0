Return-Path: <bpf+bounces-7055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFFC770BDE
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C282826F5
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990702417D;
	Fri,  4 Aug 2023 22:20:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F521AA8B
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 22:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5285C433C9;
	Fri,  4 Aug 2023 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691187621;
	bh=72knttdP8xG4mfYnrCY9aUzpFZLcsrcMRMCIOU3P3tI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RHSdM4ZeHkPakMOhkUgzNJWtYtdJTw07FqLhffBb/TZqoXqSJ4pEsfYhQKcmOG3QG
	 mSqoJmNWK4kfNmmt8ZSN6nic+AC5dERGd9CpwzfUnVGp/ToG5tF9XzU4As7rOBngEo
	 AvSP9EkDmhLYktdjXFxnbIC6zkwSO4/J0Z1if4h1lcEZ/YRXc4X9lOZKK3y1THWes/
	 YtLhEQtNY+xi6c1G7fph373yG20jhBGj0HawOfgdp/mZUGM8QBddDIEaFKFdECfNJo
	 fvQjUklmZLIvymfafcUabUKd4d8TyMIXqBu9qRS4xDSnY/slALQF/LodBan4ydA0XR
	 LVjQpIUoP0iLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 929ABC595C3;
	Fri,  4 Aug 2023 22:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] libbpf: Use local includes inside the library
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118762159.26162.4706175343280887034.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:20:21 +0000
References: <CAJVhQqUg6OKq6CpVJP5ng04Dg+z=igevPpmuxTqhsR3dKvd9+Q@mail.gmail.com>
In-Reply-To: <CAJVhQqUg6OKq6CpVJP5ng04Dg+z=igevPpmuxTqhsR3dKvd9+Q@mail.gmail.com>
To: Sergey Kacheev <s.kacheev@gmail.com>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, alan.maguire@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 2 Aug 2023 21:22:14 +0300 you wrote:
> In our monrepo, we try to minimize special processing when importing
> (aka vendor) third-party source code. Ideally, we try to import
> directly from the repositories with the code without changing it, we
> try to stick to the source code dependency instead of the artifact
> dependency. In the current situation, a patch has to be made for
> libbpf to fix the includes in bpf headers so that they work directly
> from libbpf/src.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] libbpf: Use local includes inside the library
    https://git.kernel.org/bpf/bpf-next/c/dde3979bb345

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



