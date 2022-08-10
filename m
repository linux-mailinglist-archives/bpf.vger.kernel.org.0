Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB69558E4B0
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 03:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiHJBu1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 21:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiHJBuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 21:50:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E71713EA0
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 18:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BCA1ACE1B37
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 01:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F31DDC433D7;
        Wed, 10 Aug 2022 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660096214;
        bh=Wb02cuiM3vPUhfimw6NHPAaoPfv5ZixuoZGB7m1xBgM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a+LtbggT5f48G+F5YpFv5afdLPLh/2a+p/exHA2qo0Z+E+6C3a1VuRiHQC8q8fMjn
         ZAlQeIyqlHjSgeHFrbNBuhk2qKHH87OkDZgalIo5zI8+OGK27/34fTE7ekKhuWSpqg
         yoyleSvAD6sOfx3kHIQDA5LO8N+PGu/h/e/HQnRDQVrTMTIoaKpCdELKMbsVgLBmhY
         A4kNc2f22guu/Pe9OKHb9esZbpeBRnC0fi7G8IUGCdFw/QyubLqGQc5ornCS9kZWSM
         O2kX1FWHXHCDkFSUiJAXdwILEsKVzMAT5THEXA1cLG8VPj+/ZXp2vhl1c2tLS9cWkj
         ORBjysdaX8EuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8E99C43142;
        Wed, 10 Aug 2022 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix ref_obj_id for dynptr data slices in
 verifier
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166009621388.24923.13609210453560307154.git-patchwork-notify@kernel.org>
Date:   Wed, 10 Aug 2022 01:50:13 +0000
References: <20220809214055.4050604-1-joannelkoong@gmail.com>
In-Reply-To: <20220809214055.4050604-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, void@manifault.com,
        andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Aug 2022 14:40:54 -0700 you wrote:
> When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> the ref obj id of the dynptr must be found and then associated with the data
> slice.
> 
> The ref obj id of the dynptr must be found *before* the caller saved regs are
> reset. Without this fix, the ref obj id tracking is not correct for
> dynptrs that are at an offset from the frame pointer.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Fix ref_obj_id for dynptr data slices in verifier
    https://git.kernel.org/bpf/bpf-next/c/883743422ced
  - [bpf-next,v4,2/2] selftests/bpf: add extra test for using dynptr data slice after release
    https://git.kernel.org/bpf/bpf-next/c/dc444be8bae4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


