Return-Path: <bpf+bounces-55772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08FDA864E3
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156591BA6323
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB73B23A9A3;
	Fri, 11 Apr 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOQPGZHZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740292376E6
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393007; cv=none; b=jJjdZrkZvq2Cz9GsEQMO3RiGjXC264VACf75plivPnDVZU5Kx1xFrr1ANVDrdc/HA4MRrpJO6tsXJLJLzROoqJ3S6ZBWGZn2cElxMY844k2yx9Dsdu2dGHutHuOKKlfDrHdmLjnQZO2FgJn1p6fu/53mJ0nkuUtaVJL6IUmrHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393007; c=relaxed/simple;
	bh=1lQxSbJgiUUVShWb8Ta+dKxN/+mDdM8UDP+snNJtDwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U5tehyEhzW3c7bYeCZbp+YsYiCMUz+0Z63VFNCZu8Vmy+aVsrgtzSL1Y1VWlCGlFTqVB1Dx838pliB2+4AQtjAGHfgx9yuTt1MsLV24DkyUznRx3dTM0rvXFZelxleECVhUMCJy1m+PFLdb3xX+Db9lH9CJwsNzavLoNIP5WI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOQPGZHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2ACC4CEE2;
	Fri, 11 Apr 2025 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744393006;
	bh=1lQxSbJgiUUVShWb8Ta+dKxN/+mDdM8UDP+snNJtDwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GOQPGZHZbpAcEzI6/MjN2tj5LUgjgu/bn8bl1Wsd1llBHAksRkHSUXdZpbOdQQBgY
	 Zy/ZUIFWjzdAKX+xImPeixuKVwe+VNEVNsC7Ps+NROTHnzb+bl5elTFLLZn8atJT2N
	 VYCdFNKje0urmupSStGMgZyL4olbJZiQ8is8Rwn5ZMfhmzii9OPxZcf+OxqoVcMx0E
	 UgRYKhT0+rddQqq46DeYE0VZFO0T6+O6XDgxTzwnfp0eAZgZ3Pim+DU8G3k5qdfRlt
	 +l5IurTTMp7DMUsbJ0Y4nQJYGytycCC27Ij3CyknAdJtxrXh2ERflm5glt5xOOdsUs
	 QpUt/mcMnK++A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8E38111E2;
	Fri, 11 Apr 2025 17:37:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] bpf: Convert ringbuf.c to rqspinlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174439304452.326101.13065462047396025802.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 17:37:24 +0000
References: <20250411101759.4061366-1-memxor@gmail.com>
In-Reply-To: <20250411101759.4061366-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
 syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Apr 2025 03:17:59 -0700 you wrote:
> Convert the raw spinlock used by BPF ringbuf to rqspinlock. Currently,
> we have an open syzbot report of a potential deadlock. In addition, the
> ringbuf can fail to reserve spuriously under contention from NMI
> context.
> 
> It is potentially attractive to enable unconstrained usage (incl. NMIs)
> while ensuring no deadlocks manifest at runtime, perform the conversion
> to rqspinlock to achieve this.
> 
> [...]

Here is the summary with links:
  - [bpf,v1] bpf: Convert ringbuf.c to rqspinlock
    https://git.kernel.org/bpf/bpf/c/0b51f0ac3dc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



