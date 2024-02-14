Return-Path: <bpf+bounces-22036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48D28556C6
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 00:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848BDB27CE1
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A8213B78C;
	Wed, 14 Feb 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYjJ+Hcv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E00128378
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951633; cv=none; b=m2W3ZNPCuY7qo98LjqYRFsL95SGWfoGNAHpjguGny5dzdpYSUAx72Z+TfXKxU9Eyi6r5FeebBJWVXcvDd0+56S72fZ8KjxbDW17RiBNr6dVxYOZM+K7peDoKLrh76VgwQrtLl8vAEoRUQgRxE86bfGHp6Bf6vl5szMvAskV3UmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951633; c=relaxed/simple;
	bh=n906eqLdzkWJxSM+U+trpdcyHIKA0LxhTTJ/6ZrFA4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kV4UR7Vq6+tYy9PzsTaC5w9OUInBmOd2XIfiMyi/jzi/EApQVd9bviNKNHJk3v/MHLI1DdBHPfQ/LoSC6wZwbTrOy+ce6lNb+WdZJSvefU/vK83XSftbrtjxj9eWAycrs8SyavcaYq6Oe0jz1uVlUTpMOWy8Ux/v90fY8KoQqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYjJ+Hcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C254BC43394;
	Wed, 14 Feb 2024 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707951632;
	bh=n906eqLdzkWJxSM+U+trpdcyHIKA0LxhTTJ/6ZrFA4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jYjJ+Hcvej63Ag8XXGKJdSqL0FKwnwF1I/aQqetFJr2GB2HkRhoJZSnGDqwm9AgJh
	 lv5uhDNvJFeZTLSVLETOuGGx5gZqu28KMSFrsMmncqbvcycej7VrAW7VesrlFax1LW
	 t0aJkVa0A1YInk6OL3u+dOX+CoPJyOxmXnFWA5m/Qal947l47yLi7DjhUBuAH4WTmp
	 ieg6Bnb132S2CERkTK2xdmprQK56ifKQ/0C77EOIWskH5JUoeq5qu4fQOWtsTAFk3C
	 FGgEweVm1iFOdXp+U4HsTLxi66LWqHs4eslq2HIEDSMYFGqWTeK4LWGZXQkTMDXmyt
	 LE3AvkYft8DxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7485D84BC1;
	Wed, 14 Feb 2024 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: use O(log(N)) binary search to find line info
 record
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170795163267.6118.13119774781444376946.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 23:00:32 +0000
References: <20240214002311.2197116-1-andrii@kernel.org>
In-Reply-To: <20240214002311.2197116-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 13 Feb 2024 16:23:11 -0800 you wrote:
> Real-world BPF applications keep growing in size. Medium-sized production
> application can easily have 50K+ verified instructions, and its line
> info section in .BTF.ext has more than 3K entries.
> 
> When verifier emits log with log_level>=1, it annotates assembly code
> with matched original C source code. Currently it uses linear search
> over line info records to find a match. As complexity of BPF
> applications grows, this O(K * N) approach scales poorly.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: use O(log(N)) binary search to find line info record
    https://git.kernel.org/bpf/bpf-next/c/a4561f5afef8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



