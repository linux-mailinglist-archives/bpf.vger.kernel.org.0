Return-Path: <bpf+bounces-8966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A9378D36A
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3B52810C4
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 06:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2201859;
	Wed, 30 Aug 2023 06:51:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB710EE
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB078C433C9;
	Wed, 30 Aug 2023 06:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693378278;
	bh=8eHFfGDrXB9ccv2TUhY4dHEseB0va24j37RaUDM761g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jJQLaToplrlQIAHSeJs9EeY6E7Tkwg/eD6ingKNPoMpzIjKiHSZakmeVu9ty4KRkH
	 K/43M7j1JbHKJFTxEl6OHoIRcc5TzRMSuFMvvjWZWd0YZLRxkfVmvY1cZpeg4IzWdD
	 a+G1+nq4FrbEKmP9Q+q+5X5gpqJBwf5bbEfluoURcLfrYfemNZTKqCARLhStMxrkcn
	 U73d90EOF32220zy2SsqvD7MjEwjkVktWHJ0aGRoegsXsk24MRcSHzg05c1jfG7rR6
	 7T86LSdnOUEchVmQ6gYbRX8fj/4qbivjUNFJb9RXioxEnp1fPSSbzvAVnEAXeodyo9
	 BR6W6b9RRVypA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A34E4E29F34;
	Wed, 30 Aug 2023 06:51:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] libbpf: add basic BTF sanity validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169337827866.20679.1176149057466169873.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 06:51:18 +0000
References: <20230825202152.1813394-1-andrii@kernel.org>
In-Reply-To: <20230825202152.1813394-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, alan.maguire@oracle.com,
 song@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 25 Aug 2023 13:21:52 -0700 you wrote:
> Implement a simple and straightforward BTF sanity check when parsing BTF
> data. Right now it's very basic and just validates that all the string
> offsets and type IDs are within valid range. For FUNC we also check that
> it points to FUNC_PROTO kinds.
> 
> Even with such simple checks it fixes a bunch of crashes found by OSS
> fuzzer ([0]-[5]) and will allow fuzzer to make further progress.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] libbpf: add basic BTF sanity validation
    https://git.kernel.org/bpf/bpf-next/c/2e29df8dbb0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



