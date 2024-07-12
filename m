Return-Path: <bpf+bounces-34662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BDA92FE10
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A041C23872
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA031175545;
	Fri, 12 Jul 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4FSKXb9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5A1DFE3
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800034; cv=none; b=jLOx6Om+SJ5+LW03j988/T/L8E8DaZ3gGr/AQqJ0MRpJKdkH5NvHK6RZezWh7zsVp2+WQVKJn7HqBFJ+HIZUiLiwQKS4mnpG8aWG5JaZpre+csJgmjFaOnL4t+4muQXtX9bv81Q7YElICxLyscJmerm+VH1gV9llwwb+sbmYs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800034; c=relaxed/simple;
	bh=0NjKbrXpSdQh69Ty9DXemB+OU9KdFiUN19kv6qWwVLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ltqkGJAhjKBlSzlDy3CBx9ZLNHbDh86aDL0uoq3JfmkvnmEoIgmTmuFngO/F431d7hyjxBri5oLsW27YEcsNdorNQY9XdU2xtru9UZyfKYaXMfezJWBn6yJqlmqPRFyRNoNDpxjr8+7Gv64SXE3ezJwkU23K8YzcWNeQaQ1FcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4FSKXb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0A63C4AF0A;
	Fri, 12 Jul 2024 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720800033;
	bh=0NjKbrXpSdQh69Ty9DXemB+OU9KdFiUN19kv6qWwVLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q4FSKXb9uDGA/k3R1KR4L/z6SohuYllrkxmF4/4uF/0Zm+fdZlWii2qGOcsXSnoVp
	 xttyWrvGh0cH9sazWfvBWdLN+D2gLAzfHUMz8fO4iwvOxHSrvb4AAv1LN+QtueFjrS
	 V1BVi39zxtvq9WYAF+8jUwPpLV6YLliv/sBoCtWPwvVk8r4AqHFLRlWsPwrKEiu8hV
	 NWpNYoGnqgM4dBJcTcRwiTqlTF0OssAon7HMaJYLeuyFySI6vxbXAEDq6kSTXpv+B9
	 J1BymHSORUUI97VojF5l0pZmDecRQa3Ej8pVyMe4c/WjNjkjghLxr7atXqIQe6Q9Ra
	 0esSysIxzXPLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B78E3C43153;
	Fri, 12 Jul 2024 16:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] Use overflow.h helpers to check for overflows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172080003374.5831.5559125781952141989.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 16:00:33 +0000
References: <20240712080127.136608-1-shung-hsi.yu@suse.com>
In-Reply-To: <20240712080127.136608-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, jolsa@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 12 Jul 2024 16:01:23 +0800 you wrote:
> This patch set refactors kernel/bpf/verifier.c to use type-agnostic, generic
> overflow-check helpers defined in include/linux/overflow.h to check for addition
> and subtraction overflow, and drop the signed_*_overflows() helpers we currently
> have in kernel/bpf/verifier.c; with a fix for overflow check in adjust_jmp_off()
> in patch 1.
> 
> There should be no functional change in how the verifier works and  the main
> motivation is to make future refactoring[1] easier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: fix overflow check in adjust_jmp_off()
    https://git.kernel.org/bpf/bpf-next/c/4a04b4f0de59
  - [bpf-next,v3,2/3] bpf: use check_add_overflow() to check for addition overflows
    https://git.kernel.org/bpf/bpf-next/c/28a4411076b2
  - [bpf-next,v3,3/3] bpf: use check_sub_overflow() to check for subtraction overflows
    https://git.kernel.org/bpf/bpf-next/c/deac5871eb07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



