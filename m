Return-Path: <bpf+bounces-60628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0323AD9498
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 20:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E433B3B04
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28FB230D1E;
	Fri, 13 Jun 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kunGd9I2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0A22F774
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840000; cv=none; b=HQ4MAjDLjyDH8xu1a+FJb8AAxAuHSmwcmUR9vGEgpxFy9DK2Gxufqbr9/5AlhNEyP4KL0KRUaFRUIEwkG0gyE5aO/1VV1afdhhNeX+QRQeMxqC0mAwQjymIk3HbPDRFbfMfdsB3dEnZDCj3ripEYxpN5zLw1lm0oCAccVWhfXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840000; c=relaxed/simple;
	bh=HnATZDgUPXRofeG5oCNFeM9d4pydtgDQGGAwiqJUpiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fvslIwIWdfy0941PTQanJMGjReR6/eAznrjp16o4yq5RMXlVW+bkQLcpv3qXyvO8EWT1CDqAKV/ripQMsE4hymtuROGsOydFkBA0jKTdvzcepy92UYxOq4IOo2GKzT8/w0EaJDfzlZrjNgsmA183z1ORLO0wheoPN4kT0BsD2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kunGd9I2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E019CC4CEE3;
	Fri, 13 Jun 2025 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749840000;
	bh=HnATZDgUPXRofeG5oCNFeM9d4pydtgDQGGAwiqJUpiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kunGd9I2emkKun8NGxona3BuYK1jKfF4RBVTJUxjXT1DXDDI/J9pew/4rHogiRpl/
	 vGSH+R8NQbedBNqdVmAoJvn+zVG7LRfc931bpJTpwHM5eOvP3scP4M3CRNWTrZt5in
	 CWMwhPIIzm8yDqmvxNDOKZTBJY6hA1FjY/XQDbxLAKxln7AebotMgT1FO7dkH59WTX
	 QMmFftCzb2126g8SUzPpUb7uc5rTRHzmFt8k0+9PLDz702jD/k6jEj6v307qQDLiaJ
	 rKRwBvreVTwX5dzVpZu1FFIHi/jROoHq92TYmuy6SKHM4Ba4VV/9dQarz79cEkkl3L
	 twazNUWxbRrlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF3A380AAD0;
	Fri, 13 Jun 2025 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Mark dentry->d_inode as trusted_or_null
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174984002952.847188.4533234140015562548.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 18:40:29 +0000
References: <20250613052857.1992233-1-song@kernel.org>
In-Reply-To: <20250613052857.1992233-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, kpsingh@kernel.org, mattbobrowski@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Jun 2025 22:28:56 -0700 you wrote:
> LSM hooks such as security_path_mknod() and security_inode_rename() have
> access to newly allocated negative dentry, which has NULL d_inode.
> Therefore, it is necessary to do the NULL pointer check for d_inode.
> 
> Also add selftests that checks the verifier enforces the NULL pointer
> check.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Mark dentry->d_inode as trusted_or_null
    https://git.kernel.org/bpf/bpf/c/d60d09eadb7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



