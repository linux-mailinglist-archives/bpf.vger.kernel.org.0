Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3C6380F7
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 23:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiKXWuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 17:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXWuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 17:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE4B85EFE
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 14:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC95062273
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 22:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 069D3C433D7;
        Thu, 24 Nov 2022 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669330216;
        bh=re/m1X/hMPoMsU+fX3RJk5qbm7e/Jn1PufMwR3FtY2U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GhIBHRIkFNl2sK34KkMP24IEiRaPvI+RYgw0/mZmNphdf1HJwXpl0TKwt6im0fPGZ
         z4wEDbftaoAcU+oURcvqH8GYP178dCInWlb95zDTYLasJAV8tmdPHjKEDXitMp+mY+
         00vf1vArpIsxnweqXsK9x8M/wGxg0GJYg4lOz7irs6gVE+9FOJ/jX5UnvD9JQHf/16
         RxXmJliujmu5b4NPjFHu+62bsp774lobJJjZDxaIkyqy24YzQ/0bAHdwbxEFMRE2HZ
         AYArJFkaUV70GmspuinbxYfZIQxcKOq8wLVVOdnc13+phAa5cVCQ+KASvVAx6THx0c
         WyaU1qYyKwsVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD986C5C7C6;
        Thu, 24 Nov 2022 22:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Don't mark arguments to fentry/fexit programs
 as trusted.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166933021590.23868.1067135773116658842.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Nov 2022 22:50:15 +0000
References: <20221124215314.55890-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20221124215314.55890-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, void@manifault.com, bpf@vger.kernel.org,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 24 Nov 2022 13:53:14 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The PTR_TRUSTED flag should only be applied to pointers where the verifier can
> guarantee that such pointers are valid.
> The fentry/fexit/fmod_ret programs are not in this category.
> Only arguments of SEC("tp_btf") and SEC("iter") programs are trusted
> (which have BPF_TRACE_RAW_TP and BPF_TRACE_ITER attach_type correspondingly)
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Don't mark arguments to fentry/fexit programs as trusted.
    https://git.kernel.org/bpf/bpf-next/c/c6b0337f0120

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


