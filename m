Return-Path: <bpf+bounces-47443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F069F9772
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E93F189B425
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C282210C8;
	Fri, 20 Dec 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIALyMaz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130421C9E8
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714015; cv=none; b=iHRYgUOQH0meI3/m4aDTmR2537zC4FjJs/+OfQxCqO/8ArFxNH/qGcsMzeM124PVIh5EGspW7tUxVlzBS+FlHjMDcDZtVT7p2VOZ8fAEQc/JCyuy6kbtrzrODqmatn09qgTyu6VbNVwoUekYY9+PfrkEdg/L+5Z8qu8C95OFH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714015; c=relaxed/simple;
	bh=nZU+Na+xCs8vH/GPYjFaLzhAUXzZZN8pQmHm5k1s6uE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SHb4Xtacsjzfz3XOPct5s4oMBgW+oIxR+a1VZmIZg3VO81AD3gzX7uKIJ2yegX7azajm0yWTEdIdSiOHVkh/+DP9VhDAGZHf0YddoORp8M5l/KpxKD99rLpIrK+SZX61C5F4/7NHoCEaP9fenp7LlJ8wGayQKVrqp64lJ32E1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIALyMaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E0C4CECD;
	Fri, 20 Dec 2024 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714013;
	bh=nZU+Na+xCs8vH/GPYjFaLzhAUXzZZN8pQmHm5k1s6uE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cIALyMazFc4NfuXdgKVC2GA2JJzSZfXNaWCtGld0f1/gLsPa1/GUfPIvBKVgIaZk7
	 nIjmVchUpp4CFafwe1MFI/XOFeZ2xBBsW2eRfnqpLCi1NtS6T+YPIbUHNPrJBfXM05
	 dypqQ9LXtEmMqogSDzTXIIE8n/FhmCog9sd2lnJUy1+3ibOJXmojkvzHBGrP+X42NN
	 J1vdcZVSbCUWAScJxwiBC4vfpTyGfGOkU3lnpTIblzDwz6nIXQREaSX5Rw7MMUh0Zb
	 B1EfSDb1+jtZN9xltF6F8UhYNRxwnCw46Aiy+N4HA/X6vM+na1MPRPFBUw6DLP3r2k
	 bkps+6NHhnR/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2DB3806656;
	Fri, 20 Dec 2024 17:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] clear out Python syntax warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173471403177.2960548.2029810410126028205.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 17:00:31 +0000
References: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
In-Reply-To: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
To: Ariel Otilibili-Anieli <Ariel.Otilibili-Anieli@eurecom.fr>
Cc: bpf@vger.kernel.org, ariel.otilibili-anieli@eurecom.fr, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 11 Dec 2024 22:57:28 +0100 you wrote:
> Hello,
> 
> This is my first patch to the list; your feedback is much appreciated.
> 
> I have been using GNU/Linux for more than a decade, and discovered eBPF recently.
> 
> Thank you
> 
> [...]

Here is the summary with links:
  - [1/1] selftests/bpf: clear out Python syntax warnings
    https://git.kernel.org/bpf/bpf-next/c/c5d2bac978c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



