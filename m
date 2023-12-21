Return-Path: <bpf+bounces-18490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909781AE36
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 06:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40ACA1F24B09
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 05:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890639473;
	Thu, 21 Dec 2023 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOhDLYMh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A288945A;
	Thu, 21 Dec 2023 05:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E8ABC433CB;
	Thu, 21 Dec 2023 05:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703134824;
	bh=nD8BeL3m4gN7DXI9mnUAEuRD4P2PBgojyF1Th0AEJ44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eOhDLYMhd0QZL+HWVBkJE1v9EpGu+iCbO7Jeh5wofbFbh+Ty+/JL+TtNTcgswHYM/
	 UQa7UpS8/RAEGLag+b7w80a8fwe35VzXiSV67TM0adt9H0g3pe27cwYKYZRM7o3kxw
	 uc/f1v79/fi/yypIsRvusnEmO/6NKK8G9eZLLQMXf7IoJs7g5QDEUNSYAyZzMkGKdW
	 Lz0Aq4F6Yp/27Rf/7wrqJkG2F9EaJ1IlVFYWVAwyGk0JH13nFO3FYMF8qjF5uVf+bU
	 PF2thDYqW7E/CBr6zQeqY4gKbgnDJ0qbM183FgTr8SKY1A97vdHz4pmo2cNRsyO9Je
	 UA8zYla4JCYUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FFF8D8C98B;
	Thu, 21 Dec 2023 05:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: Fix NULL pointer dereference in
 bpf_object__collect_prog_relos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170313482438.22190.7805144869864343062.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 05:00:24 +0000
References: <20231221033947.154564-1-liuxin350@huawei.com>
In-Reply-To: <20231221033947.154564-1-liuxin350@huawei.com>
To: Xin Liu <liuxin350@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yanan@huawei.com,
 wuchangye@huawei.com, xiesongyang@huawei.com, kongweibin2@huawei.com,
 tianmuyang@huawei.com, zhangmingyi5@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 21 Dec 2023 11:39:47 +0800 you wrote:
> From: Mingyi Zhang <zhangmingyi5@huawei.com>
> 
> An issue occurred while reading an ELF file in libbpf.c during fuzzing:
> 
> 	Program received signal SIGSEGV, Segmentation fault.
> 	0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> 	4206 in libbpf.c
> 	(gdb) bt
> 	#0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> 	#1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:6706
> 	#2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
> 	#3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
> 	#4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
> 	#5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
> 	#6 0x000000000087ad92 in tracing::span::Span::in_scope ()
> 	#7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
> 	#8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
> 	#9 0x00000000005f2601 in main ()
> 	(gdb)
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos
    https://git.kernel.org/bpf/bpf-next/c/929154ac3b88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



