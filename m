Return-Path: <bpf+bounces-46564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1349EBBE2
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807F91686D9
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F590232383;
	Tue, 10 Dec 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I30opVH2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF51A9B4C;
	Tue, 10 Dec 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866213; cv=none; b=JY47kzNooaqDpCxVSYwdHnrIa6yQ4P5RB9qHejXNmDnoP298eBoOyJtK2TmXha37nByIZ95Wmn27x2/m1FP4QZ8PGX0ORMwn92nvhP5fgeaNJQWfFShBkfel5yLd/MQZmZdAUq1JHFEex37/njnJRKCQN2Qj6OUOt97ya6IzC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866213; c=relaxed/simple;
	bh=0lZbsLOWsSFXO9/XROl+6h/zwNLHDgoV4fTZnYifFJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZq6PYJMv+h8sOdYEguOTlodaanTRMDzzJ4AShX8pIdXLhECm2BTMS9d9I/f0jtGL2hZuN4/3SOjjf7MYCkoJxR1sqZxcCQ0SKplXpVvUS/0AcYWW5gr7epNZLrnGPLaVf0zF/yxlq8tFn5YtyCF7XCOFOcKmeMBDnQdiHKh7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I30opVH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8BFC4CED6;
	Tue, 10 Dec 2024 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733866213;
	bh=0lZbsLOWsSFXO9/XROl+6h/zwNLHDgoV4fTZnYifFJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I30opVH2PrhRNYeiNX501q8UlQ/6e8P3I/ykGk+Knu97pEU95ZNGw7XQ+5NI5/Jej
	 /g27joRzZn9f0cQelQOPCW70Wb4fqPK+WNd6RtN6T4CSYU9Ac4lGaE0oBU1rX2aPS/
	 R5nkq5XDYXIXzH2P8kO4vzVN7n8hUZSmXI7hurfZgGYQLggFWDCRpVn0DZhSnTPhx1
	 uvOO4EwFz2GHzLZECYbqD86rvBFOZ9zct2rPBcJ7Iuj8OOIqDv6WvgmFf0MA6jJYK4
	 qnSs/3pkxsWlP4EDA4cG0VCfDO4TQLPud4+bZ5nyMlV/SR918IW0NC/JNnqRN7QQTG
	 39cQyLxG4VjtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346F1380A954;
	Tue, 10 Dec 2024 21:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] bpf: Fix theoretical prog_array UAF in
 __uprobe_perf_func()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173386622902.984066.17756652143302232987.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 21:30:29 +0000
References: <20241210-bpf-fix-uprobe-uaf-v4-1-5fc8959b2b74@google.com>
In-Reply-To: <20241210-bpf-fix-uprobe-uaf-v4-1-5fc8959b2b74@google.com>
To: Jann Horn <jannh@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, delyank@fb.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 10 Dec 2024 20:08:14 +0100 you wrote:
> Currently, the pointer stored in call->prog_array is loaded in
> __uprobe_perf_func(), with no RCU annotation and no immediately visible
> RCU protection, so it looks as if the loaded pointer can immediately be
> dangling.
> Later, bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical
> section, but this is too late. It then uses rcu_dereference_check(), but
> this use of rcu_dereference_check() does not actually dereference anything.
> 
> [...]

Here is the summary with links:
  - [bpf,v4] bpf: Fix theoretical prog_array UAF in __uprobe_perf_func()
    https://git.kernel.org/bpf/bpf/c/7d0d673627e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



