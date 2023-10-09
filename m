Return-Path: <bpf+bounces-11772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E47BEF5D
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 01:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78493281CEF
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 23:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25854737B;
	Mon,  9 Oct 2023 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXpgOFbE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143847363;
	Mon,  9 Oct 2023 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60BACC433C9;
	Mon,  9 Oct 2023 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696895425;
	bh=eObT4QKQncrRqBMkVkxuhqNRGiLyShrYtKXKf4yAYzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXpgOFbEy2ErehPdH+wuk4Ia7zRnnWwmldH201Ygfb2e1eM3q7uC7JzSStDKWEiPc
	 BCSvTAKce4TpT6paCkvkJruXLgLd24/QKNdYJ80pwq+O0vdkucddDZZLvYFQK2nhof
	 62l4NkHWR4zYIArHIM8Mm3cXBVQti43Ly2NH4f13qSQY9fX/z/cCS82jjaiHPpMhQc
	 /oFe2pRPm/dbE0c/cr3/EYQ0BXhP3QAkWoB4bosws8nlIfu3yvzy84qlSbopG0K7RK
	 UlaBYDaJMoFi0ado2i4uu3grTMlxER206tF5FlP709perf6t1Q3SNJU5UMuPJpYn8o
	 Qoo/TtTcEsw4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41A5BE0009C;
	Mon,  9 Oct 2023 23:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix src IP addr related limitation in
 bpf_*_fib_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169689542525.10639.4943696470893944027.git-patchwork-notify@kernel.org>
Date: Mon, 09 Oct 2023 23:50:25 +0000
References: <20231007081415.33502-1-m@lambda.lt>
In-Reply-To: <20231007081415.33502-1-m@lambda.lt>
To: Martynas Pumputis <m@lambda.lt>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 martin.lau@linux.dev, razor@blackwall.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat,  7 Oct 2023 10:14:13 +0200 you wrote:
> The patchset fixes the limitation of bpf_*_fib_lookup() helper, which
> prevents it from being used in BPF dataplanes with network interfaces
> which have more than one IP addr. See the first patch for more details.
> Thanks!
> 
> * v2->v3: Address Martin KaFai Lau's feedback
> * v1->v2: Use IPv6 stubs to fix compilation when CONFIG_IPV6=m.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
    https://git.kernel.org/bpf/bpf-next/c/dab4e1f06cab
  - [bpf,v3,2/2] selftests/bpf: Add BPF_FIB_LOOKUP_SRC tests
    https://git.kernel.org/bpf/bpf-next/c/b0f7a8ca1179

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



