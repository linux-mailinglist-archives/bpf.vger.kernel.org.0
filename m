Return-Path: <bpf+bounces-5848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD1761FFE
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88982817AC
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9DB25903;
	Tue, 25 Jul 2023 17:20:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960712419B
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A7E7C433C9;
	Tue, 25 Jul 2023 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690305620;
	bh=bY9Flce1Qo/ebE7NecIRJuQQ0kWbB3rfBy50pN2K+50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gLG2lnGAXmx5Um4uV8I4cqbfJeXgcoBmAxd1Kxj1uaSc+ozAK3Vm0J+Hu961MeQNt
	 bHAbqAsub5LKMzAEB1ikv6r+Sk2w/bpE0+MIEXJTM4Sgzohg4l3nycUKwKkeyjwwKU
	 pGruhReeolUXdoKLX14384y20Ti037PGawmINIaN4peZJVdvfUyKDwECRmSenA1n4D
	 5HgKA3+poYal54sZ8PAPFweBJa6HXymuu75bPqO7cBPaO5IR7kc2vua3siQWX0S8QL
	 A4slqpjHnohsOsShAhUKsiOxl9XHlQZWL6sUaSCd1Z5SCLY6A1E+S8lu5WgAthQRu5
	 cUjrOrfDXa9gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECC4AC4166D;
	Tue, 25 Jul 2023 17:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] MAINTAINERS: Replace my email address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169030561996.1699.12268504990027250198.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 17:20:19 +0000
References: <20230725054100.1013421-1-yonghong.song@linux.dev>
In-Reply-To: <20230725054100.1013421-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 24 Jul 2023 22:41:00 -0700 you wrote:
> Switch from corporate email address to linux.dev address.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] MAINTAINERS: Replace my email address
    https://git.kernel.org/bpf/bpf-next/c/7b2b20125f1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



