Return-Path: <bpf+bounces-69727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7437BA05BF
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780F0172C1C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B721C3043BA;
	Thu, 25 Sep 2025 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJhomZjc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19308303C9B;
	Thu, 25 Sep 2025 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814334; cv=none; b=fmJzqe/uMsM6XooIWgGnBJt/2m+v4tS+8uUJ59lMP6OmnIu0mB95hYxlhLb2tUAwu4QHcWesFEXQDOEnmN3r10j3gTu+o9oLw61VohxsQ4uzlvVOnsHwFfiymFCFvYMRz4kW1VigRuTUmgYojKblBDLHuAPzhI04iXtJRyvHFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814334; c=relaxed/simple;
	bh=nJtC9h9+MFddQfow64tKhZDUie+SLtMhzJFDXayXg1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4EUkCMJZdsZeS7CrHbxL2989jlvlMO17lonK4JnITDqIaCxSkU1D0Y67gL3M2vcD/tkZwacNhCC9FTzuLViTJ7/EqkSrlXvYpo57uYk+uNIawhoFvZtK87EcOBdEIIEn/pQC1+QcJQHUNhb44vmTBnF6sQPFd2/4KuA1ieaQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJhomZjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FFFC4CEF7;
	Thu, 25 Sep 2025 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758814333;
	bh=nJtC9h9+MFddQfow64tKhZDUie+SLtMhzJFDXayXg1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJhomZjcuVQrsHtrwBqbU+0MZQ0FrWB1VHntRw2PT8v8rBNupBnMn33m3k4k9UV8K
	 YZnj3knKOay2cX3MtpylgvUzKVndJtBYnW2Gi+sYrsdiQs670EN5OqM5BGm3lGwCQ3
	 nIMDTD0aGLZpRwy2MtdkVa0YMXWbEc22xktR+l0p5evgMyAOthM2CHVcc6qrkrKunf
	 N7dI23kY6Ry7Yoz3hn2VVAibpDeTSvoLSO6VdS2AE3bDnswUpL5hbbfnnwm3/UDNwj
	 nqJn3PaNjQcbb2wKbjMtkZUwxkYPQuhwXgn7/2KR98ki2uBY3LN0rhEf7KPKTgkR1i
	 MTt4XfjJb6KVQ==
From: Will Deacon <will@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	olsajiri@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	Feng Yang <yangfeng59949@163.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64
Date: Thu, 25 Sep 2025 16:32:02 +0100
Message-Id: <175880516935.3262599.14788507714084459007.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250925020822.119302-1-yangfeng59949@163.com>
References: <20250925020822.119302-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 25 Sep 2025 10:08:22 +0800, Feng Yang wrote:
> When using bpf_program__attach_kprobe_multi_opts on ARM64 to hook a BPF program
> that contains the bpf_get_stackid function, the BPF program fails
> to obtain the stack trace and returns -EFAULT.
> 
> This is because ftrace_partial_regs omits the configuration of the pstate register,
> leaving pstate at the default value of 0. When get_perf_callchain executes,
> it uses user_mode(regs) to determine whether it is in kernel mode.
> This leads to a misjudgment that the code is in user mode,
> so perf_callchain_kernel is not executed and the function returns directly.
> As a result, trace->nr becomes 0, and finally -EFAULT is returned.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64
      https://git.kernel.org/arm64/c/fd2f74f8f3d3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

