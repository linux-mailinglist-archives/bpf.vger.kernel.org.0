Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA957A451
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiGSQuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiGSQuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 12:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A31491CA
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 09:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92F3661A56
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF256C341CB;
        Tue, 19 Jul 2022 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658249415;
        bh=bZkciFgXkcWsiApsDI3rFVX79hFcNLhqPeuEp19L2n4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iRbT+h5aFjGWx0b491Lo461XsybG7vyEvBEzLh9Ti7DiRTqLhEx684+fn6PCD2ner
         eXkSGzgd8pSCPOGN9cm+pizpBlQX9DmS+VirCsuPIGaEaeSkTMCBw2vVr2kLtEDyxa
         Mxj5nBRoG07omIMlOqiVkE5ecBQrYHoElFlN7lA9NOdZ52UlVLfAjTI8XjaUsLClsi
         CbKsYRAPO/siszpoxKSXetewF2dkWgYtuvcuAgdHBCMk/QD7KrvVoEfB4hA17yWm+2
         O88ENU74Ix3rqXlE8aGtvib/0BRUE/lgNayrD0emrcl2+OV/9DG7iwK7qR3wT/DKXb
         UgISFEDJLqQkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0D30D9DDDB;
        Tue, 19 Jul 2022 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/5] Add SEC("ksyscall") support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165824941564.16633.11728582955522641826.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 16:50:15 +0000
References: <20220714070755.3235561-1-andrii@kernel.org>
In-Reply-To: <20220714070755.3235561-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 14 Jul 2022 00:07:50 -0700 you wrote:
> Add SEC("ksyscall")/SEC("kretsyscall") sections and corresponding
> bpf_program__attach_ksyscall() API that simplifies tracing kernel syscalls
> through kprobe mechanism. Kprobing syscalls isn't trivial due to varying
> syscall handler names in the kernel and various ways syscall argument are
> passed, depending on kernel architecture and configuration. SEC("ksyscall")
> allows user to not care about such details and just get access to syscall
> input arguments, while libbpf takes care of necessary feature detection logic.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/5] libbpf: generalize virtual __kconfig externs and use it for USDT
    https://git.kernel.org/bpf/bpf-next/c/55d00c37ebc3
  - [v2,bpf-next,2/5] selftests/bpf: add test of __weak unknown virtual __kconfig extern
    https://git.kernel.org/bpf/bpf-next/c/ce6dc74a0a4a
  - [v2,bpf-next,3/5] libbpf: improve BPF_KPROBE_SYSCALL macro and rename it to BPF_KSYSCALL
    https://git.kernel.org/bpf/bpf-next/c/6f5d467d55f0
  - [v2,bpf-next,4/5] libbpf: add ksyscall/kretsyscall sections support for syscall kprobes
    https://git.kernel.org/bpf/bpf-next/c/708ac5bea0ce
  - [v2,bpf-next,5/5] selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests
    https://git.kernel.org/bpf/bpf-next/c/d814ed62d3d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


