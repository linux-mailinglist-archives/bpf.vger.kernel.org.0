Return-Path: <bpf+bounces-47317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6549F7B59
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 13:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165F37A5B4B
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593A2253E0;
	Thu, 19 Dec 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvMIf8Cg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FD2248BA;
	Thu, 19 Dec 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611416; cv=none; b=X0gHM6pR9Zsrt8aAsn7iuIlQnc4gd0pn/mcksEvnfHrmRcX9irC9s5YTAuX8eZNK3GFVd1HNIvuEBuIhc0Wx83bk6Cvba8ITLAQOWeTlZdLwlmEWTQIk3QQQcOyR9bSb3WFq33SNIe8jCaHvLKJFCi+uYHnKxQ8tI4Okcd78jmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611416; c=relaxed/simple;
	bh=9uRoxvcxKvdooYBXPzUvSfSpejHOsahqw5PMMeZoCss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SNhEcVXHM1TqxK+7Nf5XKlqL1uZJ/JSnCl6oH2mMZ7tLTfnLxU1OO0cuSaWzMYdWBUjtVaThFoKuQd9psM76kWA48JGz5webqukdEU3G/Ze2Oe0MTtyUKCVJreJkSbvPpUHMhGfbrKgTk8rfC/oFGYyj3ucpt2k3ESuHZDswyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvMIf8Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0571C4CECE;
	Thu, 19 Dec 2024 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734611414;
	bh=9uRoxvcxKvdooYBXPzUvSfSpejHOsahqw5PMMeZoCss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rvMIf8CgXUznLxwpYA1ChvATt0Uu0MFQ9NqyWrDdB7UbcBGJYSZU85x1nylP178NP
	 UhoLhWBxgxGWZVJvLWhWVVkRt8rnfISmO+pZIJEYS/N4xMow8sMxlrEO6ltXKG4SNw
	 8i9qN6fVs25E9Y5bY7TPtIzHWsxDjAcPHiPiEqDOg3jgCYBTiZNsd0ZieBgKLnal+L
	 Li2RRLEVecxYoEhyTemjNsgCRsZoHlza2WvAffxKrKP/MrNJKRSng8TGMcXdo8aFsy
	 B5MBGS6ggKeRtj9OQQGgQZJ9Ua7vztDKZ1n2A2QZysm4DY98ukzlYfurho2hqldW7T
	 BSaqwG9zlxDRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF9273806656;
	Thu, 19 Dec 2024 12:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix compilation error in get_uprobe_offset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173461143251.2240195.7800413033319730480.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 12:30:32 +0000
References: <20241218175724.578884-1-jmarchan@redhat.com>
In-Reply-To: <20241218175724.578884-1-jmarchan@redhat.com>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 18 Dec 2024 18:57:24 +0100 you wrote:
> In get_uprobe_offset(), the call to procmap_query() use the constant
> PROCMAP_QUERY_VMA_EXECUTABLE, even if PROCMAP_QUERY is not defined.
> 
> Define PROCMAP_QUERY_VMA_EXECUTABLE when PROCMAP_QUERY isn't.
> 
> Fixes: 4e9e07603ecd ("selftests/bpf: make use of PROCMAP_QUERY ioctl if available")
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix compilation error in get_uprobe_offset()
    https://git.kernel.org/bpf/bpf/c/716f2bca1ce9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



