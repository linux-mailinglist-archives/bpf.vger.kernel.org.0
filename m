Return-Path: <bpf+bounces-18298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B2A818A08
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01A5B20ADA
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F7A1CA98;
	Tue, 19 Dec 2023 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbnFl8eD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A13C1D;
	Tue, 19 Dec 2023 14:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4C89C433C9;
	Tue, 19 Dec 2023 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702996223;
	bh=faeMPzd73yVIKMm0m1fp3uXayvPlwPSp/B2C28RZlD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SbnFl8eD6e2r27N/6/SEqBRAKNMpf+lzcCr3YGUk0le1kcnVQGIMKy6eKi5JTb356
	 He40HkPTSENk1LhI9pyuJcWcsvLJMFP8XbN0FurXB4gjCTs8nBWZNOEKitk4XImw9G
	 WRswfzCnBaRFytM2J/+pFZYrN03Mt+K75lb3TU0OziK24+bYQa+Q+zk2TsUHNa+xPw
	 xM02x13Qk6DqK4ytOWOfMobcP5Ou1nyUQb0e0k6PvArfaMv52T7J8vWT9fDn2k5ehj
	 wWa/+dTcgV6zAQMeeCGCFA7fM0bDrMXz6GxZRpiCP++xPAGam0r8l4IszRKOYSbWjs
	 nm8xriXsLV5oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAB35C561EE;
	Tue, 19 Dec 2023 14:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: use nla_ok() instead of checking nla_len
 directly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170299622376.11598.17473952266274189003.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 14:30:23 +0000
References: <20231218231904.260440-1-kuba@kernel.org>
In-Reply-To: <20231218231904.260440-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ast@kernel.org, netdev@vger.kernel.org,
 syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, keescook@chromium.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 18 Dec 2023 15:19:04 -0800 you wrote:
> nla_len may also be too short to be sane, in which case after
> recent changes nla_len() will return a wrapped value.
> 
> Reported-by: syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com
> Fixes: 172db56d90d2 ("netlink: Return unsigned value for nla_len()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: use nla_ok() instead of checking nla_len directly
    https://git.kernel.org/bpf/bpf-next/c/2130c519a401

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



