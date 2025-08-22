Return-Path: <bpf+bounces-66290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF94B32078
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F309E794F
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DD2727F3;
	Fri, 22 Aug 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh5WV9Da"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1426A0C7
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879606; cv=none; b=qhoWCHnO+zerSRydHAAqLPjDWi3bseRUW2Yb+2hChxdzRa6XfvQSMRAanUjrWOTM8yRIwyJyIHDU9qOgFVr9ICfsmD1BgkFgOS1Ga/cpVYuwqBU7MIeSVXOf5FBpHue5BF5E4qokz59S3AgZAtJUlNpyvxgE1WRBQOJsDjeGEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879606; c=relaxed/simple;
	bh=aHyhJojknLMQHL3kvth3OaYiBs3HvL0fMVCQS2uU+mM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aV38ekk2mKLM9BLwk7VnWGNfo9F9mwy3pI5agiY4LPYX2tDY/RjC9oQ/A3T4AmVl6dyjxqOEPdmZrZ9HwWFiQFK58+AJWfNtjtqId8PHj3s7BZKFkkXDNasGIOQpfEqnaIJkN3NngotQ5GRlg7oDv7qlJyRiar3T7KplCBwn5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh5WV9Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0A6C4CEED;
	Fri, 22 Aug 2025 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755879605;
	bh=aHyhJojknLMQHL3kvth3OaYiBs3HvL0fMVCQS2uU+mM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rh5WV9DahJgMdz4AE/3q1AO2GFM+n3eAn0Q3CKc+P2MMzJLymR8vpDYIBukyKTUqp
	 7sa4KCOFBtaBiG+vKineRImQ2ddIhhIuNgX1XJXfnVwO1c3M/WLaVALeyPxVknZPhu
	 5pw0CU4IPe7B6G2LyYHObmch4hIaR8MowMllDuAZ9AoF2htuBhc75Ce3SQJhxzOCHP
	 +rD+p151APmBnz3Vpm+Rvn1jbKSw/jVLLbeCUQmYomkoa1GLK8secyeNTY24qZwLKO
	 l5Qy7RgSVdebfidIxI37+AlDj4Gx6/rgs51ZMIEo69Jl3eOU5/Dygkint50VSUC5BU
	 Ocez6IiKdDGiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE15383BF69;
	Fri, 22 Aug 2025 16:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Use tnums for JEQ/JNE
 is_branch_taken
 logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175587961449.1895682.8759743694728637602.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 16:20:14 +0000
References: 
 <be3ee70b6e489c49881cb1646114b1d861b5c334.1755694147.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <be3ee70b6e489c49881cb1646114b1d861b5c334.1755694147.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 shung-hsi.yu@suse.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 20 Aug 2025 15:18:06 +0200 you wrote:
> In the following toy program (reg states minimized for readability), R0
> and R1 always have different values at instruction 6. This is obvious
> when reading the program but cannot be guessed from ranges alone as
> they overlap (R0 in [0; 0xc0000000], R1 in [1024; 0xc0000400]).
> 
>   0: call bpf_get_prandom_u32#7  ; R0_w=scalar()
>   1: w0 = w0                     ; R0_w=scalar(var_off=(0x0; 0xffffffff))
>   2: r0 >>= 30                   ; R0_w=scalar(var_off=(0x0; 0x3))
>   3: r0 <<= 30                   ; R0_w=scalar(var_off=(0x0; 0xc0000000))
>   4: r1 = r0                     ; R1_w=scalar(var_off=(0x0; 0xc0000000))
>   5: r1 += 1024                  ; R1_w=scalar(var_off=(0x400; 0xc0000000))
>   6: if r1 != r0 goto pc+1
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Use tnums for JEQ/JNE is_branch_taken logic
    https://git.kernel.org/bpf/bpf-next/c/f41345f47fb2
  - [bpf-next,v2,2/2] selftests/bpf: Tests for is_scalar_branch_taken tnum logic
    https://git.kernel.org/bpf/bpf-next/c/0780f54ab129

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



