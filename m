Return-Path: <bpf+bounces-14693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337F77E7802
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21A62815D9
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027315CE;
	Fri, 10 Nov 2023 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxOo+PaE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7728139C;
	Fri, 10 Nov 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 481B4C433C9;
	Fri, 10 Nov 2023 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699587024;
	bh=rtAxl1XIygp6DGaBTvt0mWqDxNItsd1DoVkKb9H5nU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jxOo+PaEXuse7iXtrzf0N7TggUmafmOoE9JQnEXmLUqUDU8intKyyZTNJI9jgUSce
	 LNT2TA/t90LnF4ul22QS6gIB3NmzapUtNaY7hi+MPZzoS/LBACg1QZovMTZZwXd5Cx
	 bSTxS1pM0k2DyxAUubeBhKc2Q10Z6u6l0pF5YoTnr89EtykTd3QvvuQYkUxz2JbYwc
	 lyzxC42Xk3QU1RPq9KcX6aw5bQ8LhnVBwwNydpnGOXbdKeGE0sF7ywyacxMBDqGqPs
	 PKbFXiyTe/bYDDggdyOgMAuuBZloGzNmPHb0Mihz1c8Cfow18BmhC2Lpn/JuLbF7/e
	 Uzqt579hHuMWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CD20C691EF;
	Fri, 10 Nov 2023 03:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3] selftests: bpf: xskxceiver: ksft_print_msg: fix format type
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169958702417.21601.7609791725807208554.git-patchwork-notify@kernel.org>
Date: Fri, 10 Nov 2023 03:30:24 +0000
References: <20231109174328.1774571-1-anders.roxell@linaro.org>
In-Reply-To: <20231109174328.1774571-1-anders.roxell@linaro.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 andrii.nakryiko@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  9 Nov 2023 18:43:28 +0100 you wrote:
> Crossbuilding selftests/bpf for architecture arm64, format specifies
> type error show up like.
> 
> xskxceiver.c:912:34: error: format specifies type 'int' but the argument
> has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
>  ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
>                                                                 ~~
>                                                                 %llu
>                 __func__, pkt->pkt_nb, meta->count);
>                                        ^~~~~~~~~~~
> xskxceiver.c:929:55: error: format specifies type 'unsigned long long' but
>  the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
>  ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
>                                     ~~~~             ^~~~
> 
> [...]

Here is the summary with links:
  - [PATCHv3] selftests: bpf: xskxceiver: ksft_print_msg: fix format type error
    https://git.kernel.org/bpf/bpf/c/fe69a1b1b6ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



