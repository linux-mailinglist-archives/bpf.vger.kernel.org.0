Return-Path: <bpf+bounces-59802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B6ACF90E
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 23:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED583AFC63
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F7027FB3C;
	Thu,  5 Jun 2025 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL8W0r3d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764727FB1E;
	Thu,  5 Jun 2025 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157202; cv=none; b=emy1/WwyXKULGFiVGrcQjpffmRGeZHgNaC2ixDpr+YTeJov/Y08xVqkBb4FiBXqOOEFAGw8GZr0waXQDkbKxxUcJ4b0dk7w2OtSzPiqMgJuCoYYfcFcmlj2cXMyTZ71DqpPF9Ol1ljM634gcZcI/qROhxPWS6VrArh4dbVLQADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157202; c=relaxed/simple;
	bh=BPN0ge9uC4F9hGWmDPjj0khq6u8sLDUV406XTmjPXE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UiT/dl7UC0+3+ZO3fa92BTDNJj6Sofss6jg7huo9CyhSIM15uUWpfRD5lxbK3evrV7j4plivSHS7nuBp+XutW1rfez8CxGgTiy0/wT/VqzgW+tBFG3EdJyNzXGgIvfJsBrhiX4AlrMn7Tz32mlzmSXNrqmeznHBcUcghWY/6NH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL8W0r3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99398C4CEF0;
	Thu,  5 Jun 2025 21:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749157202;
	bh=BPN0ge9uC4F9hGWmDPjj0khq6u8sLDUV406XTmjPXE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hL8W0r3dNWkBU6sdgkpAdnmuSUnuB9olEZLq8OqF1EUCJwAPz1TdJbh5TIx5C54qE
	 gzCG0YeeJoKrx2GvvvTDz9e2w3eCx8zoGqscLoveobDua16gQC38JU40W/YH01pm5j
	 Y+fg3IXi+cSStg50+k5SF3b/MJX8mPiiXKl5RWak8lodOsBXWMFP952/4gErqQkQ/6
	 6mmHAvzq0RKeZS37H6HGJYZ61MKkAn0oCmWEx7tLOts7pEVioAiyLx+bQUtsWR8VTq
	 VprlhNY1daBAGHRQhp3BbYjVw2VEel2Jtun3RRZFUxwge4BAxE8nBjmSatcJIDwnvf
	 s+xGSX4+IhrHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6439D60B4;
	Thu,  5 Jun 2025 21:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Clarify sanitize_check_bounds()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174915723425.3244853.1418000264549776836.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 21:00:34 +0000
References: <20250603204557.332447-1-luis.gerhorst@fau.de>
In-Reply-To: <20250603204557.332447-1-luis.gerhorst@fau.de>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: memxor@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Jun 2025 22:45:57 +0200 you wrote:
> As is, it appears as if pointer arithmetic is allowed for everything
> except PTR_TO_{STACK,MAP_VALUE} if one only looks at
> sanitize_check_bounds(). However, this is misleading as the function
> only works together with retrieve_ptr_limit() and the two must be kept
> in sync. This patch documents the interdependency and adds a check to
> ensure they stay in sync.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Clarify sanitize_check_bounds()
    https://git.kernel.org/bpf/bpf-next/c/97744b4971d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



