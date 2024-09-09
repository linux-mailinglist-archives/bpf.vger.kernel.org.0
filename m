Return-Path: <bpf+bounces-39372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D88972580
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF3FB22A07
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4880018DF69;
	Mon,  9 Sep 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXj7GAA/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBD5189909;
	Mon,  9 Sep 2024 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922827; cv=none; b=POeXe+Zn0OfQY0pLHC6A4qANqngNf49G69/AIAUIfbJbacCNoHIv5uT2/3iivEIaQzwg1HupEa5hjzWCnZm4tciKluB0btBKQcj+vw0Oamz5kW+Vy4w2pUqTjVpX6LM+u4x98IuMjlvaxNmKHtvjYssMSabr2x2Zi13ZS6J4mRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922827; c=relaxed/simple;
	bh=s0cP65g6pItKcMxlcYnOarQlrocndbE3JSdfpUp2gLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b7peys+xp23lP5MaCNA7Q0krcPc9WI6ow1ssrlqoTYk2Cy6f/lCI5WENlyPgneG+kJ3LL/A8QB6yfM9KgnRGmzJoIX+/b/xi+YJtdPoDTRJlDxMlr5axfuR5UNq5vty7DTguowgEmCwRK8Fe+hff4HDvb0Jc3DJdBnXTTtz/g+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXj7GAA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0C1C4CEC5;
	Mon,  9 Sep 2024 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922827;
	bh=s0cP65g6pItKcMxlcYnOarQlrocndbE3JSdfpUp2gLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NXj7GAA/lWFH0ILNcuB5xFf6gajajoI/2AsU6UkcsliWFnibi7ToWdf2PZjYpBhCx
	 cZLdqAhut93ttbapVc/1fHt3U62aACuG3cu3f9iUyA+HN02vM111HffO5wO8G7geK1
	 1jCfHbtapIUTPyJHbWD8eGe4GdP398R6vY0zLz43Oxn4t0qqcDf1An3lU5gz3R0SA9
	 MZZd1ibHvPLVlADOh2P23oZzYwC04l77aW35m03QDNfAtVv4RmDYdy1pUtDESvAfSx
	 VdTDbCRVFkizl6qN5w87V2yYAykDeMYj5CBan6bCz6zThbaIMN556FwuOf1cwV38Nl
	 nc9a7XQOCduJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FEC3806654;
	Mon,  9 Sep 2024 23:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: Fix undefined behavior caused by shifting into the
 sign bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592282826.3949024.18238924106063803133.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 23:00:28 +0000
References: <20240908140009.3149781-1-visitorckw@gmail.com>
In-Reply-To: <20240908140009.3149781-1-visitorckw@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jserv@ccns.ncku.edu.tw,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  8 Sep 2024 22:00:09 +0800 you wrote:
> Replace shifts of '1' with '1U' in bitwise operations within
> __show_dev_tc_bpf() to prevent undefined behavior caused by shifting
> into the sign bit of a signed integer. By using '1U', the operations
> are explicitly performed on unsigned integers, avoiding potential
> integer overflow or sign-related issues.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> [...]

Here is the summary with links:
  - bpftool: Fix undefined behavior caused by shifting into the sign bit
    https://git.kernel.org/bpf/bpf-next/c/4cdc0e4ce5e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



