Return-Path: <bpf+bounces-76813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B98CC5F9D
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 05:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CC893025140
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 04:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE01DB551;
	Wed, 17 Dec 2025 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd3d6MnU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDF16A956
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765946839; cv=none; b=vD5lK60J6kl41ZMicuvhyNlVLfxtTi2HLShy6ax27hrttbcQOQzFZzX70oXhCIK7Xo/mgyrbDowvV4mVrCTZwV8thToE4uowQEe/FBvlUcLuzNy5QgQvb+Ts9cI/Vh+cdVDM6vvbOmKJScUAFZXfGICWQlt+D2HIIuEHZjJruKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765946839; c=relaxed/simple;
	bh=2up64z/TnnUzHQf477MfQMiTVz1EDBdPUTy1xeiD4LM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O5NJd+f1UUvIObpH2u1hpvqyq9+7sM1yq40ee2POPYTA3uxDBkiMaV/zHb5dFuIWMxYq5Y5BFA45o/bq/GptOLWpVm1VTPyOBf5QSoVYqMNozfu4c08LYrI+hKjHB615yk/nf/EVA1szzWrHqU/LCkvuEIX0GGrq1Id+nvU6EmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd3d6MnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DE1C4CEFB;
	Wed, 17 Dec 2025 04:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765946838;
	bh=2up64z/TnnUzHQf477MfQMiTVz1EDBdPUTy1xeiD4LM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qd3d6MnUov5gbgwag5eexLCs3NcoMU+pNLI5IUyrMke12ZWOSf6mlw5AKyf/iPOo2
	 q9SiRcd2k8wh2IuH+J96R/LiveMU6Ie8GjXBlS+t10m9jni/GD9JO53snRFUuzy+RW
	 0Mc74YUXXWcWrR8UKGlts1L59FkxRM+KotmqVajLet1N7pthPjwhwni611PwOC0ebS
	 m1WgyDn7o8GfKavhnWaVShidYQ35R6SLYKD7rZRhJPHBBv3ipXXo3QI5BVkgblqVg7
	 ZNfd+orNoArUdcixJP+Sg/Z1Wjfk4dUYIYQQqT3rBpCWaj5uBpuJWKgozaksi3JlxQ
	 z7lUPNMOdZ2Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78AF93808200;
	Wed, 17 Dec 2025 04:44:10 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251217013719.85504-1-alexei.starovoitov@gmail.com>
References: <20251217013719.85504-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251217013719.85504-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 1d528e794f3db5d32279123a89957c44c4406a09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea1013c1539270e372fc99854bc6e4d94eaeff66
Message-Id: <176594664900.1854801.14762866667404992748.pr-tracker-bot@kernel.org>
Date: Wed, 17 Dec 2025 04:44:09 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Dec 2025 17:37:19 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea1013c1539270e372fc99854bc6e4d94eaeff66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

