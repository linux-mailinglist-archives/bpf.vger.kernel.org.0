Return-Path: <bpf+bounces-6633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8176C037
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CDB281B7E
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330D27730;
	Tue,  1 Aug 2023 22:10:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFC275C0;
	Tue,  1 Aug 2023 22:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D14CCC433CB;
	Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927824;
	bh=sQZrJ2mgn6S+xsfQa/9uZC+/9VMnVcolqLNOajQX8oo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MiXItRXqNOqgvz/6og/TyLOwv8ZlVaFFMtA8lcpXhbshVEYp4fShlysiTFrJBFWp5
	 3VUCRD0knHvkNAj6+Y5k1djeSxhZdW5GvyUxdlPzD/eCO+uxm003SYiybjI/yHu/am
	 xBnG6MtkAkjNazfkJWVSV4QKZ+LTGxoDgKzE+CEGpm6sTkFIAsqMpFScGJ7RB0YtRC
	 p84AFfR4pM0DZFA9V8sBmOPYaRdz4xslXefuEMtCz7Ee3RbeMphXV68HTG6XqMYsF0
	 pfZ9HSkd/M8/K5dq6700HhK+7eE+xMf3sQtRhdCssmfoZGsKdr1RsM9mms3fS7Xqyt
	 FQTwIXxGBlp8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB62FC73FE2;
	Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bnxt_en: 2 XDP bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092782476.18672.7697027930473187015.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 22:10:24 +0000
References: <20230731142043.58855-1-michael.chan@broadcom.com>
In-Reply-To: <20230731142043.58855-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com, bpf@vger.kernel.org,
 somnath.kotur@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 07:20:41 -0700 you wrote:
> The first patch fixes XDP page pool logic on systems with page size >=
> 64K.  The second patch fixes the max_mtu setting when an XDP program
> supporting multi buffers is attached.
> 
> Michael Chan (1):
>   bnxt_en: Fix max_mtu setting for multi-buf XDP
> 
> [...]

Here is the summary with links:
  - [net,1/2] bnxt_en: Fix page pool logic for page size >= 64K
    https://git.kernel.org/netdev/net/c/f6974b4c2d8e
  - [net,2/2] bnxt_en: Fix max_mtu setting for multi-buf XDP
    https://git.kernel.org/netdev/net/c/08450ea98ae9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



