Return-Path: <bpf+bounces-52133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAFBA3EA13
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032B13BC1BC
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE778F4E;
	Fri, 21 Feb 2025 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRlF11im"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF98821;
	Fri, 21 Feb 2025 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101548; cv=none; b=uAUQ8wKfVZvS3cepKDgyqW9N/H6n5QiToF5qAcfEHeE4T9FAD8R0Bz7CCcvAE5Ho4hrimFi8pIukUhjzbCVDDF1kq2JWEAwar1oeK0xtYKiccWXkipdV+naYUsJF4Vvl7LyjxUYqFYnzo3wLngb5gFLVVPTs+1+1JHUDFU++M4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101548; c=relaxed/simple;
	bh=sHDFzEYghSBSVnShTOcQ89fQRVPyj55hm+u8IeVIL4k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wbnv8+kRWm+YFWrEoCdu/FAo9ajSaKeusBOAizK7MdR6qn20Wv+utbQKmQm/R9aEEGg44wYA/TEByOk3tJRsSawP9MGIgI/+b6pMp9hhaQAQ7+fGZjbaB19XP3j05rj44U5DYKQyjpDDNk2t85Wg8dQ5kmcHwHm7zvmiHWIfE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRlF11im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7062C4CED1;
	Fri, 21 Feb 2025 01:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740101548;
	bh=sHDFzEYghSBSVnShTOcQ89fQRVPyj55hm+u8IeVIL4k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FRlF11imUfrkiu0kVqBv3szHydxXoVcZ7Tktb1NXY8MCf3IaBIaK7+atuEwAra1G9
	 2C9G2sLOsjNYtJe33+2ClrF2XPk6j0cIorZYUwwtLdLlmX8JpXLr/UWemDexAJi8yg
	 fxday3q3ezy4qEkGtT6Xz70Y4j0Lm65CVxltMs92we/oKswGX4ke4pJcAxpVpCU3aR
	 ojE6A9sPez0LgxngsVnhhGzCCwOcuowl02RTknV+3fbBGQN7MrfRYgMIuGlVww9DxV
	 hhAsMQ0ZlAbkLobsunwteKIzg8mqso35aM2pCHjZVVNRWkiJAuhsPlO0LMMtcBv9Dc
	 gC9m61sKRGPdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCF380CEE2;
	Fri, 21 Feb 2025 01:32:59 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250220225331.46335-1-daniel@iogearbox.net>
References: <20250220225331.46335-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250220225331.46335-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: dbf7cc560007c8624ba42bbda369eca2973fc2da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 319fc77f8f45a1b3dba15b0cc1a869778fd222f7
Message-Id: <174010157858.1537942.12356827966825077517.pr-tracker-bot@kernel.org>
Date: Fri, 21 Feb 2025 01:32:58 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Feb 2025 23:53:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/319fc77f8f45a1b3dba15b0cc1a869778fd222f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

