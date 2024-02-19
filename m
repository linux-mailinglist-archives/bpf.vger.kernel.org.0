Return-Path: <bpf+bounces-22248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7B85A238
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EF31C23215
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491732CCB3;
	Mon, 19 Feb 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlisHf2S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8D2E835
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342825; cv=none; b=EwCAdSMNKUgzdqQWFDq5S53ON2zJXqXxLatSrlAXYy1wW2hvC722zy4PT4HYFUGuPVkOK409EjDdE293Wx+bsNs5suShJk3srdaUkLA6PJQgi4fjMlgSl1HJFS3RcmE+ohBJB2gmOSDCmIB7ohcAH+6yKPWITaNUZgjTQ/dYpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342825; c=relaxed/simple;
	bh=v4RQ5O/PGJ+i7nx4jGgbKh3nBhcmtlPfS/SpZ9WOyls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tgjLS1f+Art9JUYHiYihiLJvOjyeD2GK4JoShGk4mYZTb10PemF1MmgHBUeujRxKBesm3fmuYU6dQMmWM7Qofq9lrM3OH/IOVNYAO214AePm09g6zaFIXzJpbDLWm18sE9OWCnhnTiD77hd6hUZ2c4w7c2DmRiDFC5SotP2ga/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlisHf2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A887C433F1;
	Mon, 19 Feb 2024 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708342825;
	bh=v4RQ5O/PGJ+i7nx4jGgbKh3nBhcmtlPfS/SpZ9WOyls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZlisHf2Se4LAmBEtIjzd4V3YE6wNyXk1QCuNRkUpelTRcEPnQ7ZJgW1epg1fc0Hx1
	 sqKvcYyfx4FktCEPocRmDrsu2XxoW40qyYGjEsMSdHdSdbdDgmaK2eNTqPktw9jGmN
	 UtRhndpj3yRaWwJeQSIAAna+v04mIVb0NuDcuXIJKSWY/akcbpf1//2eQ8fmPPz1r1
	 qYWgJ679eleYQz1nO4Ocmowq6z0vOJkaJ7sLFyLHhVMIbQYpFCxQ1hWI9pPxT+KK20
	 619lz4zQJej1bmMFJVEc0RNPObSJhMsT5O14w05FOrw6Q3PXo/Bpps6+epjLBRYGhN
	 2qTmUbADdmCdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21123D990CA;
	Mon, 19 Feb 2024 11:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] bpf: Fix an issue in bpf_iter_task
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170834282513.9491.594829879590162217.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 11:40:25 +0000
References: <20240217114152.1623-1-laoar.shao@gmail.com>
In-Reply-To: <20240217114152.1623-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 17 Feb 2024 19:41:50 +0800 you wrote:
> The uninitialized bpf_iter_task variable poses a risk of triggering a
> kernel panic. To fix this potential issue, it's imperative to ensure proper
> initialization of the variable. This problem surfaced during the
> implementation phase of the bits iterator [0].
> 
> [0]. https://lwn.net/ml/bpf/CALOAHbDJWHOB+viBz6SUqdeF+Nkxmh4gLZo5Ad_keQXjBWHAsQ@mail.gmail.com
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Fix an issue due to uninitialized bpf_iter_task
    https://git.kernel.org/bpf/bpf/c/5f2ae606cb5a
  - [v2,bpf-next,2/2] selftests/bpf: Add negtive test cases for task iter
    https://git.kernel.org/bpf/bpf/c/5c138a8a4abe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



