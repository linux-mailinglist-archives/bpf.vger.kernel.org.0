Return-Path: <bpf+bounces-43940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA23C9BBE3F
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F5CB213A0
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4880D1CC165;
	Mon,  4 Nov 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI3+Uiqp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B223A6
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749822; cv=none; b=aA4ROmGdxIwxCt1be+juxkANQ3voDAb5Y0CsCaoRuduWFVLQcSGthpMJnNeWoqEtM2p0vCNwtXmO9uHdUBzo5L4tGOu2HrQPdB80sKi1s9NYw1uNdRrISbvnWCW3Vm0OCfTSleq3iPK5+oZcsEoPiezXkfj9jI7hlR4lXHyWo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749822; c=relaxed/simple;
	bh=ohc2JU/UXNFoJM4Qo6bV/kRrhVT45p8VTlIJnlCXWJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=exdqkqrJq9s1XjKhLcf87ZrdezbI0OFLo0fgbf+76OpioOcneyPG4K9ugrQ8b1q4V2Wjirw60y6qIi+KNUWr9ZzXEUAutZrHsCDodTo4fIwi77pRCUH0x9nsulls7EBvuM66zknETFdQORLVllKZBBhNwewUzE8ViCXNZzxxhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI3+Uiqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514E9C4CECE;
	Mon,  4 Nov 2024 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730749822;
	bh=ohc2JU/UXNFoJM4Qo6bV/kRrhVT45p8VTlIJnlCXWJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nI3+Uiqp4Qx8SPI58ATq1AENbnrOv3nUoHmqcOX3b35xEs0ZODPO/3kcjn46tdxKx
	 Eo3odYSo/K4KfUj//zW18mkIKa3hItamdDsxzgcYh7A4oGTwpXGQZqO7TDLfpm9rAQ
	 eqIUl+w85QJMB/6YYK2D/m9YSj8nz3MYw6P0U7zbLyUjqxWCxYWYZAAgLyZGIxmOii
	 rwHQbQLZSD76eJyU1YeMLmSrtSNTTfQBT2vww+1OtQ0kIpGuDmnFS4BOdr7DLz1TDi
	 u2ByWBphQgvf9bMz6DCZZLXQw17XcQndNEmuMY9hjYgwZN9IMvEh8qCIqRqRPzM9xe
	 FjsIiYAPJMZow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3405B380AC34;
	Mon,  4 Nov 2024 19:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] Handle possible NULL trusted raw_tp arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173074983101.4192045.14999885368639278804.git-patchwork-notify@kernel.org>
Date: Mon, 04 Nov 2024 19:50:31 +0000
References: <20241104171959.2938862-1-memxor@gmail.com>
In-Reply-To: <20241104171959.2938862-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  4 Nov 2024 09:19:56 -0800 you wrote:
> More context is available in [0], but the TLDR; is that the verifier
> incorrectly assumes that any raw tracepoint argument will always be
> non-NULL. This means that even when users correctly check possible NULL
> arguments, the verifier can remove the NULL check due to incorrect
> knowledge of the NULL-ness of the pointer. Secondly, kernel helpers or
> kfuncs taking these trusted tracepoint arguments incorrectly assume that
> all arguments will always be valid non-NULL.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
    https://git.kernel.org/bpf/bpf-next/c/cb4158ce8ec8
  - [bpf-next,v3,2/3] selftests/bpf: Clean up open-coded gettid syscall invocations
    https://git.kernel.org/bpf/bpf-next/c/0e2fb011a0ba
  - [bpf-next,v3,3/3] selftests/bpf: Add tests for raw_tp null handling
    https://git.kernel.org/bpf/bpf-next/c/d798ce3f4cab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



