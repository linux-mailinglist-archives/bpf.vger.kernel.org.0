Return-Path: <bpf+bounces-17623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED4980FB7D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985F11F213AA
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7D745C4;
	Tue, 12 Dec 2023 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzZHd2L7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0564CEB
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D369C433C8;
	Tue, 12 Dec 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702424424;
	bh=IF/EAOleqfx95Xue2yRzziLG7/7DRiCAfRYYtOQ8hKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XzZHd2L7P0KcrF3KUhHFC3+2mQCKXG9GjL+1U9YOzkbBogLqM8Xk2zGfDGjDxqXud
	 v2vF1AEGW7uCt3/1kZpCPljhx7/nuZLfZfRha0gZnyaST8U0/Ij8MgS/TnjeqZ/0Zp
	 ct53xTKjU1LsMStzAgKLGA7lGgnx0XrmTxt+pn3kk1HG661I2oSfK7Uo9z1jE74LCw
	 4Jo+kDHGfmq+xyMXyBKGj82fIDGZku4+x74gQGLf0Ih4v696rHW2APl2VvKz2IYpJC
	 VG2J4Auj6Xw0QuuripeGn8Tv6jzOzwTBmxBvdnwMZRCmfhdVsUdE7cZ464kQphCaHQ
	 c4qUDpJL6x1/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75F83DFC907;
	Tue, 12 Dec 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Comment on check_mem_size_reg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170242442448.16020.3279506207327220991.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 23:40:24 +0000
References: <20231210225149.67639-1-andreimatei1@gmail.com>
In-Reply-To: <20231210225149.67639-1-andreimatei1@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 10 Dec 2023 17:51:50 -0500 you wrote:
> This patch adds a comment to check_mem_size_reg -- a function whose
> meaning is not very transparent. The function implicitly deals with two
> registers connected by convention, which is not obvious.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [bpf-next] bpf: Comment on check_mem_size_reg
    https://git.kernel.org/bpf/bpf-next/c/745e03113065

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



