Return-Path: <bpf+bounces-56517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEDA996AC
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725691B8619B
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2628BABA;
	Wed, 23 Apr 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPLEx1UU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481272857C4
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429393; cv=none; b=CH4CiKg0Q371MQdUlIiO+RC7qjyh0jcpclITezsjtcnM//eWCRhiUODJ+pfT4+JfIDVmKi0lFFgzNnrFdatiKgGJ7ZXVQO3vptVjKZVLBMLFaIZTpHZCpKjpFswZuWIH9HMhu+rVtCAQUadIhZyqFawb3a9IUcsGrhFevLpzvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429393; c=relaxed/simple;
	bh=+3l35Sax4pRQjU5UjGD/jiLukaYM8SqVXwPMQLTEex4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LXsFomEpT1ZVnRBWGVFUelIJMtlN5GfGP6uPn5JNZ3lLNxYk6jyxgpNUSDCOvtOmGNjpj41gwXKWVdv+TZU7XDbS6aEL4emhRdA5lXmiK3WHXTwwCGmbM2ba8c72ZWOxxig7k0qEZYx+ilx4ydRYhpnuw3bNHrRDxx7by6zbtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPLEx1UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB027C4CEE2;
	Wed, 23 Apr 2025 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745429392;
	bh=+3l35Sax4pRQjU5UjGD/jiLukaYM8SqVXwPMQLTEex4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qPLEx1UUwi/NZfd8b8aAuM+vbrZ2v6NocC7Nt1+CTv0WVb/GBSa+FFe9n09Vi54+Y
	 gBDMn6FNCmcuuvzRd2Bfwu0mSnUf0CDlehCcvHsgOUzX+Wr2NdpI4E8UiC6WhseVWV
	 O5ecYsBaHGZZn3S3qtNQyE5nLGjv9vcUjD686jNPmBOXtHFq1FTVj48MrOj+NWyz9D
	 Ry4ZuHWFxxG4zwLxWgATlyKvwaUEQP5YyYFCEGhvlaT7CWm8JT0g/x45DMeGGzsNT0
	 76FMmr/2NqMchfFLUW3bxvqAkDAU+jdClR7nIX5Oef5rlp5AE/zBnWovcQiF3Cp1lN
	 7ysA0qgDcPdJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F63380CED9;
	Wed, 23 Apr 2025 17:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/1] bpf: use proper type to calculate
 bpf_raw_tp_null_args.mask index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174542943100.2710773.7570153362776930688.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 17:30:31 +0000
References: <20250418074946.35569-1-shung-hsi.yu@suse.com>
In-Reply-To: <20250418074946.35569-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, memxor@gmail.com,
 dan.carpenter@linaro.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 18 Apr 2025 15:49:43 +0800 you wrote:
> The calculation of the index used to access the mask field in 'struct
> bpf_raw_tp_null_args' is done with 'int' type, which could overflow when
> the tracepoint being attached has more than 8 arguments.
> 
> While none of the tracepoints mentioned in raw_tp_null_args[] currently
> have more than 8 arguments, there do exist tracepoints that had more
> than 8 arguments (e.g. iocost_iocg_forgive_debt), so use the correct
> type for calculation and avoid Smatch static checker warning.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/1] bpf: use proper type to calculate bpf_raw_tp_null_args.mask index
    https://git.kernel.org/bpf/bpf-next/c/53ebef53a657

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



