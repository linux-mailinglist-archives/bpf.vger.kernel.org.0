Return-Path: <bpf+bounces-30141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4848CB31B
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30DFB21EB5
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320191442F3;
	Tue, 21 May 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVETT2sn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5FD22EED
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313829; cv=none; b=F2bLEXYDOHGT/LmplMCM//VPwG4FMqYHH6GP8b5qcNwUBmEkOKZDIrAN3GshUJR77EAmqfgfc7mipzMwH8p+lCjI3ZvIPtcl6TZihF6eXSdw3dwM6NwS/zcuSDcNpyTCbw7tq9y5+sYj4It41MsP3Cuk5DdvCFjrNElTtiZZ5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313829; c=relaxed/simple;
	bh=pCTjCK4iCXCuOF6zAKrkCoTm+tjnspQwnZBGyMlbACQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rkjoopYVrgvrPon/rZjAJ/Pj4rQ+YFRhCInn6yVgbBR32vacUiR4O9ZvAw5drct200R+Dfdl3zCA4TmTHUuG790jFghgTchWmVM3jb/WCREQ0Q0bRcbgpJjvNjn6RP7EBDD1dZki1GUfJPdiiYoakD0belIZglnY1SG2oXEQYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVETT2sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 426C1C32782;
	Tue, 21 May 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716313829;
	bh=pCTjCK4iCXCuOF6zAKrkCoTm+tjnspQwnZBGyMlbACQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GVETT2sn6/V97+kfXRu32JlncQiEoFGWd9NKe87VrEtPyiWh0UOuGOM09jUrr//Ss
	 bG12Sotz4pI/69qZnKgIurP0OhIvG+CXZZTZUJjWc854jVq7v/wUcyU8mSgNZoIN9P
	 7PY+n5ktU65LmDrts6o9oR8O8YIiMbKHJeFhTypWkTUdDdvsGqXW7Pp+j4sJZjGCQQ
	 j2OOn4BIjDSOp1gtm9quwu629xXXFsjeQw4DqCjjo1S9i3M5dsvfNpaj6AyiMZ+eRn
	 D/q3LwJ0JzfPphmGtETcaq1OE0ukNSc0QMrPmUeKs6S6cI/pE5PZ0jSlNzPHDgA99F
	 KlzruGo5lVXig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E613C54BD4;
	Tue, 21 May 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Remove unused variable "prev_state"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171631382911.5181.18012897943027697699.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 17:50:29 +0000
References: <20240521161702.4339-1-yingzhang098@163.com>
In-Reply-To: <20240521161702.4339-1-yingzhang098@163.com>
To: zhangying <yingzhang098@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 21 May 2024 16:17:02 +0000 you wrote:
> From: Ying Zhang <yingzhang098@163.com>
> 
> The variable "prev_state" is not used for any actual operations
> 
> v2: Fix commit message and description.
> 
> Signed-off-by: Ying Zhang <yingzhang098@163.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Remove unused variable "prev_state"
    https://git.kernel.org/bpf/bpf-next/c/1b0215a3633a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



