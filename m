Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A76DE0B4
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjDKQMr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjDKQLj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 12:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA9658C
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 09:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29F0A6290C
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 16:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E8ABC4339B;
        Tue, 11 Apr 2023 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681229421;
        bh=fyGGzkoZlolcX1ptvVdOE8vddsm6aIHwJIQadtwU7y8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uDTePWDDCYPqdsIEZrbemZmJ+u7xm2BMgP/8No1n2xJ2/XuedGB5VtnX5Nyw7d660
         u3yZIYyXZJk+0LFOnNHr93u5zuiZWuL73pmqJnCENaWxu8/SRh9ZUC8F4kNgnFll/+
         zc2oDQnm7mlOYwzUqWAHpjFCc7w47b2zxGyb8Ai55vpFRBTWZ9ZFtDf8YGEuL+xa4D
         3rFr1kBo6eWI9URPoJIknYwrXHP/ak9l6TvnTvqnvIb1/+9Xk9h6E1sn+tYduIjGaU
         72/DzXG7A3YgkiPrn2qXaLNpcH5G9J2j1ewvuMvP2u3wP4ybUbKDan1wDWzUTwECql
         m76MjQa2fQOZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 626BAE52446;
        Tue, 11 Apr 2023 16:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 00/19] BPF verifier rotating log
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168122942139.10317.9668007640331547908.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 16:10:21 +0000
References: <20230406234205.323208-1-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, lmb@isovalent.com, timo@incline.eu,
        robin.goegge@isovalent.com, kernel-team@meta.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 6 Apr 2023 16:41:46 -0700 you wrote:
> This patch set changes BPF verifier log behavior to behave as a rotating log,
> by default. If user-supplied log buffer is big enough to contain entire
> verifier log output, there is no effective difference. But where previously
> user supplied too small log buffer and would get -ENOSPC error result and the
> beginning part of the verifier log, now there will be no error and user will
> get ending part of verifier log filling up user-supplied log buffer.  Which
> is, in absolute majority of cases, is exactly what's useful, relevant, and
> what users want and need, as the ending of the verifier log is containing
> details of verifier failure and relevant state that got us to that failure. So
> this rotating mode is made default, but for some niche advanced debugging
> scenarios it's possible to request old behavior by specifying additional
> BPF_LOG_FIXED (8) flag.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,01/19] bpf: split off basic BPF verifier log into separate file
    https://git.kernel.org/bpf/bpf-next/c/4294a0a7ab62
  - [v4,bpf-next,02/19] bpf: remove minimum size restrictions on verifier log buffer
    https://git.kernel.org/bpf/bpf-next/c/03cc3aa6a533
  - [v4,bpf-next,03/19] bpf: switch BPF verifier log to be a rotating log by default
    https://git.kernel.org/bpf/bpf-next/c/121664093803
  - [v4,bpf-next,04/19] libbpf: don't enforce unnecessary verifier log restrictions on libbpf side
    https://git.kernel.org/bpf/bpf-next/c/e0aee1facccf
  - [v4,bpf-next,05/19] veristat: add more veristat control over verifier log options
    https://git.kernel.org/bpf/bpf-next/c/d0d75c67c45a
  - [v4,bpf-next,06/19] selftests/bpf: add fixed vs rotating verifier log tests
    https://git.kernel.org/bpf/bpf-next/c/b1a7a480a112
  - [v4,bpf-next,07/19] bpf: ignore verifier log reset in BPF_LOG_KERNEL mode
    https://git.kernel.org/bpf/bpf-next/c/24bc80887adb
  - [v4,bpf-next,08/19] bpf: fix missing -EFAULT return on user log buf error in btf_parse()
    https://git.kernel.org/bpf/bpf-next/c/971fb5057d78
  - [v4,bpf-next,09/19] bpf: avoid incorrect -EFAULT error in BPF_LOG_KERNEL mode
    https://git.kernel.org/bpf/bpf-next/c/cbedb42a0da3
  - [v4,bpf-next,10/19] bpf: simplify logging-related error conditions handling
    https://git.kernel.org/bpf/bpf-next/c/8a6ca6bc553e
  - [v4,bpf-next,11/19] bpf: keep track of total log content size in both fixed and rolling modes
    https://git.kernel.org/bpf/bpf-next/c/fa1c7d5cc404
  - [v4,bpf-next,12/19] bpf: add log_true_size output field to return necessary log buffer size
    https://git.kernel.org/bpf/bpf-next/c/47a71c1f9af0
  - [v4,bpf-next,13/19] bpf: simplify internal verifier log interface
    https://git.kernel.org/bpf/bpf-next/c/bdcab4144f5d
  - [v4,bpf-next,14/19] bpf: relax log_buf NULL conditions when log_level>0 is requested
    https://git.kernel.org/bpf/bpf-next/c/fac08d45e253
  - [v4,bpf-next,15/19] libbpf: wire through log_true_size returned from kernel for BPF_PROG_LOAD
    https://git.kernel.org/bpf/bpf-next/c/94e55c0fdaf4
  - [v4,bpf-next,16/19] libbpf: wire through log_true_size for bpf_btf_load() API
    https://git.kernel.org/bpf/bpf-next/c/097d8002b754
  - [v4,bpf-next,17/19] selftests/bpf: add tests to validate log_true_size feature
    https://git.kernel.org/bpf/bpf-next/c/5787540827a9
  - [v4,bpf-next,18/19] selftests/bpf: add testing of log_buf==NULL condition for BPF_PROG_LOAD
    https://git.kernel.org/bpf/bpf-next/c/be983f44274f
  - [v4,bpf-next,19/19] selftests/bpf: add verifier log tests for BPF_BTF_LOAD command
    https://git.kernel.org/bpf/bpf-next/c/054b6c7866c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


