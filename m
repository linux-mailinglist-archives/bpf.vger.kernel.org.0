Return-Path: <bpf+bounces-8444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D47866E3
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 06:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA461C20DC4
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 04:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C77185D;
	Thu, 24 Aug 2023 04:50:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7317E1
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 04:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3C75C433C9;
	Thu, 24 Aug 2023 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692852625;
	bh=N9/Mx63bgJQ6Jdgio9+XaPjJI1914MnAxVE9i8+SpYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SAhPSmxp4SoxUCy26lnidKV9tS2K0zmpAnNk7EvLJ/IAhSRfWQAu3OUaSXQCfaCrg
	 St6ZD/HAG/tGqREsPVHa+MkEWYYj9t2l0+kv1V9keA+HWVTrMIljNrCvcdveYYC6Rl
	 QoP5lxUeIDl/EVDsgWn365s3TFkhEgKNw1v0cNb/X0X671Wt4lOpPcseEZUe8DG0g+
	 NmH0ncHwOwIWvD3hE0+yQ930HMCIeKoK4Khb7/QGkJzaDs/V0a4uljxUURBjd95uFV
	 jTF8g1OE0KPb3n/SXOOIJaOe1gCAIvage+iraBNWOA2lwwigvnb6sRzd8LK2fEhpoO
	 x3AZmY3ugNEbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B81DFC595CE;
	Thu, 24 Aug 2023 04:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: add uprobe_multi test binary to
 .gitignore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169285262575.9976.10611134377469617771.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 04:50:25 +0000
References: <20230824000016.2658017-1-andrii@kernel.org>
In-Reply-To: <20230824000016.2658017-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 23 Aug 2023 17:00:15 -0700 you wrote:
> It seems like it was forgotten to add uprobe_multi binary to .gitignore.
> Fix this trivial omission.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: add uprobe_multi test binary to .gitignore
    https://git.kernel.org/bpf/bpf-next/c/a182e64147f7
  - [bpf-next,2/2] libbpf: fix signedness determination in CO-RE relo handling logic
    https://git.kernel.org/bpf/bpf-next/c/f3bdb54f09ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



