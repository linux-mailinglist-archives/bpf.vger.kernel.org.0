Return-Path: <bpf+bounces-70786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66410BCFAF6
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 20:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE11B4E8E95
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B8283FF1;
	Sat, 11 Oct 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPw8vc83"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1D265CAB
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760207971; cv=none; b=DK9DDgZJ/MnIfLewhms/PGwe2FfnbsJEZViRTnf7WurZQCJJZJQAT/PTTdD5f5p4yaCm2DORJMKUqmbtc4/Tq+NlpdXDIVCIsIX6vJx2eBlLYAlTlFxlBfAva5bi2GQmHDSronNQUsF32pTmzx5Zf0Fl4IG8H8y3iKuos7yWl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760207971; c=relaxed/simple;
	bh=PDD94/KXRRDKPPiCPhtslzTug4IfhC+U7gd18+Z4rpE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NXM3dmFvQbxylAEncqZDPQqtTaSFK+4/2uqWsse8pQHFQbmXNawa86fvpTPaTQsJgRaE7qV52gPul9HRf++aHnWUOL5zpl/XFTsySeTMXnFVQ3Pwlm0278CZJM3LysnOn5zlsUQ6LmOaVJvOQ5HLkKAqgwTG4AeEns/RKI5GQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPw8vc83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7F5C4CEF4;
	Sat, 11 Oct 2025 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760207970;
	bh=PDD94/KXRRDKPPiCPhtslzTug4IfhC+U7gd18+Z4rpE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cPw8vc83DEQr13l26Fxn2woQOz/VeSDysZRX/AxvL0lbU64B62NgGVPiHQgngfWWF
	 u3HTba7fTU4TFsxphOq9JkJTSgE8RQZf8h5jhEBVDA/rikvwpqLKN1hQyy8oquHwTu
	 NKdNhLx5kw7MTogbtBWKYFY5PL1cJbyT0Yyw9ygRCfH0Duoy8rUKGXFnnm+S5OSXuR
	 cQ2u7/KWHMf6GCk1uRfQ83rciEfReAk719hYRplFfgg84PMY3Hb0eOHUbAsHu2cQ1O
	 VlHUFalTAi0g2tvpZ880MQ4Ni8mSOnDpGt9EojiD9xrXy0ldwOTSPeY7sRzoVwbBMH
	 nE3+Qi9e+zcQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF33809A18;
	Sat, 11 Oct 2025 18:39:18 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251011004722.81978-1-alexei.starovoitov@gmail.com>
References: <20251011004722.81978-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251011004722.81978-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: ffce84bccb4d95c7922b44897b6f0ffcda5061b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbde105f132f30aff25f3acb1c287e95d5452c9c
Message-Id: <176020795745.1422231.3858949988203761277.pr-tracker-bot@kernel.org>
Date: Sat, 11 Oct 2025 18:39:17 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 17:47:22 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbde105f132f30aff25f3acb1c287e95d5452c9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

