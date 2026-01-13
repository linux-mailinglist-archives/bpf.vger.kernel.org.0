Return-Path: <bpf+bounces-78744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 146AED1AD22
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 19:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B22343062D50
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D339434D4F3;
	Tue, 13 Jan 2026 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLK0JOd8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7F34C130;
	Tue, 13 Jan 2026 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328460; cv=none; b=CQ/5s8wErUv23cFQLTcYKOVw/Uund2Ph0nIf1f0Lqd1kn7uHRNylvPlxKXk+z8Quu9uRAgAXVifJFAJoicYFKnEG/qfs9kmUGiBOf1Cz05L1bdJMWusS3LMRSuS7lilYVc8p5y1VxhusJ6a5m4uDLBQMQN6I4jbXc0AiuVNt5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328460; c=relaxed/simple;
	bh=tYLQey64Rm/1ZTq868ph8+Pl3fj6d5I528S11kKY2m0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMstnd3ohTplOeZKvT3hV2V65g6lROyRjmYYWBb4576vYHP/yyBBk1L0o6ZzdhW6fRJRXuRQIv0IoGPi0RER71ZidSq4vTPdLeBWRnl2yOOVCMIpRm3eN7OLReCRQuK17TwSkOOlTW8Oyxd3RL2oXMqQUyN1/tAEaJgjgkT9xFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLK0JOd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE3BC116C6;
	Tue, 13 Jan 2026 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768328459;
	bh=tYLQey64Rm/1ZTq868ph8+Pl3fj6d5I528S11kKY2m0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZLK0JOd8rNtDQmMUZIy3NxhySbgf/PE2HgjjjVvDlSoN7NTGOfQtr84dVi4g4U4WW
	 2izMrhHq51cTLj8YiXBk8wsEJ3DNgw6YquKrF9+20wqO7h9KgEeyOlKFQdXLMYdp14
	 dzIzE+SF62muQiqgldB2mJ0iLhtbOMc9g35RKLR7Obt5ObFt6vUuVdnTSPnIEnZTsr
	 nvtKW/HdewC4jHl36zFHeQDgdWf+vC1cB/zwIlpoab1Dg9htyZbhfXDzyIh5opFBV2
	 37fAX3Gh3PsGo+TCJIdeqQ3DQXRAxPVoI7nhn/AvkcuwWbg5yAdd1p6kE9udDItkoq
	 8X0xtfAbRyXJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9CF3808200;
	Tue, 13 Jan 2026 18:17:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] kernel/bpf/verifier: removed an unused parameter in
 check_func_proto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176832825277.2345780.14684423827074036706.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 18:17:32 +0000
References: <20260105155009.4581-1-chensong_2000@189.cn>
In-Reply-To: <20260105155009.4581-1-chensong_2000@189.cn>
To: Song Chen <chensong_2000@189.cn>
Cc: ast@kernel.org, andrii@kernel.org, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  5 Jan 2026 23:50:09 +0800 you wrote:
> From: Song Chen <chensong_2000@189.cn>
> 
> I accidentally saw an unused parameter in check_func_proto,
> it's harmless but better be removed.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> 
> [...]

Here is the summary with links:
  - kernel/bpf/verifier: removed an unused parameter in check_func_proto
    https://git.kernel.org/bpf/bpf-next/c/c9c9f6bf7fbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



