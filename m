Return-Path: <bpf+bounces-725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F40705F7D
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 07:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47FF2814DD
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517153AE;
	Wed, 17 May 2023 05:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B915258
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 05:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67D0AC433D2;
	Wed, 17 May 2023 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684302022;
	bh=zLbjv8C/ILBSEZzlSIzrkq77JMOavpAoZWX2VHd6HG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nQr1tTgUsHfjeWV3KTh9u6B3237FbK9uErmL8L0kl8Hk2kgI3Pn9yxVKSV8lDDak0
	 dM7A7orwUNES9Y/guYgGF8uL8mfBJdIxHoG6pO6b38auk7sy4DN0HXFEcri9Z6XHzW
	 c+y1Ms+fF2enWdWP4+eR+Lt80d88xd0//znETvYG6fuc36XgmVnePSbEyKcVyN/CIN
	 Qr6eVqfvlwBdpRBQVZmO2Rp3BGuaiwTRgGi86ORXiWWYr7rZvCjeT8jjaebJyRcnBf
	 E+gVtzB0hbUfhgc2TyvntObWyeoF4XOlu4D4fic0jLEygoFGALF3qDNd4pMCD8gAG+
	 YZjjIwCB2FjAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48492C73FE2;
	Wed, 17 May 2023 05:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: drop unnecessary user-triggerable WARN_ONCE in
 verifierl log
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168430202229.4983.1720030359058594874.git-patchwork-notify@kernel.org>
Date: Wed, 17 May 2023 05:40:22 +0000
References: <20230516180409.3549088-1-andrii@kernel.org>
In-Reply-To: <20230516180409.3549088-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com,
 syzbot+8b2a08dfbd25fd933d75@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 16 May 2023 11:04:09 -0700 you wrote:
> It's trivial for user to trigger "verifier log line truncated" warning,
> as verifier has a fixed-sized buffer of 1024 bytes (as of now), and there are at
> least two pieces of user-provided information that can be output through
> this buffer, and both can be arbitrarily sized by user:
>   - BTF names;
>   - BTF.ext source code lines strings.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: drop unnecessary user-triggerable WARN_ONCE in verifierl log
    https://git.kernel.org/bpf/bpf-next/c/cff36398bd4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



