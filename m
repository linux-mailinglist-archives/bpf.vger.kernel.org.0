Return-Path: <bpf+bounces-57182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F0AA6834
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 03:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFAB3ABB7E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E71A08CA;
	Fri,  2 May 2025 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1B8yLAy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925719E97C;
	Fri,  2 May 2025 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148204; cv=none; b=cjhE7FbB9LWtyWkFcEjEpkX4CBWWNHK99PZ4+RVTSDHfQiQ8kVs1edAXl3eKP9Nq0wvUq9lz+8AVHcQ9/5yuhaEat+KRyDzk5ZPQWxJbDrfrYlk0v7OBkBSFJO3pJd6tcc85l5eoC95t7yLbmGHujAXWrmSS+WMT0k8fzdaqMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148204; c=relaxed/simple;
	bh=HeRz4Eqjgid11Yf2gHq/DK2dnmS/GnV7dhlmGANKrNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NA9AN+4V8jwXB18zGW1a+Xmz4FXAEmU8LNWRTekZBObzfN5eGJQ6zcTN41BuU3xbOH1QxRkCdBAj4CItX1GK6QVxOnITtjjO+o23nNhagAtX2YBHCTpo94d6KI+ENQ/vvfSpHEInDST1DdJ+mVyL4Y4S7MMt96/P3t0s0yXLUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1B8yLAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970BEC4CEED;
	Fri,  2 May 2025 01:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746148203;
	bh=HeRz4Eqjgid11Yf2gHq/DK2dnmS/GnV7dhlmGANKrNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G1B8yLAyDtduRjGPdq7uUrpR6hEKFMURfo2UNDMhNEWKlUW6kPbnvPt282ioWWGBK
	 qhqPTgMWdnkNJBSxO4wNKzdZM3lHrktJDK1Ftr7nbnML8ciWyEbZYLC+s7nUr5XWCh
	 IyYxH2BdOUuevtYnJm6ciXi9k9YaezN1sdB1NqMNXVFrQJ1tMpCWGUtqqED1L55/3K
	 jnitNdb2kNTeRvgv522iSip1N++Xpdnik+uodfPSKT/BT67fXDFkVcjM1j3bhzwgqX
	 ZwfLLyXYVj007xBfeMzeSmeWQbcvwjby2kGaktM06iztrWdQVCtLGUq+fR27E1LpfH
	 pbwWtmB+C1T9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0443822D59;
	Fri,  2 May 2025 01:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] ipv6: sr: switch to GFP_ATOMIC flag to allocate memory
 during seg6local LWT setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174614824249.3123530.9494554975799967680.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 01:10:42 +0000
References: <20250429132453.31605-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20250429132453.31605-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, kuniyu@amazon.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
 ahabdels.dev@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 15:24:53 +0200 you wrote:
> Recent updates to the locking mechanism that protects IPv6 routing tables
> [1] have affected the SRv6 networking subsystem. Such changes cause
> problems with some SRv6 Endpoints behaviors, like End.B6.Encaps and also
> impact SRv6 counters.
> 
> Starting from commit 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and
> RTM_NEWROUTE."), the inet6_rtm_newroute() function no longer needs to
> acquire the RTNL lock for creating and configuring IPv6 routes and set up
> lwtunnels.
> The RTNL lock can be avoided because the ip6_route_add() function
> finishes setting up a new route in a section protected by RCU.
> This makes sure that no dev/nexthops can disappear during the operation.
> Because of this, the steps for setting up lwtunnels - i.e., calling
> lwtunnel_build_state() - are now done in a RCU lock section and not
> under the RTNL lock anymore.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup
    https://git.kernel.org/netdev/net-next/c/14a0087e7236

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



