Return-Path: <bpf+bounces-71614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E0BF815A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5D54242EF
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C203502B4;
	Tue, 21 Oct 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDRvETHV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0AF264A92
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071430; cv=none; b=mjP9Z6BwW2n8PaAKBx5foLOIYdzSEDsohmUfXYXNaUnMtc6sM7qkVzRrBx58WoGybNo0jhXheXOGC0DRnlJE4JvizDlGNaXLlbV2MsRDNQeV+5wJFC9BOG/4ABQBnSR4V1bTrULh9XY4UDRtZmIR3Paf+0lUDFymA1xNcf7ACog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071430; c=relaxed/simple;
	bh=A5nBW8hs6qz/5+WCw/bs10w/YvYax7UsbafW9xYJMYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MQtscrS5gPKu1vGR3eR0wlrz4lnBK9rJ+r3f/rchAMRJ/U+mMQfGSMYvZ6pMAfhGR3qFGuxjZa5+TwWGeP7sRP+jpTRzgh4LxwMwV8M8EHfUPIxMr70+Cm5JDA6gD2ZgyyZSh12csriQ2z9a2aOgmTQ3h8w7ENrEfCExEuEox5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDRvETHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177C8C4CEF1;
	Tue, 21 Oct 2025 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761071430;
	bh=A5nBW8hs6qz/5+WCw/bs10w/YvYax7UsbafW9xYJMYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MDRvETHVZsEiDmkwIWvrYQITfUzPKGSG9cjMRirA04u3rj1qimOar9Vd2WCVRiWSX
	 ROVI2lBvY+F2yreGaxEKjF31r7zhoSnQPixVtpNqEjkfrBQZ3z5m+DtlRsAziO11qx
	 1L1pjH9pBNhTNYnt5KNfy5hTFa/q9JEGqwdWseq/NpYIhCwNibz0OWATQlDdaFSzlH
	 w9U7iKxp+xDugmo1Z/xFPplk8qlrAhpVvgVlDhXyqyYEVFans5ZyAx8+gcY6/4hIib
	 VmyHJIBAIByy05EXxbH0wJ9fVl1vVRPuEDR0UKWmdTbgek5mVAZlc6w27IefM2Hlcv
	 xpKMt+Jja6Fug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD43A55F96;
	Tue, 21 Oct 2025 18:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 00/17] BPF indirect jumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176107141151.1186177.14682170643872702477.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 18:30:11 +0000
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com, qmo@kernel.org,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 19 Oct 2025 20:21:28 +0000 you wrote:
> This patchset implements a new type of map, instruction set, and uses
> it to build support for indirect branches in BPF (on x86). (The same
> map will be later used to provide support for indirect calls and static
> keys.) See [1], [2] for more context.
> 
> Short table of contents:
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,01/17] bpf: fix the return value of push_stack
    https://git.kernel.org/bpf/bpf-next/c/6ea5fc92a0fc
  - [v6,bpf-next,02/17] bpf: save the start of functions in bpf_prog_aux
    https://git.kernel.org/bpf/bpf-next/c/f7d72d0b3f43
  - [v6,bpf-next,03/17] bpf: generalize and export map_get_next_key for arrays
    https://git.kernel.org/bpf/bpf-next/c/44481e492532
  - [v6,bpf-next,04/17] bpf, x86: add new map type: instructions array
    (no matching commit)
  - [v6,bpf-next,05/17] selftests/bpf: add selftests for new insn_array map
    (no matching commit)
  - [v6,bpf-next,06/17] bpf: support instructions arrays with constants blinding
    (no matching commit)
  - [v6,bpf-next,07/17] selftests/bpf: test instructions arrays with blinding
    (no matching commit)
  - [v6,bpf-next,08/17] bpf, x86: allow indirect jumps to r8...r15
    (no matching commit)
  - [v6,bpf-next,09/17] bpf: make bpf_insn_successors to return a pointer
    https://git.kernel.org/bpf/bpf-next/c/2f69c5685427
  - [v6,bpf-next,10/17] bpf, x86: add support for indirect jumps
    (no matching commit)
  - [v6,bpf-next,11/17] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
    (no matching commit)
  - [v6,bpf-next,12/17] bpf, docs: do not state that indirect jumps are not supported
    (no matching commit)
  - [v6,bpf-next,13/17] libbpf: fix formatting of bpf_object__append_subprog_code
    https://git.kernel.org/bpf/bpf-next/c/e7586577b75f
  - [v6,bpf-next,14/17] libbpf: support llvm-generated indirect jumps
    (no matching commit)
  - [v6,bpf-next,15/17] bpftool: Recognize insn_array map type
    (no matching commit)
  - [v6,bpf-next,16/17] selftests/bpf: add new verifier_gotox test
    (no matching commit)
  - [v6,bpf-next,17/17] selftests/bpf: add C-level selftests for indirect jumps
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



