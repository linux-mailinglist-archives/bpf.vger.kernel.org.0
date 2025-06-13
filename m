Return-Path: <bpf+bounces-60573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B56AD813A
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50DB189862A
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04567242D64;
	Fri, 13 Jun 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjhcKUIk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579B433A8;
	Fri, 13 Jun 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783003; cv=none; b=FBD6OCqh4NfK/mYiJF/ow/tlx2+MK+gozU8n+EcpxIP97Tw0GdUWOu/pj1xM7gWvXCua7yeM52ljlfxfEyYQqpU+uJFugT8s8TYeJm2Qv6IUmj1hv+qRCUpKJnQFDV637khmLVvVr+Ypbo7ziiRKm3t3sGg6sP6ACYojaUs3P78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783003; c=relaxed/simple;
	bh=NGlagSnJ4T/MF2hIBZ8ka35d70cJhY8BeilcrfmgwlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DNbwGKaJ7aQXFsTcGRrdfL/BxecBz6f1m3ZgwmPhjKg+fEdNno+7AynMGk5WqNiIpfRq5mah5y350awcZuEWYk1dfw7EP3lNoInQol88U1vj6jxJmxI5yRU5Nvdj26fEwttwceLfHwE9uQphhZr8ZPa8r15DS9WSULgftZy/qM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjhcKUIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0747DC4CEEA;
	Fri, 13 Jun 2025 02:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749783003;
	bh=NGlagSnJ4T/MF2hIBZ8ka35d70cJhY8BeilcrfmgwlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gjhcKUIkIvw0aFZzmmButMRI0Y6RX6YuRIpPhv/glNpgj1Vzj7nEjZn+LttDIR565
	 n5ejnM3KxJ82r9Rf2tSVyQ7+bqBghW7ufCrtNGxjfAumvNJuQ13okOlmZfJ9qXTjLi
	 QqcfrNcb/Fy/G++2kc6DglkfXAalHBxZxQzWuiF0MQ7uYnwRyG/xYpKnYUppgBoL1G
	 Y7UJC1Z86RN52cf4tAPiHuqagFx7/jvoOGVCvnY/InDdSAHFhbfrgYVyLN8PBPJUq5
	 RqHFts+KCuF6DrQuLVctQgkkL0I6TqRC+kbX9/u/hjpkL3T5xBLX1CLu/W8scJZlQF
	 IcRJxlIrKXRMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3739EFFD0;
	Fri, 13 Jun 2025 02:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] xdp: Remove unused events xdp_redirect_map and
 xdp_redirect_map_err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174978303251.199960.6452866597649393391.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 02:50:32 +0000
References: <20250611155615.0c2cf61c@batman.local.home>
In-Reply-To: <20250611155615.0c2cf61c@batman.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Jun 2025 15:56:15 -0400 you wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Each TRACE_EVENT() defined can take up around 5K of text and meta data
> regardless if they are used or not. New code is being developed that will
> warn when a tracepoint is defined but not used.
> 
> The trace events xdp_redirect_map and xdp_redirect_map_err are defined but
> not used, but there's also a comment that states these are kept around for
> backward compatibility. Which is interesting because since they are not
> used, any old BPF program that expects them to exist will get incorrect
> data (no data) when they use them. It's worse than not working, it's
> silently failing.
> 
> [...]

Here is the summary with links:
  - xdp: Remove unused events xdp_redirect_map and xdp_redirect_map_err
    https://git.kernel.org/bpf/bpf-next/c/a9a5f41b04dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



