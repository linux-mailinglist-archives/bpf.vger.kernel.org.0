Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DEB601648
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiJQSaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJQSaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 14:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D692E15823
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 11:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84BB6B81A07
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 18:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ADCBC43142;
        Mon, 17 Oct 2022 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666031417;
        bh=jSRRu5AHEM1tx5JqC+g935vjzZy5Ife8mLnHVTQJVPg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R3ZBU1oo5k4aCwOC8HHkKU+oeBGyXjbNQsGdtESDLRCl+fW7D2C9KpqpR6FzZjjl7
         fDTxto9pw5jcp4mcLNLQ5W9BlgcK1Ywu5rWexDaSU5S1axWhyTLDqTQ3n5QR8a4siF
         bVOrcaUjAU9yOd/Rn4CFJf+0fbeL1n8IntMM1q96Nr8s5nZIdwRPGdMxEJ2dcs7480
         a11CYWZ3vag5u8rTFM4JL9HO9yZcO28WX4hF/1nHqkg3poR9UiE2hXfRT+boOUFPDR
         voRtdt28rG7soyJzo8sVKCrKw36miIwHiTH6nn2dcPhbs/qGZKWiYwdSlIczY6UqKH
         g368uk6U1Ud3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CC04E270ED;
        Mon, 17 Oct 2022 18:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Add reproducer for decl_tag in
 func_proto return type
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166603141711.4727.6436294411941106100.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Oct 2022 18:30:17 +0000
References: <20221015002444.2680969-1-sdf@google.com>
In-Reply-To: <20221015002444.2680969-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, martin.lau@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 14 Oct 2022 17:24:43 -0700 you wrote:
> It should trigger a WARN_ON_ONCE in btf_type_id_size.
> 
>      btf_func_proto_check kernel/bpf/btf.c:4447 [inline]
>      btf_check_all_types kernel/bpf/btf.c:4723 [inline]
>      btf_parse_type_sec kernel/bpf/btf.c:4752 [inline]
>      btf_parse kernel/bpf/btf.c:5026 [inline]
>      btf_new_fd+0x1926/0x1e70 kernel/bpf/btf.c:6892
>      bpf_btf_load kernel/bpf/syscall.c:4324 [inline]
>      __sys_bpf+0xb7d/0x4cf0 kernel/bpf/syscall.c:5010
>      __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
>      __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
>      __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5067
>      do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>      do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>      entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Add reproducer for decl_tag in func_proto return type
    https://git.kernel.org/bpf/bpf/c/35cc9d622e8c
  - [bpf-next,2/2] bpf: prevent decl_tag from being referenced in func_proto
    https://git.kernel.org/bpf/bpf/c/ea68376c8bed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


