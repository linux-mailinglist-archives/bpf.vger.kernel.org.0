Return-Path: <bpf+bounces-65457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC2B23B86
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C7C175AEB
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425092DC32F;
	Tue, 12 Aug 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We4Pg/yo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE52D97B0;
	Tue, 12 Aug 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035994; cv=none; b=NjTiRgs6yDHG8LhPDifBHYtA3RzO/EKmAQB87vOfMuUPUWu1X8yfXna4aaWsgEuF2tIvd0QqTe2hFY13Ap97cQh1EJfaT/BoeGvp8B45oSranIpXlzG9T+GDHqgbu+wM73GAMwVISdeJ0tFmt9bvNL+cODJKHJLqzKkiBkCE7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035994; c=relaxed/simple;
	bh=xUugcCeDupeyRXAma99g9hNuqgU1BUg1Rp1oGev2xfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V2m4ZA3aKYt3ql4LdlNPO+W4ZTzH7p93wQIiDGLua4DeEEhp8CN8rlxNSjz+xRQ3fCinr0rkDLluYVId3EvC6CNaoZsqZCe2wdfE1JwGoqlrm+S8QmrQgzIKm3Br+wpoRElmumNRRwu2fIrvw5HdIvadYwnnQ7OpWJ/OGTVym5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We4Pg/yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFF2C4CEF0;
	Tue, 12 Aug 2025 21:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755035994;
	bh=xUugcCeDupeyRXAma99g9hNuqgU1BUg1Rp1oGev2xfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=We4Pg/yodZ96jYPtXBXiiQijqlJUpUHkRUdXUaf2kVmQnu5Wl1F9XYYIrv+YtJ066
	 HGvSX2Kiz027R4SAdX1zfL+bACD7vTJDVUjMwBBTOuwh15MUqTTpa6T6cnfg6AyjY2
	 kC38g/PEEVCYoYFZnKiUb3pPI5uxSuC1sSAsSPr3NCpNeP5TDEKiJygmVFwReV5DPK
	 NG6wMi1awIhJ57VOZTj58OTATmcj5o8ecH7zWOzXdceCIrLQncFP3JhoauD3rIU8Kf
	 on+5/xPG6W2sZkA8EghNNe1fS5nXg/fv/OwAS06FZYIh0pae2k6vT7qZc6ZUbjhKic
	 jwd7H1HIHZeFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E1A383BF51;
	Tue, 12 Aug 2025 22:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Remove redundant __GFP_NOWARN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175503600627.2840750.12029210649916309661.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 22:00:06 +0000
References: <20250804122731.460158-1-rongqianfeng@vivo.com>
In-Reply-To: <20250804122731.460158-1-rongqianfeng@vivo.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  4 Aug 2025 20:27:30 +0800 you wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> [...]

Here is the summary with links:
  - bpf: Remove redundant __GFP_NOWARN
    https://git.kernel.org/bpf/bpf-next/c/3e2b799008a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



