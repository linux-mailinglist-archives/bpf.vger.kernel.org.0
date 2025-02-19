Return-Path: <bpf+bounces-51988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2FA3CB20
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280C31894E77
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D1253F0B;
	Wed, 19 Feb 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+NXjtL9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF610253324;
	Wed, 19 Feb 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999435; cv=none; b=kL0fw8EK9Ukwp3+kWHJxfyt/IDhSwZgJl9ERng36G0v+fsyhGIJJ6lTGH81QyeLsecH3lKnpSyRj9KhIv5aYybvxO8P3y0UuJhH6rWMwt/DJasj5xMnE+q9Lsjjlgy97s3BX6JRDdJ60+ZFzV8RaFEF2d1nKIcM+OoBAfrCCF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999435; c=relaxed/simple;
	bh=0xRRSYQ1OmGWI7IlCITRJ0+pJBszPQXs57yOcBkZxeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F1WgtCedx+PuQhueUnBMr5sZoo3wFMfYQE56gBW9QTnCTGg9obP8MFVdvN5wZgc2/A4qcOVBJIYtf/tYYv7MXbsXVmVQBYaVgRSipPRP8oY9wVoMx0ADQdg+neNMlSm/O57UsnvvNIPRCht8i3pgaJVM4ADTKACFWd3HyMUOiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+NXjtL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39686C4CED1;
	Wed, 19 Feb 2025 21:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999435;
	bh=0xRRSYQ1OmGWI7IlCITRJ0+pJBszPQXs57yOcBkZxeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O+NXjtL9Rqjt2fROpQWO6wGGSK9Qo+an29GzSPLFQHJorwLVoixP6XxkZq1H4D0Av
	 U4CtdZLenvc8P7QH/T1d2osz+0V3uESYiJRJl8kX2s4chiy7OUDx8eXjamvkrUPMdy
	 dG6zbtNQlByd8lBo7w0mmyqMDOR7vE4udEoSJthP2VcDctZSCMbS6VHebfQSitWXhT
	 7g9Bm+ixoBxI3AuzEEcXG7bhXul1UCcv+cGEEqF0RbL4NdROcFuzO83zgpOrCnygEP
	 wl/BRnS6A0OdKc02lBJLkrKb2k2ysxb9HXD+s3KkBBJMIRDzvc4U7p0jV4lXFzwLaq
	 Q9oxv/Tn+ahMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0F2380AAE9;
	Wed, 19 Feb 2025 21:11:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: support setting max RTO for
 bpf_setsockopt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173999946560.749158.5665115901775500511.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 21:11:05 +0000
References: <20250219081333.56378-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250219081333.56378-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 19 Feb 2025 16:13:30 +0800 you wrote:
> Support max RTO set by BPF program calling bpf_setsockopt().
> Add corresponding selftests.
> 
> Jason Xing (2):
>   bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
>   selftests/bpf: add rto max for bpf_setsockopt test
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
    https://git.kernel.org/bpf/bpf-next/c/6810c771d316
  - [bpf-next,v3,2/2] selftests/bpf: add rto max for bpf_setsockopt test
    https://git.kernel.org/bpf/bpf-next/c/7a93ba804847

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



