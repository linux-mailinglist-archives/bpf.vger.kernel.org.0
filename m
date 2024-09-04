Return-Path: <bpf+bounces-38915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00496C6FB
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6CD1F2268E
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300CD13AD27;
	Wed,  4 Sep 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlzFuRGF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA51D528
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476433; cv=none; b=IhFVEXeaD4m5us5OphaaGjNBypjHDxzR9upTwhbflBSOziP0GWOUN9YG1ZMtxIGQNtGrZReE8HfXjhVHrzCqBAvs+o/dz6JXXk5Da8E3ga+znx0AbMMNfKFDymphHYMUvTl4U5S9bcwAKFXGHUUVDO1wh6Rat3+bLRLJp49dSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476433; c=relaxed/simple;
	bh=QKzIeSKe/SqrAyL+t+H27XT115iybAb0U7Wyes5VDNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TU8REVW9LcxhGyGyxlgLhe6S+xEfnzTgJ7g55K4UQnvILbL2nSTTCXlF+1GVGGydtamo5DssEJ1Js/8GCxVgNeTwhTg/3cYHHHLZre789vr3MYrb8K7P+B2ob3UNjJCKkSKorHw849dWYDyIYhfKyvQTgoJR2sjWFZDmTck93iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlzFuRGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68018C4CEC2;
	Wed,  4 Sep 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725476433;
	bh=QKzIeSKe/SqrAyL+t+H27XT115iybAb0U7Wyes5VDNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WlzFuRGFk1BAwdhcjWg5is/Jw9GBDL/A10/aEJmlJx7432rJtnUo+ltXE9vLF05mL
	 7XEc1JCYD7m4Y6WhDBvjqIQSpF+4MWSWphQSGMVjTil57ueU6u02OnO5UofAFIPlvu
	 mTGy2nmUXf0A2sWTnXgstNf1neVQnE6KSYZQuu6htELj210DinrPowhE6Ius3v3/uR
	 E9TJr7BIdnl1x6GrV2kJUD56dBGAM9IUl9n0Wah8FNagBPZYeIiVHr4LZFSfNVN11t
	 CuLYt2gpPXTruL3nG0v56zuwO9s93wDIQy1WB+9YGlqw02TVY4YR0yDhXMVUjlDRz1
	 tvrmCvC2+Q0zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E623822D30;
	Wed,  4 Sep 2024 19:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 arm64: Jit BPF_CALL to direct call when possible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172547643424.1133672.16287759168749483933.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 19:00:34 +0000
References: <20240903094407.601107-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240903094407.601107-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, puranjay@kernel.org,
 catalin.marinas@arm.com, will@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Sep 2024 17:44:07 +0800 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Currently, BPF_CALL is always jited to indirect call. When target is
> within the range of direct call, BPF_CALL can be jited to direct call.
> 
> For example, the following BPF_CALL
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, arm64: Jit BPF_CALL to direct call when possible
    https://git.kernel.org/bpf/bpf-next/c/ddbe9ec55039

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



