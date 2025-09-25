Return-Path: <bpf+bounces-69795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97689BA1F4A
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E096561299
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A82EC54B;
	Thu, 25 Sep 2025 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knv08NBw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987E2EA17E;
	Thu, 25 Sep 2025 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842413; cv=none; b=YeqzK4M8TeFaqAZd0Bfcd1sIpPSFRzGmTfwUSitP66joVL/ZUOip3FiCoAhDBn9XLmN5mJFBlMQ0Zgnf+3Nudh1cIlTqkpiBrcdU1EPfjaFN9oqIXbTPHmsQY0A/Yp5EvXa1kBH3uJ6eaxOuvEUyuOVELygnISc5QoPC/SUFTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842413; c=relaxed/simple;
	bh=eBnfRaFiZeXs2eKrJjhXvANquIeZmlV6BOJpJm/uXT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W48Rt2Gr1yD+6iChjEXsLrXGvZlFwT7jqqER32Lwf7Hm3C9W7Aiz4ILEdyPoDhGJ4VPYRceWacNUU6xR2oYpbqD+EPzx5sO3X9n3a6K60CllZE3soASQN+mYIGvYIZ7DphZDPxScoxNhId4PH2IrkJbPZelL4vAe98elDbxg1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knv08NBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F52C4CEF0;
	Thu, 25 Sep 2025 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758842412;
	bh=eBnfRaFiZeXs2eKrJjhXvANquIeZmlV6BOJpJm/uXT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=knv08NBw509vx1CVoNUCY6EZsUHlEeJjOA2X75TzRr+RV0q1V4DOJZ3qIpyBmt8qA
	 u74aIzjcpm8wAY280IAK8dWKMB1PbHV7FZJ8Vq8hQt2i4m4zU0lKBvQUNP40lPlp7L
	 Wm4TrH0kPpg0K6xGq94te/Qqm6mTBG+dS1tq2Wv1/tDj6arFzEevKDI2syS4Hy1Z/c
	 bWFkdraL0iYwJiarzaFBdcirXRzA8ma4SEgi9GIb/2vLX453OOsvqafWWkG3+z4z9E
	 OrD+driMsrkxq/Gw5sUBGHAbsyd4uQG38MAXNP1xEpRxz7VkB8oMSvgJBme1ggiKeZ
	 EVu/SkkuBQx8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EE239D0CA0;
	Thu, 25 Sep 2025 23:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Add lookup_and_delete_elem for
 BPF_MAP_STACK_TRACE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175884240831.3555731.6888839221416950805.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 23:20:08 +0000
References: <20250925175030.1615837-1-chen.dylane@linux.dev>
In-Reply-To: <20250925175030.1615837-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 26 Sep 2025 01:50:28 +0800 you wrote:
> The stacktrace map can be easily full, which will lead to failure in
> obtaining the stack. In addition to increasing the size of the map,
> another solution is to delete the stack_id after looking it up from
> the user, so extend the existing bpf_map_lookup_and_delete_elem()
> functionality to stacktrace map types.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/3] bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
    https://git.kernel.org/bpf/bpf-next/c/17f0d1f6321c
  - [bpf-next,v6,2/3] selftests/bpf: Refactor stacktrace_map case with skeleton
    (no matching commit)
  - [bpf-next,v6,3/3] selftests/bpf: Add stacktrace map lookup_and_delete_elem test case
    https://git.kernel.org/bpf/bpf-next/c/d43029ff7d1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



