Return-Path: <bpf+bounces-71290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CEEBEDDC8
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 04:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D4B3B11CA
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B81EDA3C;
	Sun, 19 Oct 2025 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glk6nqJ9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE2354AE8
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841034; cv=none; b=LEuzj7pJLzW2axXvnT1fVK0xsYxdEsiu/MIXCoRDnhAJu9/R4vIKUVoLQQ3cvQw3MNbUh2cRBoxd5d9K+KNa7rDJmXbmcqrpWwztG2KaWOCgrsviuZXXnU8OvX73C+FW3QGc+SBcwe2O4vXsYeiQ5Io1iW0CYNWPOyKuDw6gJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841034; c=relaxed/simple;
	bh=wdbLV7EMDwss6atWheK+iVpg/E7qzsDkx5CQCGrQ170=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iELgwesMbjY38zfu0bpRl96VCHX64g8b0OJGsTr5eUgwEdc3uJz0P43LoodsfkbsO0s2HoSAcAi6zhPLPK2b2TZTuL7zO2ib/TTnbAlesQbnOOB1WaRRImrcUFHHqLXsFVFn7yXd/v07agianGm3bIyBnZcLGP1fURhn6W5wnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glk6nqJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E4CC4CEF8;
	Sun, 19 Oct 2025 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760841034;
	bh=wdbLV7EMDwss6atWheK+iVpg/E7qzsDkx5CQCGrQ170=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=glk6nqJ9XEuMOS4WbgADJRMSICAklnJnstGoOrYe4Ze+0P6q6ajfiXeStyJ6/TX6x
	 Aedz6rejQ1gfOUxGPaTkYc1DcwT8cZedHHv861p+1vE3NepyjywYrgWkaCGGMNKTwW
	 WRjhuJAFkQxC1axdQ4FfW6NMIrGQGfeZeSKvYw/MA839EU85Dq1M5FcMX1miao8aFJ
	 SGUInnNGVagaAAEmkff1j7Qsfgkj+bBVhEbNYp1gW919LEPplxFY+ySdehAw66B+pB
	 Tv7R/6YKGz5FkI6p6Jt+0BUADc6CtrNqRHu9BqDOJ4ozOe982nUumSOSI/Wkw3nVVj
	 9lLckRMMpju6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7F39EFBBF;
	Sun, 19 Oct 2025 02:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest
 verif_scale_strobemeta
 failure with llvm22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176084101675.3155740.4372204792816827273.git-patchwork-notify@kernel.org>
Date: Sun, 19 Oct 2025 02:30:16 +0000
References: <20251014051639.1996331-1-yonghong.song@linux.dev>
In-Reply-To: <20251014051639.1996331-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Oct 2025 22:16:39 -0700 you wrote:
> With latest llvm22, I hit the verif_scale_strobemeta selftest failure
> below:
>   $ ./test_progs -n 618
>   libbpf: prog 'on_event': BPF program load failed: -E2BIG
>   libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>   BPF program is too large. Processed 1000001 insn
>   verification time 7019091 usec
>   stack depth 488
>   processed 1000001 insns (limit 1000000) max_states_per_insn 28 total_states 33927 peak_states 12813 mark_read 0
>   -- END PROG LOAD LOG --
>   libbpf: prog 'on_event': failed to load: -E2BIG
>   libbpf: failed to load object 'strobemeta.bpf.o'
>   scale_test:FAIL:expect_success unexpected error: -7 (errno 7)
>   #618     verif_scale_strobemeta:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix selftest verif_scale_strobemeta failure with llvm22
    https://git.kernel.org/bpf/bpf-next/c/4f8543b5f20f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



