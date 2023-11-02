Return-Path: <bpf+bounces-13912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A77DECAF
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B573281B7F
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174675CB5;
	Thu,  2 Nov 2023 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGSxH+lk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3C53B1
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 185EEC4339A;
	Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904825;
	bh=AFvFGJ5RX5HWQ7BExEjHkNCgb8lQ0TX7Ja+9M4aY+cs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nGSxH+lk0IVP8DkS/EnGW8XWyk0K4mJdtEzhaPaqfJ4/134giY2slmHvTNYqrssvS
	 8j7H2Nh0ZRXO+58K+DSKiqVu7CsNy55w29K5vwQ68RP5ZAmLN55rN+7rz7BUfm4lcl
	 i827Pju0jU5KV5X10ftjRRb3jmRxFHxz6IO5AR+pbvykffwLZH9oHUhZ+YnrUoJoyd
	 I1hbpxO5A3DlcOH14NQUfNikQPPJve5CinE6jvVPI69ysx6aZgYTd21CRdYnsnJNvh
	 pmfg7QgDYDoxDxUmI3xRj/Tl+EUL9NeWG7uysOJ0udTM+foFOp12xLhM91yLhM+VSd
	 jODOEKx+DmCIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F336DE00092;
	Thu,  2 Nov 2023 06:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add __bpf_kfunc_{start,end}_defs macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890482499.9002.3938790944237757134.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 06:00:24 +0000
References: <20231031215625.2343848-1-davemarchevsky@fb.com>
In-Reply-To: <20231031215625.2343848-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
 laoar.shao@gmail.com, olsajiri@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 31 Oct 2023 14:56:24 -0700 you wrote:
> BPF kfuncs are meant to be called from BPF programs. Accordingly, most
> kfuncs are not called from anywhere in the kernel, which the
> -Wmissing-prototypes warning is unhappy about. We've peppered
> __diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
> defined in the codebase to suppress this warning.
> 
> This patch adds two macros meant to bound one or many kfunc definitions.
> All existing kfunc definitions which use these __diag calls to suppress
> -Wmissing-prototypes are migrated to use the newly-introduced macros.
> A new __diag_ignore_all - for "-Wmissing-declarations" - is added to the
> __bpf_kfunc_start_defs macro based on feedback from Andrii on an earlier
> version of this patch [0] and another recent mailing list thread [1].
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Add __bpf_kfunc_{start,end}_defs macros
    https://git.kernel.org/bpf/bpf/c/391145ba2acc
  - [v2,bpf-next,2/2] bpf: Add __bpf_hook_{start,end} macros
    https://git.kernel.org/bpf/bpf/c/15fb6f2b6c4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



