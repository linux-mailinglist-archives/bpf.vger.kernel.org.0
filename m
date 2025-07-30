Return-Path: <bpf+bounces-64736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591FDB165F0
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB187AB067
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7382D9EC4;
	Wed, 30 Jul 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUst3OIx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DEE78F20;
	Wed, 30 Jul 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898460; cv=none; b=u3qyck2iuflcFiUa96mVq7nDy7NlO7ejneZ76OJyneiveC8tPikyAkY1U1q+NswmuItsrG7jqYDO9ueZWGcTo6Dw7+2KODQWhkTTzXgXzNyf+VVhi5TnSLfnolulOHk9AMjEevzxL5HpBAntv8cfGcfpOt02Kv6O0tFa29/JEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898460; c=relaxed/simple;
	bh=dWwtSYW+iDZHusRZg0t2hF/jXRXd0waqaqXGTuW4zrM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jpYhTkBbPXBKV2QrbPwB36L136lGZd2RBvQksY+hYj+x4k/GxZTXzTnNZ2yrppU6NX/D7PxJY1L5YHS6XmqAG/ivd54SeWIz1QAmXALFA9pL5E8UPC99PmuhfC0L0uc1FJIrjUyhvmkM2u5ENxYowK0J0dCQLfL+UbxdsgkXRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUst3OIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4D3C4CEEB;
	Wed, 30 Jul 2025 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753898460;
	bh=dWwtSYW+iDZHusRZg0t2hF/jXRXd0waqaqXGTuW4zrM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LUst3OIxd++LKZIxMdiOOA6xhZQRtSnsDWylo+O4xgXya+0/7KYeQwnSmRDwF3/jF
	 Qqq8sshmmV6F8aDtG4xIMSf7e2WZ96ytsCKKwUh7E/9xGNPK/ybRjOwRYRytNQIRnH
	 kh/X6HkA64G16rZReWXcl+6385ZllZQrKsXSXNgu4nCZLJqg4IKUKN3B3LEoKZfZ/e
	 nGySZJJQMslRFXYAZaIjsngMbqC+juOF/OZPb+3megmPGhl6xKQYpZHd4Jul2RkIhQ
	 zejYUxnVTGtZu8SzGN8+uvQ5XO0hOPnvMvKzzH/Q9JjhGjUBgTeo8jo4NP6AZ33X39
	 Kb4E872geTqUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E8DFF383BF61;
	Wed, 30 Jul 2025 18:01:17 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729180626.35057-1-alexei.starovoitov@gmail.com>
References: <20250729180626.35057-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729180626.35057-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.17
X-PR-Tracked-Commit-Id: cd7c97f4584a93578f87ea6ff427f74e9a943cdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9104cec3e8fe4b458b74709853231385779001f
Message-Id: <175389847682.2400114.7378959513515655705.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 18:01:16 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, linux-kernel@vger.kernel.org, brauner@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 11:06:26 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9104cec3e8fe4b458b74709853231385779001f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

