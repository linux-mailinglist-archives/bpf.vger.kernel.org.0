Return-Path: <bpf+bounces-9784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E838879D9FA
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35B6281BF7
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF2B64D;
	Tue, 12 Sep 2023 20:20:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC41FA8
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CCF6C433C9;
	Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694550025;
	bh=hHFOxkwWPUtRzqpYo757WoZUZn4Twmz5EfGjFfx3rb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S10YmzMZz4XIQRC3fXmBgknQ8g7X57k/VJQPqviJOj0AgPZAzlCTwEoysB/nJYQ0w
	 d9PL6WUaqmQrMnLRkEvpxEpNqTFdjyQhNCU0NRpIUipMdYnBD5shVdxXBI33GAJmzI
	 9/TxL9HwbbN0TitzSn21gZNAKoi0xbVakDz6PBZ8jVGaMtXAapIWgxoJTCDHmaafIF
	 9P2xa6hf7S8qk6W2AilFxrpWLck8k0tmOGQqzQ/xUHHXXdmqH8BoY9FTDWN8oqGdxe
	 igoD0VA3DFyDxFmd5F/78zUVmwmQBbqXKRhOj3uLzWPIjtSifPl9ffMP/zQfnU/ScA
	 CCBXDJm9l/39A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FF15C04DD9;
	Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix a erroneous check after snprintf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169455002545.29579.9098192345328945185.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 20:20:25 +0000
References: <393bdebc87b22563c08ace094defa7160eb7a6c0.1694190795.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <393bdebc87b22563c08ace094defa7160eb7a6c0.1694190795.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, void@manifault.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 Sep 2023 18:33:35 +0200 you wrote:
> snprintf() does not return negative error code on error, it returns the
> number of characters which *would* be generated for the given input.
> 
> Fix the error handling check.
> 
> Fixes: 57539b1c0ac2 ("bpf: Enable annotating trusted nested pointers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - bpf: Fix a erroneous check after snprintf()
    https://git.kernel.org/bpf/bpf/c/a8f12572860a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



