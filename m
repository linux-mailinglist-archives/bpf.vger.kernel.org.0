Return-Path: <bpf+bounces-18033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7476814F9E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 19:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DE41F236AE
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F330139;
	Fri, 15 Dec 2023 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imlajq3B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DAF3011E;
	Fri, 15 Dec 2023 18:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA42FC433C8;
	Fri, 15 Dec 2023 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702664424;
	bh=AA2I9gq/rdT7kKV0mCYstmitqiVrwtIKVadp3cHB48s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=imlajq3B7bwr3mpz0sn58QpujZMVK8zS43ZFp+ezmAQCyj3rOugDV1Yx0bWvQvVzc
	 re0TDMuDYpzxzxAitzIQm1uWVEL3H+0mUszeutF+R/Zgiwha2IY38HqrRFtPNVJObG
	 wjE7X7xyeVl6hb/CvZalCRoZcCnEAJ0/vWqLSuxULnd9f1povyl6EE2keboshUpU6r
	 LgfgFzmOZWDMRQRqXNZNK7TBnCGR97U80HXFSc8teTrSH4AyLXFYHiiB9YdWJTKgr5
	 vEw6z7f4hO5K7eCyOMR+0fiQ5lLEP9Qt1thqI5Y4JD5Z5JwMY1q/9/M+YWuDDiptex
	 Y7nyMnmCSQJSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E717DD4EF5;
	Fri, 15 Dec 2023 18:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: do not map packet buffers twice
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170266442457.14713.14756808926921500725.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 18:20:24 +0000
References: <20231214213138.98095-1-michael.chan@broadcom.com>
In-Reply-To: <20231214213138.98095-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrew.gospodarek@broadcom.com, somnath.kotur@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Dec 2023 13:31:38 -0800 you wrote:
> From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> 
> Remove double-mapping of DMA buffers as it can prevent page pool entries
> from being freed.  Mapping is managed by page pool infrastructure and
> was previously managed by the driver in __bnxt_alloc_rx_page before
> allowing the page pool infrastructure to manage it.
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: do not map packet buffers twice
    https://git.kernel.org/netdev/net/c/23c93c3b6275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



