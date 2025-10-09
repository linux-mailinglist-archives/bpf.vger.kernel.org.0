Return-Path: <bpf+bounces-70631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F62BC70EB
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 03:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774BC19E3624
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 01:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A85155C97;
	Thu,  9 Oct 2025 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9qApm1x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A263D987;
	Thu,  9 Oct 2025 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972028; cv=none; b=GHlumnzQFYtwTBAdOHf8t0M6wty9ioYAG5bgqTDgqBs/wAtzm6PNqMqc/6xjIU94gBi6KEu/aXDIeonNaBsxaQfueSMp6N0+jlFLbTY65uJSLCAqPkZPl83A/uxPXnu2FZ7m+YyH1KmBy8vChpUhgAlYuDRick2JIW4+FL00t3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972028; c=relaxed/simple;
	bh=Cu58U/6vwTP3AaZHhN1PkZiohTEnguFUy6GZ3S1rnzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uyU3wzKURtqB1QRVj3mLI83Qp+Gkv/Yvh51pt1zFBMzbujzm7v+V7R+ALx7J/kwh2b99u3Ai6fYLh04eccK2fyVxYf1YSjWMLXy4SJcq1rrkOBfCX2WkR4laFJK8xRp12DXUx3bcCKwrKtEwVy9JzyiSjIUu7WBe1Xzy7W9fmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9qApm1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C192C4CEF5;
	Thu,  9 Oct 2025 01:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972026;
	bh=Cu58U/6vwTP3AaZHhN1PkZiohTEnguFUy6GZ3S1rnzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B9qApm1x5XDZGOFdYS3j59zH6youFsA22ezfZq69+0s9BWrQc6xa6lytNspJ1UURj
	 s19bkbHos1e1Lkrjixk5yoEVTCm8z/Tr5hExsCqxpAPbGLQsJaCa+OJ6bCbYBVUi3V
	 z/+W6BCwbyAiSMIqrZGxrBbeBC+iqhovHvtL5Ka/RbXrgHMuPeEMA8YOh6XPYFDzX2
	 78pHRKfY0AGex7e28/L0RBvjgH/Psf+G0oLIvXy2hJmK7WUwQGibAUE86yOT5S3Yrd
	 Ul1Wgxyg8lvNW++hW+9fYBIfrxqFDMj3XP2kUuEwQggZN8P2Lva961Vz+U2fieUx9l
	 m8eBjsBk+rAgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0DD3A41017;
	Thu,  9 Oct 2025 01:06:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] riscv: bpf: Fix uninitialized symbol 'retval_off'
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175997201456.3661959.4723986638267153868.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:06:54 +0000
References: <20250922062244.822937-1-duanchenghao@kylinos.cn>
In-Reply-To: <20250922062244.822937-1-duanchenghao@kylinos.cn>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: linux-riscv@lists.infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, alex@ghiti.fr,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 22 Sep 2025 14:22:43 +0800 you wrote:
> v2:
> Adjust the commit log
> 
> URL for version v1:
> https://lore.kernel.org/all/20250820062520.846720-1-duanchenghao@kylinos.cn/
> 
> Chenghao Duan (1):
>   riscv: bpf: Fix uninitialized symbol 'retval_off'
> 
> [...]

Here is the summary with links:
  - [v2,1/1] riscv: bpf: Fix uninitialized symbol 'retval_off'
    https://git.kernel.org/riscv/c/d0bf7cd5df18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



