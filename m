Return-Path: <bpf+bounces-46293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824AB9E779B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F04118823CB
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB262206B1;
	Fri,  6 Dec 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXSXKxRJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618C220683
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506817; cv=none; b=swTBycpey7Ypq3psVfUx9Dtsy1QiD8hklKRkonfVFGnkcXPuKKEyM2FmDWCpOlOqaZSRyvolbkx9YDluSb58VSbWIoL2rWHTcIKYpAaY69DsgfCnW+6LITlvURT+wsvHQeNhkVqyJChSMEhxbRzgQ1J87lqNLUXSnxrR8kY8oCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506817; c=relaxed/simple;
	bh=xXEka//hkP4wJgoEn5EbobGFHmPZpz9/swfZy3O3dT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=icwNEWSpU91HQcizM09Qy+ShPdYlNiA/lFhoHN8VzI2NIYNV9/vhVgqILc98wPVAJkZh4oqbh2okPSoIL3lJ6HPNjPALJAckXUUg2Cob1D5FpEGxhVZjwvNGw51aA4PcOjkVMbIXkwEZO/+c8c/DaCN/438WxVFup2Vo7dr7YWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXSXKxRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC1CC4CED1;
	Fri,  6 Dec 2024 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733506816;
	bh=xXEka//hkP4wJgoEn5EbobGFHmPZpz9/swfZy3O3dT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fXSXKxRJ1NibkiQ5ZhvhdrliCGBHZsruJRMu0figmqELN7bQX+1VYRDZzdMwK74Q9
	 jzLByeR+lrsia2Wb2wqXUFR1VBf7uKfkktwFbw2iGF4wYEFtidMZIFd8zDG6kistEU
	 ezuO842ywiVGFAHhP6PqyWhqFbrKXnj+Njw5CqH8g46C4zmS4Dv2bcmeaKGwh5Obbq
	 pfCbFJR7ybtfytdIDW1Rm62q/IK/AB5VUe/c28GVmM4+8+jT5MKrkpd2jI1oqcyEtA
	 JpaydA9dLEf5edaKChScN84FWA2e+YotiM22Qp9pUUAnY7084Il2nHHBypI2j770PH
	 /eTuOH9g9/0ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF81380A95C;
	Fri,  6 Dec 2024 17:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/9] Fixes for LPM trie
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173350683178.2738959.6443569959137524250.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 17:40:31 +0000
References: <20241206110622.1161752-1-houtao@huaweicloud.com>
In-Reply-To: <20241206110622.1161752-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com, toke@redhat.com,
 bigeasy@linutronix.de, tglx@linutronix.de, linux@weissschuh.net,
 houtao1@huawei.com, xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Dec 2024 19:06:13 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> This patch set fixes several issues for LPM trie. These issues were
> found during adding new test cases or were reported by syzbot.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/9] bpf: Remove unnecessary check when updating LPM trie
    https://git.kernel.org/bpf/bpf/c/156c977c539e
  - [bpf,v3,2/9] bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
    https://git.kernel.org/bpf/bpf/c/3d5611b4d7ef
  - [bpf,v3,3/9] bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
    https://git.kernel.org/bpf/bpf/c/eae6a075e953
  - [bpf,v3,4/9] bpf: Handle in-place update for full LPM trie correctly
    https://git.kernel.org/bpf/bpf/c/532d6b36b2bf
  - [bpf,v3,5/9] bpf: Fix exact match conditions in trie_get_next_key()
    https://git.kernel.org/bpf/bpf/c/27abc7b3fa2e
  - [bpf,v3,6/9] bpf: Switch to bpf mem allocator for LPM trie
    https://git.kernel.org/bpf/bpf/c/3d8dc43eb2a3
  - [bpf,v3,7/9] bpf: Use raw_spinlock_t for LPM trie
    https://git.kernel.org/bpf/bpf/c/6a5c63d43c02
  - [bpf,v3,8/9] selftests/bpf: Move test_lpm_map.c to map_tests
    https://git.kernel.org/bpf/bpf/c/3e18f5f1e5a1
  - [bpf,v3,9/9] selftests/bpf: Add more test cases for LPM trie
    https://git.kernel.org/bpf/bpf/c/04d4ce91b0be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



