Return-Path: <bpf+bounces-70550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C375BC2E24
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 00:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7FA189EA79
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F4258CE1;
	Tue,  7 Oct 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It/Y0xhT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB523D281
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876842; cv=none; b=PfPzHiCLoHe9ra/PGZ30xHzPyluIIQvTZ/zpvuHiwDiUMRsYHYa3xN+L62+dWftszh6p0eFgQk3bDNgYmyESarnmJVZZd2oFh3C1LleK5msY0IAeXhjdmUZ92RkuD1/rDhUygvDg0E8m2AaQToz7+WeHm4sf9IAJNOtjTwSi7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876842; c=relaxed/simple;
	bh=LjvmVNMM3wxf6FqRUWUJzcgTJh5yQKEFyFf1W8v7Iws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cy0CIUrs2FmZgfH//B5gXuCJNgYx99OJwWBlt8bV/+1NvZVX6vUly6ysmnoN/lEzKDmIzMS6dKTVnO1hp6gygLuh/V35PrKnLDrrdKo7f+lDqSoodTcnpWDp8ctE1QBEZybZhJAvNywdWbZ8doyMJzYPIwXE7WPsKrzosAZjNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It/Y0xhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF04C4CEF1;
	Tue,  7 Oct 2025 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759876841;
	bh=LjvmVNMM3wxf6FqRUWUJzcgTJh5yQKEFyFf1W8v7Iws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=It/Y0xhTa8YAOzXOh7ax27mbk/KkrK31QBm9XZ1+hj6QPJ68EeLE2mHq08TnMXec1
	 2+xQiH7a54QILY9xEQ6o2B+G3p1jfXPPF7selJ4ZW1Oru0yoFMNWmeXKmXx3YjCOB6
	 sHra3tJZuSFilkglJOWLzGIbTqzQQvx9fjz7ECz/Qj5dDopDLTYirOq9W+Tnqkpr9S
	 juXfDgwETFp5Whg9nJ5EZM3/1+DcjV35z9mgJBa+fNAWRyxsFZwDM2sQd5UWOxLltK
	 QYnMU/kLT4CBYKgNGhUpWjxrHwwjQjAmca+1DEo6IxBmcHZSEeR0L3g2CxWuAEtWbz
	 CFMipD9Exo0ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DA5E839FEB7E;
	Tue,  7 Oct 2025 22:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Cleanup unused func args in rqspinlock
 implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175987683052.2810832.13268230032122706620.git-patchwork-notify@kernel.org>
Date: Tue, 07 Oct 2025 22:40:30 +0000
References: <20251001172702.122838-1-sidchintamaneni@gmail.com>
In-Reply-To: <20251001172702.122838-1-sidchintamaneni@gmail.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, memxor@gmail.com,
 rjsu26@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  1 Oct 2025 17:27:02 +0000 you wrote:
> cleanup unused function args in check_deadlock* functions.
> 
> Fixes: 31158ad02ddb ("rqspinlock: Add deadlock detection and recovery")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  kernel/bpf/rqspinlock.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: Cleanup unused func args in rqspinlock implementation
    https://git.kernel.org/bpf/bpf-next/c/56b4d162392d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



