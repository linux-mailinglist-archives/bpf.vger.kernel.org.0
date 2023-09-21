Return-Path: <bpf+bounces-10593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9397AA2AD
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEA12812CE
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3B1947A;
	Thu, 21 Sep 2023 21:30:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0219470
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 21:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C5E3C433C8;
	Thu, 21 Sep 2023 21:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695331826;
	bh=vXQOIgNvu2MkAiXRO6EtuTvhqw2j58Jv90s6wKELrL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ej46deitiA2JTdZC9Q6B2ROi1/GSAbuai39IHq/CwNB+MESfGB5LQ23vx+wowqT8Y
	 PQ3jpG40yluPiNKjPfCJocxz1IykuE49AbEeugpU9vSiV5HQXxiXPc7sp1n7zmhq8Q
	 4J2nI6D86MKSo9ThEMMIdRmYmVTbgfXZjErBpzBA1kxzLDNKhvGvtisWsD26bYMgC8
	 1CZYe+UzoLU6iOL0Y+rfWy1JY4W5oIMcBt+DGcF7gd9mbWJV4H71JYjoUrEf+Z+UvP
	 UI+QHk2Vr83XDWnenKcJiEeAai9/c3h4PGUsNVL/nUwkheBiyy/VOaKucUr9mlMyQX
	 DfT2+eTE4B4LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 815ABE11F40;
	Thu, 21 Sep 2023 21:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/10] Implement cpuv4 support for s390x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169533182652.8962.13089527935405318096.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 21:30:26 +0000
References: <20230919101336.2223655-1-iii@linux.ibm.com>
In-Reply-To: <20230919101336.2223655-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Sep 2023 12:09:02 +0200 you wrote:
> v1: https://lore.kernel.org/bpf/20230830011128.1415752-1-iii@linux.ibm.com/
> v1 -> v2:
> - Redo Disable zero-extension for BPF_MEMSX as Puranjay and Alexei
>   suggested.
> - Drop the bpf_ct_insert_entry() patch, it went in via the bpf tree.
> - Rebase, don't apply A-bs because there were fixed conflicts.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/10] bpf: Disable zero-extension for BPF_MEMSX
    https://git.kernel.org/bpf/bpf-next/c/577c06af8188
  - [bpf-next,v2,02/10] selftests/bpf: Unmount the cgroup2 work directory
    https://git.kernel.org/bpf/bpf-next/c/6cb66eca36f3
  - [bpf-next,v2,03/10] selftests/bpf: Add big-endian support to the ldsx test
    https://git.kernel.org/bpf/bpf-next/c/9873ce2e9c68
  - [bpf-next,v2,04/10] s390/bpf: Implement BPF_MOV | BPF_X with sign-extension
    https://git.kernel.org/bpf/bpf-next/c/3de55893f648
  - [bpf-next,v2,05/10] s390/bpf: Implement BPF_MEMSX
    https://git.kernel.org/bpf/bpf-next/c/738476a079bd
  - [bpf-next,v2,06/10] s390/bpf: Implement unconditional byte swap
    https://git.kernel.org/bpf/bpf-next/c/90f426d35e01
  - [bpf-next,v2,07/10] s390/bpf: Implement unconditional jump with 32-bit offset
    https://git.kernel.org/bpf/bpf-next/c/c690191e23d8
  - [bpf-next,v2,08/10] s390/bpf: Implement signed division
    https://git.kernel.org/bpf/bpf-next/c/91d2ad78e90c
  - [bpf-next,v2,09/10] selftests/bpf: Enable the cpuv4 tests for s390x
    https://git.kernel.org/bpf/bpf-next/c/48c432382dd4
  - [bpf-next,v2,10/10] selftests/bpf: Trim DENYLIST.s390x
    https://git.kernel.org/bpf/bpf-next/c/c29913bbf4ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



