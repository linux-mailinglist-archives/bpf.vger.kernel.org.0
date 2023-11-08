Return-Path: <bpf+bounces-14451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA877E4E36
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 01:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1FAB20F7D
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2CC650;
	Wed,  8 Nov 2023 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnFEbLa1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1320634
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 00:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13B20C433C9;
	Wed,  8 Nov 2023 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699404025;
	bh=7Ev7zIpBR2JbyftwmXueiakT202KuLx3+6E9ATV/2pU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nnFEbLa1epH7EYlBPCgH7Ca6G+vuyrg3dHusnnO0lTL3sD+snr7MycfMZCWIRDBV7
	 YiT8njbEV01HyyNxA6QtQ+9yI+OeOh1v2rdV6w+VTL6hB+ZOqs6HWaMXgklP3TEISa
	 WlGfZYt5jMEgMI1xeseNU1zmpcfq4iOKghQKGtmRBFBOY55mCmum7yTQXxvUZdDd13
	 E5COLWPGolQvOUOSVzjk7KwGZO/ig+osqLbnerHHds/wiObVJblyUKOwfrl7H8fxNC
	 dusR9Z/TmpL1b6L6Z2QnUz2lB+lgjE06cvhRsw9FziBhQ/BaZjVf0uUPZtMgNJjCKj
	 CC62vkDORsTtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBEE0C395FC;
	Wed,  8 Nov 2023 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] libbpf: Fix potential uninitialized tail padding
 with LIBBPF_OPTS_RESET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169940402496.4503.7316199244566854205.git-patchwork-notify@kernel.org>
Date: Wed, 08 Nov 2023 00:40:24 +0000
References: <20231107201511.2548645-1-yonghong.song@linux.dev>
In-Reply-To: <20231107201511.2548645-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  7 Nov 2023 12:15:11 -0800 you wrote:
> Martin reported that there is a libbpf complaining of non-zero-value tail
> padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modified
> to have a 4-byte tail padding. This only happens to clang compiler.
> The commend line is: ./test_progs -t tc_netkit_multi_links
> Martin and I did some investigation and found this indeed the case and
> the following are the investigation details.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] libbpf: Fix potential uninitialized tail padding with LIBBPF_OPTS_RESET
    https://git.kernel.org/bpf/bpf-next/c/9ce5a7a0c8bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



