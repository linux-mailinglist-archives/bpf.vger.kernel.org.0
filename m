Return-Path: <bpf+bounces-60120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4DAD2AB1
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF45E16F6D9
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9668D22FE08;
	Mon,  9 Jun 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+Pu1kb+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2522F77A
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513014; cv=none; b=CksSHx0qZF57lwoHhm5Jt+2oU23YxU8qxN6YRNsZfQP6dvNN6Umou4K6wmLPHu3n2kiSMQs7WD4fOyVRB+uy5JChY5JLlHbX3UUNy32i5NmbmGZZaN+a/rzhVPz3F527e/9T88jhlExhxTDmkyxiKArhya1OUnj3X89w3l/ewIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513014; c=relaxed/simple;
	bh=TMJyLJNL3EjcXG1Tz8mpQzLGO2LOXFy8rniwlKQhxhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e0mlvUoPuW//1tpNLRb3tLoOEuQD2p11uqMhy/BsU5RJHsziPDeGZQhEquBLyE+BJy9ytG1Vnrm4oB0GJxOZnXG9eLOaVYZ7+hPWu8U1BSSwJLVdq8kf7wecUDA5lgWLGGZWYfNF3puxE8Y4Y7Y6AetBg6qBT5TxIRpatHAZ7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+Pu1kb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D176AC4CEED;
	Mon,  9 Jun 2025 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749513013;
	bh=TMJyLJNL3EjcXG1Tz8mpQzLGO2LOXFy8rniwlKQhxhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p+Pu1kb+MuuKxL86zsm8Zr1YcnZfludX9rpN/5u5l3dyZervl5XQpvK9WtHBp870d
	 6FQZfE26VOx5FWtyvTqLyOKkBb+ZCebkvKlazD+NktRGHv/5Xos72zERO2mASmUIhu
	 PnUcvO159Mg9LimNupyk46x9MX160H+bKlqoxgOZ+XHNRdLIJAlZGX/G91epCY3HS7
	 7ONUN9KvoCn8gPu4Q2QocoIovDcVZ71RNictSobAxlZVRtfggtZUdxll86ZNLqDnIJ
	 /Gz+Ly7Uxc50kwbd/3FqkVDhxhawhDITuMdNlYHp2/d2O5LVB5BgMstxz16Qk5B8eM
	 hzFEIRiVMSrYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC23822D5A;
	Mon,  9 Jun 2025 23:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] bpf: make reg_not_null() true for
 CONST_PTR_TO_MAP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174951304424.1595076.4289928368826491596.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 23:50:44 +0000
References: <20250609183024.359974-1-isolodrai@meta.com>
In-Reply-To: <20250609183024.359974-1-isolodrai@meta.com>
To: Ihor Solodrai <isolodrai@meta.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 yonghong.song@linux.dev, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 9 Jun 2025 11:30:21 -0700 you wrote:
> Handle CONST_PTR_TO_MAP null checks in the BPF verifier. Add
> appropriate test cases.
> 
> v3->v4: more test cases
> v2->v3: change constant in unpriv test
> v1->v2: add a test case with ringbufs
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf: make reg_not_null() true for CONST_PTR_TO_MAP
    https://git.kernel.org/bpf/bpf-next/c/5534e58f2e9b
  - [bpf-next,v4,2/3] selftests/bpf: add cmp_map_pointer_with_const test
    https://git.kernel.org/bpf/bpf-next/c/eb6c99278490
  - [bpf-next,v4,3/3] selftests/bpf: add test cases with CONST_PTR_TO_MAP null checks
    https://git.kernel.org/bpf/bpf-next/c/260b86291896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



