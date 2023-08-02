Return-Path: <bpf+bounces-6759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6476D9C0
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 23:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE42E1C21340
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67372134B7;
	Wed,  2 Aug 2023 21:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC392D51F;
	Wed,  2 Aug 2023 21:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58895C433C7;
	Wed,  2 Aug 2023 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012423;
	bh=NLSSRe4RVRV0fKoewTCaMcbMjSsMEN9rztajQMsWR2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=esycnZjyO0VbjW17K3U6sGAkEzCF+dRNGe4hD+KeQ4ImP+IQhHmvmvZARPoH+XNXs
	 MsCJMYgKdRrUTCV208xUdg08KulgKKbrc3fsyZTKZ1+1VEuE6r9kGDo0xwSDqnKdrj
	 2qhT2/evFQwN6oEo35S4duyZOiZNfG10og3yRd++S4qFSVeIGPzG7m8Z96N6Tcmh3Q
	 FiWvXpGSdxVML/QTjDej3Kyisy3yOvURBAqz//gfdCTSDKAb+Ct9u7hxHe7IwQl2Fl
	 L4YNh9BYpo/1Kc1DmFQacYkWHxfXiM9osnaneUzRAmEhZUetyh8chL5LAJd9rTGXfs
	 HN0lvuxv5kRbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37263E270D3;
	Wed,  2 Aug 2023 21:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] bpf,
 xdp: Add tracepoint to xdp attaching failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169101242321.7476.5572550064226640292.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 21:40:23 +0000
References: <20230801142621.7925-1-hffilwlqm@gmail.com>
In-Reply-To: <20230801142621.7925-1-hffilwlqm@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com, shuah@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  1 Aug 2023 22:26:19 +0800 you wrote:
> This series introduces a new tracepoint in bpf_xdp_link_attach(). By
> this tracepoint, error message will be captured when error happens in
> dev_xdp_attach(), e.g. invalid attaching flags.
> 
> v4 -> v5:
> * Initialise the extack variable.
> * Fix code style issue of variable declaration lines.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf, xdp: Add tracepoint to xdp attaching failure
    https://git.kernel.org/bpf/bpf-next/c/bf4ea1d0b2cb
  - [bpf-next,v5,2/2] selftests/bpf: Add testcase for xdp attaching failure tracepoint
    https://git.kernel.org/bpf/bpf-next/c/7fedbf32fcc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



