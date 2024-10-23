Return-Path: <bpf+bounces-42962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4169AD6F1
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0952A285752
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE741E32D9;
	Wed, 23 Oct 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb3M2qbo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0F22615;
	Wed, 23 Oct 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720224; cv=none; b=m7GBZxK85PMN+C6DZsFUGqINXkdq4/HBTthaLDWFV7Na5/RSLEIuhG5ZWoWqVkJtSrqpRXCDte2r4P+kjcn55Xo3Ip6D2rrhBSvVaExHXAt/ivdUkx2xg41RdSzjU+aASZYGQoY57pReU78tPG7UpHJvhuUJvvKutcRPsUFZmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720224; c=relaxed/simple;
	bh=zoHXjjYUvGkMGGOjaB7+mV9MJeemvFfXronJM1vZNWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IsNZIYKyp50Aw1cJnCzhOpJ4nUUG7YtLV9i67/Z5VVmtr28K7fNkJ+v/noU2lUuKBEGgU6FiQpoltSdDJpTFDa1peUsMYQJYPkpUMLa1taW/PMXl7oz/d2ZhMjoTQ2zPCcX+UkOsiWzIDuFrBL9qANqEKk4O+I+w86Kbful0xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb3M2qbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B56FC4CEC6;
	Wed, 23 Oct 2024 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729720224;
	bh=zoHXjjYUvGkMGGOjaB7+mV9MJeemvFfXronJM1vZNWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vb3M2qboODOUPM4iq7HYh2agb5iOYhyqdZaWQuCc57r+4FVzIkhnqM6qGwH85wqRJ
	 F4VjPdgDLLxuaFeowwTmLQ7eIf6CRcrMwPj3obTCEut8uwYsnq3CsuZXTdX/pZxCC4
	 n2Mr7KfeazJNenbf1hzQdz22fRNVEMRNZQ4nElPVrOtJszGYSQg4cOjuZhoJRTKtmJ
	 LsnF4EHMjuYEEjFsNt+SI3dpCC62rbc446NIgT9c7ZPkyCzpCyks8gP/GESN0hN6aH
	 /U68yyHlaphdLw2d48Ar62HCddolnwtSHHZH/VibC8a0ytLbNkx1ZA+QdSrk4ZtgKy
	 T1U+QaIVYb2Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8C3809A8A;
	Wed, 23 Oct 2024 21:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Fix -Wmaybe-uninitialized warnings/errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172972023053.1735140.3189800590749495169.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 21:50:30 +0000
References: <20241022172329.3871958-1-ezulian@redhat.com>
In-Reply-To: <20241022172329.3871958-1-ezulian@redhat.com>
To: Eder Zulian <ezulian@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, acme@redhat.com, vmalik@redhat.com,
 williams@redhat.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 22 Oct 2024 19:23:26 +0200 you wrote:
> Hello!
> 
> This v2 series initializes the variables 'set' and 'set8' in sets_patch to
> NULL, along with the variables 'new_off' and 'pad_bits' and 'pad_type' in
> btf_dump_emit_bit_padding to zero or NULL according to their types and the
> variable 'o' in options__order to NULL to prevent compiler warnings/errors
> which are observed when compiling with non-default compilation options, but
> are not emitted by the compiler with the current default compilation
> options.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] resolve_btfids: Fix compiler warnings
    https://git.kernel.org/bpf/bpf-next/c/2c3d022abe6c
  - [v2,2/3] libbpf: Prevent compiler warnings/errors
    https://git.kernel.org/bpf/bpf-next/c/7f4ec77f3fee
  - [v2,3/3] libsubcmd: Silence compiler warning
    https://git.kernel.org/bpf/bpf-next/c/7a4ffec9fd54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



