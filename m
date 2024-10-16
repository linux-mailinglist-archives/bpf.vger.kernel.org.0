Return-Path: <bpf+bounces-42238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62FC9A1464
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A078283363
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B45B1CC893;
	Wed, 16 Oct 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9VHbr0t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835E4409
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111826; cv=none; b=SkUWCvYFl1JWZC1ixu+3r5KOR3zIJ4aBIVnku3U6NocF7j5eEYgyhlRNqO44k6WeyZichndqx9kzWWNfqyBzWG1x7ynv8ZO9Kl/i0p7v+/VKgb1emdwETU8iEcFvVe08cgpN5oksfdJao8VZkHqT/0pqSXZGUga7gc56t/n+3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111826; c=relaxed/simple;
	bh=y18M/JQjTegEKUTQXtq5RzabjTpYSpDaYW83Web1GiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SJqSw9wnP+ZJj6a1wxrYXnz7HHSI5aPQ9pn1nUir98LhsC0n26mINAf3dqt2McbsZ3sLNwf2DfoJJjnvRLUepnexs5VvKkFNTfabdMU8n3W42xW6EXxj17GnxRIwJhFKyUg8NqACLXpP0APGgGFLgGCT61wqhmbT6SXam9ormA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9VHbr0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7B8C4CEC5;
	Wed, 16 Oct 2024 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111826;
	bh=y18M/JQjTegEKUTQXtq5RzabjTpYSpDaYW83Web1GiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I9VHbr0tFgvQdnjRUsiBycwbkbXGVWgKYvTIANrz8yGh6CcgHiSBAE9ubYwPxB+nw
	 2YN9m18guHJkaLcGEPlDmjpsDCrcebUXqz2iqlXSbkV+RCwaU/47S6l1Vf1zAprzMm
	 T6R7Ex4sN8UOp9sbThl/tEIu1wYZYAXUyBuq62Sjm4tddasA9sfm9lIbT4XJIUsFiF
	 9j0Zi/uFhArw0YNYxUTrHUMr99g7yU7BSshnFtvWhy547lDbYqKqNRhUesi/vV6L+/
	 +f/E2HESTayEPxCF0gKBGMW/ZTkZfS+plW6iHehXLV4nd19QHLQqNNCk8eKhqGI/67
	 hI449MZ++4gbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1A03822D30;
	Wed, 16 Oct 2024 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] Two fixes for test_sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172911183123.1953970.3889586443573064355.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 20:50:31 +0000
References: <20241012203731.1248619-1-zijianzhang@bytedance.com>
In-Reply-To: <20241012203731.1248619-1-zijianzhang@bytedance.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bhole_prashant_q7@lab.ntt.co.jp, jakub@cloudflare.com,
 xiyou.wangcong@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat, 12 Oct 2024 20:37:29 +0000 you wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Function msg_verify_data should have context of bytes_cnt and k instead of
> assuming they are zero. Otherwise, test_sockmap with data integrity test
> will report some errors. I also fix the logic related to size and index j
> 
> 1/ 6  sockmap::txmsg test passthrough:FAIL
> 2/ 6  sockmap::txmsg test redirect:FAIL
> 7/12  sockmap::txmsg test apply:FAIL
> 10/11  sockmap::txmsg test push_data:FAIL
> 11/17  sockmap::txmsg test pull-data:FAIL
> 12/ 9  sockmap::txmsg test pop-data:FAIL
> 13/ 1  sockmap::txmsg test push/pop data:FAIL
> ...
> Pass: 24 Fail: 52
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] selftests/bpf: Fix msg_verify_data in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/ee9b352ce465
  - [bpf,2/2] selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/b29e231d6630

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



