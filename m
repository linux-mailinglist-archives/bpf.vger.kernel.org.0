Return-Path: <bpf+bounces-19110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C4824DBF
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 05:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5A4286571
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 04:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F9524C;
	Fri,  5 Jan 2024 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG1C658H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE405238
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 04:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C82F1C433C9;
	Fri,  5 Jan 2024 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704430225;
	bh=mlH/fB3fQqKGuXXfVwdkJsd5VE9WRD8mqsCbKF/FC6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iG1C658HmkGbgBo2grVcvsNasMerG9UVRYS/RS3zToY/6AVEThNemy1bjFGLScG9O
	 yBrG/D/pqxBDTUqXMTyEN3p4hCXckNTttHzdjA8SwOqyVWHrv3I8biepCkGW76wbHZ
	 +HRzOd564QPKCAEtI1CmIHKU4Z+juyk4JQvUHn8TQESshM0oh9gCwMozmOrqpI0KH6
	 7bXIK2l02FCXNqPLBs6+FTCRhR7NWh7hpkKkLjGjM+MFfahICCVI4FV/5mJxvrflBX
	 vBeRnlITqOpII7EHB8N3SLYtDmhuwUv6TyK07Fm2v94ZCYCK+xik4l5DdZeSBpXHPz
	 /4FYdx2cNAiew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD58BC43168;
	Fri,  5 Jan 2024 04:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v12 0/4] Relax tracing prog recursive attach rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170443022570.4868.18367369657258878206.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 04:50:25 +0000
References: <20240103190559.14750-1-9erthalion6@gmail.com>
In-Reply-To: <20240103190559.14750-1-9erthalion6@gmail.com>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, dan.carpenter@linaro.org, olsajiri@gmail.com,
 asavkov@redhat.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Jan 2024 20:05:43 +0100 you wrote:
> Currently, it's not allowed to attach an fentry/fexit prog to another
> fentry/fexit. At the same time it's not uncommon to see a tracing
> program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs for
> offloading certain part of logic into tail-called programs, but the
> use-case is still generic enough -- a tracing program could be
> complicated and heavy enough to warrant its profiling, yet frustratingly
> it's not possible to do so use best tooling for that.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v12,1/4] bpf: Relax tracing prog recursive attach rules
    https://git.kernel.org/bpf/bpf-next/c/19bfcdf9498a
  - [bpf-next,v12,2/4] selftests/bpf: Add test for recursive attachment of tracing progs
    https://git.kernel.org/bpf/bpf-next/c/5c5371e069e1
  - [bpf-next,v12,3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
    https://git.kernel.org/bpf/bpf-next/c/715d82ba636c
  - [bpf-next,v12,4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
    https://git.kernel.org/bpf/bpf-next/c/e02feb3f1f47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



