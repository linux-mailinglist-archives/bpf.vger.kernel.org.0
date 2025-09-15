Return-Path: <bpf+bounces-68409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D9B58373
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 19:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F6B3BF9D9
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19F27A103;
	Mon, 15 Sep 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnuSe5yl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47755284679
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956806; cv=none; b=nBgvhYvfweD8/OhDqUA3FzTjCWOqmUIdRiEpdbh8P7lVy2lpn9zhlCWxXjOaHDEuW6191U3lv85coLiDU0fBb6cjvRZABE5SjkRz9I0MblIU1MWVhEyRZmNYCrE53QFp4zxYVcIi8W8VuWrzlwNmncy3RbwF2Vw0EqKJS8Pdfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956806; c=relaxed/simple;
	bh=ihRwLNewiuKcQt5FHktIIF1XM4ddwN8YJfB33xf4Rxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FofCIj4YpEWWE6+YcjrIUsC4O4+voeydQpPRt0ibeauuRnAb0JM0uwUcs7h9yYFN8OBD6BsKaNhxyDMmi/jFpRwtFZkHl9wEBwhxErvKEO0AxeV6Dt6AS+1ZLT9KaV60ckTFBdCukRIGbf6YDlxL91JmvDF5Mq6/RYLf961mr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnuSe5yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03FCC4CEFA;
	Mon, 15 Sep 2025 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757956804;
	bh=ihRwLNewiuKcQt5FHktIIF1XM4ddwN8YJfB33xf4Rxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cnuSe5yleDARQg9G+PuEsuCQ3cGEHcZ8sIVs1FNZvG/Iu1N8Be8rKfcjjah9ilMpO
	 YcDrKQ2hJtbQQpB8fGYNRVC3Y0Jckn9HJm5nDOucHjo1aBVbc5UihRGK33/QPUiew0
	 aTOWHGb8ZE1UofKkl455MCUF8ohfcUAWrqc+0+e/+45S6TP8U7kirasqVXpF/QDmyd
	 tDPraq7cEoh1lj5hc6bdOuv817k5lYdad/Ja9Myc78uNycHn4gR8VyWKLL9iyX2jo+
	 AW2boSacJz++3tsIq3bsHjQu0YNJ0L2qBWFa0/XWde3fUbMBLmVQSwcTXKY1uCbRGY
	 EYXKWgn+ahEBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F5D39D0C18;
	Mon, 15 Sep 2025 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: Search for tracefs at
 /sys/kernel/tracing first
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175795680625.66377.14189607108181766320.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 17:20:06 +0000
References: <20250915134209.36568-1-qmo@kernel.org>
In-Reply-To: <20250915134209.36568-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 15 Sep 2025 14:42:09 +0100 you wrote:
> With "bpftool prog tracelog", bpftool prints messages from the trace
> pipe. To do so, it first needs to find the tracefs mount point to open
> the pipe. Bpftool looks at a few "default" locations, including
> /sys/kernel/debug/tracing and /sys/kernel/tracing.
> 
> Some of these locations, namely /tracing and /trace, are not standard.
> They are in the list because some users used to hardcode the tracing
> directory to short names; but we have no compelling reason to look at
> these locations. If we fail to find the tracefs at the default
> locations, we have an additional step to find it by parsing /proc/mounts
> anyway, so it's safe to remove these entries from the list of default
> locations to check.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: Search for tracefs at /sys/kernel/tracing first
    https://git.kernel.org/bpf/bpf-next/c/32d376610bdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



