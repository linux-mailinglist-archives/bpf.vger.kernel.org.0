Return-Path: <bpf+bounces-62870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF199AFF6EC
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 04:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595CB1C83E89
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 02:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879925BF14;
	Thu, 10 Jul 2025 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ+kH7jw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D4280A5C;
	Thu, 10 Jul 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115195; cv=none; b=UC2rCoT3/WuRdaQ4DayQ9RIxYIptnA7xpoJm0gAFYb14x8OrENF09BVncM/gXi+S5HbJVQqeS7THsIFXD22EBbDhYDS1FzYGQbM6V7RKHbyHgtKLUEuBkHIf0+3JxB5qTDItytU77gvVMhWpDvHLeOEoGp/R3lHdqGKLlI9Kobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115195; c=relaxed/simple;
	bh=qn1sjrm3ZnvSOCku/UBWq/N0j8fm02+rgViX9WfUvHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H+vsYOcHfQyFR9LwYYZo4YkohYlFUggyF9p1b1mmEQPH6v38W9vr/R5/GYbmiYeoUp7V/lbYkStHb59BwMsaECPnqencZmnOC0LlyQm1m2bKSuL6tyVhY+Lauyv3gUQl+I6xcvUNK9JtJ3YFLTl0uDswxRqhsHS6t7Se2VahJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ+kH7jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A570C4CEF5;
	Thu, 10 Jul 2025 02:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115195;
	bh=qn1sjrm3ZnvSOCku/UBWq/N0j8fm02+rgViX9WfUvHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PQ+kH7jw/i7RLeZjFNC3Uyf1fRr9sE+nCxwyTEM1Mp3LPxnfXv0q/YQLy1wQSfrb+
	 yoOL4TYrXu46nX35URZ6lblPwnICAQB9J9IN6gLDJlF3guC1CbCXzLBEUa4lx+oQKe
	 ayMScDnWVm2z3sLvonKL25J7OOc0S0/6UB0lU385LPHcR559KMqPbul2hcCqu5LfV9
	 6DW8kdil3WYtuUNqsUWV+GytMYn7tnkcsgVXLzXHY0NHskPcRqMwxsKX7zIXpdovj2
	 c9WfD+3JjnBkjs9tmzuVwKn9Nv20ZGw7+lbFRiGRtsLLslAsRCTKfzq2G5X+K/nRjc
	 2hDsBXUMOO4Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC1B383B261;
	Thu, 10 Jul 2025 02:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] Documentation: xsk: correct the obsolete
 references and examples
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211521725.965283.3026383577930214041.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:40:17 +0000
References: <20250708062907.11557-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250708062907.11557-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernelxing@tencent.com,
 toke@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Jul 2025 14:29:07 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The modified lines are mainly related to the following commits[1][2]
> which remove those tests and examples. Since samples/bpf has been
> deprecated, we can refer to more examples that are easily searched
> in the various xdp-projects, like the following link:
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
> 
> [...]

Here is the summary with links:
  - [net-next,v3] Documentation: xsk: correct the obsolete references and examples
    https://git.kernel.org/netdev/net-next/c/819802e25a09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



