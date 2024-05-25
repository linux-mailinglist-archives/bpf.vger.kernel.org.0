Return-Path: <bpf+bounces-30595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FFA8CF095
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C31C20F8C
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1D1272A0;
	Sat, 25 May 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBGL2reV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459F85934
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659432; cv=none; b=kDuLZJjBN/D/ROBOYghpFMH92Q5Ecp1S051UMqzbsIHlpr8DWvw0gqidBzMBYXJETOSRVWkBfMFc9Dn8PKPWJVnovwW0TopV6ylfSlI+80IV/+CRsQ825s8B0jNeoiJSr2/pLORKi/RRV1hv3R9UJauQe/PzivompYUGjCztCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659432; c=relaxed/simple;
	bh=hCkznmaAgLnkcfUVo3YOftwDJRio1M+oTAJtlzMy4Mo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t11KZWXnfIP6yK6HthvMqX5o6WvVxM+AUGKCoYzTaNO0BwsUTnYuzzoUeluj1FinKifrI1WOoX6fhmeHGh4RCm7xIxASfk7e3Bwej5yKd00A92l0cMJnzmx7RE9hyl8FTDlTc6JXa3hTU+fYQd50qHsakn8gPYTpfcNo9g5weX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBGL2reV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3398C2BD11;
	Sat, 25 May 2024 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659431;
	bh=hCkznmaAgLnkcfUVo3YOftwDJRio1M+oTAJtlzMy4Mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mBGL2reV19AqiFoyfE6Bi3hxyhqQ1E+gf3giBVsS77yQrql/SB2+aTfMSdZovGwNh
	 ihPIV1clZJtevEg+bY6XhxgLgq/OHkqw/pdptHbgMioKbZa5UU9iedtypKx70HZB/9
	 5OsLEbaohLpW97rURceBXqEt3t2wuCxhx1a5LqtDKBeNCAgl8Ob6fdrJ95C7q8yl7u
	 CmDgnfFxsej/0qOh2LWPTcGqNoeKpy5RSV+ZdKkNhDzvBbxcszkp40Wkp+ZyHDiz2d
	 uQGOYLmcNDCduN1n7T1dbO/bQrHullcy69/2dpBmOPSxZHh1VVR4tL6uZXte6rX0DM
	 x35TRWT+MkWCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B90E2C54BB3;
	Sat, 25 May 2024 17:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 0/5] Fix BPF multi-uprobe PID filtering logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171665943175.11416.9298090720554703908.git-patchwork-notify@kernel.org>
Date: Sat, 25 May 2024 17:50:31 +0000
References: <20240521163401.3005045-1-andrii@kernel.org>
In-Reply-To: <20240521163401.3005045-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 21 May 2024 09:33:56 -0700 you wrote:
> It turns out that current implementation of multi-uprobe PID filtering logic
> is broken. It filters by thread, while the promise is filtering by process.
> Patch #1 fixes the logic trivially. The rest is testing and mitigations that
> are necessary for libbpf to not break users of USDT programs.
> 
> v1->v2:
>   - fix selftest in last patch (CI);
>   - use semicolon in patch #3 (Jiri).
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/5] bpf: fix multi-uprobe PID filtering logic
    https://git.kernel.org/bpf/bpf/c/46ba0e49b642
  - [v2,bpf,2/5] bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic
    https://git.kernel.org/bpf/bpf/c/4a8f635a6054
  - [v2,bpf,3/5] libbpf: detect broken PID filtering logic for multi-uprobe
    https://git.kernel.org/bpf/bpf/c/04d939a2ab22
  - [v2,bpf,4/5] selftests/bpf: extend multi-uprobe tests with child thread case
    https://git.kernel.org/bpf/bpf/c/70342420a1cf
  - [v2,bpf,5/5] selftests/bpf: extend multi-uprobe tests with USDTs
    https://git.kernel.org/bpf/bpf/c/198034a87dfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



