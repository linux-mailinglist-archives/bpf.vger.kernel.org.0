Return-Path: <bpf+bounces-5739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3FF75FF9C
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352041C20C57
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E2101D5;
	Mon, 24 Jul 2023 19:10:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919EF51C;
	Mon, 24 Jul 2023 19:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20D49C433C9;
	Mon, 24 Jul 2023 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690225822;
	bh=ujnDSd65smrCj3S58K++7NXFH0zZfR/5ieE5tyGHfm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mQWKVps6qy4AKLQP3EB7Sqqz/cVnf2stFPXSjPU1ay9pyi0oQB+8wjZ9g1mYGiodI
	 VMwo1KlNLIJJ/eR4MQAW3YXm+yftxQd18iaobYrWERqJA0/F/Rxg51s3I86t1dFck5
	 kGO+HUP9KTeqheygUyJGZiPXmp42jmBKiPZC4nY2uytNSks1z1CkGBSLvEO5IKo9RB
	 iXdNF0tH48e0o6cSo8zUMXnSM/VnNAxf2uT1a9cvgnNAUwPhAgIv+AaNecj+zStr+A
	 VEsyo7JpWGaJOC8SWAbeaL+Hd9dh9BQBL+uR8Ei/IW0c34IR1qyuDPIQudXRPKSbOV
	 aRM8wIQUmD63w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0911DC595D7;
	Mon, 24 Jul 2023 19:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169022582203.21248.6314356948130016152.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 19:10:22 +0000
References: <20230721233330.5678-1-daniel@iogearbox.net>
In-Reply-To: <20230721233330.5678-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org,
 syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
 syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
 syzbot+14736e249bce46091c18@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Jul 2023 01:33:30 +0200 you wrote:
> On qdisc destruction, the ingress_destroy() needs to update the correct
> entry, that is, tcx_entry_update must NULL the dev->tcx_ingress pointer.
> Therefore, fix the typo.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
> Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
> Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> [...]

Here is the summary with links:
  - [net-next] tcx: Fix splat in ingress_destroy upon tcx_entry_free
    https://git.kernel.org/netdev/net-next/c/dc644b540a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



