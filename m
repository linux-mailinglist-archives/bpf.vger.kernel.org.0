Return-Path: <bpf+bounces-49636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD8AA1AE63
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC2C7A495B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 02:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133C1D63D2;
	Fri, 24 Jan 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILVOrO+w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6B1D61A3;
	Fri, 24 Jan 2025 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737684006; cv=none; b=d7f9SFpM0AARzSrP1hZCg7ar1mmcbBnzfDodUShRfr4NZFdrhvQAqvRXDr4EdbzyyNXBDXmSeQ+5RudOhWcr6uN0IrW+qfktS+oNAsJWXSHPP98Uh8i0DejIx04dzJmIsYWMlitPaxRxJosVcy2M/Kym25n7WjS8yWZUWbWTSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737684006; c=relaxed/simple;
	bh=a1KRwH8RO6ZTwL4G9IZHP24SRXiGkZVnIvMlezISNzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJJ8mDkIHRXXR7rTW2k0KDZutIeJvn0xyWDXS+7zpKek5JPg7E+KeWxRgiWW8FehTePevT/Ihg9IGqmhAAWX3tNFqal2p3dzoWWmt3Fdik28q00YZRwirAz5joMf4LT10agVDaLdpPfeOWfqnLA7zS+ciXrAHjFFCLXNJMXiydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILVOrO+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD325C4CED3;
	Fri, 24 Jan 2025 02:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737684004;
	bh=a1KRwH8RO6ZTwL4G9IZHP24SRXiGkZVnIvMlezISNzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ILVOrO+wwJ8OMuZwYMxo96KUxj/8Wm3PqWIW+3bzQAdk33v8xAYnyxLJ1TKFfnSI+
	 O7A7FQ4T4912NMt1Di6muLAAYyQE62LdRH16jvLhz/plLaUaUy9ZsghXfdkJquKAd8
	 OmBWjQfkk2QqtJKUeY5bNPXwdnNmUQJFWh7zyrK6UvXrETSITA2K0Ax1PaHJl4Nhod
	 wzDArJA3GUIqMoXOqMv185QOEmkK/qNaOGehdTnrVe8VrgDmRtXvo4iOcFal96bx7v
	 G6SXDktegRYxROzQE9rw54tj7M7OoALiMKLg+5MCRvOrhdJSh7LxKygPpfvUzvIRWt
	 a4TKVvr+Szk2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE33380AA79;
	Fri, 24 Jan 2025 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: remove unnecessary BTF lookups in
 bpf_sk_storage_tracing_allowed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173768402953.1562390.16117638635222628603.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jan 2025 02:00:29 +0000
References: <20250121142504.1369436-1-jkangas@redhat.com>
In-Reply-To: <20250121142504.1369436-1-jkangas@redhat.com>
To: Jared Kangas <jkangas@redhat.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@kernel.org,
 ast@kernel.org, johannes.berg@intel.com, kafai@fb.com, songliubraving@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 21 Jan 2025 06:25:04 -0800 you wrote:
> When loading BPF programs, bpf_sk_storage_tracing_allowed() does a
> series of lookups to get a type name from the program's attach_btf_id,
> making the assumption that the type is present in the vmlinux BTF along
> the way. However, this results in btf_type_by_id() returning a null
> pointer if a non-vmlinux kernel BTF is attached to. Proof-of-concept on
> a kernel with CONFIG_IPV6=m:
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: remove unnecessary BTF lookups in bpf_sk_storage_tracing_allowed
    https://git.kernel.org/bpf/bpf/c/7569fc94ad0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



