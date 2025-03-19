Return-Path: <bpf+bounces-54355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC5A6831F
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 03:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3681F189790E
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6039B224898;
	Wed, 19 Mar 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS6tJYOL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97151EFFAB
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350797; cv=none; b=tKbOJmJt4JyWrY1ILmtdQf9g1kkPmyBJX1J6TS8LN666SSRQKvKIh/0ga0hEULfNsTFD6Kht72Z+y/GehGvDQyyyXQ4x+bBp253nrXxADV+jutF8eY2umLYEz57CoW1w9t3BWhDPl6gXIELoWSIFUvrpJLyXZQgWtcl19gSBgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350797; c=relaxed/simple;
	bh=ufnlsRt+ZS/9eCet5AlvD6XNKqva91juFVldNeP1mT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vFvjcBArfaQHF9rffUmWvsg5Q05hAHNus4o9JrqavcnEDZufA4TKnTIRPe6PPJl0ecSNVDRYGkAtxLGdIDwMi6c/ci2wlyeGfuaUKH1mQ4wy0coYuSxgsJQnvcCv0OXs0f9zcVWb69ExCZvoHI05lHkuYLSCVJx7FLOsClgVrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS6tJYOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5404C4CEDD;
	Wed, 19 Mar 2025 02:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742350797;
	bh=ufnlsRt+ZS/9eCet5AlvD6XNKqva91juFVldNeP1mT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JS6tJYOLw16Ye5dwXgYx3uzzFws5U4exjCPyIvIsGLU/tWLBQIoOUXhgokjfx2l+y
	 OW4TAIfaxMaLr3ImaOVbJDxlkX6CKCCjw05mNI1gCFkkKypV0G8XGAR/nkWQjIK0vk
	 BLh9p7SSbsoRRQdbckn4/kSYjevBocPIMf4bFLFGBPT7IMvAnO5Cnm9eJUPhdSbjmr
	 3OICB+3f71OBlX1UewWSHYF3oPELQdzFbqL1ouiWCze1qf7DFRisR+eZxtvZU4JkDj
	 tWJaGZlVvOb09T81FfQWjxzE1IluzWU5IzwDOQOrVmU7dsbmzoNIsvnZ4dG6BYaaz9
	 LM7VXZFYyUovw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719DC380DBEE;
	Wed, 19 Mar 2025 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: clarify a misleading verifier error message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174235083326.538922.12977081852338669711.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 02:20:33 +0000
References: <20250318083551.8192-1-andreaterzolo3@gmail.com>
In-Reply-To: <20250318083551.8192-1-andreaterzolo3@gmail.com>
To: Andrea Terzolo <andreaterzolo3@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shung-hsi.yu@suse.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Mar 2025 09:35:45 +0100 you wrote:
> The current verifier error message states that tail_calls are not
> allowed in non-JITed programs with BPF-to-BPF calls. While this is
> accurate, it is not the only scenario where this restriction applies.
> Some architectures do not support this feature combination even when
> programs are JITed. This update improves the error message to better
> reflect these limitations.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: clarify a misleading verifier error message
    https://git.kernel.org/bpf/bpf-next/c/a2598045ead9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



