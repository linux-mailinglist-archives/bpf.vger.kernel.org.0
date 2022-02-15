Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC94B76C9
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 21:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiBOSUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 13:20:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiBOSUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 13:20:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CFD119879
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 10:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E0F9B81C36
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 18:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F351FC340F0;
        Tue, 15 Feb 2022 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644949210;
        bh=u2eclioaRAYEDUG7s2mcUFulLEkHYB4t/53db+tQi00=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ikpMh4Fn6s568jGbKIYX/vT3/ElwMwwYDnoV3WEfQH2Er7y+3udvSGFQAa3VIiStw
         lMk1sXnrqLfcmQK466I6daXdau3n7ro7QkvGuzy3D+5ahexP+s4zXO7b2q+U3WRv4z
         r+CaAClADnG0cxtCTzN9PY9oJPjYag7MHVUaBPEHLQDrG550F7C8ZBQrsZJwtO5WB3
         xL8yzIueps/iJWy8MKMe7R+undAvhD8K/v6SWBTPrh/X/F0Z3da5IU8ecR8d6tFQwW
         5IB4RHd6mlffF2Na9ogSgYy4Gv2JXmZWcLuPeOKR/KWlKMM552zCwQ/vHUCQ/daXp1
         yYy9uDBD6fvnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBAC9E6D458;
        Tue, 15 Feb 2022 18:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests: bpf: Check bpf_msg_push_data return value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164494920989.30934.9224774889748870295.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Feb 2022 18:20:09 +0000
References: <89f767bb44005d6b4dd1f42038c438f76b3ebfad.1644601294.git.fmaurer@redhat.com>
In-Reply-To: <89f767bb44005d6b4dd1f42038c438f76b3ebfad.1644601294.git.fmaurer@redhat.com>
To:     Felix Maurer <fmaurer@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, davemarchevsky@fb.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Feb 2022 18:43:36 +0100 you wrote:
> bpf_msg_push_data may return a non-zero value to indicate an error. The
> return value should be checked to prevent undetected errors.
> 
> To indicate an error, the BPF programs now perform a different action
> than their intended one to make the userspace test program notice the
> error, i.e., the programs supposed to pass/redirect drop, the program
> supposed to drop passes.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests: bpf: Check bpf_msg_push_data return value
    https://git.kernel.org/bpf/bpf/c/61d06f01f971

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


