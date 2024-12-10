Return-Path: <bpf+bounces-46539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A89EB953
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DA7166C7E
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F41319E971;
	Tue, 10 Dec 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfICpRmd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5BDF58;
	Tue, 10 Dec 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855416; cv=none; b=tO4q50AiKTfX1bIujygV48ZRxazqVUzMol4RyLlWU5seXh//GkHX2nUTtP5++3SE9VTs2VDisCptEnd2FZPxnq5v5IkKvDBLrqGOKJplLjxUfWvqqbeS6PMXoBiAt9+S4+qrzlqZMXCC5xBLxliPjQf9Bplq3dJi7GeHdCGu/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855416; c=relaxed/simple;
	bh=jXIPBO8rBfEr3t5k/LZU4uYdY0/haRq+iVX3DtOR7ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UcBM/nTIlm06l720sw0M1MLk52omInpqi+vw8nwc3pQy3ZD8ET3sbv2iS3I8qJAcLzExJR9MLpPOK90vJjOxTrdpgNIFigC6Asp/5SzOgQOZc2vwi9/nKhYs/d52/geb27zMYv7ob9VHL84LBhbCHIZrXYGVtUKBUFk2wlj0wLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfICpRmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BE8C4CED6;
	Tue, 10 Dec 2024 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855416;
	bh=jXIPBO8rBfEr3t5k/LZU4uYdY0/haRq+iVX3DtOR7ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CfICpRmd3+kThFNnC78wKScvjuU+n14FYthNCXst7wpOvMSFQG5tDMckpsCnQfq/F
	 yS9CRb8OFjxhtXvXmQMc6uoC8B4MUeCfasMxyWbp38TFCJfDmBMVS54/EKSgrhEre9
	 gBw0J29/1CN4fUlJtw/MVf76Z0O3T2px6JZm6QzCzmPjEqEjHYdQpKPNtc3IFnBTo3
	 UIm0nLl6KAlOoV3gcd6hr3JEKzJdti4RObSJknP3GSyabxzR533k7cBkmCkkpjOeYP
	 Qrlzv9ZifvU0XdtAt44XYDp+eVF0wVUj8F2W4qcBcGtIw3+XqdSOcU5MYRLLCtab1h
	 mBT+QJ5vzHIew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9EE380A954;
	Tue, 10 Dec 2024 18:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix UAF via mismatching bpf_prog/attachment RCU
 flavors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173385543176.937529.2200344298659513715.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 18:30:31 +0000
References: <20241210-bpf-fix-actual-uprobe-uaf-v1-1-19439849dd44@google.com>
In-Reply-To: <20241210-bpf-fix-actual-uprobe-uaf-v1-1-19439849dd44@google.com>
To: Jann Horn <jannh@google.com>
Cc: song@kernel.org, jolsa@kernel.org, kpsingh@kernel.org,
 mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, delyank@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 10 Dec 2024 17:32:13 +0100 you wrote:
> Uprobes always use bpf_prog_run_array_uprobe() under tasks-trace-RCU
> protection. But it is possible to attach a non-sleepable BPF program to a
> uprobe, and non-sleepable BPF programs are freed via normal RCU (see
> __bpf_prog_put_noref()). This leads to UAF of the bpf_prog because a normal
> RCU grace period does not imply a tasks-trace-RCU grace period.
> 
> Fix it by explicitly waiting for a tasks-trace-RCU grace period after
> removing the attachment of a bpf_prog to a perf_event.
> 
> [...]

Here is the summary with links:
  - bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors
    https://git.kernel.org/bpf/bpf/c/ef1b808e3b7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



