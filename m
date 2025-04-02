Return-Path: <bpf+bounces-55187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F64A79804
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 00:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466E73B1C9A
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0159B1F4CA9;
	Wed,  2 Apr 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfaDzdrO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD7CFC0A;
	Wed,  2 Apr 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743631236; cv=none; b=DonkMnyNhYN7S3Ewi6mUIlq5l9cwcozaPhS3NbB8Yc29hbD8Fpx4pInQ0QfucfwJa7tyy5QTDR/0GUK9iwYMKYBVz+6h1sAP/kwHDO0v/QOSGr1I3P6F5qdIWrBK7XE86Hdt2vhO66H7GvkwfK/Ggdqqv+mzzh6xOFkiHYLZnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743631236; c=relaxed/simple;
	bh=5NFMEr9F90N7WcvGqR37ewUjTZWEjV2cbta9TErRb9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=czAZ4HrzG4CtYE3uzzlVcIfjf4BqhB5TXHF8hbR4+VODPnQTsPhknVtgIySdkrhkmoHJ4YVHALRuqTidhdB+dYe+tgbokmTStgFvSKOLyRt0HyjzPp2Qk4v3QdPLOIkN/FLgg+O+LWKpnA/NiXt4F6zx5RCaDfLkwfjL9oSjfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfaDzdrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A84C4CEDD;
	Wed,  2 Apr 2025 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743631235;
	bh=5NFMEr9F90N7WcvGqR37ewUjTZWEjV2cbta9TErRb9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LfaDzdrOCGPDAzOIGwFrVj9i5ZUeTDxJiwrgnxdiFzypOZvaFiDX83uv2hqx+cp07
	 7xOjvdEqghnM0QoZbIt5uJI8rHiSA7OVFx1YvmlRXDmmIR8+gU3kNXIuj/HG0lnasS
	 zeguElI4bJZu07DqkiCmlvkYdSl8BaVlFPkwDKRGBHKkod7reID4bdHu+8E3OPgdQg
	 MQZkOK4I+y2gtlIDghozUprDOMx9jOxwZBotI7JCSBDuqb3mnBz3F2bS0oz9LldwMB
	 QOpbqnh8W3S7imMcgqTOu7aB8AFyvn6jIh7kre7ntX2V7uvmHmQ8GRJ3HeV9fTggzr
	 5q/8bffScVkLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB973380665A;
	Wed,  2 Apr 2025 22:01:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mm/page_alloc: Fix try_alloc_pages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363127276.1691717.9312096960990925926.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 22:01:12 +0000
References: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, akpm@linux-foundation.org,
 peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de,
 rostedt@goodmis.org, shakeel.butt@linux.dev, mhocko@suse.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 31 Mar 2025 20:23:36 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fix an obvious bug. try_alloc_pages() should set_page_refcounted.
> 
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - mm/page_alloc: Fix try_alloc_pages
    https://git.kernel.org/bpf/bpf-next/c/2985dae1e521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



