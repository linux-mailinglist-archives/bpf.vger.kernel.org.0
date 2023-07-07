Return-Path: <bpf+bounces-4466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5806174B5EC
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1389828187B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28125168D9;
	Fri,  7 Jul 2023 17:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E55385
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 17:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD30EC433C9;
	Fri,  7 Jul 2023 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688751621;
	bh=AYVfimEp8+8DulP0DHL5IdruuPSov040P2t3VymNxrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UOJEeOtvppRTK7L2/gkrGVCDo/9QnmeCrVb/T25qUI2mR9ZninphUmJI7mdl12yYn
	 7Ngg9fFHLwZ+8noaYO3JHhEZnB/UqJj39DA4QTV5LCgQFo/qsvv/GQE9wY5RNa0bJ7
	 mafUAEOcmP1VNXRNXcFpXGDtrPkmGewdrTndpFVGydD2LcJPckpNxM+IkAiNEyFAYa
	 liJm09sQCZ1bR1N3Byv/7pXx4YRvUxdxtM6wAsTjLHKRElDS9e83iZBFk5N68bExkH
	 jHgCY9QWBf3NJuYyBM6b5TIAnOKgIML4O/Vtzz/OjLn1xsVbw9RXZFEJM8ynSZp/6P
	 vi94LEuxMlTTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A872C59A4C;
	Fri,  7 Jul 2023 17:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Corrected two typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168875162162.5278.14612195207224938068.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 17:40:21 +0000
References: <20230707081253.34638-1-luhongfei@vivo.com>
In-Reply-To: <20230707081253.34638-1-luhongfei@vivo.com>
To: Lu Hongfei <luhongfei@vivo.com>
Cc: andrii@kernel.org, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, houtao1@huawei.com, aspsk@isovalent.com,
 wangyufen@huawei.com, zhuyifei@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  7 Jul 2023 16:12:50 +0800 you wrote:
> When wrapping code, use ';' better than using ',' which is more
> in line with the coding habits of most engineers.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
> Compared to the previous version, the modifications made are:
> 1. Modified the subject to make it clearer and more accurate
> 2. Newly optimized typo in tcp_hdr_options.c
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Corrected two typos
    https://git.kernel.org/bpf/bpf-next/c/856fe03d9292

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



