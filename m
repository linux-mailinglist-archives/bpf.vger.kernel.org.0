Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4041C560B09
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 22:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiF2UaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiF2UaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 16:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386324F27
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 13:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE7F620FA
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 20:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78876C341C8;
        Wed, 29 Jun 2022 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656534615;
        bh=4nr2zo1Wf8CV/0hmlhY9wCuf+sFjOH+n8ubVpSimvjY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i5vZagqxhz9fFNjuRL8APL3Bx0BnX+zWRe78erfkgBtzyyM5TmgUSpJxBXhhCwXhx
         ec+TY366zirxZW1ZVbOBL08LfHqXYxW0MkDUP4FA0TUJlBW9cDL2lJQUuDhcRM4xn0
         mK2cgWnMhKM4nvzAbhFxWXtXUcDhVBX8tGnxiUX6RCOIjGI2JM30Tsdx/e+ePRJ0eM
         +EUZT4suJ71AMpFZkMhFJDXVkVTO9fmc8OI0a9rRl58+xc15mRgkL5VGHMyvaFUp5f
         AVCgGTB9faaA4ADv8RNXEiGkmLzdYhn+E1XCalLjQNG5nMeDKApLbuHD1wXLbS1nXH
         wYxulGstVv0Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50D56E49FA0;
        Wed, 29 Jun 2022 20:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v11 00/11] bpf: cgroup_sock lsm flavor
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165653461532.29579.2794486523144840306.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Jun 2022 20:30:15 +0000
References: <20220628174314.1216643-1-sdf@google.com>
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 28 Jun 2022 10:43:03 -0700 you wrote:
> This series implements new lsm flavor for attaching per-cgroup programs to
> existing lsm hooks. The cgroup is taken out of 'current', unless
> the first argument of the hook is 'struct socket'. In this case,
> the cgroup association is taken out of socket. The attachment
> looks like a regular per-cgroup attachment: we add new BPF_LSM_CGROUP
> attach type which, together with attach_btf_id, signals per-cgroup lsm.
> Behind the scenes, we allocate trampoline shim program and
> attach to lsm. This program looks up cgroup from current/socket
> and runs cgroup's effective prog array. The rest of the per-cgroup BPF
> stays the same: hierarchy, local storage, retval conventions
> (return 1 == success).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v11,01/11] bpf: add bpf_func_t and trampoline helpers
    https://git.kernel.org/bpf/bpf-next/c/af3f4134006b
  - [bpf-next,v11,02/11] bpf: convert cgroup_bpf.progs to hlist
    https://git.kernel.org/bpf/bpf-next/c/00442143a2ab
  - [bpf-next,v11,03/11] bpf: per-cgroup lsm flavor
    https://git.kernel.org/bpf/bpf-next/c/69fd337a975c
  - [bpf-next,v11,04/11] bpf: minimize number of allocated lsm slots per program
    https://git.kernel.org/bpf/bpf-next/c/c0e19f2c9a3e
  - [bpf-next,v11,05/11] bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP
    https://git.kernel.org/bpf/bpf-next/c/b79c9fc9551b
  - [bpf-next,v11,06/11] bpf: expose bpf_{g,s}etsockopt to lsm cgroup
    https://git.kernel.org/bpf/bpf-next/c/9113d7e48e91
  - [bpf-next,v11,07/11] tools/bpf: Sync btf_ids.h to tools
    https://git.kernel.org/bpf/bpf-next/c/3b34bcb946c2
  - [bpf-next,v11,08/11] libbpf: add lsm_cgoup_sock type
    https://git.kernel.org/bpf/bpf-next/c/bffcf34878b1
  - [bpf-next,v11,09/11] libbpf: implement bpf_prog_query_opts
    https://git.kernel.org/bpf/bpf-next/c/a4b2f3cf699f
  - [bpf-next,v11,10/11] bpftool: implement cgroup tree for BPF_LSM_CGROUP
    https://git.kernel.org/bpf/bpf-next/c/596f5fb2ea2a
  - [bpf-next,v11,11/11] selftests/bpf: lsm_cgroup functional test
    https://git.kernel.org/bpf/bpf-next/c/dca85aac8895

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


