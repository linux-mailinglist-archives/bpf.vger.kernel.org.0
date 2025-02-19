Return-Path: <bpf+bounces-51894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849A4A3AF52
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B0A3B0C24
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB02D15C15C;
	Wed, 19 Feb 2025 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPqNhZ8L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1622301;
	Wed, 19 Feb 2025 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931004; cv=none; b=BGMLiXYXF5mRdlWw3b11AHPO86qfkkxvwgvFXdfRG1QlJu0N+L8ckhhodWJyYY9YR8xHTtPnVXUdWCvJNFl95Izs4o903/RESui98/2++55XsfnJkQDXVB/ufA44u6/pVAqhB8NtzLnSnxZe78stfwhXsc1mtPFPC69E8mYFrZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931004; c=relaxed/simple;
	bh=1vuRrzCv9xweqkmuH+srxMwEH5MPJ0Ub298fgEapBkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mLn8Tu2sPHpDfaWl0/votc/swq4xNrjQDMERR26znW8e2qqgRpyD0LWPtx284m52p5OlsjTFiOvXFgYbRqwlKGllfDjUw3vemg4QDd+trNJOeEhazsR4dC0mrP06WKCR7YR9RMqn3PvNUMJ7Y/LBY3+mA8VL2mRgAgXgQG8Rumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPqNhZ8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2A3C4CEE2;
	Wed, 19 Feb 2025 02:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931003;
	bh=1vuRrzCv9xweqkmuH+srxMwEH5MPJ0Ub298fgEapBkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sPqNhZ8LhVCX5z4gNqkF1PPv0lZoBTxTARFDdfZiMJigB7IUEQ755p5S4k3jXbOsG
	 yP1Dsb679iism7Yz0EDTG4iozS3bgGZyDw/5SX9xCTOLa5u+AefnIUhrOJjh4IoIVo
	 tiyyQsAVqHJk9BnRr6Kpm605XQvIDKgb4W4E9WR2l5ioAus7hrZIU7XcsrlDR8Zz/b
	 mFiNUp7t+JDpHBeM8EXgKk1T68dbS5wD4FW0ML6/z/cPyU5fL0QQBXLVqHRyUG5K51
	 6j5TlQ2O5l6kUgEi4A0op4AMrlYL0aa1O6MyGEtIz3w9klXHvMY8efXx3LIiVwGXHG
	 dzz1JsnInEULg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34055380AAE9;
	Wed, 19 Feb 2025 02:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: set xdp redirect target only when it is available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993103376.103969.7360725098289491054.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:10:33 +0000
References: <20250214224417.1237818-1-joshwash@google.com>
In-Reply-To: <20250214224417.1237818-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 stable@kernel.org, stable@vger.kernel.org, pkaligineedi@google.com,
 jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, willemb@google.com,
 ziweixiao@google.com, shailend@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 14:43:59 -0800 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> Before this patch the NETDEV_XDP_ACT_NDO_XMIT XDP feature flag is set by
> default as part of driver initialization, and is never cleared. However,
> this flag differs from others in that it is used as an indicator for
> whether the driver is ready to perform the ndo_xdp_xmit operation as
> part of an XDP_REDIRECT. Kernel helpers
> xdp_features_(set|clear)_redirect_target exist to convey this meaning.
> 
> [...]

Here is the summary with links:
  - [net] gve: set xdp redirect target only when it is available
    https://git.kernel.org/netdev/net/c/415cadd50546

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



