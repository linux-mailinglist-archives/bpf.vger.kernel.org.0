Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ABC5F6A9C
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 17:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiJFPaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 11:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiJFPaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 11:30:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AC4F681
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 08:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCB2DB820C0
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 15:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8841EC433D7;
        Thu,  6 Oct 2022 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665070216;
        bh=MNoap0c7m9RNVSXSpNZ8e6h0MSMp3tcS9Yw/njg2hDk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kKyVi/OWtv63yS3YLZ5m+z/PB9D7CyQVj6uxGV2QPeIot9CFsHheqO5QmWpayyC/7
         crKmjseVoyxyksh7HIBsiEZHcyFSEsdS287sZGe6+4jp3CXGg1FESaV42FB0k1iYBH
         xbnyWd/P56JcH55kEN2eSsXC5fstmyRKO5zxQlMtuBPqhUUjissR7lZzt7op7YOV8Z
         u8kY/mYf4y9BRIy1LomRkGWXNx/A5ojkauOYRa98zwGeBDlAtpKlF5u1i2RAwLXbfK
         8EUw4CbJGSOThIjigUnAI1bthjH1uIBrg/YHDDIOK/uOLbzR+Hy+RlBFt/tllFgvIQ
         +Y/gLdgw5SgmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67BA1E45BE3;
        Thu,  6 Oct 2022 15:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: explicitly define BPF_FUNC_xxx integer
 values
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166507021639.23640.5377002138284115237.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Oct 2022 15:30:16 +0000
References: <20221006042452.2089843-1-andrii@kernel.org>
In-Reply-To: <20221006042452.2089843-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, quentin@isovalent.com, andrea.terzolo@polito.it
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 5 Oct 2022 21:24:51 -0700 you wrote:
> Historically enum bpf_func_id's BPF_FUNC_xxx enumerators relied on
> implicit sequential values being assigned by compiler. This is
> convenient, as new BPF helpers are always added at the very end, but it
> also has its downsides, some of them being:
> 
>   - with over 200 helpers now it's very hard to know what's each helper's ID,
>     which is often important to know when working with BPF assembly (e.g.,
>     by dumping raw bpf assembly instructions with llvm-objdump -d
>     command). it's possible to work around this by looking into vmlinux.h,
>     dumping /sys/btf/kernel/vmlinux, looking at libbpf-provided
>     bpf_helper_defs.h, etc. But it always feels like an unnecessary step
>     and one should be able to quickly figure this out from UAPI header.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: explicitly define BPF_FUNC_xxx integer values
    https://git.kernel.org/bpf/bpf-next/c/8a76145a2ec2
  - [v2,bpf-next,2/2] scripts/bpf_doc.py: update logic to not assume sequential enum values
    https://git.kernel.org/bpf/bpf-next/c/ce3e44a09dce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


