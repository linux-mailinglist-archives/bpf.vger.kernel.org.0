Return-Path: <bpf+bounces-62362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D52AF85A4
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 04:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B744A771B
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2B1DF991;
	Fri,  4 Jul 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWfoeEqL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4702594;
	Fri,  4 Jul 2025 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751596815; cv=none; b=DWwPxkLcwo/43NgLHeapy+icmbs/PM1xx25xmsrwegj4igqhHXieIowHRDVkP65InNluMTciCF2Nzblrjd8Y3+tGbnxsK22ddKosGdiixynjEEoAVTTD36hpXzzIrEQ78s6qx3JYyQhdsrIAo3qMPQXNUbf6VfoVyHceB2ahYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751596815; c=relaxed/simple;
	bh=TdWwQzR0zpIAe0xbdpoU/xjLevB+Vt2+KTdSQblx0Hk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pk5CdtYBjdxMQbQ8f6tM6toImW3oX0f6C/z1Tw7Wi7OVdqkRtpm2odhHO2IoJWnsfkqmKpeSepaUZNr9+wdxnBjoFGBV+Mu5LzfWM7heP3fzpSK2+wVfxdJvKYp4o8ieoKjLWmU1ZUJzbicATlCvE/e9zZq+93EKoNgy9IIdOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWfoeEqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEB9C4CEE3;
	Fri,  4 Jul 2025 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751596813;
	bh=TdWwQzR0zpIAe0xbdpoU/xjLevB+Vt2+KTdSQblx0Hk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KWfoeEqLMSdUyQvci5Q1J8AYWa8fJWWc2SBAPQidzv/8+ovkfWFdFaClJuc3mne91
	 xyFN2E4rubeg+q0o99WL7H1jOaw2uX0Pezr1WRwgAeE+EbOWwHLcvp8bA24/RACLu5
	 s1TBmEKTDLJTM0s6pzzljdoiK+T2xwm4+gdaeTiwqfV7DdtSCkVYOrVuxeEfqYx/fw
	 eszAEMDYfitRtjowd9VW9xhIABato/ySZjWzIgRS7JlVe/9kLJB5AHmc/gm03bSB7c
	 CUJk6rHqd9bC6Q7PbYpXk8eiMxRd80/OCA7fRVnDmJHRSlBeNgPSgXAW6LgySp54PN
	 RHX3ngcfsjOqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1F383BA01;
	Fri,  4 Jul 2025 02:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Show precise link_type for
 {uprobe,kprobe}_multi fdinfo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175159683750.1682876.3979686281569023976.git-patchwork-notify@kernel.org>
Date: Fri, 04 Jul 2025 02:40:37 +0000
References: <20250702153958.639852-1-chen.dylane@linux.dev>
In-Reply-To: <20250702153958.639852-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  2 Jul 2025 23:39:56 +0800 you wrote:
> Alexei suggested, 'link_type' can be more precise and differentiate
> for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
> kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
> can show it more concretely.
> 
> link_type:	kprobe_multi
> link_id:	1
> prog_tag:	d2b307e915f0dd37
> ...
> link_type:	kretprobe_multi
> link_id:	2
> prog_tag:	ab9ea0545870781d
> ...
> link_type:	uprobe_multi
> link_id:	9
> prog_tag:	e729f789e34a8eca
> ...
> link_type:	uretprobe_multi
> link_id:	10
> prog_tag:	7db356c03e61a4d4
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/3] bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo
    https://git.kernel.org/bpf/bpf-next/c/803f0700a3bb
  - [bpf-next,v7,2/3] bpf: Add show_fdinfo for uprobe_multi
    https://git.kernel.org/bpf/bpf-next/c/b4dfe26fbf56
  - [bpf-next,v7,3/3] bpf: Add show_fdinfo for kprobe_multi
    https://git.kernel.org/bpf/bpf-next/c/da7e9c0a7fbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



