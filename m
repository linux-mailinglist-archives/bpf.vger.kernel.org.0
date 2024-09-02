Return-Path: <bpf+bounces-38721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41822968C68
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC1F1F23095
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296E1C62A5;
	Mon,  2 Sep 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwctoLmR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC91AB6FA;
	Mon,  2 Sep 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295829; cv=none; b=Cwac+jiyjRm+Zk/xJSWW+Fy+j/8zingr4FdZZn+6yh8LF07ZvfepOZww9uxwfEE2gWyKTj+fxTZTMiLLjiiXLNCDGA10oX68iDfQsitwrD32xjGEvCzExUmRlqMwspxnBUmRr/lvCG+5i0q7hkQt7PHKa+q2vk6tjqSzU5BRWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295829; c=relaxed/simple;
	bh=wxPFyeq5yzB2RoK93AIqyg1fzdGOH1Ytlp1a/YYU/50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HHtVDz+FEoJ473MnUXmzZzpwKMdUr5jVW0Tr+wz7Bq2Fn9VxTkaouT1i6+BtRLb4EVmlQKsVyJGwaokFgYOn0vw+i0lWz43V/LdO3mvSQ3mlo3uUIUuuf7XhSoVBtpl+43TQglgFP71kIEVs47NeJSaZUs9q7NSLHg4sinwtLg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwctoLmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2BAC4CEC2;
	Mon,  2 Sep 2024 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725295829;
	bh=wxPFyeq5yzB2RoK93AIqyg1fzdGOH1Ytlp1a/YYU/50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DwctoLmRSGaPY4U+46CXD6gku7kxvNtjj1KSFHwvcpoK8r7KUeEsu0f7DcwWU4hj/
	 L7RSR4tC0Q9GyFr7DB4IKeh0NCnJkO9jRpKhqlHqzm4LvMGcTMNy4hN21JWOol4bVc
	 ebLaO/gBgVHgsTEKYSLSeryfQ2O8FLRK8lBxh6C1vYKqj5zOQ0N9otKBKd28WloE77
	 OOeccnvGAvy6FUkoEK9I75vpagb9uiFmMgsdmtm1KWCCXYYhnPj4aKAkkwEAJvX86N
	 gxa+pzDs8goVuPH96EKIfY6a01Kg2P/ix04a/OQCQbJ5cW9hSyU0FnxBr96YVt1gUi
	 xiC2kuZq1tTvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C183805D82;
	Mon,  2 Sep 2024 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, sockmap: Correct spelling skmsg.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172529582975.3940663.7590397936206103563.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 16:50:29 +0000
References: <20240829-sockmap-spell-v1-1-a614d76564cc@kernel.org>
In-Reply-To: <20240829-sockmap-spell-v1-1-a614d76564cc@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 29 Aug 2024 16:45:51 +0100 you wrote:
> Correct spelling in skmsg.c.
> As reported by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  net/core/skmsg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf, sockmap: Correct spelling skmsg.c
    https://git.kernel.org/bpf/bpf-next/c/731733c62348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



