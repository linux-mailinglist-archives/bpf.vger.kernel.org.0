Return-Path: <bpf+bounces-34345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298A92C863
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 04:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087E81F234BF
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4EB663;
	Wed, 10 Jul 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9Z7neCS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BD63D5
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578031; cv=none; b=JHD1+rr2fjdE49iniFO66btVLhVYbHBxn0di1ZK9QW2FT34ftOEn4np0t2cGV3eymQwYi1kbkugqRVxwAP9BOQGJXKLgGrEzlAxPcQqiaoCEONU5YuKAKUDVati3muIqy9y09VIs87pG8cslCqwhedLi0krI4lqnTzFMsGIHNb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578031; c=relaxed/simple;
	bh=Wp6tke6TlTvAbkcbIgv+V92nmX37oES6HqaE5K/jq40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tj7EuuhlSC3kStofHN5XfBEMjR677GPEaL88ZCYqq+i4H8mnI+B9qTOxZAdP7HOK2QSuUGBKv8W4sz2SqRDNJfnDcCtyH5iX2F556c7tw6ygfG42ewlEAWIg7Thk6/jnZ0oR25OtFQ54VBRMcQ5F/EqPWBbLys7nvOjo4lxG06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9Z7neCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FC01C32786;
	Wed, 10 Jul 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720578030;
	bh=Wp6tke6TlTvAbkcbIgv+V92nmX37oES6HqaE5K/jq40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k9Z7neCS+XDW3c9el6OxxYHgrmUYdv18tpP12rfobC9tcryHzugVDIYmVY2Xtc65t
	 WIHH4MyzkcMGjG/VSqMDz5Gh/kkXJpMFp+0pRLYGlDKk+grpfeNUHdEF6beaNWkmEX
	 BlNIFg1LjWzdV1IhUhfuccVDndKWgnThuuHn/K56XmJCxp6XzdVGPH1vPm77E3rlM+
	 T+6P4tAt9GHHI62T9i2dm2wmx7RaeNVc5FkVBuchao7vfznqU4okDPjQAsMoRz60+z
	 mMxM+jL1km6R8syuG31EcCLvYZISP1oDg+zJAqrnvWq1hSlswHNaiMj0A3GyRte7wt
	 zf32JIJ+FF0ZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 104EBC43468;
	Wed, 10 Jul 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: relax zero fixed offset constraint on
 KF_TRUSTED_ARGS/KF_RCU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172057803006.8253.5388343610581514290.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 02:20:30 +0000
References: <20240709210939.1544011-1-mattbobrowski@google.com>
In-Reply-To: <20240709210939.1544011-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jul 2024 21:09:39 +0000 you wrote:
> Currently, BPF kfuncs which accept trusted pointer arguments
> i.e. those flagged as KF_TRUSTED_ARGS, KF_RCU, or KF_RELEASE, all
> require an original/unmodified trusted pointer argument to be supplied
> to them. By original/unmodified, it means that the backing register
> holding the trusted pointer argument that is to be supplied to the BPF
> kfunc must have its fixed offset set to zero, or else the BPF verifier
> will outright reject the BPF program load. However, this zero fixed
> offset constraint that is currently enforced by the BPF verifier onto
> BPF kfuncs specifically flagged to accept KF_TRUSTED_ARGS or KF_RCU
> trusted pointer arguments is rather unnecessary, and can limit their
> usability in practice. Specifically, it completely eliminates the
> possibility of constructing a derived trusted pointer from an original
> trusted pointer. To put it simply, a derived pointer is a pointer
> which points to one of the nested member fields of the object being
> pointed to by the original trusted pointer.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: relax zero fixed offset constraint on KF_TRUSTED_ARGS/KF_RCU
    https://git.kernel.org/bpf/bpf-next/c/605c96997d89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



