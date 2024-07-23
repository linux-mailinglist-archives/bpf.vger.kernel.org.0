Return-Path: <bpf+bounces-35309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515DF93979E
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D624281C61
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32AD13210B;
	Tue, 23 Jul 2024 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIZo++Js"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F3130AF6;
	Tue, 23 Jul 2024 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695835; cv=none; b=lcs8i0vTZ9Xv9+7rJY7qZl8aqpnvr8KGBsGtZPxWfAFoMOFsm7JOpw41GaQaH4rYmBP8297s7wbRwq2MkFv7CQn9dh0V28HR+4uJhlWXEcvoWqu+N6s5D1cN626d5esQF9arHqdZ7v0WmmMQbiuQBckVs+4ZeO7x/gCSvMKB3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695835; c=relaxed/simple;
	bh=4dHJ3uOIaKJzQvyoi3jjvyfi4uKfIRx2WsTsbJs5KzY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YD8mraIoNHl0VhexCpazkyZVaOxX3TJogN7+ufe3SA/oMQhEy7/gwPWW56eGIiUI/y1eUN16t0xl6FRM/qJmjTvm0lDW9pjzLZP6wX1XluxVSjM4fCO98RtCVY7sHJogV0wo9XWAud4jargmgX22eS47iCAnKB9ZxYXvwJFNLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIZo++Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20AC3C4AF0D;
	Tue, 23 Jul 2024 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721695835;
	bh=4dHJ3uOIaKJzQvyoi3jjvyfi4uKfIRx2WsTsbJs5KzY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iIZo++JsyTR4WcnzCnmAXepjY4k5krECC4bNOtr7/qABdcM8EbX+B9ZLgiHuGNoWO
	 yLRa/SY53RE6BFN5NF/QI4QyY1SsYH1DyQjYFKB59EMdSZOuQmCiHzjpSLW/uLEUjl
	 4S0TD8AlpBrn1TjK/Otdo5RPB6Fhgvu0wFKm++s6wdf7GCDBhUUKHxnAerssc+8tfP
	 2SFZs3BYxWZanQolnHw0AC/Jk7LJI5uk43YXBvmBc/Xytk/2Sg8gknXHzzdaEORkTm
	 rEfKeCgSVuUfYehq380P/eAO6CE/LQMcaBEm29l2Ck3Jf4ex71LL+TrZsFvL2Nvm2Z
	 tTuMG8Y0joubQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DDC6C43445;
	Tue, 23 Jul 2024 00:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/9] Add BPF LSM return value range check,
 BPF part
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172169583505.13320.286982146467311269.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 00:50:35 +0000
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240719110059.797546-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, shung-hsi.yu@suse.com,
 yonghong.song@linux.dev, kpsingh@kernel.org, roberto.sassu@huawei.com,
 mattbobrowski@google.com, laoar.shao@gmail.com, iii@linux.ibm.com,
 jose.marchesi@oracle.com, jamorris@linux.microsoft.com, kees@kernel.org,
 jackmanb@google.com, revest@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 19 Jul 2024 19:00:50 +0800 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> LSM BPF prog may make kernel panic when returning an unexpected value,
> such as returning positive value on hook file_alloc_security.
> 
> To fix it, series [1] refactored LSM hook return values and added
> BPF return value check on top of that. Since the refactoring of LSM
> hooks and checking BPF prog return value patches is not closely related,
> this series separates BPF-related patches from [1].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/9] bpf, lsm: Add disabled BPF LSM hook list
    https://git.kernel.org/bpf/bpf-next/c/afe4588df73f
  - [bpf-next,v2,2/9] bpf, lsm: Add check for BPF LSM return value
    https://git.kernel.org/bpf/bpf-next/c/af980eb89f06
  - [bpf-next,v2,3/9] bpf: Prevent tail call between progs attached to different hooks
    https://git.kernel.org/bpf/bpf-next/c/b39ffa50b415
  - [bpf-next,v2,4/9] bpf: Fix compare error in function retval_range_within
    https://git.kernel.org/bpf/bpf-next/c/9e14de5b9c12
  - [bpf-next,v2,5/9] bpf, verifier: improve signed ranges inference for BPF_AND
    (no matching commit)
  - [bpf-next,v2,6/9] selftests/bpf: Avoid load failure for token_lsm.c
    https://git.kernel.org/bpf/bpf-next/c/f81ad29cdf88
  - [bpf-next,v2,7/9] selftests/bpf: Add return value checks for failed tests
    https://git.kernel.org/bpf/bpf-next/c/fc2baf1730f9
  - [bpf-next,v2,8/9] selftests/bpf: Add test for lsm tail call
    https://git.kernel.org/bpf/bpf-next/c/2f56fae88135
  - [bpf-next,v2,9/9] selftests/bpf: Add verifier tests for bpf lsm
    https://git.kernel.org/bpf/bpf-next/c/cc1bfd52e4ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



