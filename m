Return-Path: <bpf+bounces-39608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC31975490
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604202839D7
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D975018DF97;
	Wed, 11 Sep 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbAbuFEX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3D18593F;
	Wed, 11 Sep 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062630; cv=none; b=mWYwlEIU/IsaY/fSUaFGgEfdhqhZMhDoU4lliKM3RYrqnoK8A5RHg+qp9DAHu71zzQl8kja7YZFV8TLBSYRenBcwK3+gK7oMJbbqwpQyZb4qGsJh1I/oKSXQOa8JX5ZZADfoJPyVV0opg3IMh4mqqgEqXi/wM+oO5WM+8OjNYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062630; c=relaxed/simple;
	bh=S7446+9lkYYtrrftnee+FNljo0veD58VbH7E7EawyhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qveHBYdoM3QoRZsYyGTYdOdghlD9GF3tXohkx/1//kRNDmGzO2llaFXVRV/cLSZARpDOVNdqXoyZntRNqWudBrh/Mf1ph+O53K6GXq2ENHYOx5N3mCjC0FiWMxxNdEJWce3CjiUPCbd8P7yEo5hXI3GfbBMtMkpBL1ti04lVMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbAbuFEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D8AC4CEC0;
	Wed, 11 Sep 2024 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062629;
	bh=S7446+9lkYYtrrftnee+FNljo0veD58VbH7E7EawyhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbAbuFEXj4+/y8J3MEcthkL9RWaWL2UvpGshV4JtjkmkDoTplnuedh7tXb2EP2bDL
	 f7XHdJV/z5Bnqdc8vzUdsmkOPwmWbHA3k2RFiA3xS1l0PfvYAc7jmln25sqIHuLHEm
	 uWtQtvgw7Z05qr/q2zCAynIJE3y+czaXiGZCcLZGmXpjvnsjpHf1g8NxJ+t2wqf8lw
	 P2Tg9fPp/C6mzzY6Oq1DK42djSoAlw4G1DqT/YLlELAXh2Cp17UFCGA81KJ2h+7EWv
	 EMHQaLrcyltvMSg8W5otxL8EEZt8HI/n4CLKo0N+6nOORpfjkuMfjs1v7JyJsctO1C
	 yA4xGN2j9axEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C993806656;
	Wed, 11 Sep 2024 13:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests: xsk: read current MAX_SKB_FRAGS from
 sysctl knob
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172606263103.924230.15052310270717202282.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 13:50:31 +0000
References: <20240910124129.289874-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240910124129.289874-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 10 Sep 2024 14:41:29 +0200 you wrote:
> Currently, xskxceiver assumes that MAX_SKB_FRAGS value is always 17
> which is not true - since the introduction of BIG TCP this can now take
> any value between 17 to 45 via CONFIG_MAX_SKB_FRAGS.
> 
> Adjust the TOO_MANY_FRAGS test case to read the currently configured
> MAX_SKB_FRAGS value by reading it from /proc/sys/net/core/max_skb_frags.
> If running system does not provide that sysctl file then let us try
> running the test with a default value.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests: xsk: read current MAX_SKB_FRAGS from sysctl knob
    https://git.kernel.org/bpf/bpf-next/c/d41905b3bb89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



