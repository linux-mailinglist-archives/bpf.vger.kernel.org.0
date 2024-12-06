Return-Path: <bpf+bounces-46336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C79E7C43
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5399B1886048
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC22212FAD;
	Fri,  6 Dec 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RicOYCrK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4F1EF090;
	Fri,  6 Dec 2024 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526676; cv=none; b=tkZaknT5U++FpBJBjavIJP23OiJ2NEHoOijlgLHnDcRrvtR4qMMgG8Mjw6o7GAOgID+hW0LgFmeJ2atXxO1JgDysfTBt9utpNJlsl8On0JtjVeiMFwQmqTBK2ousdgN8xCe6/tYJPUqgOns1v2KW87r/KZOU4jBZCd8LIerqhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526676; c=relaxed/simple;
	bh=ch/woLSlffPB8izas1EMPDsXt1Rc5X0fNFedcJdKWbQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i3PcTY/jszAC0An/07VB+//RKQxZXvw2qB8eYqJNmOW0IKTRe0FjC+zYrvsehUo2wqIBGrCaysjhwgw4Bu9qMNwZIVnaEKKDfaTzo6nEgDF2mmgZ4YfvN3xy7FOJrTXCHe1eGSact7GaJzoWrraRRxObGXBy6NWZADHOqWGmQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RicOYCrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A4DC4CED1;
	Fri,  6 Dec 2024 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733526676;
	bh=ch/woLSlffPB8izas1EMPDsXt1Rc5X0fNFedcJdKWbQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RicOYCrKXX6++HSVIRoU9vZVhmbgYq35mL/4hlxN60HK74931u+KxIGctQvlfwTwJ
	 YP7moFSjQOHonCaqLgkX5JlrH8Fq0JIcNcPQgTsSFPZFCydQO6tFRNQ5eYGW8U1izg
	 NZSFxzqFivmsT46REIQKyXFKnSaaRSvcqvaVIyE/65Q5/YVo1XgYQU74BDu0ClFYXU
	 urwh9HqaMbmYajZv3NLDh8UcBOJyjFW4xljdGHH51zkJu6AjZIb0pb2Tdv0yrG6F+5
	 QtDLm5qwDe7RJ/dujH+1x6eK5UAwuAPQ3boUn+TT+EHtk92XkLRmVi1+4TBJ0ZHdd9
	 Fu7JxwsR0M+bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF71D380A95C;
	Fri,  6 Dec 2024 23:11:32 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241206224535.279796-1-daniel@iogearbox.net>
References: <20241206224535.279796-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241206224535.279796-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 509df676c2d79c985ec2eaa3e3a3bbe557645861
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
Message-Id: <173352669111.2828685.2494191278567483163.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 23:11:31 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Dec 2024 23:45:34 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

