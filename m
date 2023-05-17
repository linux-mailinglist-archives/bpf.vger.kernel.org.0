Return-Path: <bpf+bounces-777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8CD706A97
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311D91C20EE2
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E431119;
	Wed, 17 May 2023 14:10:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA52C757
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3788C4339B;
	Wed, 17 May 2023 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684332619;
	bh=4l5rszFTt3R0rdYTxoo/y/yJlCMhM+iJx4WMb8Us5xY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uCz78OBmyKu5pbHJxBSGoxGNjGo5OLKtH74fp//xY8W4y6YJHyV5ktmWjZeyCXpzQ
	 LAZHQbwkCFclpfogmlDlrCyNWkL7yzikoHSc4/QROuiwi+MXALmWPzH6VWRpzbk8ap
	 FXM1WIhdo0ZKqOWI7Gs8fhdllvyU/05nBonHGprpqUxdjYtgif1yacJoweMUHuIRCf
	 wL/NledFkUOPfiUhV/ibkzI6JG8qG+FybYs80ev0T6nb7ptDaVSIUMGb+gcE89Y5CJ
	 ajiNt5KQ3jtCwwtLy+cmzmfkwVosqadhCKJQZ15/qKifhKn+eFqyhKUNCNeBOcGFsr
	 LBKQqXfHOKl+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A36AC59A4C;
	Wed, 17 May 2023 14:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpftool: Support bpffs mountpoint as pin path for
 prog loadall
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168433261962.10644.15924445827364561434.git-patchwork-notify@kernel.org>
Date: Wed, 17 May 2023 14:10:19 +0000
References: <1683342439-3677-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1683342439-3677-1-git-send-email-yangpc@wangsu.com>
To: Pengcheng Yang <yangpc@wangsu.com>
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, sdf@google.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat,  6 May 2023 11:07:19 +0800 you wrote:
> Currently, when using prog loadall, if the pin path is a bpffs
> mountpoint, bpffs will be repeatedly mounted to the parent directory
> of the bpffs mountpoint path.
> 
> For example,
>     $ bpftool prog loadall test.o /sys/fs/bpf
> currently bpffs will be repeatedly mounted to /sys/fs.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpftool: Support bpffs mountpoint as pin path for prog loadall
    https://git.kernel.org/bpf/bpf-next/c/2a36c26fe3b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



