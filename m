Return-Path: <bpf+bounces-62361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF208AF85A3
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 04:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751045483A0
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9551DDA34;
	Fri,  4 Jul 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F28IYftK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD978F54
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751596812; cv=none; b=phx396rPOPDJ1eErxGIO81vnQ7I8UMsxs4fTimW0OD5lH5QyO5nMOu0mAY7tkuy8khDmiBdmhfCnSzgyBwXlIJJhk+D/2pE7+I5E/5BtDAZ7EQZUnaYBnoX/HfOyvItsfwWTjdpi7S5TQ5u4ypdD4jsf2e8EvEttH2WBDPaTFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751596812; c=relaxed/simple;
	bh=ePWut7P6rDsEENzfw6Q5eDrCp7F2/v4iq4Q7ectDI+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aoyfK7colAGVL+6v1acmCO3reg+PTFRTRz7oa/as/I4yqC6M/0riak5o62a9m6qtpWgeNLgeCFkHsjiFKLau0DGhIvwyw0R8g+NKF2vb7jkYaVa2uEVwMmn6NBL4EmomqIGoqq6L9ps1eRviu3IAQGVMrgzkIcBfKD9rzaVZb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F28IYftK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21667C4CEE3;
	Fri,  4 Jul 2025 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751596812;
	bh=ePWut7P6rDsEENzfw6Q5eDrCp7F2/v4iq4Q7ectDI+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F28IYftKj0B+XR6jhg6IIrNMLGjTTsyqbQNSzRviNxqFvWa/pT/xkblqGv7gMinMt
	 dI+86qTKggOJ1e2TeDWeGsjJQ0lrBLu44Z4V/5i1qa3IttR75AINT9uiRZabB3MnOw
	 nqwRiWjv0bVmYsVgdz9XRDvK+YaxAequEgzeT4ulJ2sB4WxAhpynmBxL77SB5jfTZF
	 nmkoNRgVEw/e66Gbsu3q8x8Ot3tNuRPM9tXT6gva+wnot6OrZ6QAPLPh5S5HqrMUaA
	 WhYgIrxE6fQoqbt/zQk24+mDdsVLFfOgV9cy4esciK1770SrjBHu9tsQNtTHAAtBmp
	 jX7lYN7h4MURQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D06383BA01;
	Fri,  4 Jul 2025 02:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/12] BPF Standard Streams
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175159683625.1682876.9033904711284711258.git-patchwork-notify@kernel.org>
Date: Fri, 04 Jul 2025 02:40:36 +0000
References: <20250703204818.925464-1-memxor@gmail.com>
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 emil@etsalapatis.com, brho@google.com, mattbobrowski@google.com,
 kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Jul 2025 13:48:06 -0700 you wrote:
> This set introduces a standard output interface with two streams, namely
> stdout and stderr, for BPF programs. The idea is that these streams will
> be written to by BPF programs and the kernel, and serve as standard
> interfaces for informing user space of any BPF runtime violations. Users
> can also utilize them for printing normal messages for debugging usage,
> as is the case with bpf_printk() and trace pipe interface.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/12] bpf: Refactor bprintf buffer support
    https://git.kernel.org/bpf/bpf-next/c/0426729f46cd
  - [bpf-next,v5,02/12] bpf: Introduce BPF standard streams
    https://git.kernel.org/bpf/bpf-next/c/5ab154f1463a
  - [bpf-next,v5,03/12] bpf: Add function to extract program source info
    https://git.kernel.org/bpf/bpf-next/c/0e521efaf363
  - [bpf-next,v5,04/12] bpf: Ensure RCU lock is held around bpf_prog_ksym_find
    https://git.kernel.org/bpf/bpf-next/c/d09032686009
  - [bpf-next,v5,05/12] bpf: Add function to find program from stack trace
    https://git.kernel.org/bpf/bpf-next/c/f0c53fd4a742
  - [bpf-next,v5,06/12] bpf: Add dump_stack() analogue to print to BPF stderr
    https://git.kernel.org/bpf/bpf-next/c/d7c431cafcb4
  - [bpf-next,v5,07/12] bpf: Report may_goto timeout to BPF stderr
    https://git.kernel.org/bpf/bpf-next/c/e8d013302252
  - [bpf-next,v5,08/12] bpf: Report rqspinlock deadlocks/timeout to BPF stderr
    https://git.kernel.org/bpf/bpf-next/c/ecec5b5743bf
  - [bpf-next,v5,09/12] libbpf: Add bpf_stream_printk() macro
    https://git.kernel.org/bpf/bpf-next/c/21a3afc76a31
  - [bpf-next,v5,10/12] libbpf: Introduce bpf_prog_stream_read() API
    https://git.kernel.org/bpf/bpf-next/c/3bbc1ba9cc0d
  - [bpf-next,v5,11/12] bpftool: Add support for dumping streams
    https://git.kernel.org/bpf/bpf-next/c/876f5ebd58a9
  - [bpf-next,v5,12/12] selftests/bpf: Add tests for prog streams
    https://git.kernel.org/bpf/bpf-next/c/5697683e133d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



