Return-Path: <bpf+bounces-11844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0137C437F
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 00:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532301C20DD6
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9566119;
	Tue, 10 Oct 2023 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFgClY9S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4332C61
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 22:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84A94C433C9;
	Tue, 10 Oct 2023 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696975824;
	bh=rUd/mgzwnBsAgxquzA3VH4UQeufVUBY4Ul9fXd6W+JQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UFgClY9SkfPQO8j7XWNEGtIhZOdVp0j7V+Zud/2s4iLICiNv8mHd5ylzs/tqBlfL/
	 KY6NaSWtFc/EMIrrzAaU8todW+ljDaesz9XboWnP9RSy1eoTkbAjVcGWpT/Ro17LAP
	 5rsQYzY/udgoGLXd204P+VNoHD/9tpnhKeikdr0F+AC5JqgmAvr4K/YaP998rp8ttg
	 wF4C4f7jxQyGQeqW3X1yyZpIQJzHvkE41yaLibpBp34yl2CaulqVNuhqQzDmfVkezI
	 H4FXwbXksd3w+HaGB+XjypE9i22Q3GiMTzkuQSSLLryyul6BjHP94rT0tmgITY61s/
	 8kOHaAlYWGrqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 644CEC41671;
	Tue, 10 Oct 2023 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] s390/bpf: Fix backchain issues in the trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169697582439.11052.1350199577400036698.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 22:10:24 +0000
References: <20231010203512.385819-1-iii@linux.ibm.com>
In-Reply-To: <20231010203512.385819-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, song@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 10 Oct 2023 22:20:08 +0200 you wrote:
> Hi,
> 
> Song reported that a patch he wrote was causing kernel panics on s390.
> The disassembly printed by the kernel indicated that the stored
> backchain was not a valid pointer; setting a watchpoint in GDB has
> shown the culprit: the trampoline.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] s390/bpf: Fix clobbering the caller's backchain in the trampoline
    https://git.kernel.org/bpf/bpf/c/ce10fc0604bc
  - [bpf,2/2] s390/bpf: Fix unwinding past the trampoline
    https://git.kernel.org/bpf/bpf/c/5356ba1ff4f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



