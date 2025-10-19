Return-Path: <bpf+bounces-71292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79EBEDDD1
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 04:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CED84E5085
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 02:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA01F584C;
	Sun, 19 Oct 2025 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4lv73f6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA081F3BAC;
	Sun, 19 Oct 2025 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841037; cv=none; b=cX3bKspzYWXUg0BJie06gjXig+o0odTZjGCcKhO9lEmBb2t0RL/GBk1HZqQLm/qZt+eHDG49q92UtIvH+JHv7Yag8+KBIwXMha4GPTg7rPqV6wso0pRxdQOQT64gpmItYaJXvZjDSIUhjLNd6LKmkzssw42Vw6n4aluKhUiyAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841037; c=relaxed/simple;
	bh=ymhIaiUZAClSPxIV2c/U4kBXKBs+Dr4086x/9efKUqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QJOjJ6bMMV2623UQVwIUFov4n2oAFFQ/beDQlSzQvm0e1Dh2YaY/UMruIUJAibW2f2eqIiJdaxHzzeQ1DjYEBprryHtai9qoM0CzfGNE8ZSGxcB6SxNLRavuyEf9o1qlh0q3O3qe0UU4qUqe5d7Ys2gynQnY1pRtyM5SVT6HnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4lv73f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68DCC4CEFE;
	Sun, 19 Oct 2025 02:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760841036;
	bh=ymhIaiUZAClSPxIV2c/U4kBXKBs+Dr4086x/9efKUqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V4lv73f6DNIba3cLSHAMnFRYFoBZr00ycaCs2B17W+UjX4ySnhHssIO8QTlIwUO3X
	 /e5sb6vSL9E1fVd4MCg9Op2tEfu4PrCw/KbTiQ9xA50b3upJcWnToHSYk7572cuYCq
	 Sr/ZC8yEkE/iUX7qe6/i59Z/xCE3+4r5kka0e1sSVEd9gtQR23SHsvRRH22IpRuGbU
	 NpWLkuVFogWNutWvhLbnjotbwOT4W+1k+rTupWCkcBjcNeErdOC+1ZHIg4VHn1nvs1
	 RqKR/kXyKQd92noQiZLevU7K+3DSwKdeEdM/lvNcM9ColdYD2d4ahCJ99CPrPmqQ0g
	 SLgxmvDJE+aqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3139EFBBF;
	Sun, 19 Oct 2025 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/1] Fix spelling typo in samples/bpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176084101974.3155740.5721967178192419536.git-patchwork-notify@kernel.org>
Date: Sun, 19 Oct 2025 02:30:19 +0000
References: <20251015015024.2212-1-chuguangqing@inspur.com>
In-Reply-To: <20251015015024.2212-1-chuguangqing@inspur.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Oct 2025 09:50:23 +0800 you wrote:
> Fixes for some spelling errors in samples/bpf
> 
> v3:
>  - The BPF module patch as a separate thread
> 
> v2:
>  - Merge into a single commit
>  (https://lore.kernel.org/all/20251014060849.3074-1-chuguangqing@inspur.com/
> )
> v1:
>  (https://lore.kernel.org/all/20251014023450.1023-1-chuguangqing@inspur.com/)
> 
> [...]

Here is the summary with links:
  - [v3,1/1] samples/bpf: Fix spelling typo in samples/bpf
    https://git.kernel.org/bpf/bpf-next/c/b74938a3bd37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



