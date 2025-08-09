Return-Path: <bpf+bounces-65293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0620B1F282
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 08:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7C118C79B9
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 06:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C321264630;
	Sat,  9 Aug 2025 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maOscEoX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA825BA36
	for <bpf@vger.kernel.org>; Sat,  9 Aug 2025 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754719598; cv=none; b=M6cK/rRAhAEQMiVWiGRbkMBbOzTWPmCGnKc8GYb+7mjiOpVSO2tjfhc9J3XL2AaA0nwy7N/43c2IroGJNfYA1ve0NZ0YAfgb/IRz9J1mw3W4ZNdwxZakDp1aJvaKlu5R674x2ILLSfl/IN1SXpds2OcMp5IOCYQO3c28Ops08lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754719598; c=relaxed/simple;
	bh=e7VyWCMctx+DB7iJsAKe9TltSsO8QtqpkIMHCFSaea0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KQ1BSHLuJHW53lxTVFweYRefUCB6mhMUmHheT4Gptvke+aLOVDtLopmK/neAZHMEczxi8+dYa6IpsMElzYTWj3bzDEJX7hYjN97tnVMe6vM7u6CTUZGbKlaJOupefcWiu3ejgMIk1O86b07n5KSN9g/+y3XcJ9TYNYKVjncl7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maOscEoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B3DC4CEE7;
	Sat,  9 Aug 2025 06:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754719596;
	bh=e7VyWCMctx+DB7iJsAKe9TltSsO8QtqpkIMHCFSaea0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=maOscEoXr8X1AS4sgQpMOygIjpC/4RSwsZQcr3sXgRopsgXr88tBFFbx7CoRiIxJM
	 wvCyE12a62sBLPFz/Wc19+Y6xlFnCQmVoyXV4SwFDjrd4cESig5BIBq3JU3m3/aMDS
	 IPvs3lckEKy58QwhF1IDHOUmvvV/V1nuyVPrPn9OiW1hr4RibgzFh5rtMDfxPKnN9R
	 30LdduWU7GaMpwIxmVR9Dwlv2kLwTktGG9RmxgXWL5xGabJ/tLHaYbzNVhCpAZyLjG
	 e+SZXlhOIjOXrg6+HvsS9Vlp44ttxW5/ff/iYpDCN9aZsHvBeyjZDPZ0vKa08I+Xxx
	 MMA4A4F2jAseQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC6383BF5A;
	Sat,  9 Aug 2025 06:06:50 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250808165513.23952-1-alexei.starovoitov@gmail.com>
References: <20250808165513.23952-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250808165513.23952-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 0e260fc798bfef6b0dd24627afa01879f901e23e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c30a13538d9f8b2a60b2f6b26abe046dea10aa12
Message-Id: <175471960907.394704.5163849537119256053.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 06:06:49 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Aug 2025 09:55:13 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c30a13538d9f8b2a60b2f6b26abe046dea10aa12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

