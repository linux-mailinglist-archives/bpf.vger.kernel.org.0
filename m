Return-Path: <bpf+bounces-41943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC5D99DBFE
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AFA1C219F2
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C05166F1B;
	Tue, 15 Oct 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6MUEwKY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39445165F16;
	Tue, 15 Oct 2024 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957627; cv=none; b=XNXEk56slSN85ibsQrWn4XMv2LH45rktxVWVIluLfQvDigojxGq5xpTiKYiQmY4Qoec1mzKWe9TYXVw2Vcmoea5Pw1xXeE80GPWoifwMFIs3YomGVYEb+dwhwpMSG1T2zSm31wwWu3iIuovUVxJhdbJtuWE337pmRmy7/UAwr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957627; c=relaxed/simple;
	bh=KNuccX5J61wl0DNAb86MlKNymkFrcicRV5AmzgSQJKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EUNgnupm/0xBFYDlMGQn7GKDvo10ENFScaKYN1eh3P725dd5V6Dt6QshMDaA/odLPlrbUInCG5nNG3pP4xD7Ol0XBxT7KrteNjHFj3OvghNIE7fnCn+SPLwHGSoBEDrTWLADD/jlvWihNCGY20AD64CbKloTbtfp4khcSpi7hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6MUEwKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43E8C4CEC3;
	Tue, 15 Oct 2024 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728957626;
	bh=KNuccX5J61wl0DNAb86MlKNymkFrcicRV5AmzgSQJKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6MUEwKYrvQFKsoQtDmEvMSwb/u8JJrGVKRIhJNZY45Q8vNBIl658DG4f26yfH4Ls
	 Du42omdsZ316qlvXDFCvc2j4EWBfU3YfJiRjMmOy+GXybVBC6AbfJWpBWADoc/xy9x
	 Bbz3W7IQ1/RwCqAi+hZi3JuY4hMIXsg8j8keupvGwB8PkI93aUY1yUjt1BsBiFYogC
	 Kcbs/rxJjY9dwLp611iaG4+RhdfQNu8sTLQ4t6suCAWcxxxxmNfxqVVKW5GU+WwWI/
	 eExSI5XytW95/HghHbxLI9y9wtPpSHkQujSlyxizoxa5Sg7wFqC5MihmepqsNnqRzR
	 2VhayXAVDy0SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0E53822E4C;
	Tue, 15 Oct 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_from_vpid() kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895763151.696768.12853090794855329864.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 02:00:31 +0000
References: <AM6PR03MB5848E50DA58F79CDE65433C399442@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848E50DA58F79CDE65433C399442@AM6PR03MB5848.eurprd03.prod.outlook.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 14 Oct 2024 10:21:08 +0100 you wrote:
> bpf_task_from_pid() that currently exists looks up the
> struct task_struct corresponding to the pid in the root pid
> namespace (init_pid_ns).
> 
> This patch adds bpf_task_from_vpid() which looks up the
> struct task_struct corresponding to vpid in the pid namespace
> of the current process.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Add bpf_task_from_vpid() kfunc
    https://git.kernel.org/bpf/bpf-next/c/6dce087f24e5
  - [bpf-next,2/2] selftests/bpf: Add tests for bpf_task_from_vpid() kfunc
    https://git.kernel.org/bpf/bpf-next/c/108e7b4db83b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



