Return-Path: <bpf+bounces-26987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423168A6FD2
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35C4282A1A
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D05130E44;
	Tue, 16 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyqcTz9T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B6130492
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281428; cv=none; b=tlIq8/dFWYb0+u5yCDkQmGGL+b5D19qMtauLIGWiJs6rNDgj3P61wt33s4OSNe/w916K83exCrjDKyJx14hQUMynL/Ht9oS1y35BV5id7Ev2PguNgn767kla/vERP1s862Ye9q5F9NPstkGeePw2RPPlTk0shIU89XV+i2l57BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281428; c=relaxed/simple;
	bh=oPwvBqYAEpsC9wQTdQEO0Wb1hyID1ZhiUozjUzIHPTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lcup8tOoU0+6+JWB72gaogVGJ924SyDs7SqS2AYrBFAveO1Vf9uGDue8Y54STQu9xO7gwwiPp4GBZnDx9CWTf0p8dweBkRYjE4EQGwu5f7Vcvshk+wC/Ij34cGY2vcepDNu72g4OI/xKMoSMWxWf9/XT+ebi7rVRCeIZP+XpCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyqcTz9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 559BBC32783;
	Tue, 16 Apr 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281428;
	bh=oPwvBqYAEpsC9wQTdQEO0Wb1hyID1ZhiUozjUzIHPTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JyqcTz9TWcFq9sASdFXtkHiiKRTdh4GxySZDVog7CunMepoxTuFJrsh7amwhe6heJ
	 /4pEagaCTQ7zXryalI91kzSUMF6CkMHiv5lTcY3Rl9Sd93X9h2wqd7OZk0GMEwE5p5
	 dadBnBtp/vhCMvmULNQ+TJ677ExkFEzf6A7ZEwWf4YrGHxUPqQm3++iMwcyuesnj15
	 Kvc6W8yOZ2RdlrLAMzobt69vSCda0CsPA+BxEmMSqllzgmvrd+wiwkCUN1P1joi8h/
	 YP+6F1UZ4L82c4JLMn43rXkiMNhzjCw3LyHAI2izvsbAIKlOcs3+zrctQdY66jay3q
	 8+qVXJQg1Mf/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 407E7D4F15E;
	Tue, 16 Apr 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Fix incorrect bpf runtime stats for arm64 and
 riscv64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171328142826.29407.1876399986836922707.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:30:28 +0000
References: <20240416064208.2919073-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240416064208.2919073-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, ivan@cloudflare.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, bjorn@kernel.org, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 16 Apr 2024 14:42:06 +0800 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Fix incorrect bpf runtime stats for arm64 and riscv64.
> 
> Xu Kuohai (2):
>   bpf, arm64: Fix incorrect runtime stats
>   riscv, bpf: Fix incorrect runtime stats
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, arm64: Fix incorrect runtime stats
    https://git.kernel.org/bpf/bpf/c/dc7d7447b56b
  - [bpf-next,2/2] riscv, bpf: Fix incorrect runtime stats
    https://git.kernel.org/bpf/bpf/c/10541b374aa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



