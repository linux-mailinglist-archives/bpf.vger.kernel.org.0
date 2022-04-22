Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149CD50C35A
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 01:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiDVXIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 19:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiDVXH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 19:07:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C6B177CB1
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 15:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9841B8327C
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 22:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56E7FC385A4;
        Fri, 22 Apr 2022 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650667212;
        bh=l+4wsZH8ePfSWlqM4DZU6/j9QS76B4oIDC3dFRFITz4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uS9PGyGD1ydPxDK0lCa9cpufk/HIg8Nr7wYd4XG/dO8gX2k8rXzK+6qSSQEqwbsoi
         UiVNIHtiyEhM70d+YFjty0O9+GlBQvzwfY/8z1LXJ51ydPIQwsT8XoIqfldrcNntL0
         /ncudkiwnRwQ7ZIxJM+4R6Y8H1r03xT33RqYqcRGoDzuOxhKYVMU71sMrizl99qKb8
         HJ2Gj2+rzTGY4ZvwttDv64Hci3ZxWu2iRi+mW+UPap7VDcxFZncA/JhagDXjP85Jh9
         eCYH+2gf4kBCfjqRAD0yY7MWbthLnDvC1+AYlAqPDkoE9wsrTM8qSl+TXosAgaGvEA
         xxpPgayBN1/3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31B0CE8DD61;
        Fri, 22 Apr 2022 22:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] LINK_CREATE support for fentry/tp_btf/lsm
 attachments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165066721219.28625.1373870919607607891.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Apr 2022 22:40:12 +0000
References: <20220421033945.3602803-1-andrii@kernel.org>
In-Reply-To: <20220421033945.3602803-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, kuifeng@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 20 Apr 2022 20:39:42 -0700 you wrote:
> Wire up ability to attach bpf_link-based fentry/fexit/fmod_ret, tp_btf
> (BTF-aware raw tracepoints), and LSM programs through universal LINK_CREATE
> command, in addition to current BPF_RAW_TRACEPOINT_OPEN.
> 
> Teach libbpf to handle this LINK_CREATE/BPF_RAW_TRACEPOINT_OPEN split on older
> kernels transparently in universal low-level bpf_link_create() API for users
> convenience.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: allow attach TRACING programs through LINK_CREATE command
    https://git.kernel.org/bpf/bpf-next/c/df86ca0d2f0f
  - [bpf-next,2/3] libbpf: teach bpf_link_create() to fallback to bpf_raw_tracepoint_open()
    https://git.kernel.org/bpf/bpf-next/c/8462e0b46fe2
  - [bpf-next,3/3] selftests/bpf: switch fexit_stress to bpf_link_create() API
    https://git.kernel.org/bpf/bpf-next/c/fd0493a1e49e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


