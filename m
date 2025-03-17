Return-Path: <bpf+bounces-54239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60CA65FF1
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 22:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE68B188E4C3
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 21:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B51F9F7C;
	Mon, 17 Mar 2025 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6nrHaqt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156B1A8412;
	Mon, 17 Mar 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245199; cv=none; b=Z3eU70m2FjHhpN5OWZNu5q0LLxCq0GjgNOIaykzRahamBH7koY1RSojKTt9DwgJMz3kWftuzeg7jItcgevH1sIH3qW8FvTfsIAi+/0H65HODS/Cfr6ExkyujOjNfkHETlVIASYvl1WfCnXF//NdeY9m3qSs+MKgzxHLE4JPe8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245199; c=relaxed/simple;
	bh=aUbH8+3Y+Q9R5IdXXRjoFdSG/+KV8wXsIDPkDCS+rFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nPtu9oUi1k7EEr1f1IjciD6qFlXFryUY3BmCgnWByoQzudzRAjxCjwAE/q0N175hWCS/n9VU4H337HR05p3LwtIGBz+p5+vJfoFVkIgk3gQJGAo931UsCK9QCr2uCwY8qA8XoBo/V2wC0rS3B4lV7bZ1fcUiH6k6OuZ5vEHJAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6nrHaqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31733C4CEE3;
	Mon, 17 Mar 2025 20:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245199;
	bh=aUbH8+3Y+Q9R5IdXXRjoFdSG/+KV8wXsIDPkDCS+rFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L6nrHaqt78Sl+rLpcfpK8aQOePl0UQpOQcBdZbrq7uWoZOn6HwjguIKG3nRiRhWfD
	 Mb+KjqFjEvLeHBj8yAF+fBkq0Jg3WQ3oHn30hptmWhbGM/+5oyRk9o10OdtUHgU8NR
	 2VFTEWGT386hF6nu4dzZdqUCef/BUw3TI9nH3Zh4Ici18qtQzNGVd767Tsec0wwpAM
	 lWI5oSpl4+/vZfu1wfFWPYbzLBhegNw1pOHmS9M6vGUXlsKB184gpx1xE5+rp2UKA3
	 YZMpPMGkrSkYTLWYNT2vRJvmG1bG7zT91JyTMYH3EDPR2PorDo2VkFxvN71Cx4smaB
	 ZMx6vlIrGlNbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0001380DBE7;
	Mon, 17 Mar 2025 21:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpftool: Using the right format specifiers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224523451.3912314.17317997494330739760.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 21:00:34 +0000
References: <20250311112809.81901-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250311112809.81901-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, qmo@kernel.org, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org, ast@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mrpre@163.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 11 Mar 2025 19:28:07 +0800 you wrote:
> This patch adds the -Wformat-signedness compiler flag to detect and
> prevent format string errors, where signed or unsigned types are
> mismatched with format specifiers. Additionally, it fixes some format
> string errors that were not fully addressed by the previous patch [1].
> 
> [1] https://lore.kernel.org/bpf/20250207123706.727928-1-mrpre@163.com/T/#u
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpftool: Add -Wformat-signedness flag to detect format errors
    https://git.kernel.org/bpf/bpf-next/c/8d86767be9c9
  - [bpf-next,v2,2/2] bpftool: Using the right format specifiers
    https://git.kernel.org/bpf/bpf-next/c/3775be3417cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



