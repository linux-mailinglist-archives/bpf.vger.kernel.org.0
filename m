Return-Path: <bpf+bounces-48271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637AA063B5
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B424F1888D48
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE32120012D;
	Wed,  8 Jan 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctAkn17O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631E1957FC
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358616; cv=none; b=kRDl5S1zNlF/AmRWnxFVXIv1jcZPNpvVFwrvusEj7kbv/Mi5+mYqCDsiCSGoYD8i+CThtejJ8ni12OgDOjhjat+wPMHB4sz5My0VHXJie3A/cqwfRnb8ffCe1lbMHLfReSjjChYSvx262Ul53ykOBhqZNcGureMX8e3AWwS7KRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358616; c=relaxed/simple;
	bh=9Z4SNfnLw9Qn+unMl0XRJ+O5utFQybqBPjcONaRWYx8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KxZkec345HLGdkztXBqN8TKCXsZUDsE8UXbXuh28/rM6vztm6Rd7dg7GmDhPQgrGeCgjJDaZiESgcZvBaoQ6lJnZ3eTp5ZwSbe1hAJV/zS8X+3cOXdrKdXWtRTpnd2AghfjKVv4ANqFmr6n1pcA227WdyiUxLG05SOq22QObLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctAkn17O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD64C4CEDF;
	Wed,  8 Jan 2025 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358614;
	bh=9Z4SNfnLw9Qn+unMl0XRJ+O5utFQybqBPjcONaRWYx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ctAkn17OV9NUl6sZwu+fhceatGAKgex652WHeWQwlJXxVDAyExTk3JnQa5uPurexG
	 A1PUgZ3UMijEXZ4Y8KMklFPGMeKjzNomzdXKbvC/CbsYhza9RGU5YsVut6HsN+Z8Sg
	 ddMJCUHdRK1C9Z1d6ZELIrxbIxN/ugdOKvrTAxshH/PDgh9Wkv5JJccybGZKhMyc5D
	 5UCinpMViaYSIZlX0dMcnfh6vRjgW1mCyo3+my/wRWEL9KPCqTPTByS3pelEo5kYwe
	 aqnNXyEjUNOtVdBMg0zOuYI5llDDnw5+FZub3gaz7/nNe/LKD9qvLVunkEkHRBM112
	 rfUvX8CTZytPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C46380A965;
	Wed,  8 Jan 2025 17:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Move out synchronize_rcu_tasks_trace from
 mutex CS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173635863601.728295.3919722459535691625.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 17:50:36 +0000
References: <20250104013946.1111785-1-pulehui@huaweicloud.com>
In-Reply-To: <20250104013946.1111785-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jannh@google.com,
 pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  4 Jan 2025 01:39:46 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Commit ef1b808e3b7c ("bpf: Fix UAF via mismatching bpf_prog/attachment
> RCU flavors") resolved a possible UAF issue in uprobes that attach
> non-sleepable bpf prog by explicitly waiting for a tasks-trace-RCU grace
> period. But, in the current implementation, synchronize_rcu_tasks_trace
> is included within the mutex critical section, which increases the
> length of the critical section and may affect performance. So let's move
> out synchronize_rcu_tasks_trace from mutex CS.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Move out synchronize_rcu_tasks_trace from mutex CS
    https://git.kernel.org/bpf/bpf-next/c/ca3c4f646a9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



