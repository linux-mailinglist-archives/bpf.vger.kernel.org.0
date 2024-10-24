Return-Path: <bpf+bounces-43074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D47F9AEE64
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513E828119D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742841FC7FE;
	Thu, 24 Oct 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ80bhYP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05691F818A
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791631; cv=none; b=PHWdrhjJhp/ttRsCngkzvSVy/1KtjBU/lFv/oOphjp4n5kjKTqY3VoCOzjdt45XZpeSDAb2xriNmb1KBtngGYaHQgLNgxC4ALxoxAnap3AS1iTVrOCorkPKbdOYVrYHB7al6Xdv07SFTLdsYKWE1MYKimQi5j7r3uYgYBFHhJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791631; c=relaxed/simple;
	bh=X7BTrm1aUkvkb1Q2Ev1j6an+yVP2DYvPmP4QJ9YkLbA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XS3TRKDn2wfhh6Qhw/8QmouN/nx3Y7oFsfKajpx3fnwd/B2vrT3P0raLNaOVRXsjpNYNCfiaG+N74Hcc/26PoO4+n5aJNFJvSb3EB0IzE0cPQnP6boXFegUxdm7neYjDGo7S77EpSiQSeLSdtoHmQXWmlMKFnIPl7lVNQdunKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ80bhYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC94C4CEC7;
	Thu, 24 Oct 2024 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729791630;
	bh=X7BTrm1aUkvkb1Q2Ev1j6an+yVP2DYvPmP4QJ9YkLbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XQ80bhYPhWD/nfd20yezebsCLw9VIrGU5y7hG/5FyKfD37mOBsjlltGmQpG8LccNs
	 5DwDAc26GuyiIhcqGlDwu4Nv9mndYzhMgEW89/dMnjKHvXVGE4YtijdMhl/d8UDMck
	 l2nbMzV3DH2R/fyDNFo0c5YBS1T8mraGMTpcyYrNlJb40K5/hktyiPwDcghPXx8LUU
	 Z03m0hJu1so4CVcuog/LNfM6XL4OIWbXu3nplqttIeKfnkdxYoWLMBs83dfyOOm4fO
	 ObtmRn54bKkcR35OlUqgOgPci0e14o7ROmBvxTVwpRWgFp0V1SEjrHCXq2iXaegdzZ
	 4efzsE9V7nmnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA6380DBDC;
	Thu, 24 Oct 2024 17:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 00/12] Share user memory to BPF program through
 task storage map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172979163723.2323425.13247638009448172609.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 17:40:37 +0000
References: <20241023234759.860539-1-martin.lau@linux.dev>
In-Reply-To: <20241023234759.860539-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, thinker.li@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Oct 2024 16:47:47 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> It is the v6 of this series. Starting from v5, it is a continuation work
> of the RFC v4.
> 
> Changes in v6:
> 1. In patch 1, reject t->size == 0 in btf_check_and_fixup_fields.
>    Reject a uptr pointing to an empty struct.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,01/12] bpf: Support __uptr type tag in BTF
    https://git.kernel.org/bpf/bpf-next/c/1cb80d9e93f8
  - [v6,bpf-next,02/12] bpf: Handle BPF_UPTR in verifier
    https://git.kernel.org/bpf/bpf-next/c/99dde42e3749
  - [v6,bpf-next,03/12] bpf: Add "bool swap_uptrs" arg to bpf_local_storage_update() and bpf_selem_alloc()
    https://git.kernel.org/bpf/bpf-next/c/b9a5a07aeaa2
  - [v6,bpf-next,04/12] bpf: Postpone bpf_selem_free() in bpf_selem_unlink_storage_nolock()
    https://git.kernel.org/bpf/bpf-next/c/5bd5bab76669
  - [v6,bpf-next,05/12] bpf: Postpone bpf_obj_free_fields to the rcu callback
    https://git.kernel.org/bpf/bpf-next/c/9bac675e6368
  - [v6,bpf-next,06/12] bpf: Add uptr support in the map_value of the task local storage.
    https://git.kernel.org/bpf/bpf-next/c/ba512b00e5ef
  - [v6,bpf-next,07/12] libbpf: define __uptr.
    https://git.kernel.org/bpf/bpf-next/c/7aa12b8d9f24
  - [v6,bpf-next,08/12] selftests/bpf: Some basic __uptr tests
    https://git.kernel.org/bpf/bpf-next/c/4579b4a4279e
  - [v6,bpf-next,09/12] selftests/bpf: Test a uptr struct spanning across pages.
    https://git.kernel.org/bpf/bpf-next/c/51fff4083372
  - [v6,bpf-next,10/12] selftests/bpf: Add update_elem failure test for task storage uptr
    https://git.kernel.org/bpf/bpf-next/c/cbf9f849a3e8
  - [v6,bpf-next,11/12] selftests/bpf: Add uptr failure verifier tests
    https://git.kernel.org/bpf/bpf-next/c/898cbca4a757
  - [v6,bpf-next,12/12] selftests/bpf: Create task_local_storage map with invalid uptr's struct
    https://git.kernel.org/bpf/bpf-next/c/bd5879a6fe4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



