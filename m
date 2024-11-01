Return-Path: <bpf+bounces-43686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3939B8830
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 02:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4A12821AF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 01:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CEF1AAC4;
	Fri,  1 Nov 2024 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdnT+Ket"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9B3B796;
	Fri,  1 Nov 2024 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423107; cv=none; b=VB247umm+siWgae63Av1QIJ7WHIE5Kq1b32l519ptQMyouuFwBPRPGxINmHnLQd1R7CTd3g0h8saELgFck7EdwmZ8UOAtLFfIOrM9Yx+8SipWHQXPSlonGqc0e6BTFSaPJgsbO4kzG5tDSbA8Ni1YWkIvvmdpeoSyG4hc9JolLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423107; c=relaxed/simple;
	bh=UwVBt+LyGjzco8FOPwDKBvI3b9d+zhXOv47l4FMHwH0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W4mY6PEqbChI/iflLv7AJHA7uax9e08iOnsrZdI3qu6sO2n+f1p3uFu+jY2Ar2yCOtMGAA0BhpkYFmt4j+R0HuHLj3mnxbhqUKwwBR7MH9uf+T35NOm98nn/9Hlm12DEFu3qTR3GcMVEK9WaNINs2Zw5ch4IkeP38iETsvS8+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdnT+Ket; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADDBC4CEC3;
	Fri,  1 Nov 2024 01:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730423107;
	bh=UwVBt+LyGjzco8FOPwDKBvI3b9d+zhXOv47l4FMHwH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GdnT+KetMM1G+4KCpwlX+7sSWCDaHsUv8ybKQfz2GtXP3MZ1xvqVmnKhvN6LO60uV
	 QYJu2kX16iywoHeUecUvUnNigAsWLf0/t3+2CHDlRsKnATsYwDJy0+P8XSdxsb+Oos
	 M3wyjYqmHxlQzKYaazjLHph7KLjwzqGb/9nygUW37eKiynqvlBwFd7RaPb49TKVa6r
	 ssnCIQea/3AoK2aDlv90cKcQGbq30QM0jUp3PTMuV2BxZiW4J/cBgfjzplYxHaYDdi
	 MwMzWHeQgqs+sqLLyfOxCdG0L92GIDqk+2lzx7nVvgkHgUL8TSTpsc6naKv5ZyBHhk
	 e4J3yBGYZxvZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 718F9380AC02;
	Fri,  1 Nov 2024 01:05:16 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241031231912.109589-1-daniel@iogearbox.net>
References: <20241031231912.109589-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241031231912.109589-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: c40dd8c4732551605712985bc5b7045094c6458d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5635f189425e328097714c38341944fc40731f3d
Message-Id: <173042311499.2139780.16238189518094679353.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 01:05:14 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Nov 2024 00:19:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5635f189425e328097714c38341944fc40731f3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

