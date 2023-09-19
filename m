Return-Path: <bpf+bounces-10419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114527A6FAC
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 01:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE731C2048F
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1F38DDA;
	Tue, 19 Sep 2023 23:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE530FA7
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 23:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 775AFC433C9;
	Tue, 19 Sep 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695167422;
	bh=MmeRD0wmyYRJSTeH6kJxxhC9paGZR0bjshKUwsQEAL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZXRMHlqyBtyHZzDQpWv2ewwrn4z6iTUBPSKTHvydlzdh2DvEchS+ibRCAs15+jHsJ
	 y/Vge1ZZCL9ywtszj0FnW2YXpboRMqYIMk+1gnEh8Ar/4PVbn6jG8Pp0dmlujbm3+T
	 UTz3VqUoAmEwMqIdme9gPtQAvN05BL5TAPdbGvFfvJcJGrwh2KxVh4Sqe45JSYGn2X
	 UhcJRp0nALh3BuVuUwTFRn0+/mJu1oxbp7GCM6mEgKTSnK8YtV8A497050E0GSayIK
	 1ta2VSDYy5k7fBUsUaHumu+502GTIqTpPa55fjrU5ChpLriOgZ/p7J51N43hcG3bwn
	 rvQQis2/4iHJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CC39E11F4C;
	Tue, 19 Sep 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: Fix tr dereferencing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169516742237.5759.15892276172655645427.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 23:50:22 +0000
References: <20230917153846.88732-1-hffilwlqm@gmail.com>
In-Reply-To: <20230917153846.88732-1-hffilwlqm@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, toke@redhat.com, lkp@intel.com,
 dan.carpenter@linaro.org, jolsa@kernel.org, hengqi.chen@gmail.com,
 kernel-patches-bot@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 17 Sep 2023 23:38:46 +0800 you wrote:
> Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.
> 
> When CONFIG_BPF_JIT is turned off, 'bpf_trampoline_get()' returns NULL,
> which is same as the cases when CONFIG_BPF_JIT is turned on.
> 
> v1->v2:
>  * Comments from Alexei:
>    * Return NULL in that case.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Fix tr dereferencing
    https://git.kernel.org/bpf/bpf/c/b724a6418f1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



