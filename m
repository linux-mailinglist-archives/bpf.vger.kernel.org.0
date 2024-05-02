Return-Path: <bpf+bounces-28474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535988BA100
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 21:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0091F2258B
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275B17B510;
	Thu,  2 May 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGxP6QJz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C417A93E
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677592; cv=none; b=HWYLs2MoEJap6TJvpdh0STfRCxh5ruxlNzvHtvNDgohV9GiAw5I+YZBqtRtZM/7O16EMxncZA+2wywMcImunKgOP50hl6+woJx3S/EtcJm3ev8C8zWk0cIzm6PAJy45bnC1XI1+53AaiMtFIwGZ9uKlOVJzSGe+PY711ldiFRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677592; c=relaxed/simple;
	bh=4M5yGmgjLTknVX3wQ9DLGdQCvnsoI2F64EEeCn+eeag=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FX5YGVC1mitonqA0paG/w8FdGBBa1+oE7iDILarigeLrpFFr4sJksQP17WXfUZLGs7cUzlljLFw0EzllcDXc1nA8QcDpm9cZjp6oe5/K4V/APCT+G+lZY0EdtDL8+emzXTfNvGi/naTrY4XSbsWiBx9CkBkkRQTYrtrAnQxWfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGxP6QJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295EEC113CC;
	Thu,  2 May 2024 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714677592;
	bh=4M5yGmgjLTknVX3wQ9DLGdQCvnsoI2F64EEeCn+eeag=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=mGxP6QJz6OpW8zRZxQf683B//+NpSV648NcKJ2BI2jmVo6GwrSvyv5/wNbGW9Hvmm
	 vXROjsdu5oA1KhSc/md7GPKtNytwoFS9nUAY56YOXzW7Hff389Zj+rbxa7YkQf1FON
	 oQyp1z0CqhmG1ovvqrrbvA02FeLLvva+Whr4JQpt517jlwn6sKJAljaX4FF3dgfa+K
	 R2zRv1AXv3hxJ7QxaT8QgHbwTriu67EkxeqXyQDqyDfRzb5HBte5TWXAtuPffwGeYO
	 8LURspDsQSKBiA0CvRtqAJI0QT2wkkjXMaXOz5fI1UvoWX8opOLuFulDGOvJ7+LLgD
	 W5rHi6uygvtaA==
From: Puranjay Mohan <puranjay@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 bpf@vger.kernel.org
Subject: Re: On inlining more helpers in the JITs or the verifier
In-Reply-To: <mb61p1q6k869u.fsf@kernel.org>
References: <mb61p1q6k869u.fsf@kernel.org>
Date: Thu, 02 May 2024 19:19:49 +0000
Message-ID: <mb61pzft8vx62.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> Hi Everyone,
>
> While working on inlining bpf_get_smp_processor_id() in the ARM64 and
> RISCV JITs, I realized that these archs allow such optimizations because
> they keep some information like the per-cpu offset or the pointer to the
> task_struct in special system registers.
>
> So, I went through the list of all BPF helpers and made a list of
> helpers that we can inline in these JITs to make their usage much more
> optimized:
>
> I. ARM64 and RISC-V specific optimzations if inlined:
>
>     A) Because pointer to tast_struct is available in a register:
>         1. bpf_get_current_pid_tgid()
>         2. bpf_get_current_task()

Tried inlining bpf_get_current_task() on ARM64:

                  Before                                                                  After
                 --------                                                               --------

bpf_prog_6e2672bcc4451a42_trigger_get_current_task:                      bpf_prog_6e2672bcc4451a42_trigger_get_current_task:
; task = (struct task_struct *)bpf_get_current_task();                   ; task = (struct task_struct *)bpf_get_current_task();
  34:   mov     x10, #0xffffffffffff9838                                   34:   mrs     x7, sp_el0
  38:   movk    x10, #0x8027, lsl #16
  3c:   movk    x10, #0x8000, lsl #32
  40:   blr     x10
  44:   add     x7, x0, #0x0



In the non-inlined version there is a branch [blr x10] to:

0xffff800080279838 bpf_get_current_task:
                     <+0>:     mrs     x0, sp_el0
                     <+4>:     ret


So, we only need a single instruction after inlining!!

I just don't know the best way to benchmark this. In theory it looks
highly optimized.

Thanks,
Puranjay

