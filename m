Return-Path: <bpf+bounces-54111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98DA63209
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 20:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BAB1896716
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 19:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90319AD86;
	Sat, 15 Mar 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfj/Fa2m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235DF192D9A
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742065797; cv=none; b=Kt6VMADCUqJQmSRKQBAFLkEnZnoLdodZD/hNgNTp+rRLM5ELjE8As5/91yY7M1udkBz6ZCIIe2tNE3R/Lfz6cY8hB4eO0HFuJlm/jDZSAurnvqdQyr9OX3xX3EBW+/D2zDBfYhRE+KfIvVoncU+H0vlz2x+hBbTsTVEMueMJAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742065797; c=relaxed/simple;
	bh=dcamRykg6CPnAvRwaybqYpprUE+RxcAn/K41QNLql8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l9MGeQELJqhPbFugkh4L0ZJUbexjekqsr434JpCnrYHj5H3dC7uB38RyqHP+koh7UiaQeDgvyl+Tp6fpg36UF2gdrleovoMc1UFtAnv8AGl23ZDXT2p9E87xGl3/SeYU1vIgb2O84sChxYtfKWQKW5PMtLNx8db9WGAI1sIK6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfj/Fa2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E371C4CEE5;
	Sat, 15 Mar 2025 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742065795;
	bh=dcamRykg6CPnAvRwaybqYpprUE+RxcAn/K41QNLql8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dfj/Fa2m3jjI/ONarOE35MV0vUY9WOxVcRhPtU9IPSFqVKjW9DbJ/2CUyqV0nuTrz
	 oDY68hixbpP/xpsWaAMsqsjXsuq6TtVD9IYbTOZfLMA/P/pau0jpjdgNLfH/GbiuXl
	 YgYayzmHT5HdU8yHmC2JJjXimQlqprSu/gIXMeoriZG6sJjCMtBmZj6fGsSJCr3z4t
	 OGr209kBxqHhclCgYbQ8hUCvwmmRscgDI76ZR6pLogQisVo23qFNKr+3hkMniQHGFq
	 lz42/Uce70VGaqbr/wMpiYCnGBMxsefINXei1qEKo9HbhRafLCcbkDb+gk9krjvCq2
	 1W0BxeKi5b3GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7D380DBDD;
	Sat, 15 Mar 2025 19:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND][PATCH bpf-next] bpf: Check map->record at the beginning of
 check_and_free_fields()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174206583052.2636935.6848646987775209104.git-patchwork-notify@kernel.org>
Date: Sat, 15 Mar 2025 19:10:30 +0000
References: <20250315150930.1511727-1-houtao@huaweicloud.com>
In-Reply-To: <20250315150930.1511727-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 15 Mar 2025 23:09:30 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When there are no special fields in the map value, there is no need to
> invoke bpf_obj_free_fields(). Therefore, checking the validity of
> map->record in advance.
> 
> After the change, the benchmark result of the per-cpu update case in
> map_perf_test increased by 40% under a 16-CPU VM.
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next] bpf: Check map->record at the beginning of check_and_free_fields()
    https://git.kernel.org/bpf/bpf-next/c/bb2243f4328b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



