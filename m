Return-Path: <bpf+bounces-8965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8878D369
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FA11C20AB5
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756DD1868;
	Wed, 30 Aug 2023 06:48:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F215CD
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79709C433C8;
	Wed, 30 Aug 2023 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693378107;
	bh=8YlurPZLP0ubYyWqvBzSB65+it4p7Fci19yOEHltuw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Eh/wcYlRH4s8u8MdZ+APh+TOWd1F1JijHPg/Jd4wJD8ZdO8Zy8Vl8QO6tWVtRA+8E
	 9khXlwA5mggyYUvksz9s4o9EnPp6yS0HhRgcBmc9OUAqnP/9Gr3oxi66YUAB8LZb5W
	 QXnVm88AG8obIpZHzqmpk+1jbqY7bB3taNw++Ip3GTrfzgGoeK+qhVFM4uLQdeencU
	 I4BRNAB6heupLOeu7KwNsDWLPs2tKUnsYNS6lcrtTcSVKlXVRxZFXpE/8RN9H7ZGDR
	 KG4z7dnyPJE2qgdgddg7A2Rilpf5kbTdp+2jJRtvxK8SYTykpbFJi1nd12MN+jnyER
	 XYssetB5wi8CA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61CD7E29F34;
	Wed, 30 Aug 2023 06:48:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Prevent inlining of bpf_fentry_test7()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169337810739.20679.14633648454962000249.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 06:48:27 +0000
References: <20230826200843.2210074-1-yonghong.song@linux.dev>
In-Reply-To: <20230826200843.2210074-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 26 Aug 2023 13:08:43 -0700 you wrote:
> With latest clang18, I hit test_progs failures for the following test:
>   #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
>   #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
>   #13      bpf_cookie:FAIL
>   #75      fentry_fexit:FAIL
>   #76/1    fentry_test/fentry:FAIL
>   #76      fentry_test:FAIL
>   #80/1    fexit_test/fexit:FAIL
>   #80      fexit_test:FAIL
>   #110/1   kprobe_multi_test/skel_api:FAIL
>   #110/2   kprobe_multi_test/link_api_addrs:FAIL
>   #110/3   kprobe_multi_test/link_api_syms:FAIL
>   #110/4   kprobe_multi_test/attach_api_pattern:FAIL
>   #110/5   kprobe_multi_test/attach_api_addrs:FAIL
>   #110/6   kprobe_multi_test/attach_api_syms:FAIL
>   #110     kprobe_multi_test:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Prevent inlining of bpf_fentry_test7()
    https://git.kernel.org/bpf/bpf/c/32337c0a2824

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



