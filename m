Return-Path: <bpf+bounces-8939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D2478CF63
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 00:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C3C1C20A75
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0541E182DA;
	Tue, 29 Aug 2023 22:10:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18D14AAF;
	Tue, 29 Aug 2023 22:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C33C433C9;
	Tue, 29 Aug 2023 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693347000;
	bh=xdJ9aMrAZsdzzeCAz7f0+38zdnn41Drubx0ekQNnTMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UrpsIYlKwr7qQum0vm+aV6KYVdbNvEkfORVsrW8XDz5P9aoPfvNJ4P156W2Le56nb
	 rz7EHbIG1tqrLUXOLsKMvu6OhRXazR9/ZLAsSH9dJCA6SFbD4id9xoF61nKO9yuvK8
	 7SWpiTGe1wJ/PS4Y/YHq9ubgiBYMEJNVyNYsnmckEQI9sqhT/egQXo4uILhPkxDx5K
	 M6OKRlk9wpIdoVi9/pFw+/74KjoFUB2mzwlciJg6izwTSVV1SMTrjZaJFddQgB1J7T
	 K2k4x96PbNvlESt15FuLN+JGnXKDzGbvTr9JwIJiPAgCEdCSt/UL5MXP4yu5DE+jAn
	 HcHywVFDYqwKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D059DE29F3B;
	Tue, 29 Aug 2023 22:09:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for 6.6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169334699983.14546.13884124780527405842.git-patchwork-notify@kernel.org>
Date: Tue, 29 Aug 2023 22:09:59 +0000
References: <20230829125950.39432-1-pabeni@redhat.com>
In-Reply-To: <20230829125950.39432-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 29 Aug 2023 14:59:50 +0200 you wrote:
> Hi Linus!
> 
> The following changes since commit b5cc3833f13ace75e26e3f7b51cd7b6da5e9cf17:
> 
>   Merge tag 'net-6.5-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-08-24 08:23:13 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for 6.6
    https://git.kernel.org/netdev/net/c/bd6c11bc43c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



