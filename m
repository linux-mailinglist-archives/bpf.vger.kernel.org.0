Return-Path: <bpf+bounces-66147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF18B2EB59
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 04:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B84A07763
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BD8258CCE;
	Thu, 21 Aug 2025 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgKP9woY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715F252910;
	Thu, 21 Aug 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744026; cv=none; b=mHvvS1lS24PDyHMOaeuecZFLOlfgoixpdGnr+OA5IWWwX1G++Jca0wlpcVm6CygGZeZyTtB5ENzbsWtgOKATZUrjBWoffdwGJerPeDEhBeHL65dsNw7mTvH2m3xyltR9kIA7vpVLUssg5QANEtceBsZDZoBi0RdyKDAxLbyc9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744026; c=relaxed/simple;
	bh=9o/c4Ykf1FXVHZSL8h2+vsayOJyjbxiOwpDKgqJnfWc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RunyoHjhjPLyAvtMZcUovISjqWHcLO44jLgTrwVtX8tOtKafyn3TuaSzBTwS48W54jyF+KP0P+xNXDbaRPGoamPYozefNUwol8MhqeR49VyTpXj0dtmiUE1YKqz1UxuNxb8q1q/xAkMVZ8BMeGpmlII4UWBFozJ/pC0iqBQ0Nng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgKP9woY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54266C4CEE7;
	Thu, 21 Aug 2025 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744025;
	bh=9o/c4Ykf1FXVHZSL8h2+vsayOJyjbxiOwpDKgqJnfWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jgKP9woYL27+rNaY9DgTwkEX+Wg9JZgEHo0dpF3zjC8QOhUVeRRaZBldyuS9n064O
	 Z5/mNN0z55Q5N7A0+CCDWPLQal70NwmGl3+ArepfWasZcPBHfFFn06lWo7ymRJvvwh
	 YJ8D+K5vagggWfJRO3ftI+D8dwoSZQvd73Sc3hMPb1djFg+4o9AcO2GG3Sbz/Z1Gtm
	 l5HnlrzMb6Jia9WSAPE2Yvthh3wv89f7ACs7/jrbA21piAuX0uMu2nNJXlp+doeeep
	 /bmQyh/tck6D3F3vWRCsYF0rJOgzqd2Ltmh6noF/+getuyly1qHZYfpguoxtAq4Pu5
	 vtLbEhvkw9G7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB03D383BF4E;
	Thu, 21 Aug 2025 02:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: bpf_offload: print loaded
 programs
 on mismatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574403449.482952.12532476837961479515.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:40:34 +0000
References: <20250819073348.387972-1-liuhangbin@gmail.com>
In-Reply-To: <20250819073348.387972-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bigeasy@linutronix.de,
 lorenzo@kernel.org, andriin@fb.com, joamaki@gmail.com, jv@jvosburgh.net,
 andy@greyhouse.net, corbet@lwn.net, andrew+netdev@lunn.ch,
 razor@blackwall.org, toke@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 vmalik@redhat.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 07:33:48 +0000 you wrote:
> The test sometimes fails due to an unexpected number of loaded programs. e.g
> 
>   FAIL: 2 BPF programs loaded, expected 1
>     File "/usr/libexec/kselftests/net/./bpf_offload.py", line 940, in <module>
>       progs = bpftool_prog_list(expected=1)
>     File "/usr/libexec/kselftests/net/./bpf_offload.py", line 187, in bpftool_prog_list
>       fail(True, "%d BPF programs loaded, expected %d" %
>     File "/usr/libexec/kselftests/net/./bpf_offload.py", line 89, in fail
>       tb = "".join(traceback.extract_stack().format())
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: bpf_offload: print loaded programs on mismatch
    https://git.kernel.org/netdev/net-next/c/eacb6e408dc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



