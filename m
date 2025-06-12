Return-Path: <bpf+bounces-60432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8BEAD65D3
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 04:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE84D3ABF9C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 02:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22B1CD215;
	Thu, 12 Jun 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnQj/4ZL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267A4C85
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749696314; cv=none; b=pEChhFMmr9GWTXxYnRloXVe9+FzcVVPvufrCafiSrljQraZ497tFRVtEfs9rH/0v+faEX5J82kIUyzt9Nmi04ntdh8KBx20C8GKm2xb7xiumY2keO0nlvRaCgxs3ZFtcXmAdzraA69+RV4hhnh9fpyFsSgRZGMM7yZITnSjcfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749696314; c=relaxed/simple;
	bh=OVWO3CV+yuyka5mc1xZ9OJK/ON3GerdV7QUhqWfG9ic=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BcFU+tQjVaJNPqpxHOpf2CLwP5hfhYGJrE3ulRnAv8y2I6g+7LEV5FsImWHJT8hLoQnb/DOiyb45sYJBxj6unwHedzFM/TUZcURzI9dkE7TW+UyOaBENPHhZAf5p2JYokQyaZVd60zs4uH6yQmaEdjpSywqh3aGJgIb/5Bov4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnQj/4ZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC965C4CEE3;
	Thu, 12 Jun 2025 02:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749696314;
	bh=OVWO3CV+yuyka5mc1xZ9OJK/ON3GerdV7QUhqWfG9ic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KnQj/4ZLIt8Ajkzo7wA09ueQR6YI0MphpdlrHJ9YyJ1js78vOKV8Auu3n1nWlt+Vq
	 uni0VFl+8c3emBqFnWx8Wtc9+CJeUZzbtbdsPL09zFx4pv9nmCIgoqjU0uY0bSlRs5
	 9Cv1Ry8Ft59nnsO/YpGyO9w+ydsfHvWNvIwzOUtXB7qylYGdo0rd4kiZ6Y6SsdR17f
	 /YBE5YJ+C9ys7zSL0qVu9KxVpxEeiGpejePWs2Xdwl4yW35qv7+UAGss8xs2EON4zK
	 nopmigXXA+AUhMtQ9m0If5AWOozeRp7PYUO5eZaxm/Z+2JxNaPiHtrvxNbhSZCVlWC
	 nmxS5yk17VMHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E193822D1A;
	Thu, 12 Jun 2025 02:45:45 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250612011913.48375-1-alexei.starovoitov@gmail.com>
References: <20250612011913.48375-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250612011913.48375-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 9cf1e25053c269d64b9e9fa25e8697d6d58028d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c4a1f3fe03edab80db66688360685031802160a
Message-Id: <174969634392.3583528.10767487193451534229.pr-tracker-bot@kernel.org>
Date: Thu, 12 Jun 2025 02:45:43 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Jun 2025 18:19:13 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c4a1f3fe03edab80db66688360685031802160a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

