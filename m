Return-Path: <bpf+bounces-1898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A847233BE
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 01:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A962814B4
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86F28C1F;
	Mon,  5 Jun 2023 23:40:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3D24133
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 23:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0CE7C4339B;
	Mon,  5 Jun 2023 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686008420;
	bh=nXb7mtrwpoQ9S7IxoV+MpDyHRELn3TsApNXMTCtdUOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LOzHFmHTlO7zjJ73OQkXKClljFGZ58nyfv1umutEQJn0cFXweJNMl6zzgHAb90VjG
	 6XL0hVUcGdYN9yImS4Rc3cfpsBsxerUzm2tkoBTV2qEmjWXe8U1icUyK34E/v7pn//
	 RAXT0l1QNTNY1sfe2jIcPG7kB2fkjI995KM6aZbNuvZkrktBNqBZgTNwGAsgryRMZz
	 VjzkotgKbwMwwWtaYQt7h7jjjbHFOG5yrq6+4GlzL05GnP85ccdMg/1hCraZU3vzs6
	 3QL3MOsO1ky4XGO9OIWimlhvrwO7OdbIrjxoCwRzGkatpFHaCD8E1sea5LIKzwZaLv
	 5Umhu+84DhRaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9712E4F0A7;
	Mon,  5 Jun 2023 23:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Add missing selftests kconfig options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168600841975.14340.2367835892708005381.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jun 2023 23:40:19 +0000
References: <20230602140108.1177900-1-void@manifault.com>
In-Reply-To: <20230602140108.1177900-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  2 Jun 2023 09:01:08 -0500 you wrote:
> Our selftests of course rely on the kernel being built with
> CONFIG_DEBUG_INFO_BTF=y, though this (nor its dependencies of
> CONFIG_DEBUG_INFO=y and CONFIG_DEBUG_INFO_DWARF4=y) are not specified.
> This causes the wrong kernel to be built, and selftests to similarly
> fail to build.
> 
> Additionally, in the BPF selftests kconfig file,
> CONFIG_NF_CONNTRACK_MARK=y is specified, so that the 'u_int32_t mark'
> field will be present in the definition of struct nf_conn.  While a
> dependency of CONFIG_NF_CONNTRACK_MARK=y, CONFIG_NETFILTER_ADVANCED=y,
> should be enabled by default, I've run into instances of
> CONFIG_NF_CONNTRACK_MARK not being set because CONFIG_NETFILTER_ADVANCED
> isn't set, and have to manually enable them with make menuconfig.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Add missing selftests kconfig options
    https://git.kernel.org/bpf/bpf-next/c/3d272c2fa804

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



