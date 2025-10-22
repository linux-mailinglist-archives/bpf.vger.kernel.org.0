Return-Path: <bpf+bounces-71754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096CCBFCD5D
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17ADE3A814C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398834CFCC;
	Wed, 22 Oct 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqDzhGux"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F4340D9E;
	Wed, 22 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146282; cv=none; b=dMsmcp1N/0+do/7NGqiyix3BdbWMPBOU4e6D/lU+dk6mTcRHT7GvUQvnBwbUzJaG+zryiQIMFy9ah47OkY2pipQt6H9xvs+axVNAaV3aarS1Ru+0txfO/tmZl9QMEVawWPfNjLVejqUmEl2WL93uLj3YiYLji4IokXEcc1Ax0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146282; c=relaxed/simple;
	bh=3yeJVTWsQ3PYP7UnkIWLKc7xoHqvrW6f9Xjdn+b5Fo0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XK0+FDvcIYHBowXLy53KFDgG5DNA5AZYzkvhD0xq5wZcKMNI9iFD0EgTVUBCZtvvet9h/Qst2Hg2loGXdmKbm6PBzZ4M3CFoDZNVCDnmaiA30j9sXqnoblXGY7pASKh9fOgxvGkRkvxTW6GB3+r3vl6EQY2ENnFS/dpn+levWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqDzhGux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AC7C4CEE7;
	Wed, 22 Oct 2025 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146282;
	bh=3yeJVTWsQ3PYP7UnkIWLKc7xoHqvrW6f9Xjdn+b5Fo0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XqDzhGuxKey4Ptn2VUX7BaTGsyOl0B4f+SD2hyzATnyW0q+zaMAsCSfnUXYwk5oxu
	 Jn2iIebbfa2s2qMpWlKLGCEPByAZIN/sCFYeCj1lByj+wQR2TJC8+ipuRQ2ZHUfWAW
	 BCGY0rQEQgIdDm5gHOsaU0RSZLjv+eBOpmThiKysl1VEbFtBILWCLh3uSZYNu40uyk
	 9aaUtZrj7Rnl4L3wcGJz3SF9zD9Oiv8WyV+DKmAiARqxxosR4u7q4orvrVQTbRyxrB
	 x3nu8WRbqh7JMIkr8X4to+VRZXo4QqDpctRVaQFecV2zAvokfi2APrc82yq8+TnKHm
	 PIJmRCIjAqB0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 353903A78A6C;
	Wed, 22 Oct 2025 15:17:44 +0000 (UTC)
Subject: Re: Re: [GIT PULL] 9p cache=mmap regression fix (for 6.18-rc3)
From: pr-tracker-bot@kernel.org
In-Reply-To: <aPhtxt7qEWY5FjPQ@codewreck.org>
References: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
 <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>
 <aPgUaFE1oUq8e1F-@codewreck.org>
 <39116c81-1798-4cc1-945c-a05d0ac7d8d9@maowtm.org> <aPhtxt7qEWY5FjPQ@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <aPhtxt7qEWY5FjPQ@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.18-rc3-v2
X-PR-Tracked-Commit-Id: 43c36a56ccf6d9b07b4b3f4f614756e687dcdc01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ea7460217423f07febe273307a5f3b6b1303b29
Message-Id: <176114626271.1971781.12512695262576428090.pr-tracker-bot@kernel.org>
Date: Wed, 22 Oct 2025 15:17:42 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tingmao Wang <m@maowtm.org>, Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Oct 2025 14:38:14 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.18-rc3-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ea7460217423f07febe273307a5f3b6b1303b29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

