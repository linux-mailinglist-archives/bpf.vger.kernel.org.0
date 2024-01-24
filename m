Return-Path: <bpf+bounces-20196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA483A0BB
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 05:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688F62895C4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 04:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96A1C8EA;
	Wed, 24 Jan 2024 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls84FGpd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61179BE79;
	Wed, 24 Jan 2024 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071826; cv=none; b=inq7bkvnAnP7QwTn6T1dCPfUt7VGZDaJo+uwrz3YwgK3EFI95+pGB0IX2FDqylzDypz7m53aMPb2FFUex67NveIz6FJf+aB/upbLd6kuKFGiQecE/EvYjw3ceSRITwPh4OGW4/PGRa4Wub4biDxF2DNbJaCTw73VUfCmnqibfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071826; c=relaxed/simple;
	bh=ueRRoOlH78hfKpV0d5rbN0kmVpLLZ6tp1SNyhyIfn6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dWPZ1smtM46Lrr/s59D1bAv7PaV4eiRTOAOdmdg1Pib55u+h/WvSdj8MOHJ+v1fZQKPw5E9NG/3iWeEO/SbF+GVMNjCrkdhJoDYmokQRBpws+O095kYNo2NB/6hEDNY9lU4RVKFxicJz2VHqmze8Fw7BKJEbco680Qf0cOiUZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls84FGpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2D4EC43390;
	Wed, 24 Jan 2024 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706071825;
	bh=ueRRoOlH78hfKpV0d5rbN0kmVpLLZ6tp1SNyhyIfn6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ls84FGpd8XLTXhNLgn89FxV/boxwhUGf9EyVVrZdFp6KSA8noNQQlmEgk30iXF01i
	 SwWHJUqsXiHneiI+JnWzg/Z3Zr24QmxJKSA/0/Mivp7pv9LQ1gz3YReyeHuf4HqOrx
	 WedDbMOYcuXzMxgzrbhZryDLUCm4Z6aAgFk7/uGfSmEhS+KJ77be4F/p+0WbpjXE1H
	 f01tc4m11bV4xzBBOdClxfh6MM48bxb6P+1RKsX6aVWq0G3owuERobt2+lXdj/WGUz
	 sQ5jPouu4oCtr/APyBbj79TGJzQiIrw4e6YNGcCx8zkfULeSDNlaCCIjwQBrtmt+Lf
	 QICLCQ6ACNDkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB23FDFF76A;
	Wed, 24 Jan 2024 04:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/2] Skip callback tests if jit is disabled in
 test_verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170607182582.16094.17473776124345852474.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 04:50:25 +0000
References: <20240123090351.2207-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240123090351.2207-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, john.fastabend@gmail.com, jolsa@kernel.org,
 houtao@huaweicloud.com, song@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 23 Jan 2024 17:03:49 +0800 you wrote:
> Thanks very much for the feedbacks from Eduard, John, Jiri, Daniel,
> Hou Tao, Song Liu and Andrii.
> 
> v7:
>   -- Add an explicit flag F_NEEDS_JIT_ENABLED for checking,
>      thanks Andrii.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/2] selftests/bpf: Move is_jit_enabled() into testing_helpers
    https://git.kernel.org/bpf/bpf-next/c/15b4f88dcc0a
  - [bpf-next,v7,2/2] selftests/bpf: Skip callback tests if jit is disabled in test_verifier
    https://git.kernel.org/bpf/bpf-next/c/0b50478fd877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



