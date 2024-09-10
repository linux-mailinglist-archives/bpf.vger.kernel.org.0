Return-Path: <bpf+bounces-39522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6A9742AA
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52948289BF6
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3C1A76A4;
	Tue, 10 Sep 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C79i468K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BD1A707C;
	Tue, 10 Sep 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994233; cv=none; b=TC9G5b5uRMjTXXbQpHxxJMi57IvjumBZGYf1qwmT++VNJ08Rbmx8Wq4zBlfbSletd+7x6etRhQ4MpxwINn0NsHVzOrAHp3ta9CPyU7EhcMgAAndCzwc3EaQ0Z2FgSARO+GxTkuUXp+PJ8H6rDBEWaQosBZix6/54QmFgRKEBmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994233; c=relaxed/simple;
	bh=Cjghdq6FbDIt8qDjfgcZE4weKxH6C44xMrytOZ79Rno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hxZvTx8NGmjJa+mDPCWoHle5Y0SDs+aNDLIEmU7+rKWVxRExo3oImCidBLp7YkfWfC5IyIn0DMAAjQLmtToGgA8HNx/rnNXCaQ2wUVoflE8Iah9R2tGHB/MC1tqfY0M6Q7EkXe7eMEDyRTxx6tt6/kw4bvXaapUy3h4kx5eQChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C79i468K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE132C4CEC3;
	Tue, 10 Sep 2024 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725994231;
	bh=Cjghdq6FbDIt8qDjfgcZE4weKxH6C44xMrytOZ79Rno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C79i468Kn/Lo5aqvmWB0f/8mYLXowJvyotApbIy+IHUNSN5Z0v6UX7c73rIt5JS5I
	 xE6yKvzxcKoa2zuAO+ubgj9WGZHVioVIRO42e563siPmLy2OF9AX5s+a8jVXSOElAS
	 C+3VSpEnPHF0xUv9vSUV0ZlE1vvmgNicmVvyNqgbGcZDP7dnn8CbnC/KcsV+fEJO/j
	 wvolgFINvWROXR24kPpfnmdepYuVbLpTjW6iyGq4rsj0euEvGC4ZBFHVayqFrLGJSm
	 L9PRuP8/nFoF5kmreeqh7A2gB3HtCPdX17y2zffHO4wsd2DriLh48M6Kibslbn965i
	 ia9A1oXKvFwyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC63804CAB;
	Tue, 10 Sep 2024 18:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172599423251.358597.13079333302470383178.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 18:50:32 +0000
References: <20240910150207.3179306-1-visitorckw@gmail.com>
In-Reply-To: <20240910150207.3179306-1-visitorckw@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jserv@ccns.ncku.edu.tw,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 10 Sep 2024 23:02:07 +0800 you wrote:
> When netfilter has no entry to display, qsort is called with
> qsort(NULL, 0, ...). This results in undefined behavior, as UBSan
> reports:
> 
> net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null
> 
> Although the C standard does not explicitly state whether calling qsort
> with a NULL pointer when the size is 0 constitutes undefined behavior,
> Section 7.1.4 of the C standard (Use of library functions) mentions:
> 
> [...]

Here is the summary with links:
  - [v2] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
    https://git.kernel.org/bpf/bpf-next/c/f04e2ad394e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



