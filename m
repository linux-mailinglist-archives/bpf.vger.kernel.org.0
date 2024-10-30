Return-Path: <bpf+bounces-43598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B59B6CCB
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E750CB2164B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E01CCB53;
	Wed, 30 Oct 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4AEOyi0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC60199E84
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730316026; cv=none; b=rcSXXzu5YZYsxdKvZG3K9seLPTq0NWk2wehVBlzHBtnVgh+hlYpb/iYb29Y3hTFcufvn5lBW6rx38lTR9oEM6vleTjfoZKBIrw/jlBqIJrxsp2VabYhyZZxXMsa/rKem0wsc6cy9sMMrtrUrLJDXO2hFiCF2XDT7yMETJY4noiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730316026; c=relaxed/simple;
	bh=/GsM55EeTPz6IYYDJy7C+VFrWWTAg4AcWGWgdCZnu3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H18ocwiWoX102y+CbrJ1tIzH2OcSQkb9jHLUNXDSPr2PPpZKD0Yk6NMjLSXepI1Ve6snd+2BrCmNRyVN6ROrY5AV5SfZyD2sS8/IXBVQCrX1I/YfIWjUlytiOnzKGAtMXX6Sbrcy7+HcmLdd0MHqpNq3KP0aFf7bTDH7eFZLZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4AEOyi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39015C4CECE;
	Wed, 30 Oct 2024 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730316026;
	bh=/GsM55EeTPz6IYYDJy7C+VFrWWTAg4AcWGWgdCZnu3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N4AEOyi0YkXtbMnx+PartH0YuYfmtTCuwlzbYIAI0WwZ+kaZ0UelM2puBed/M9F8b
	 TxU0Ok7GnyikN7xGtA54cD7VTH0j8LLnNjsBqUp0stzN8vBJKdsawkAJAJR4HD9/f1
	 IHJR+of0FAPPRflcPyExiyzWMQDf46lXi1k2Mtf90h5ZrLy6qRGYiZwKsktwLb8HbG
	 bUe8YiAr903qi2tJ0ZX19avm4WS1ugcScJtSfqgFUIowxjuDbdKp2PZ79lDe4sxvfh
	 Y0sM02lH1MHAqU1EXDArHxAf2HXAakdkWOwQsl0uF0GG7dvZhZIrHIBZvesAeGeIfY
	 IvUWmCCZfp9Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAF380AC22;
	Wed, 30 Oct 2024 19:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/5] Fixes for bits iterator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173031603400.1439165.2937332424790644908.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 19:20:34 +0000
References: <20241030100516.3633640-1-houtao@huaweicloud.com>
In-Reply-To: <20241030100516.3633640-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com,
 laoar.shao@gmail.com, houtao1@huawei.com, xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Oct 2024 18:05:11 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set fixes several issues in bits iterator. Patch #1 fixes the
> kmemleak problem of bits iterator. Patch #2~#3 fix the overflow problem
> of nr_bits. Patch #4 fixes the potential stack corruption when bits
> iterator is used on 32-bit host. Patch #5 adds more test cases for bits
> iterator.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/5] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
    https://git.kernel.org/bpf/bpf/c/101ccfbabf47
  - [bpf,v4,2/5] bpf: Add bpf_mem_alloc_check_size() helper
    https://git.kernel.org/bpf/bpf/c/62a898b07b83
  - [bpf,v4,3/5] bpf: Check the validity of nr_words in bpf_iter_bits_new()
    https://git.kernel.org/bpf/bpf/c/393397fbdcad
  - [bpf,v4,4/5] bpf: Use __u64 to save the bits in bits iterator
    https://git.kernel.org/bpf/bpf/c/e13393836750
  - [bpf,v4,5/5] selftests/bpf: Add three test cases for bits_iter
    https://git.kernel.org/bpf/bpf/c/ebafc1e535db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



