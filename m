Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9558CA0B
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbiHHOAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiHHOAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:00:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781EB89
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3089EB80EAD
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4740C433B5;
        Mon,  8 Aug 2022 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967213;
        bh=WgjNVV2EnrEDKMGUqUPIArn3+7YfPgTxaPM+cQjl24M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tjABYboDeLCGKc09KgI1743jTCV+kwHZFwCMwk32DSDkTzk2EurlP29rdPR8V3Bg/
         o/E+124lff1dCu/0KoMdank4f7GTlNrvNOsuKFpRt2WOmh0rzQj0ShvhJ0ZdNn1otL
         v7ty5KivYl+0JHweK0FIisHgMZXiL6CtadlaWrNUXAKtkH4/N1klNuEDI704g6+ooH
         9//Az56Q1YqAsGzP/PGdQwuc+7hQRaADR0CeFelR02N8mmfRWZ2jOg8wBtm7xI5ZM8
         IdmKUAMHoB+HCoXjVfMyQX/12RI3GvUxV4peBnmxVi0Bzq6wiuQAzSHPslCJ3VSuAO
         ugLLbOT5x9LEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC4F1C43142;
        Mon,  8 Aug 2022 14:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: use proper target btf when exporting
 attach_btf_obj_id
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165996721370.30475.9351067978243460294.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 14:00:13 +0000
References: <20220804201140.1340684-1-sdf@google.com>
In-Reply-To: <20220804201140.1340684-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, kafai@fb.com
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

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  4 Aug 2022 13:11:39 -0700 you wrote:
> When attaching to program, the program itself might not be attached
> to anything (and, hence, might not have attach_btf), so we can't
> unconditionally use 'prog->aux->dst_prog->aux->attach_btf'.
> Instead, use bpf_prog_get_target_btf to pick proper target btf:
> 
> * when attached to dst_prog, use dst_prog->aux->btf
> * when attached to kernel btf, use prog->aux->attach_btf
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: use proper target btf when exporting attach_btf_obj_id
    https://git.kernel.org/bpf/bpf/c/6644aabbd897
  - [bpf-next,v3,2/2] selftests/bpf: Excercise bpf_obj_get_info_by_fd for bpf2bpf
    https://git.kernel.org/bpf/bpf/c/ffd5cfca5388

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


