Return-Path: <bpf+bounces-59696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B5ACE884
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 05:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84D47A3CE4
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5675B82866;
	Thu,  5 Jun 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm7ExYnp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8786DCE1
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749092647; cv=none; b=mmGcl7Z4CcljFYbvDajnp5GZDWhSTIeyflpxIx4OaBHT1Sf2JFuDf4Avbz5a2IFKtXiOFkP34TlW4+Pswa6ADDcOlyK6gECK4FlDNHYqQ1gzWNzD4AZNH6mJpYnas0elTFAMCItY3TqaX2QhnjmFwXfEm5RbFKmwGBEwbyUEAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749092647; c=relaxed/simple;
	bh=l8d6EA/eAp2XfG2W36D5UCAwyPT8ncSQ2QJKuHHfuR8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CV+CCuSJuLxGAa3dy3MKJ+IoAH7OQYJO3MNtpK+YpcBLDSey0qzG+iR0b9WMbW044iJPg/cFPH6WyZG8O0r9uks6oQMIsmbTfwKtKBkJi2ufDfrGVjCiWj9jlQFTvCDw2VFYsNsK0hSoR/CcU2VlZsIVTeVJtzGBLrbxMhijvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm7ExYnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FAEC4CEE4;
	Thu,  5 Jun 2025 03:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749092647;
	bh=l8d6EA/eAp2XfG2W36D5UCAwyPT8ncSQ2QJKuHHfuR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gm7ExYnpd3+3bPgQHAF51G2ogLReg79Hf7HZaM+PgrZH/dQpV6TWD0DjA4Ab4MS8P
	 rd9pt8adbvAQ2g3Nl88H9+DcoWsAz5Vl8tFWE3HOL6h6SWOqye5m++gNQ1hkip84bN
	 2m+zkmpCdNZ8F2aaw9mp4mAvhiCsVVBMywCuWjAccRXr/w4br739weYoqzIdBGj2AV
	 B5r8PvdHt1qeF3L2tM3VnqnntylIa5yporkRM2M945D0dwPnq35X5YbkbaH3vv42HU
	 CvBtPhOHIK9b/jgjCVsqXf//jBTFBO1NlM1Cn1koSqKu1wDX5+5uyaJpjGF+8qADny
	 3tJ0bacSTtRFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF73380CED9;
	Thu,  5 Jun 2025 03:04:40 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250604233028.41784-1-alexei.starovoitov@gmail.com>
References: <20250604233028.41784-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250604233028.41784-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: baa39c169dd526cb0186187fc44ec462266efcc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64980441d26995ea5599958740dbf6d791e81e27
Message-Id: <174909267979.2554386.13396568220964240848.pr-tracker-bot@kernel.org>
Date: Thu, 05 Jun 2025 03:04:39 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  4 Jun 2025 16:30:28 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64980441d26995ea5599958740dbf6d791e81e27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

