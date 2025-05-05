Return-Path: <bpf+bounces-57381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2194AA9E2E
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566A91738B1
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD1274FC3;
	Mon,  5 May 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8YnpFyw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39D2749EB
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480594; cv=none; b=L3cPH1Z39uHHukb7rFK9y3ITp/Ow7aXhhL+KVcCNn0H7+wyrF93QdxfCjNRdGz3PzibUIauFZBD4oRlOkhSalSq+nPt0nKamDEkd5cp04gYDHXuezX0ZgQfZFBlWeQY3csWJNc4Of+tf1ZdX/o8yPddaTJ8hXH4NdzLTivOrUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480594; c=relaxed/simple;
	bh=a+fzC36CgEtRedHuHKFuZIfZPYXcVbGz7xZCn72Kd/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pAkpJP/5aeW/a2+jxXpWlP0BoBnfq7jUduTqKIc+kHWkXitZ8XwvZiAu6oH9k5V8NzNZGiwm+ojU/EJl9FuySxLuAo+sexhEbRx+eTCw31FLY28br8OeSQBlyX6oTlg7m/fEi/YF7pBuxZkGt7jaSDc5IcCmXc8ar/OiYecSUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8YnpFyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6EDC4CEEE;
	Mon,  5 May 2025 21:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746480593;
	bh=a+fzC36CgEtRedHuHKFuZIfZPYXcVbGz7xZCn72Kd/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E8YnpFyw9ogwcybS5KF3nMTGbZzNlW+3Yol+t3ApA1E75HLNO+7NN0BO43G1mXG+n
	 MOsajW53B/3hmov1MP3oj6oMyjcVY82L+leUzCCZ6/stRBkxOY0RtH0ctMN0qfcPQX
	 Q1vwgHBPN98krFOaxlCJ/AoWzfZDuCkfy6Vc4ZvVr20ke7uJg13Wc3rj7pIu9pOtPX
	 yumFHn3pl8gsdv4MlyOZ8AXHxBeKG4j9cBvpqviLAAlmXYmFsyJ5cR66Ck7RzTa5Qb
	 /WnFiyayQUH3tv1lE4i5AMbPiIlfJTSn4OsTqzeEv2+OCLGnrqqIkJHV/Ttp/cMJ0L
	 3UfeRn8hdXCMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9B39D60BC;
	Mon,  5 May 2025 21:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next] bpf: fix uninitialized values in
 BPF_{CORE,PROBE}_READ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648063299.894801.3557081686545846257.git-patchwork-notify@kernel.org>
Date: Mon, 05 May 2025 21:30:32 +0000
References: <20250502193031.3522715-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250502193031.3522715-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  2 May 2025 19:30:31 +0000 you wrote:
> With the latest LLVM bpf selftests build will fail with
> the following error message:
> 
>     progs/profiler.inc.h:710:31: error: default initialization of an object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigned int') leaves the object uninitialized and is incompatible with C++ [-Werror,-Wdefault-const-init-unsafe]
>       710 |         proc_exec_data->parent_uid = BPF_CORE_READ(parent_task, real_cred, uid.val);
>           |                                      ^
>     tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35: note: expanded from macro 'BPF_CORE_READ'
>       520 |         ___type((src), a, ##__VA_ARGS__) __r;                               \
>           |                                          ^
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next] bpf: fix uninitialized values in BPF_{CORE,PROBE}_READ
    https://git.kernel.org/bpf/bpf-next/c/41d4ce6df3f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



