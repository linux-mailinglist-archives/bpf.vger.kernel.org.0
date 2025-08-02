Return-Path: <bpf+bounces-64944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A61B189F0
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 02:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE001C84FE6
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBD1262A6;
	Sat,  2 Aug 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNqfktMQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7BF1CF96
	for <bpf@vger.kernel.org>; Sat,  2 Aug 2025 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754095189; cv=none; b=Zh+Ky7TSkPrqh20kEcEFipGYhZxkOFTbDmAOpgkt4fxUqdMW4HXY3UL8PymhvOk48/nSrpqbIAHgkujQXIfBn9mEPrNtuIjR2Dbb8ahnvO//r835Tui7TCEZ90ngrKxFmg74Jjz4vMUAkSYSHKWFsN5/HX4QvmDpbasoF4Tq878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754095189; c=relaxed/simple;
	bh=EM1kG3uugKUhCveergER/ZSRBr9Em7y7lgMtIJIQizw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O45e9GfrDcQpBGJo/28qCSZsC4zNO00bNgx5xqp0nSNC8DeSxA7LICxsQZk6TQWJqQ2lyDE7E1Q3z8JDNnTkG5gxinnyDCVgSwFdK/ZbrDhQmQu2c7YCGjEcnfhPvGob6xepePEtRu9Kx4m3vlpooHi43H5Eyyl3kZT0kmtsGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNqfktMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722CBC4CEE7;
	Sat,  2 Aug 2025 00:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754095189;
	bh=EM1kG3uugKUhCveergER/ZSRBr9Em7y7lgMtIJIQizw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TNqfktMQ0Ygu2sHMaEE/n3zFy8hKV/psE1p+qONijilu3VqdRspjRoWeBVnwhmNQf
	 cJbq1amMIfsl39oDInJ8LfU5BIBeWo1DEF4DKr6D2u/XTWVP2YBBYJbSYoUEYveO/s
	 MpY679zo3/q7YLBffilj754U/sJMJNNjPp+xenerF3wza2O/ybXop0cNNPhSRd7dLr
	 +6aJLQnmXlB0NX+ikUqNVmpDJ4HHEpDkr7DLp1HHSaCpEDPp9ZWiq0yuvEzcvfHAac
	 h3tl1MI5EFJ7wzHAlDOLse7T7w49G7GpzWOWsz508EG7TVnGj4AlaFMf8JtV/IxK2t
	 9LMrAxW4oavHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16F383BF56;
	Sat,  2 Aug 2025 00:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250801222035.69235-1-alexei.starovoitov@gmail.com>
References: <20250801222035.69235-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250801222035.69235-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: d8d2d9d12f141302aaec3ff9a3a8cbed4ac0546c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6923c06a3b2e2c534ae28c53a7531e76cc95cfa
Message-Id: <175409520466.4175294.1127194027537487095.pr-tracker-bot@kernel.org>
Date: Sat, 02 Aug 2025 00:40:04 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, will@kernel.org, mark.rutland@arm.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Aug 2025 15:20:35 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6923c06a3b2e2c534ae28c53a7531e76cc95cfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

