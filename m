Return-Path: <bpf+bounces-44980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B9C9CF4DC
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 20:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D91D1F23E8B
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 19:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B398E1E0E03;
	Fri, 15 Nov 2024 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzA4Hm1Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92C1891AA;
	Fri, 15 Nov 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699020; cv=none; b=CaegxA2oHe9yV0zmscoSApZWT6kuAis/5aDq7kudj0OdBq/YRrAzFaMpZPkrbrlXNQ8C+IzayYNulA3Ms5a7QDwBPLdsNV8Hufargm4EUn7MRYC2V9jtaK2seEuoeLTjCIbPzS6k4X8lgDHm0W47Ygj9yO+UNjQqdXbV49DXw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699020; c=relaxed/simple;
	bh=R0TFQLdk+C4vkQbH+5pNDmvTjVa5SxUpwjya5XVkzX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NEPZgDxRtG5AzJiI76pyYkz2TGx9ksPmUOaJCMEoLo52ATqJmJlPbz8abw6UhB0R8YAtQSLnUMKCqAl7b1yMDZyrajSG//TmC3hL8gwYuUkEMqBs+RIzNGBapcLByyg8a4yJRmpC+CX4FCoxE0+rXQL/O7P3vTxj4luHC6UGbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzA4Hm1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B472DC4CECF;
	Fri, 15 Nov 2024 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699019;
	bh=R0TFQLdk+C4vkQbH+5pNDmvTjVa5SxUpwjya5XVkzX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UzA4Hm1Q6lT7Fxu0QMwOYPI7zZsFqZrIaSW9GC4wYJGL5VUvnjTyo/M7NBhWxYjSh
	 sAz8wCHpHwk/e2slSrjxdprzVeadJ15XwAALhKchiSKkaG21VbOFKlMKzUTiqTjTit
	 bATbLx+gc/7mDjnm/r1vsegrlvtS3KO9mXiLK0uU8vdftwUPZouHD4a6kGndXi6E3W
	 yYea9aC0oOKbJgurZ0K8HBlk2ma6uAxundqvrGA1s+MltbDuJgCiljykKcxPfGweRf
	 WZWcM2J3K41/oELrb+uE4uBDSWkrQ8SFsMpDxhY2Gagu7uHKrC42odIOvlfhu7vrsQ
	 7pN/gkxht+PRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2743809A80;
	Fri, 15 Nov 2024 19:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix memory leak in
 bpf_program__attach_uprobe_multi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173169903051.2693789.11550576117876256024.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 19:30:30 +0000
References: <20241115115843.694337-1-jolsa@kernel.org>
In-Reply-To: <20241115115843.694337-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@fomichev.me, haoluo@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 15 Nov 2024 12:58:43 +0100 you wrote:
> Andrii reported memory leak detected by Coverity on error path
> in bpf_program__attach_uprobe_multi. Fixing that by moving
> the check earlier before the offsets allocations.
> 
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix memory leak in bpf_program__attach_uprobe_multi
    https://git.kernel.org/bpf/bpf-next/c/fab974e64874

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



