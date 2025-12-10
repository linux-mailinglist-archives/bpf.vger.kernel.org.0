Return-Path: <bpf+bounces-76402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E6CB2636
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 09:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB85330271BC
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFF02E613A;
	Wed, 10 Dec 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0TMvcAj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683E23505E
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354995; cv=none; b=kYNuerQKGZgKJzUQfeib1Ie4gUbVKH9PeZivX2F4z33NN1Mch1jG3owCXqUbQiZXibR66FHzpn9ezVS0ffuDNP5DrumgEl1bckSZjfhrXz57yUR4hp3VZK8cLXsb0p1LIxcov+JFsUvGT9D4E9Jc93YOe+3A8HqqcK2d/QdVqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354995; c=relaxed/simple;
	bh=SYEbIA+zEE7zuU9nPLRQuKU9tolKaSWVyzcnI0cm26U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tJbZtLe3D2C3Iij6iSsS0R/WKX0UyQy8EUAbGuixOvMW0VysrT2dijHQvJVKuRH3KfK9+eIirhtqNrHlyfzvyqyphJsQgvstDWnjwmI6cSV/arF5gvmPrImnidQTXq97RP5DvrPXaVipn7rx93qjF1Jc93uwP3Kt79KM/X+mL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0TMvcAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC38C4CEF1;
	Wed, 10 Dec 2025 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765354994;
	bh=SYEbIA+zEE7zuU9nPLRQuKU9tolKaSWVyzcnI0cm26U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F0TMvcAjzWI+fQ7pRFKHccLtacY9yY3azzFYSbrvq9LYUMGZ3qjKp232RrKqfT5I7
	 Eh0+2KchKPpgwJMdWfVLEA0bkX+sAeFpxFC+2JUqA/pNQEVWwF4v91s6xnDwXOzlNM
	 0mFOMJaKMyWO//Szi+8ekmVi282pQixsDLRBGnXznOF6L9uZvwtsNPgebmJj0skCcQ
	 bSggPs1jl4ti16SxQL9rCIZr3KgBJPIGl5ePVrGOYP5MtmNgwFdxUjP6JR7YMLg5EU
	 yBXTVDlS900mbYlZsw9gzY8VhEZeEG6gj6xlwJdfYjL+0oR3ZE9JpnlKOQeu365B0u
	 oMjj0Pp2mp9ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B84E3809A18;
	Wed, 10 Dec 2025 08:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] bpf: verifier improvement in 32bit shift sign
 extension pattern
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535480904.504732.11414561723390357570.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 08:20:09 +0000
References: <20251202180220.11128-1-cupertino.miranda@oracle.com>
In-Reply-To: <20251202180220.11128-1-cupertino.miranda@oracle.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, andrew.pinski@oss.qualcomm.com, eddyz87@gmail.com,
 alexei.starovoitov@gmail.com, david.faust@oracle.com,
 jose.marchesi@oracle.com, elena.zannoni@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  2 Dec 2025 18:02:18 +0000 you wrote:
> Hi everyone
> 
> Looking forward to your review.
> 
> Cheers,
> Cupertino
> 
> [...]

Here is the summary with links:
  - [v3,1/2] bpf: verifier improvement in 32bit shift sign extension pattern
    https://git.kernel.org/bpf/bpf-next/c/d18dec4b8990
  - [v3,2/2] selftests/bpf: add verifier sign extension bound computation tests.
    https://git.kernel.org/bpf/bpf-next/c/a5b4867fad18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



