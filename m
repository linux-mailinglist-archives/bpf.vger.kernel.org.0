Return-Path: <bpf+bounces-50585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A10A29E25
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA3A167B7B
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B841A85270;
	Thu,  6 Feb 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip2Iwstt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E7768FC;
	Thu,  6 Feb 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803611; cv=none; b=dHBkoaDRvT3zICn/Yx0kYkRJ3xVb29wSfEjIAisoQnoHBG5wx0mt2KDuUYG4ZWklGMs5JEvA7iLyPNzQXjJrvRShFnQhotfJzTcUWyBMIfPVasoo6iko6qzICVRtP+yp0DbA5MNMA2STqdai2ieHW7MCjHz89+RE3iSZn9j8V2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803611; c=relaxed/simple;
	bh=P7/lRyUDtTea65Xs+PwXbOl2Vx4ZhhEsIK/YykjUdY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l0jfYzX8f9a1iAeLZyOAIWAsRKVStCLc1ZfFgyal1oT1AE//L+i/dYcA7pEwarHXvIa/ISsd2qtLeMU9YdA6zKplub7zXoRy9+w0JCqOqb/uthlvRApDfrW535CPEWcewIcmLZtQx5k6vZX0zW5wq8Wxcx/vBSJcM8aGYXzTbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip2Iwstt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14BEC4CED1;
	Thu,  6 Feb 2025 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738803609;
	bh=P7/lRyUDtTea65Xs+PwXbOl2Vx4ZhhEsIK/YykjUdY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ip2IwsttyCSA67yriFrUsA4EC7qntWYmNz56I2MeUJ0QE+x7Rbo9IsPRC4BllsR6e
	 ulSlZgMNmHxoj9y9Yg7rfNaJTTGD9oc/Z/o2c1yLlj827C2UeS5sbNHA4q7aRftkdd
	 Re7UZurOe3IzhTGLvoT/ASQWkj67G925fwBbAi5EjgZKox9uQtbicKT8hvBn9xwQvA
	 lh9/oi3buvYjhB8mEqHleUTQNo6cRx26mTvK5O5TR+NsCyivb5I07X/Nc/zQgA3mN8
	 p8Pr2iRSyf/Co41Z3cZ5JLeR11RSI293pBCIBbR7XbPXy+K2NUYE8bXgw2iC8JzkZP
	 zRhx4kgOXjYVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E7B380AAD0;
	Thu,  6 Feb 2025 01:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add comment about helper freeze
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880363701.959069.14322252522302513524.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 01:00:37 +0000
References: <20250204-bpf-helper-freeze-v1-1-46efd9ff20dc@outlook.com>
In-Reply-To: <20250204-bpf-helper-freeze-v1-1-46efd9ff20dc@outlook.com>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, rsworktech@outlook.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 04 Feb 2025 10:00:21 +0800 you wrote:
> From: Levi Zim <rsworktech@outlook.com>
> 
> Put a comment after the bpf helper list in uapi bpf.h to prevent people
> from trying to add new helpers there and direct them to kfuncs.
> 
> Link: https://lore.kernel.org/bpf/CAEf4BzZvQF+QQ=oip4vdz5A=9bd+OmN-CXk5YARYieaipK9s+A@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Add comment about helper freeze
    https://git.kernel.org/bpf/bpf-next/c/0abff462d802

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



