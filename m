Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E36C520102
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiEIPYL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiEIPYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 11:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CF28FE9E
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 08:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 964B961133
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 15:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F26A9C385AF;
        Mon,  9 May 2022 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652109613;
        bh=pJ3gNBKMgwuuIqn5OLB1OB5XQaSERssmFywmO2iJmSQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FM08zcyAZhiVcgFY+bcivRlam7Zr2ZDdHfEKE+Vl7hZ14kOSlg96s4oghaOigaGcw
         z0eVe3uOb63QlM1pXCYkpHQGEqRnjAiNOzStNsqhN2nwE2eug8Jhr7zuzJeciI9AHF
         dqx0yhId8moo+mg2sgl1gUH21F0WCY6RM9oCpkKtR7b5C15beL3ZPF86i965zVNr3N
         W85kfAU/hSf3xW6x977fo8+cqAsz8pEzc/CeH+mhdqRM3nKb6ijSzfmXcBum7Uww6Y
         qT15iqy/SpehwM2qc/42xgeg4iQ0rww+rxFXgIbhNlqaq+ySpU/R9hqpomUoaTkZsL
         xrfdAZdgUV2hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6E5EF0392B;
        Mon,  9 May 2022 15:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/9] Misc libbpf fixes and small improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165210961287.23832.9091333940199617708.git-patchwork-notify@kernel.org>
Date:   Mon, 09 May 2022 15:20:12 +0000
References: <20220509004148.1801791-1-andrii@kernel.org>
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 8 May 2022 17:41:39 -0700 you wrote:
> This patch set is a mix of mostly mutually unrelated libbpf and selftests
> fixes and improvements. Individual patches provide details on each one.
> 
> Andrii Nakryiko (9):
>   selftests/bpf: prevent skeleton generation race
>   libbpf: make __kptr and __kptr_ref unconditionally use btf_type_tag()
>     attr
>   libbpf: improve usability of field-based CO-RE helpers
>   selftests/bpf: use both syntaxes for field-based CO-RE helpers
>   libbpf: complete field-based CO-RE helpers with field offset helper
>   selftests/bpf: add bpf_core_field_offset() tests
>   libbpf: provide barrier() and barrier_var() in bpf_helpers.h
>   libbpf: automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary
>   selftests/bpf: test libbpf's ringbuf size fix up logic
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/9] selftests/bpf: prevent skeleton generation race
    https://git.kernel.org/bpf/bpf-next/c/1e2666e029e5
  - [bpf-next,2/9] libbpf: make __kptr and __kptr_ref unconditionally use btf_type_tag() attr
    https://git.kernel.org/bpf/bpf-next/c/8e2f618e8be6
  - [bpf-next,3/9] libbpf: improve usability of field-based CO-RE helpers
    https://git.kernel.org/bpf/bpf-next/c/73d0280f6b79
  - [bpf-next,4/9] selftests/bpf: use both syntaxes for field-based CO-RE helpers
    https://git.kernel.org/bpf/bpf-next/c/2a4ca46b7d2a
  - [bpf-next,5/9] libbpf: complete field-based CO-RE helpers with field offset helper
    https://git.kernel.org/bpf/bpf-next/c/7715f549a9d8
  - [bpf-next,6/9] selftests/bpf: add bpf_core_field_offset() tests
    https://git.kernel.org/bpf/bpf-next/c/785c3342cf6c
  - [bpf-next,7/9] libbpf: provide barrier() and barrier_var() in bpf_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/f760d0537925
  - [bpf-next,8/9] libbpf: automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary
    https://git.kernel.org/bpf/bpf-next/c/0087a681fa8c
  - [bpf-next,9/9] selftests/bpf: test libbpf's ringbuf size fix up logic
    https://git.kernel.org/bpf/bpf-next/c/7b3a06382442

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


