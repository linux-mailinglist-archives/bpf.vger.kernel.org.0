Return-Path: <bpf+bounces-46175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48569E5E5C
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 19:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6740916BAA2
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED022B8C0;
	Thu,  5 Dec 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdRqcwGp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C2229B15
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424021; cv=none; b=VGrrmVQGpj9nZeY8zkLErTYT8Hel40lpGASYMcLy4uCHFtiS0Vc8de5trmx7Ji9jwignAAkxPff2YqwRS+GtBcNkaNqaAtikK5pkI75OchrY/UhBm/gRE/UFrEM8WWaYoUuZz7AfMf0skBK3WbutuBAowfwKromSm9LXWRYr03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424021; c=relaxed/simple;
	bh=Nav4nLSgBuNPzVPdi0wjwnZ+SCP8FiIYJX03i6oYL7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ltAeCObAcRjMEdqD1pohTBBKdC08O03VrXW1wyIFkIXGL0JniOAuZWB1qeoerxhcN399eavBPqUshjDOIoISDxCKqYpQ0D9YtzS9rNhih7gTIv4AmJmRIX7SoLo/JQx7a8i7lTym3lo417nN1Zg12BBf1LwOIFomtbTiG0vNqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdRqcwGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026B6C4CEDC;
	Thu,  5 Dec 2024 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733424018;
	bh=Nav4nLSgBuNPzVPdi0wjwnZ+SCP8FiIYJX03i6oYL7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SdRqcwGptjTVdTW0uJKSNVsPwe4fImevqH+k6dYEIveHujxxRt90iLBaCwhpUqOv4
	 D8mP+gdVhn8QZ645baVYWcTZDlWw4quE0deLGgPA824BrYPxa69MWnRuo99vnoRB0k
	 oIF4ZfAFfwSuKkI+3vmxwUldCzqiCQfqqT5rDbUUjQwT/bMK71eTns2t5z1AuJqM7j
	 hehv3emmzEljxNrcWvDXZV0i1PB62wkna61MH+apHSgaSMdJTxguTvz1d4VmOtmkvo
	 lIu6sHgYTjco77WTn8iTmNFzlat4Cm+RtMqiUZUIV4r8C9cawbXjzhYsZVFQPFw1Ay
	 yopDYZULsBHZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB003380A951;
	Thu,  5 Dec 2024 18:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] samples/bpf: pass TPROGS_USER_CFLAGS to libbpf makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173342403279.2023970.1966197574456555770.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 18:40:32 +0000
References: <20241204173416.142240-1-eddyz87@gmail.com>
In-Reply-To: <20241204173416.142240-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, vmalik@redhat.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  4 Dec 2024 09:34:16 -0800 you wrote:
> Before commit [1], the value of a variable TPROGS_USER_CFLAGS was
> passed to libbpf make command as a part of EXTRA_CFLAGS.
> This commit makes sure that the value of TPROGS_USER_CFLAGS is still
> passed to libbpf make command, in order to maintain backwards build
> scripts compatibility.
> 
> [1] commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS")
> 
> [...]

Here is the summary with links:
  - [bpf] samples/bpf: pass TPROGS_USER_CFLAGS to libbpf makefile
    https://git.kernel.org/bpf/bpf-next/c/dff8470b99da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



