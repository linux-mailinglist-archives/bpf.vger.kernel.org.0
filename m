Return-Path: <bpf+bounces-7413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F37776E8D
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 05:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4941C210C0
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E1EC2;
	Thu, 10 Aug 2023 03:30:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E267F5;
	Thu, 10 Aug 2023 03:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DF0AC433C9;
	Thu, 10 Aug 2023 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691638221;
	bh=pSd+VoKNP34UZb9BcUq2Lnoe4HOh65In+TbpqL/m4nQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XmA0um0iP3q1bDWwDq2dmWmdk3qrwVLrodDgJsIA+6OtXnVtuCkZwVULbvi95j2mg
	 ZwA2SbWIPuKGRQWNteMwu28BEcZ+qwocCylM0+WtoyZ63s/Hp6T442ykDfV+InEXaz
	 iQ4JNrn/1Zbib4bUCyDDtDlC1VTRWjoUpHpRxgutJXA/fI839iHN4WSf94ansFnfIw
	 FdkLeuYWosH3TTKv3ZvCDRU9Q9nRj52utgTFFbM7SowNDQcu2qh+BL6sCtTpibESrJ
	 VJjY0D/isFLEuchp1oYEQYohD5aWlkPdutC0HoLGuL59m6So7oHVJg8pELr7tXyvjR
	 e+MUnQgqAmssg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3018EE3308E;
	Thu, 10 Aug 2023 03:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: fix refcount underflow in error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169163822119.30696.9356557415848654995.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 03:30:21 +0000
References: <20230809142843.13944-1-magnus.karlsson@gmail.com>
In-Reply-To: <20230809142843.13944-1-magnus.karlsson@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, bpf@vger.kernel.org,
 syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  9 Aug 2023 16:28:43 +0200 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix a refcount underflow problem reported by syzbot that can happen
> when a system is running out of memory. If xp_alloc_tx_descs() fails,
> and it can only fail due to not having enough memory, then the error
> path is triggered. In this error path, the refcount of the pool is
> decremented as it has incremented before. However, the reference to
> the pool in the socket was not nulled. This means that when the socket
> is closed later, the socket teardown logic will think that there is a
> pool attached to the socket and try to decrease the refcount again,
> leading to a refcount underflow.
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: fix refcount underflow in error path
    https://git.kernel.org/bpf/bpf/c/85c2c79a0730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



