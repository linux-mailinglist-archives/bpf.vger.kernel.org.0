Return-Path: <bpf+bounces-39652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC60975BBF
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EF01F23629
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C714D6E9;
	Wed, 11 Sep 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKQiY+Ul"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3F149C7D;
	Wed, 11 Sep 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086629; cv=none; b=mkygEXdecP54lnzFl0U/egEbZpEVL7WIewacac+huA9G90XDNUpf+Ph76votkm/RnnjkkBiC6Vxf4PPC5fJ7fM9GHOwkbkQkN2OBlr751e1qGCAx++/kHk7SnPSFirH9MdXLBOPT8hLrazDXqkR+JKlhFA0kzBS2t9p8xx64B5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086629; c=relaxed/simple;
	bh=v/Yrte8Jw5KgfJel5NdVbyIKhs87v+lyoQcR6vFj3EU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fx5oZcl/W9QKIrxwcy5WBU9bMv/Zt8NaYklRjr7Gr1SVom86Gc06tkGHS2HuTOaqHsW7kUAGsJsaGw+PLLe9D1ovTp9nD5gJjIyxcHJ/9g/xaEyLjdM7pjfOgci78pwHsiJ7WxP06BFhguhKtRua6x2RuYLiEAbX+rVw8ov9vVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKQiY+Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A25DC4CEC6;
	Wed, 11 Sep 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726086629;
	bh=v/Yrte8Jw5KgfJel5NdVbyIKhs87v+lyoQcR6vFj3EU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VKQiY+Ulc/jPYmnjyUi35+3gUg0Dvzk8sNcJpNakffn/iw2AyuZhNEN7p7vsf8Nnz
	 9zUCeljUopTyDLBFvM7pF3yOzn0ScddAH462LHUYj/BZHLCSeA4mMNYb4ESkMnOkRN
	 /t40xQ3DrsBp98xF7IhThaHJEusRKAy10OWRjKVSCyFYFJR/fpo2JjiYxo0Face0sO
	 3xQ4oizT313IzYqTVNklZ9pCEvflbwoW7v5o7VXY9RLdcW8UyRImpkD/qp2CQ5XmpD
	 l3iXXhd3j662RR0PuNgH8OJbuJQegOOpe8yMo2U895zJ7Qxg83lHs7kKlMIUenFxO8
	 onvmrO5/8iCaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDA3806656;
	Wed, 11 Sep 2024 20:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v3 PATCH bpf-next 0/2] bpf: Add percpu map value size check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172608663051.1037972.16330226485258580048.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 20:30:30 +0000
References: <20240910144111.1464912-1-chen.dylane@gmail.com>
In-Reply-To: <20240910144111.1464912-1-chen.dylane@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, houtao1@huawei.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 10 Sep 2024 22:41:09 +0800 you wrote:
> Check percpu map value size first and add the test case in selftest.
> 
> Change list:
> - v2 -> v3:
>     - use bpf_map_create API and mv test case in map_percpu_stats.c
> - v1 -> v2:
>     - round up map value size with 8 bytes in patch 1
>     - add selftest case in patch 2
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] bpf: Check percpu map value size first
    https://git.kernel.org/bpf/bpf-next/c/1d244784be6b
  - [v3,bpf-next,2/2] bpf/selftests: Check errno when percpu map value size exceeds
    https://git.kernel.org/bpf/bpf-next/c/7eab3a58ac7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



