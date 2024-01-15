Return-Path: <bpf+bounces-19549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09CE82DE37
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 18:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2271F22922
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8C17C7B;
	Mon, 15 Jan 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPHxPqWy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE117C6E
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 17:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7961BC43394;
	Mon, 15 Jan 2024 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705338625;
	bh=ZbTHbDKBPJVfGgVoPHOB1eHZsYEDnCcreEk09w2oyU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPHxPqWy97Od+k7z737xP5LxFcaezEsOCKzCDinNYtICU3d26/XxrvjnIf0OMhm/n
	 FxyPkKjAjQTZ53Ju12/5UwLSncyHS2eElGrd06K5TRQAq71mugWqLeXpi0MxEdaI/l
	 MvlABG9PHjDBRrDBZN8bfVbN6yeeNT7aFwVGNXXUs9yn3OpWlpjTcXKfSq4wSN6ZV7
	 pIaRg3fD9aca0jJy8JFNWhQP1zofyHosM+eYh1wJmIksDR8DT8s3MQ+KUef6FVWolw
	 nycHeEoZxYbe9EXfk2eAGQ6ycrG+Jdb6meWpFNBePBUdUyJTFrkOfzs7G3AXsSd/zd
	 sj2D00M9vJiNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E071D8C987;
	Mon, 15 Jan 2024 17:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Minor improvements for bpf_cmp.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170533862538.21502.16542685570377112908.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jan 2024 17:10:25 +0000
References: <20240112220134.71209-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240112220134.71209-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Jan 2024 14:01:34 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Few minor improvements for bpf_cmp() macro:
> . reduce number of args in __bpf_cmp()
> . rename NOFLIP to UNLIKELY
> . add a comment about 64-bit truncation in "i" constraint
> . use "ri" constraint for sizeof(rhs) <= 4
> . improve error message for bpf_cmp_likely()
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Minor improvements for bpf_cmp.
    https://git.kernel.org/bpf/bpf-next/c/7f0aa0dd07e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



