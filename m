Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0D5F6A9D
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiJFPaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiJFPaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 11:30:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF854C87
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 08:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40F23CE16E0
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 15:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76B7BC433C1;
        Thu,  6 Oct 2022 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665070216;
        bh=jfqHkjSVmxpScxHkJHb+O/C3Dqz4XkamydzHooFMT8Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eYZG52AhMgIcXBVay3NIBOO0fhbMsP+hJuKWT0AsyqPqBHTYhBfCFcZoo0e627LYZ
         U87MMhJt4d8dyfkEOysvX07wWN9pcpHVyk+/Io4amaHlhH+j0cYc9kFW4pR7fUerz/
         a4VsAGps3JmNb6XGWIzKBHMDdG2Ga65dXWh6ASGRz1UXY/Tq060DDWL4yBBI1DzZXJ
         Efbl4zwFiUcH5wFG40FCtnvN24TL+M+gRKPhzRm1DNpx9LBmjUFu1aJA5rj0Emd0P3
         839wFJpI+ZausEqNrA5jS4D2uqsPVnVKMsLtBUF9Psou36xki1u98FNlJPqhTLgPgJ
         X0vLs52vJyCjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 543E6E2A05F;
        Thu,  6 Oct 2022 15:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add selftest deny_namespace to s390x
 deny list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166507021634.23640.373748112138514966.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Oct 2022 15:30:16 +0000
References: <20221006053429.3549165-1-yhs@fb.com>
In-Reply-To: <20221006053429.3549165-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 5 Oct 2022 22:34:29 -0700 you wrote:
> BPF CI reported that selftest deny_namespace failed with s390x.
> 
>   test_unpriv_userns_create_no_bpf:PASS:no-bpf unpriv new user ns 0 nsec
>   test_deny_namespace:PASS:skel load 0 nsec
>   libbpf: prog 'test_userns_create': failed to attach: ERROR: strerror_r(-524)=22
>   libbpf: prog 'test_userns_create': failed to auto-attach: -524
>   test_deny_namespace:FAIL:attach unexpected error: -524 (errno 524)
>   #57/1    deny_namespace/unpriv_userns_create_no_bpf:FAIL
>   #57      deny_namespace:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add selftest deny_namespace to s390x deny list
    https://git.kernel.org/bpf/bpf-next/c/8206e4e95230

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


