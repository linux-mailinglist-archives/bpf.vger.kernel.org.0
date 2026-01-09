Return-Path: <bpf+bounces-78366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FBD0BFF2
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 20:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93A6B3020C6B
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906902DFA3A;
	Fri,  9 Jan 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHT3+AR/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B31DDC1D;
	Fri,  9 Jan 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985411; cv=none; b=lo4A0Czl/LXod5w7r9zv95rdyc3rFMDUpM5PP7cQNVl6PeBYPgqMf+B9YyQWe0efG0BlCYJfc6KrQU90L4GOTIl+Tx96WBJyfnM/1JvJXOYVfZiCV1ZDI5DBS/U9eng45TiG/cvTj9PXjvpMdbkFOxzuz7ZbVobmm/DofM9WBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985411; c=relaxed/simple;
	bh=kG20MsDRW6NATqP65BlX2YUbY53SMbegKV4Bzt3Sg3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K2GchW7621HOrjkAJDE3/+v/S/zmD0CgP34/fyQ9lpPjgZsSanC1PRXyZiMh/7q7WWvC6kBV31yR/ojsrG6Ts+nO4MPzP/4aepOx/yPjlPs3IRAqCn8vmqdtBJSrJQrypYHPRVOxXkQtMCZCc9sgcKXLCHsbwfGNrjvo0r7xw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHT3+AR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77BAC4CEF1;
	Fri,  9 Jan 2026 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767985410;
	bh=kG20MsDRW6NATqP65BlX2YUbY53SMbegKV4Bzt3Sg3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FHT3+AR/KxpwVX7hX/YT3MqwRMmnUN3sZJwEUvsgBlISKnXyWQk0V+97munlxfpR0
	 s3LInKVX7+K3kDEsK2+o5k7z6huC/aY2YtmfLA2Kzcu2mYcPwR3E5bVcPyDgT7bTAu
	 7e90KQLXMG22s/6y8P8i/EftGFLCOKHmIX0akHwtgnvghmarYLUPhsArhOw9ro8as7
	 /6hSc3h0VbZzaCV6iAQzw/5w5cSAeMxQoJO8yPTQLP14ao4VCg1AhifNjT44ogvzuA
	 WkY8B0iErDFf6tqusUfePDYVMd69R0UQ0tMHX9eU7Ae/tEPhShlJvWOCCRXYMsnT0M
	 0C+lLlEZORi5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B243AA9A96;
	Fri,  9 Jan 2026 19:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next] bpftool: Make skeleton C++ compatible with
 explicit casts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176798520655.368147.17396600775278527236.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 19:00:06 +0000
References: <20260106023123.2928-1-kiraskyler@163.com>
In-Reply-To: <20260106023123.2928-1-kiraskyler@163.com>
To: WanLi Niu <kiraskyler@163.com>
Cc: qmo@kernel.org, andrii.nakryiko@gmail.com, jose.marchesi@oracle.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 menglong8.dong@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 niuwl1@chinatelecom.cn, dongml2@chinatelecom.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  6 Jan 2026 10:31:23 +0800 you wrote:
> From: WanLi Niu <niuwl1@chinatelecom.cn>
> 
> Fix C++ compilation errors in generated skeleton by adding explicit
> pointer casts and use char * subtraction for offset calculation
> 
> error: invalid conversion from 'void*' to '<obj_name>*' [-fpermissive]
>       |         skel = skel_alloc(sizeof(*skel));
>       |                ~~~~~~~~~~^~~~~~~~~~~~~~~
>       |                          |
>       |                          void*
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next] bpftool: Make skeleton C++ compatible with explicit casts
    https://git.kernel.org/bpf/bpf-next/c/4effccde0a05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



