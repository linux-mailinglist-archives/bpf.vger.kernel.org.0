Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B888B61A211
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 21:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKDUUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDUUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 16:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260B4B9A6
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 13:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D18EF62285
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 20:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DCE1C433D6;
        Fri,  4 Nov 2022 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667593215;
        bh=tlwVSCJQomnj+kMHW+I8uVPWjCOWq146AW5b8sv2qdU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GymRS4Zd9A7gaR/jBVJ3FSNtoUZaoiMQoc7P2rJLmNm1Upumzwy8wmK1EpCam4DRr
         iGBwAefouFE7cGY6qoJ+zHbe+dJBN8RXBHI1AntB7ws1SpEOV+8fPU7nPrtxZWTICC
         21/GpN2RcHtoxprCrOPfiPkjxCvcZ0Uc86z8aoTpVuB+Mu7sghE/TuIc0WBQKGeFbL
         jWCYPm8V5xa8whBkEON+5THeTy3WhrfLB+fgQVpebBBeHkQd19BKePYcDAYfutXNMx
         4eaUGPbKMYQ2w6/L/Rh/9ykKEFPQ7dogBLoo/CyxEbhnVVDaXKENoG8DjpzjIGsxnW
         QuQf+8XJ77O+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D85CE6BAC1;
        Fri,  4 Nov 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: Resolve enum fwd as full enum64 and vice
 versa
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166759321505.8776.1021581252608507513.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Nov 2022 20:20:15 +0000
References: <20221101235413.1824260-1-eddyz87@gmail.com>
In-Reply-To: <20221101235413.1824260-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  2 Nov 2022 01:54:12 +0200 you wrote:
> Changes de-duplication logic for enums in the following way:
> - update btf_hash_enum to ignore size and kind fields to get
>   ENUM and ENUM64 types in a same hash bucket;
> - update btf_compat_enum to consider enum fwd to be compatible with
>   full enum64 (and vice versa);
> 
> This allows BTF de-duplication in the following case:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: Resolve enum fwd as full enum64 and vice versa
    https://git.kernel.org/bpf/bpf-next/c/de048b6ee865
  - [bpf-next,2/2] selftests/bpf: Tests for enum fwd resolved as full enum64
    https://git.kernel.org/bpf/bpf-next/c/2e20f50ff849

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


