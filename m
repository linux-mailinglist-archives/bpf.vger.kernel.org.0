Return-Path: <bpf+bounces-10017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A287A04B2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BF21C20DBC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34AE18E3A;
	Thu, 14 Sep 2023 13:00:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FC241E0
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 13:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 180ECC433CA;
	Thu, 14 Sep 2023 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694696426;
	bh=JnGXz16l4E8oLSfnUoqmt+jwbuOV16bjQ7fZpkFPPLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vGo51jYB3aHh9P3teaIVRdwy/cf6PWMv7k9BQUbAbH6DpifUN0tnSfEngCJLPWDkg
	 2MGQUV6phoiR2WUZbp4twmGj83j/tLBv79VaZc22sk/awKf9DVr6KyCwJwcKoWs25+
	 Ap3Ms0Rb3b8KEg9ntDECyV+O2vPrP1PL0IYpPW671ODRzTRgwdAN2PU4mUtPYc8k7u
	 ChXAt4ZLKH86s4gJz1RldZ8vnBQqxuVQZsV8kpl9TN9pnm3lBoUKjQy2DVifMjO5ta
	 YmeVF4Dt5clktxZ8GI8b1C/8ypB5y6/Lbesfpf1sI0pBcyNCuopUUnrm/0GxoulJ3x
	 uTOGABMqwJNgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02010E1C280;
	Thu, 14 Sep 2023 13:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/11] Implement cpuv4 support for s390x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169469642600.18020.9158299367745661864.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 13:00:26 +0000
References: <20230830011128.1415752-1-iii@linux.ibm.com>
In-Reply-To: <20230830011128.1415752-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 30 Aug 2023 03:07:41 +0200 you wrote:
> Hi,
> 
> This series adds the cpuv4 support to the s390x eBPF JIT.
> Patches 1-4 are preliminary bugfixes.
> Patches 5-9 implement the new instructions.
> Patches 10-11 enable the tests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/11] bpf: Disable zero-extension for BPF_MEMSX
    (no matching commit)
  - [bpf-next,02/11] net: netfilter: Adjust timeouts of non-confirmed CTs in bpf_ct_insert_entry()
    https://git.kernel.org/bpf/bpf/c/6bd5bcb18f94
  - [bpf-next,03/11] selftests/bpf: Unmount the cgroup2 work directory
    (no matching commit)
  - [bpf-next,04/11] selftests/bpf: Add big-endian support to the ldsx test
    (no matching commit)
  - [bpf-next,05/11] s390/bpf: Implement BPF_MOV | BPF_X with sign-extension
    (no matching commit)
  - [bpf-next,06/11] s390/bpf: Implement BPF_MEMSX
    (no matching commit)
  - [bpf-next,07/11] s390/bpf: Implement unconditional byte swap
    (no matching commit)
  - [bpf-next,08/11] s390/bpf: Implement unconditional jump with 32-bit offset
    (no matching commit)
  - [bpf-next,09/11] s390/bpf: Implement signed division
    (no matching commit)
  - [bpf-next,10/11] selftests/bpf: Enable the cpuv4 tests for s390x
    (no matching commit)
  - [bpf-next,11/11] selftests/bpf: Trim DENYLIST.s390x
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



