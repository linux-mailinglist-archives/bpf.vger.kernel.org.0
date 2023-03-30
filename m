Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F86CF842
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 02:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjC3AaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC3AaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 20:30:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E7955AE
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 17:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC42AB82565
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FA58C4339B;
        Thu, 30 Mar 2023 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680136220;
        bh=yjQE95Rbwp5D4l24ejQ5x7Dm0yU89ajJDQBfwJEIbk0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fnQ5r06GMnJgilVkRYsrP8sD22K9fnnqCF0m6jjSQwEY3U6SzIxQORg2TlAYHSTTC
         ZvcZzHApCZMHs7g91yYQwrD/hnhPQ4mKRMe7dSEHHWLWbbDynJqg02vq/PC0A70ueB
         jwdSHjaNJmngDKHMaU42rAPqcqISFqGIFcWD9QMz1/YcBMfAiYUnIQfYsN3ST+zNDd
         ECc/gLqTwmQXAszxUDiXKCh3i5n5TzCoTGnY1xvR+YNX9AQLokZdphdXgbKujAFMWK
         ttm+8ABH6VH8d0PTzmLK4SqpXZgIQOLI+sKs0a7gzJ/3lNYgo/CeQ2V7rQGqnCLDJt
         nO3aZEs/tOpIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B0DCC41612;
        Thu, 30 Mar 2023 00:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/3] veristat: add better support of freplace
 programs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168013622041.690.10021346688734338264.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Mar 2023 00:30:20 +0000
References: <20230327185202.1929145-1-andrii@kernel.org>
In-Reply-To: <20230327185202.1929145-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 27 Mar 2023 11:51:59 -0700 you wrote:
> Teach veristat how to deal with freplace BPF programs. As they can't be
> directly loaded by veristat without custom user-space part that sets correct
> target program FD, veristat always fails freplace programs. This patch set
> teaches veristat to guess target program type that will be inherited by
> freplace program itself, and subtitute it for BPF_PROG_TYPE_EXT (freplace) one
> for the purposes of BPF verification.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/3] libbpf: disassociate section handler on explicit bpf_program__set_type() call
    https://git.kernel.org/bpf/bpf-next/c/d6e6286a12e7
  - [v4,bpf-next,2/3] veristat: add -d debug mode option to see debug libbpf log
    https://git.kernel.org/bpf/bpf-next/c/b3c63d7ad81a
  - [v4,bpf-next,3/3] veristat: guess and substitue underlying program type for freplace (EXT) progs
    https://git.kernel.org/bpf/bpf-next/c/fa7cc9062087

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


