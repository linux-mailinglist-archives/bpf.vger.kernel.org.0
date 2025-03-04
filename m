Return-Path: <bpf+bounces-53157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0FBA4D16E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 03:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB34A3AD263
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383D14A60F;
	Tue,  4 Mar 2025 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNitq5Xw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28533D8
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 02:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054198; cv=none; b=bMhUOnEQow91Mq9SrPoNXy5i1YP7rIB/sveUyl3tEN8e57VxFbWAB+B8K8zVMrnQHP5hKDBJOPwVDy3plY3VlMQnWmUaANmbpVuz6tCSTXIIJ515HF1rNuSQ5hT5xrAimVKCZNgRxHrCEqbc7UFmv9LapI0FBga3DwsiRhE6mZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054198; c=relaxed/simple;
	bh=aTvzy0iaBG9DQBA/kwWtVb70yexGBET0LY9Y0uMDb3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j+grEm3yR0Wo1J0gjJh6I/IcAecQRhW3sbJNXqaRJKdhCURyty0tS3M6Nxr/MdHokbaauJee0jKnlNczRXtlNNHUxG1EKbe0OWjyJ+rEaeeGS1DHKiXlJ9hJMcq44ezn31rLWxeUkGUWTUMsmdcIjIebeU2heoyiM9e45V7Eym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNitq5Xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD483C4CEE4;
	Tue,  4 Mar 2025 02:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741054197;
	bh=aTvzy0iaBG9DQBA/kwWtVb70yexGBET0LY9Y0uMDb3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fNitq5Xw3hEuGo355N4Fl2MXfb2iYXIno/S6EegeZy3iNBqQgn0x2AZngYIwauA26
	 xrTc8rmcxJ5+hCQ08XZ+N5l4nN3dLwaCreswKXGBuOfBAT9LqZydxl3uvSiFbHYA7j
	 Zw4TSuZoxvtRmohUP7NixG58Xh6rPlC3Zo0eL7lvszlz/xEvw+Or8Y1B4vddwRgX/q
	 0xJgMSWrgot2zmO717FQvbJb0Ga+pHqW/Ce1WqJ7LOY/+K5JJpDy/iTfTRoU4MPiow
	 k9t/ovBmEyMXXILM2zklB1vjBfPOf2LKGKbMi6UVTGbKUdg10bT0SKlG6zPEnabyGl
	 N6fC77gxlS2pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF61380AA7F;
	Tue,  4 Mar 2025 02:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Timed may_goto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174105423050.3834266.5937070565519145279.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 02:10:30 +0000
References: <20250304003239.2390751-1-memxor@gmail.com>
In-Reply-To: <20250304003239.2390751-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 tj@kernel.org, emil@etsalapatis.com, brho@google.com, joshdon@google.com,
 dohyunkim@google.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  3 Mar 2025 16:32:37 -0800 you wrote:
> This series replaces the current implementation of cond_break, which
> uses the may_goto instruction, and counts 8 million iterations per stack
> frame, with an implementation based on sampling time locally on the CPU.
> 
> This is done to permit a longer time for a given loop per-program
> invocation. The accounting is still done per-stack frame, but the count
> is used to instead amortize the cost of the logic to sample and check
> the time spent since the start.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Add verifier support for timed may_goto
    https://git.kernel.org/bpf/bpf-next/c/13a664f46e34
  - [bpf-next,v2,2/2] bpf, x86: Add x86 JIT support for timed may_goto
    https://git.kernel.org/bpf/bpf-next/c/2cb0a5215274

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



