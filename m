Return-Path: <bpf+bounces-39085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AAA96E6A2
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 02:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024D61C23221
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAAF15C0;
	Fri,  6 Sep 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/v/i6sC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95811EC2
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581434; cv=none; b=aXBbbXBPtFA7BliesHdcBb8MLxIo9vlzFdz1mQGqJUlHz3xyhVv96n+R9uM8x6EvWXfL+54yZ9B7j4K/H1IkSGFAErDehpdkbqVs7gAjcNIxrwYC8QxEvnlJTtkLSGvXC1ZwSZhnfcVvQfy8r7xAZdGVj47mwz9jj6lX3kLjWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581434; c=relaxed/simple;
	bh=Kk6gD+CZK+G1iOzzAfU3O6J/3K5FhtrMBnIjH/oL64I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kw0lmveWUOzgSZdysWI4bUTp0qTeDsxxm2X2CDqTRIA7EaRSVtHu7M3dnhldwS1eb03cqc27X6KomqOHPaLQlXjz25bZUOdS2RuCZYy8Ri85lPlwluoq9y7Bm35zjAX+7Jce5LHrgu9w5LRlnJ07WJNCcMAUAY8sJjzqiCMl5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/v/i6sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257B6C4CEC5;
	Fri,  6 Sep 2024 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725581434;
	bh=Kk6gD+CZK+G1iOzzAfU3O6J/3K5FhtrMBnIjH/oL64I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/v/i6sC9M9To+yP8fVrfFc0Y8iH8480RvhLf+s8Xdsp8JUzLDeNKCCwXXs76D/C0
	 jW44cn0vJPkWo4gYYqlg9EbD2SeGuKay4OjZzcY0rpQ69HUnEcsClafod5mnZn+pB1
	 PgD0iIWrYA24NcZyxZs9Nx3Z7TDwz+k4Ow1baQpmssT9MTyhYqglmf0QGKWZOjftsQ
	 fNwTKFb9drf5rldZOC6M7+woelvr7w/e8uB7Wl19R5tcvntRCWwX+EhTxacaAt6RMe
	 5IbFBTksTAVjAAnJxT0xRx+PF0ft5QYUin8xiagunfHc2XB5GT1cKJeIhmlAtDPh8O
	 aq6LctFywqj6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340103806654;
	Fri,  6 Sep 2024 00:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] allow kfuncs in tracepoint and perf event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172558143499.1881463.2654494687672084301.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 00:10:34 +0000
References: <20240905223812.141857-1-inwardvessel@gmail.com>
In-Reply-To: <20240905223812.141857-1-inwardvessel@gmail.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Sep 2024 15:38:10 -0700 you wrote:
> It is possible to call a cpumask kfunc within a raw tp_btf program but not
> possible within tracepoint or perf event programs. Currently, the verifier
> receives -EACCESS from fetch_kfunc_meta() as a result of not finding any
> kfunc hook associated with these program types.
> 
> This patch series associates tracepoint and perf event program types with
> the tracing hook and includes test coverage.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: allow kfuncs within tracepoint and perf event programs
    https://git.kernel.org/bpf/bpf-next/c/bc638d8cb5be
  - [bpf-next,v3,2/2] bpf/selftests: coverage for tp and perf event progs using kfuncs
    https://git.kernel.org/bpf/bpf-next/c/1b3bc648f506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



