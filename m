Return-Path: <bpf+bounces-16812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE045806131
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8830A1F216D2
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103226FCEF;
	Tue,  5 Dec 2023 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5wENeJw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABC6FCDA
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 22:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C5ABC433C9;
	Tue,  5 Dec 2023 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701813628;
	bh=IkgBdkEn8R7TrSQyWMuShXoRKnHqdy9IHvN5w2AWMiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y5wENeJw10ZnQdrCf9tN4ymordtuwZ2h9IR3QEH5OevL35fRFXT4RNumkqnJMt2A0
	 215Hz8U0+yhrc5l4PHZM4AiBOu5kkcNTLCvvTrvzaxVmLtGiX5d1QFPa/tJPPYf03s
	 zYwVk6yA7lMEZVJ8u5n46altc8XKTmPo838tISLVk7Z17WN5j/FOfDkW/HyyhILCrb
	 V4BFcaoDcz/FeFfysGbarTLx/4n+wSAsVYKMRa3W3cge/SDEzCbVQDylsGfL4dd+zU
	 lkbYnUIo7m2fd1frKDO2Q7EnIqZV6chqi9Sm30Ccbqi+tvjoWxT8JZ8pC7RQwXww/D
	 DOHaIFV8MEvKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E68AC41671;
	Tue,  5 Dec 2023 22:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 00/10] Complete BPF verifier precision tracking
 support for register spills
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170181362805.14422.8529379228061492969.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 22:00:28 +0000
References: <20231205184248.1502704-1-andrii@kernel.org>
In-Reply-To: <20231205184248.1502704-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 5 Dec 2023 10:42:38 -0800 you wrote:
> Add support to BPF verifier to track and support register spill/fill to/from
> stack regardless if it was done through read-only R10 register (which is the
> only form supported today), or through a general register after copying R10
> into it, while also potentially modifying offset.
> 
> Once we add register this generic spill/fill support to precision
> backtracking, we can take advantage of it to stop doing eager STACK_ZERO
> conversion on register spill. Instead we can rely on (im)precision of spilled
> const zero register to improve verifier state pruning efficiency. This
> situation of using const zero register to initialize stack slots is very
> common with __builtin_memset() usage or just zero-initializing variables on
> the stack, and it causes unnecessary state duplication, as that STACK_ZERO
> knowledge is often not necessary for correctness, as those zero values are
> never used in precise context. Thus, relying on register imprecision helps
> tremendously, especially in real-world BPF programs.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,01/10] bpf: support non-r10 register spill/fill to/from stack in precision tracking
    https://git.kernel.org/bpf/bpf-next/c/41f6f64e6999
  - [v4,bpf-next,02/10] selftests/bpf: add stack access precision test
    https://git.kernel.org/bpf/bpf-next/c/876301881c43
  - [v4,bpf-next,03/10] bpf: fix check for attempt to corrupt spilled pointer
    https://git.kernel.org/bpf/bpf-next/c/ab125ed3ec1c
  - [v4,bpf-next,04/10] bpf: preserve STACK_ZERO slots on partial reg spills
    https://git.kernel.org/bpf/bpf-next/c/eaf18febd6eb
  - [v4,bpf-next,05/10] selftests/bpf: validate STACK_ZERO is preserved on subreg spill
    https://git.kernel.org/bpf/bpf-next/c/b33ceb6a3d2e
  - [v4,bpf-next,06/10] bpf: preserve constant zero when doing partial register restore
    https://git.kernel.org/bpf/bpf-next/c/e322f0bcb8d3
  - [v4,bpf-next,07/10] selftests/bpf: validate zero preservation for sub-slot loads
    https://git.kernel.org/bpf/bpf-next/c/add1cd7f22e6
  - [v4,bpf-next,08/10] bpf: track aligned STACK_ZERO cases as imprecise spilled registers
    https://git.kernel.org/bpf/bpf-next/c/18a433b62061
  - [v4,bpf-next,09/10] selftests/bpf: validate precision logic in partial_stack_load_preserves_zeros
    https://git.kernel.org/bpf/bpf-next/c/064e0bea19b3
  - [v4,bpf-next,10/10] bpf: use common instruction history across all states
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



