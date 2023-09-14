Return-Path: <bpf+bounces-10058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB117A0B24
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9B91C20C41
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3442925105;
	Thu, 14 Sep 2023 17:00:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42A14F6B;
	Thu, 14 Sep 2023 17:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D759FC433C8;
	Thu, 14 Sep 2023 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694710830;
	bh=Kip5grhzjzPCjXLhT14s3Z3y+fwxwyDlWBabAsm+07c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O46MvJ5uaqIXRc6taXai6zoRI0NOz25PzYETYjTtSkmrrEeCiORvnuEJ3BtxxGE8G
	 7WXe01nVI6u63e2hvG0zc51s/PoKeEnnnKHmZ1JIIO8y2jL+MlHSQMD2qFN/ArsHhK
	 8JpeM69FU5zo1wBUgdM7xPlQmCmJsxyvtP9poW3u0rS9qN3GuYH+0U6iaygQZYxVe2
	 Mt/GzVzAmtCjRDUuKWZFzJzgDGaL+tLMurz8S3j0AFtjyyfhwz6r/jASESWn8yqxT4
	 zOg+t5M/guNl8j06qcEpgiZIZDV+qDGAO4KOMCsGaJAW48UuEA8JNJ2W2nHcVoILr3
	 gMLGoXb9liqDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B42F9E22AF4;
	Thu, 14 Sep 2023 17:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/10] seltests/xsk: various improvements to
 xskxceiver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169471083073.13698.15966940549889255467.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 17:00:30 +0000
References: <20230914084900.492-1-magnus.karlsson@gmail.com>
In-Reply-To: <20230914084900.492-1-magnus.karlsson@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 bpf@vger.kernel.org, yhs@fb.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Sep 2023 10:48:47 +0200 you wrote:
> This patch set implements several improvements to the xsk selftests
> test suite that I thought were useful while debugging the xsk
> multi-buffer code and tests. The largest new feature is the ability to
> be able to execute a single test instead of the whole test suite. This
> required some surgery on the current code, details below.
> 
> Anatomy of the path set:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/10] selftests/xsk: print per packet info in verbose mode
    https://git.kernel.org/bpf/bpf-next/c/2d2712caf44b
  - [bpf-next,v4,02/10] selftests/xsk: add timeout for Tx thread
    https://git.kernel.org/bpf/bpf-next/c/64370d7c8a91
  - [bpf-next,v4,03/10] selftests/xsk: add option to only run tests in a single mode
    https://git.kernel.org/bpf/bpf-next/c/3956bc34b66c
  - [bpf-next,v4,04/10] selftests/xsk: move all tests to separate functions
    https://git.kernel.org/bpf/bpf-next/c/13c341c45083
  - [bpf-next,v4,05/10] selftests/xsk: declare test names in struct
    https://git.kernel.org/bpf/bpf-next/c/f20fbcd077eb
  - [bpf-next,v4,06/10] selftests/xsk: add option that lists all tests
    https://git.kernel.org/bpf/bpf-next/c/c53dab7d39ab
  - [bpf-next,v4,07/10] selftests/xsk: add option to run single test
    https://git.kernel.org/bpf/bpf-next/c/146e30554a53
  - [bpf-next,v4,08/10] selftests/xsk: use ksft_print_msg uniformly
    https://git.kernel.org/bpf/bpf-next/c/7c3fcf088ba3
  - [bpf-next,v4,09/10] selftests/xsk: fail single test instead of all tests
    https://git.kernel.org/bpf/bpf-next/c/5fc494d5ab41
  - [bpf-next,v4,10/10] selftests/xsk: display command line options with -h
    https://git.kernel.org/bpf/bpf-next/c/4a5f0ba55f46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



