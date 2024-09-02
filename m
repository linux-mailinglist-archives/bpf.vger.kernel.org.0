Return-Path: <bpf+bounces-38720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B8D968C66
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0488CB21BDB
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11A81AB6F0;
	Mon,  2 Sep 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPnBvLgu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA73BB50;
	Mon,  2 Sep 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295828; cv=none; b=DgQsgUsqtV2Mj14h9CQMxYY5fyEqjRbxUpdRSam4WCf8aqzgussDIV0E4zqZqUh5Fmrk9oEaZFHcEn9fzGEErVtkKCtMZfZTeU/jSNo8J23A7mAX3TnCBj/K6xmqTBTrtDDmvLSGuY2cljTv+UawA+I/ASSpsDLlRbou6TjO4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295828; c=relaxed/simple;
	bh=1z/07igGMbmNg+P3E+Orp67NJHAjT/01gy4hXePzFmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VArg2l3r/Z5UKxuPezqo8AdWxOYdWZvuW3zGtkoCvbx0CchVfQKl0RaDKjFXVK/tsQS/ru+c4enba2wCRnsvRDnA4yrFUTMOl6fLurgXboUwGIpcd+MHsyP/iDhCWC9VBq8p+b2975hQNijiAMXqZKf8lNelSIo4JSvEaKeWwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPnBvLgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14FBC4CEC2;
	Mon,  2 Sep 2024 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725295827;
	bh=1z/07igGMbmNg+P3E+Orp67NJHAjT/01gy4hXePzFmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mPnBvLguhB+WP4gmBcITd54Z7+ymfv15e1WQFyiZXrv/n4AXF/V732H45fNEYvKCS
	 YyUIkKifNBmeShrngJiNzqIk5R6EZAYYsz/jjHqGK4ZrJjuZmCs9CI+9ZZW7WsbhWY
	 IBWCqtQcsyXZVp8V6HKTBFwJjCOi+MGoTNxCNBa8ehPCBW61RLK8B2Bg0MNFOrGEaW
	 FyAEmmtvfE1wZ+DsKnzXP+FC5YciCMQv5lb8LfzdR+fRckDQW3jpRbUJmYq2Wz9N4Z
	 OOZFQazYlXqzr8KZjMRuBzx2/7KYvQHQjlops/nsnGWFoh4NeoJhoQdFETGqWf9TVn
	 oJZNJeRaT1KBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE093805D82;
	Mon,  2 Sep 2024 16:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net-next] tcp_bpf: remove an unused parameter for
 bpf_tcp_ingress()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172529582854.3940663.11642128339023634756.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 16:50:28 +0000
References: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
In-Reply-To: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
To: Yaxin Chen <yaxin.chen1@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, cong.wang@bytedance.com,
 john.fastabend@gmail.com, jakub@cloudflare.com

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 23 Aug 2024 15:48:43 -0700 you wrote:
> Parameter flags is not used in bpf_tcp_ingress().
> 
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Yaxin Chen <yaxin.chen1@bytedance.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp_bpf: remove an unused parameter for bpf_tcp_ingress()
    https://git.kernel.org/bpf/bpf-next/c/5d1622831064

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



