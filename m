Return-Path: <bpf+bounces-10370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB217A5F14
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7849F1C209E0
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB663538C;
	Tue, 19 Sep 2023 10:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADD110B
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D53ACC433C9;
	Tue, 19 Sep 2023 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695118222;
	bh=7NsghFbc5JOl9+KgshP+WTAv4Da7q0aG1sHQIOUiiZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ex5rBDAR63IHleS/BWVAp1urZuhkB8wrvAH/nqdKoW1aL+8WEOlp4uzWfv58N81gj
	 s1ZAOfU6KQ8td0CTYQyQpdo7kmKuNScaB+/wpuAsaC5k7GKmDIYg3tbjyKUyywDnaD
	 7sg3DVHinodFcxji34zQplGENDMzyJkeI9pOYhg/qIHfuacDq12BHq0QbfO66LUCEW
	 7Clf2ijxWy71H8O2m3SGfjkRuTfWXto49TCNITDYG06YZnpXSW9UZL3KOKnP9r+kQd
	 NSONJBu+9isa/ADv9pObVfOKqp27Jc620ZKEHPYjhPfPro/FTM0Tberw5q7mjR/K/j
	 bGtpUUsCPflbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCC0DE11F42;
	Tue, 19 Sep 2023 10:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] s390/bpf: Fix arch_prepare_bpf_trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169511822276.32013.17640068962746661120.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 10:10:22 +0000
References: <20230919060258.3237176-1-song@kernel.org>
In-Reply-To: <20230919060258.3237176-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 iii@linux.ibm.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 Sep 2023 23:02:56 -0700 you wrote:
> While working on trampoline, I found s390's arch_prepare_bpf_trampoline
> returns 0 on success, which breaks struct_ops. However, the CI doesn't
> catch this issue. Turns out test_progs:bpf_tcp_ca doesn't really test
> members of a struct_ops are actually called via the trampolines.
> 
> 1/2 fixes arch_prepare_bpf_trampoline for s390.
> 2/2 adds a check to test_progs:bpf_tcp_ca to verify bpf_cubic_acked() is
> indeed called by the trampoline. Without 1/2, this check would fail on
> s390.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] s390/bpf: Let arch_prepare_bpf_trampoline return program size
    https://git.kernel.org/bpf/bpf/c/cf094baa3e0f
  - [bpf,2/2] selftests/bpf: Check bpf_cubic_acked() is called via struct_ops
    https://git.kernel.org/bpf/bpf/c/48f5e7d3f730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



