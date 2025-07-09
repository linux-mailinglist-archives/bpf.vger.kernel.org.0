Return-Path: <bpf+bounces-62740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E464AFDD2F
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC0E3BBA7C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B5199931;
	Wed,  9 Jul 2025 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckv6fG6h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA449625
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026385; cv=none; b=Xw+9OS1XhweQ+/b8tLAyn0BdEkHgWtB2DS/B4m1I92h0cbgEQTK1lgVk77ujuQaWZEvlwpkl0Ti7gzpI4ZiBtUpvm7baly20zaeKxX7mA737SEAHkrDC7JDHo5dddJbm4AuJKYY3AfhyVEZOT2MEQOIgUefdrUeRPYuZQTL6QVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026385; c=relaxed/simple;
	bh=U2l2PPYMBpCzq7nFfiwb4RIOQP2ps2QvuHWk8EFNd3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lXdXWqssxg/upRcbBjaMW4dLvOoH/FHS8jfg0N/dOauX1fFUlXHq++diZ2xzokjyYUiCvGVgxamZD+3cyLg417GuJmrotoCsMbc+5jxlBqxT7fweGbulRJv4HF35dSad8PAj1JF/R9h/uiBsB9orpSaLKuOmpz7rPA6Vw/cw670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckv6fG6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02491C4CEED;
	Wed,  9 Jul 2025 01:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752026384;
	bh=U2l2PPYMBpCzq7nFfiwb4RIOQP2ps2QvuHWk8EFNd3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ckv6fG6hW1J2QLF0JdPedBATsdWXVRtWA4X8Dykc7rETEBD5PZ3TXcuWfrzVb+Tu2
	 bqbEabgHd4e1VxwAoERNUr8hrrjxvt1mfM2HNAF/hoWwvFIeNF7KVb5+nlogvB4BCS
	 TRA7ZeFdjoFGrT9d0FGqA0oqsAtF/wI8gsOT3vIA4N9tf0lH4PCndBVbnLzDEKN43I
	 4OQtWoowq0GuLjTJakxLQ3xA4tMw9ZO735xwxcryjgjGlf50eQnQDGLGl980IhKcgw
	 B864gG0qgYKjYzQTk54OcOyhh9ZaY87hm6NdllARtzpFlQqIWz7qYN8Nwl5mAbGTSh
	 QBMbRus89ONKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC224380DBEE;
	Wed,  9 Jul 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: remove enum64 case from
 __arg_untrusted test suite
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202640668.192708.8030248051047101744.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 02:00:06 +0000
References: <20250708220856.3059578-1-eddyz87@gmail.com>
In-Reply-To: <20250708220856.3059578-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, ameryhung@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Jul 2025 15:08:56 -0700 you wrote:
> The enum64 type used by verifier_global_ptr_args test case requires
> CONFIG_SCHED_CLASS_EXT. At the moment selftets do not depend on this
> option. There are just a few enum64 types in the kernel. Instead of
> tying selftests to implementation details of unrelated sub-systems,
> just remove enum64 test case. Simple enums are covered and that should
> be sufficient.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: remove enum64 case from __arg_untrusted test suite
    https://git.kernel.org/bpf/bpf-next/c/ad97cb2ed06a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



