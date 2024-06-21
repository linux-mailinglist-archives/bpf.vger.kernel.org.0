Return-Path: <bpf+bounces-32754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB7912D21
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 20:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA316B25CAD
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE5D168482;
	Fri, 21 Jun 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blEh02Gl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7E13D521
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994034; cv=none; b=cREW/qWbJI7J/jkiKjaKNrJg8dvQVkLxReSyUNXKjxv5ZwMjCS7hUISqE2zhkF3HhFfLNlnNxIhA4PABvKaQKBKQLiGYLSc9Evhgz9EgLnYv928FG7/5ScU9FLd9HP0gO3TrDwg+ZTt3FgXtjrsIAa1X2qfDjRB+b6EybgsE9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994034; c=relaxed/simple;
	bh=HYdkD5+6emd1Dcyddvs4QCVofbPU/TTWJM21EzxQwuQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u/zreo6e66wc3xIeyl3UZArPaUWW0KsGdVLMzZRWXUr2EImz0oQGiWtPtGF0rGvWS0wAq5XDg+pqRniHWwWIL0uT5fQNtbqBEbueoLyyisz3vHMyLk4A+LtlW7xNcERdJHYb3BS8ZtO6x5BEVxqFYtbmARO3pPsdqaFclcmHqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blEh02Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38143C32781;
	Fri, 21 Jun 2024 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718994034;
	bh=HYdkD5+6emd1Dcyddvs4QCVofbPU/TTWJM21EzxQwuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=blEh02GlTFLDBvZYSsyVqEyhefNaKIQy+4XoNUhEjQoW2604zD2y36jVqoY0wYQso
	 hwzQiunBjtdMuDvEqih/6zfkv3FXy/VQhp1PwqL6c/yAU1NUeSXdFRA7HOv0I29VuT
	 uuEPFAgGHvE/UNOLVEHaHngz6ZDEKCeb9gdOGsMld/59BTkFnJtfTW8aGjQeSYmABa
	 tXYnrG0LIbq18xnhspsl6y2TO2zZfeCNaQLW004t+yjTwcOpc6HdqhMaUaVlV5XVfQ
	 UA+cAaT9OJMwV8IJ5KiWp7jTHxZpQC7EVzmBWb5AoZFy8/XjS/1WP1IFaeJe3Ed1/p
	 bSffpUwfNleFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2557FE7C4C5;
	Fri, 21 Jun 2024 18:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 1/2] bpf: Fix the corner case with may_goto and jump to
 the 1st insn.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171899403414.24191.3222078179875130837.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 18:20:34 +0000
References: <20240619011859.79334-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240619011859.79334-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 zacecob@protonmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 18 Jun 2024 18:18:58 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> When the following program is processed by the verifier:
> L1: may_goto L2
>     goto L1
> L2: w0 = 0
>     exit
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/2] bpf: Fix the corner case with may_goto and jump to the 1st insn.
    https://git.kernel.org/bpf/bpf/c/5337ac4c9b80
  - [v2,bpf,2/2] selftests/bpf: Tests with may_goto and jumps to the 1st insn
    https://git.kernel.org/bpf/bpf/c/2673315947c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



