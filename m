Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76220540859
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 19:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349044AbiFGR5t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344460AbiFGR52 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 13:57:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D11149153
        for <bpf@vger.kernel.org>; Tue,  7 Jun 2022 10:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16D08B82285
        for <bpf@vger.kernel.org>; Tue,  7 Jun 2022 17:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF715C34115;
        Tue,  7 Jun 2022 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654623617;
        bh=aYU22WvdZiB0ccBRKk57IpwAo0BX+yFgYbJzHmn/yRk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IP62N8034+T2JDlpxg5/fh473mPj1exSuFXIj824F5yXxMo0hTg4Si2sxobUWKpXR
         CaxlzLf1w/ELoGJ0KUbL3w7xhDmmVMxj1KFdpo7ILIWZEuVwI3gIcczyAyMiW2c6ww
         CGa9UfQRZaiavK3mZJScu3rnrxUN/iQxEQ0mEzvOWIPanuLw3sg/0RbN4S1Zrv3yjM
         MHjTzPDiU8k+/7rx4JRNVNDYTSeDAN9qdpd8b/T8VupJ/PEs4oigV6bBKAU8/EHvbf
         jWjCNo/CzrebMCz8VAboDMohFcbbhobhgROWhHbxhb4dPfKzVftDTyoeoAMMNNjFDH
         aceVmt8S7jiew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABD11E737FC;
        Tue,  7 Jun 2022 17:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/17] bpf: Add 64bit enum value support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165462361769.5218.5561986964163226721.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Jun 2022 17:40:17 +0000
References: <20220607062554.3716237-1-yhs@fb.com>
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 6 Jun 2022 23:25:54 -0700 you wrote:
> Currently, btf only supports upto 32bit enum value with BTF_KIND_ENUM.
> But in kernel, some enum has 64bit values, e.g., in uapi bpf.h, we have
>   enum {
>         BPF_F_INDEX_MASK                = 0xffffffffULL,
>         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>   };
> With BTF_KIND_ENUM, the value for BPF_F_CTXLEN_MASK will be encoded
> as 0 which is incorrect.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/17] bpf: Add btf enum64 support
    https://git.kernel.org/bpf/bpf-next/c/6089fb325cf7
  - [bpf-next,v5,02/17] libbpf: Permit 64bit relocation value
    https://git.kernel.org/bpf/bpf-next/c/776281652ddc
  - [bpf-next,v5,03/17] libbpf: Fix an error in 64bit relocation value computation
    https://git.kernel.org/bpf/bpf-next/c/b58b2b3a3122
  - [bpf-next,v5,04/17] libbpf: Refactor btf__add_enum() for future code sharing
    https://git.kernel.org/bpf/bpf-next/c/8479aa752226
  - [bpf-next,v5,05/17] libbpf: Add enum64 parsing and new enum64 public API
    https://git.kernel.org/bpf/bpf-next/c/dffbbdc2d988
  - [bpf-next,v5,06/17] libbpf: Add enum64 deduplication support
    https://git.kernel.org/bpf/bpf-next/c/2ef2026349cf
  - [bpf-next,v5,07/17] libbpf: Add enum64 support for btf_dump
    https://git.kernel.org/bpf/bpf-next/c/d90ec262b35b
  - [bpf-next,v5,08/17] libbpf: Add enum64 sanitization
    https://git.kernel.org/bpf/bpf-next/c/f2a625889bb8
  - [bpf-next,v5,09/17] libbpf: Add enum64 support for bpf linking
    https://git.kernel.org/bpf/bpf-next/c/6ec7d79be202
  - [bpf-next,v5,10/17] libbpf: Add enum64 relocation support
    https://git.kernel.org/bpf/bpf-next/c/23b2a3a8f63a
  - [bpf-next,v5,11/17] bpftool: Add btf enum64 support
    https://git.kernel.org/bpf/bpf-next/c/58a53978fdf6
  - [bpf-next,v5,12/17] selftests/bpf: Fix selftests failure
    https://git.kernel.org/bpf/bpf-next/c/d932815a4394
  - [bpf-next,v5,13/17] selftests/bpf: Test new enum kflag and enum64 API functions
    https://git.kernel.org/bpf/bpf-next/c/2b7301457ffe
  - [bpf-next,v5,14/17] selftests/bpf: Add BTF_KIND_ENUM64 unit tests
    https://git.kernel.org/bpf/bpf-next/c/3b5325186dfa
  - [bpf-next,v5,15/17] selftests/bpf: Test BTF_KIND_ENUM64 for deduplication
    https://git.kernel.org/bpf/bpf-next/c/adc26d134ef3
  - [bpf-next,v5,16/17] selftests/bpf: Add a test for enum64 value relocations
    https://git.kernel.org/bpf/bpf-next/c/f4db3dd5284d
  - [bpf-next,v5,17/17] docs/bpf: Update documentation for BTF_KIND_ENUM64 support
    https://git.kernel.org/bpf/bpf-next/c/61dbd5982964

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


