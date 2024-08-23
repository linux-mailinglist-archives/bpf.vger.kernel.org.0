Return-Path: <bpf+bounces-37974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351395D586
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AE81C22204
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1AC18BBB7;
	Fri, 23 Aug 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I15ZnE1V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F92D7B8
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439034; cv=none; b=ZoQcR9i0VOgQSgDFAiwFL6tfyIP58UVi3z1MYQzqUEQQBW5RRZdXVME8T/fgr1COFrKJHgAOxfAu4MM9sRmyVtBhn5ORQOiXHPHgfTeG7UJmudQCBpeIKhxLozmwbN2WwlXmZ2MgghyVVANiS6RStFjWyPWPLlb7BWLNv7X9Pz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439034; c=relaxed/simple;
	bh=MgnPC9DwPVh6Qovvgwi8c8md9GXV9aqooPRpAQjtMnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lz3RAsrm7/cMjMqlGzwq41Y/2NKv/cFk9vW4g75kyIabo2L4e8Qv7qJpOFBjTEmQVWWR9NqghqV+LMFMVcD8uGbXklLZbWSZuUr9XwpfUtL0eD9JeKvqXdVryZJGrlQ9DSXFgbXyfInUme/bie9hwtQUs3d9kkXqh7v712xNKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I15ZnE1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9309C32786;
	Fri, 23 Aug 2024 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724439033;
	bh=MgnPC9DwPVh6Qovvgwi8c8md9GXV9aqooPRpAQjtMnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I15ZnE1VBoCQ4uZwrxhaPbVeLEXsEfF21tDBldP30ie5zBK3S9axHy1WNOFJ5n5i8
	 AwkVZhSXXivXdBXpPbrGUcxKc7XWZJ6qdrojT1qpYnLTOushLAgU+68oIKomJ4taFC
	 CjSWsqUB6Ew/QXKOlQI3Q8knf58v/2JztxnLMrHfh/JpkmIQdxBlUDVEEu78lOyQYE
	 k1OUeIZTqQjDPlTJDgKQ94b+ZjQ63NAnKYb1Z74H17oOkpN4cVzUI4Kvt3nrc1zPlf
	 hix28qNK93M47rosni9LJHg2BV0EMey5URgUToivCU9Rwu0eST3Izp08X6t3imIH6B
	 ANBDSb8drjakw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4D13804C86;
	Fri, 23 Aug 2024 18:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/5] Support bpf_kptr_xchg into local kptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172443903354.3055350.8541667784916946733.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 18:50:33 +0000
References: <20240813212424.2871455-1-amery.hung@bytedance.com>
In-Reply-To: <20240813212424.2871455-1-amery.hung@bytedance.com>
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, houtao@huaweicloud.com,
 sinquersw@gmail.com, davemarchevsky@fb.com, ameryhung@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 13 Aug 2024 21:24:19 +0000 you wrote:
> This revision adds substaintial changes to patch 2 to support structures
> with kptr as the only special btf type. The test is split into
> local_kptr_stash and task_kfunc_success to remove dependencies on
> bpf_testmod that would break veristat results.
> 
> This series allows stashing kptr into local kptr. Currently, kptrs are
> only allowed to be stashed into map value with bpf_kptr_xchg(). A
> motivating use case of this series is to enable adding referenced kptr to
> bpf_rbtree or bpf_list by using allocated object as graph node and the
> storage of referenced kptr. For example, a bpf qdisc [0] enqueuing a
> referenced kptr to a struct sk_buff* to a bpf_list serving as a fifo:
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/5] bpf: Let callers of btf_parse_kptr() track life cycle of prog btf
    https://git.kernel.org/bpf/bpf-next/c/c5ef53420f46
  - [v4,bpf-next,2/5] bpf: Search for kptrs in prog BTF structs
    https://git.kernel.org/bpf/bpf-next/c/7a851ecb1806
  - [v4,bpf-next,3/5] bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
    https://git.kernel.org/bpf/bpf-next/c/d59232afb034
  - [v4,bpf-next,4/5] bpf: Support bpf_kptr_xchg into local kptr
    https://git.kernel.org/bpf/bpf-next/c/b0966c724584
  - [v4,bpf-next,5/5] selftests/bpf: Test bpf_kptr_xchg stashing into local kptr
    https://git.kernel.org/bpf/bpf-next/c/91c96842ab1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



