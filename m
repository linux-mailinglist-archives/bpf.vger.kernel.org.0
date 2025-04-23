Return-Path: <bpf+bounces-56472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32EA97BA2
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 02:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FB11B62317
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 00:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D01F03DA;
	Wed, 23 Apr 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuaYF4a4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0E1EDA36;
	Wed, 23 Apr 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745367593; cv=none; b=mxz5JcwOyYA72SQoZpEGdKfNTZ9ds4TG2k99Jhb1zpIzn8dE/a9tOHAPIzGkmKFiFkHhu6hmas4FSGVlFnHfUjtGZyfzPgLh4nJoBjavollTC1jpkh2mtxz9Bqhlg2wh51Z2X/n+q1Lyh/Dn7JA3uZttBIfCELkov9LMakiXnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745367593; c=relaxed/simple;
	bh=g4wT0br6Q3eKj2Xok4jODJ5FYGVqkxwnEIQSKqaQeVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ean243GOAMWCRdza7SHF4GpQG5Fa4k0xfcpEsjoR7TYungDLaduoY/elIgFMScswlW5pUZR91mcMURW+DxgDij5OBPrR43P8rWrrmbJyGEwwHWtAueEy5fVas59yvmFMSe/64fGeAIFPx5wAV+y293hwSCd9OduNYkUMGb6YpXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuaYF4a4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF94C4CEE9;
	Wed, 23 Apr 2025 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745367593;
	bh=g4wT0br6Q3eKj2Xok4jODJ5FYGVqkxwnEIQSKqaQeVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AuaYF4a4LmETrC4hV+qrXOzzVOrFV3aT2VEhjAlSVKXhY05HlyTifHoS0Zw/iqT1Z
	 wTgSYmLaiX3LyNXwAhJjj1suIanbbDEHkyQ6MrGIcU1y6MLQcVijLgUtEjDlfqVmcw
	 FV7t2QyjjweaJdvn+u2CAl3SYWPZHfH5oH11jg24jpUrJ1q9NABoDIJUfq03dweAPW
	 K3nOqMMZtgQIpab2pByaJw9I7BCX5BspzJCHttIBL6ya4idyLh7AZ+WTUUUV0B7sO3
	 Xrp/Qw8dzQ9RpL5nlNB2VxqRZLIj0BXUZDpsr2Rd16tD9b4HLQLoiqG6TlHrbR/6Wa
	 9M2MYkWh1fbbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0C2380CEF4;
	Wed, 23 Apr 2025 00:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/3] libbpf: Fix event name too long error and add
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174536763175.2096010.2128821424847053296.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 00:20:31 +0000
References: <20250417014848.59321-1-yangfeng59949@163.com>
In-Reply-To: <20250417014848.59321-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hengqi.chen@gmail.com,
 olsajiri@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 17 Apr 2025 09:48:45 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Hi everyone,
> 
> This series tries to fix event name too long error and add tests.
> 
> When the binary path is excessively long, the generated probe_name in libbpf
> exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> This causes legacy uprobe event attachment to fail with error code -22.
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/3] libbpf: Fix event name too long error
    https://git.kernel.org/bpf/bpf-next/c/4dde20b1aa85
  - [v5,bpf-next,2/3] selftests/bpf: Add test for attaching uprobe with long event names
    https://git.kernel.org/bpf/bpf-next/c/e1be7c45d244
  - [v5,bpf-next,3/3] selftests/bpf: Add test for attaching kprobe with long event names
    https://git.kernel.org/bpf/bpf-next/c/9b72f3e5b760

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



