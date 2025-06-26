Return-Path: <bpf+bounces-61640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D43FAE94E3
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 06:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0B63B1134
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 04:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90120212D7C;
	Thu, 26 Jun 2025 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3FhqjV9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35D186E2E
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750911139; cv=none; b=N4BGDiu+yS5Lp1dhnxpKcC7LUIXpyfpdjupFvS5c08Fj1JWYDpiPDLBsfrSUkyT238os5OX+oqg/Ge5Yqk0DiWohmNYDIvUN/cAZWosn6hLTJAPt2SFI4ZZUasX+rdJ03MZOlVoklm6JmqK+IWngxcz+rO3zTaeeogNpP+EMuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750911139; c=relaxed/simple;
	bh=E8z5dUJPzaWzbQy+r4M+HJp0OX8fPMD4cJEPbnpe23g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZszXuhPYVdvOIB18Ih5D8P7E6Ca4eW7jpIF5bsRAZ4bahvTZ2WMqjQsjvaWUOeu0cT9Uf5K92mu4syQ0RWpLpESJATvC8rb+TuCf+QvEEDlqZpgN/VANiYUNdSn+/zozSTtACEBUz+UnMPAliqdENcYh1sfE7mR2hvKZ48sxEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3FhqjV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88157C4CEEB;
	Thu, 26 Jun 2025 04:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750911138;
	bh=E8z5dUJPzaWzbQy+r4M+HJp0OX8fPMD4cJEPbnpe23g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B3FhqjV9gME8lhJ/v7+ilUzQrHamGXTfU7KlKBWhfSK/QT6+fs4UXyv25KykY7a+w
	 gi0dD5+7l0MXOGw+BSeCZyLcdRuc3vKpGkx1kZXfpYkVfoVP/oKOmPKas42psWy52E
	 UZyOG5VbpPu7bikdRqS644aCMkP8nDV04QKpw774k4A/idNhWZDaU3N/5g4dD94/Ud
	 E6oRkY2nB3P7hkPklJD+FwAdChrVdBr5WhHQRnrWfahj6Imr17yuRS2Dvc3W02HJO8
	 BaGHYf2lMA4WJHa8xBc+dkFKSCWy4puArMNflSlg3jANuijfBOivYnEsFOi14P1aKt
	 FuYiWULJJv6Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E713A40FCB;
	Thu, 26 Jun 2025 04:12:46 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250625223229.46651-1-alexei.starovoitov@gmail.com>
References: <20250625223229.46651-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250625223229.46651-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 5e9388f7984a9cc7e659a105113f6ccf0aebedd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee88bddf7f2f5d1f1da87dd7bedc734048b70e88
Message-Id: <175091116477.711106.16657768188135687406.pr-tracker-bot@kernel.org>
Date: Thu, 26 Jun 2025 04:12:44 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Jun 2025 15:32:29 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee88bddf7f2f5d1f1da87dd7bedc734048b70e88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

