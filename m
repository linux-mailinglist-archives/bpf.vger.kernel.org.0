Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DCF4BD048
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 18:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiBTRae (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 12:30:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiBTRae (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 12:30:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240126AEB
        for <bpf@vger.kernel.org>; Sun, 20 Feb 2022 09:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63902B80D0C
        for <bpf@vger.kernel.org>; Sun, 20 Feb 2022 17:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5F8DC340F0;
        Sun, 20 Feb 2022 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645378209;
        bh=hr/Vz+NZragK0TGnk7pkjy7FE9IMI6nEL4Cjo4DLrys=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kTwYp34+eFmG8YQ0HEQBsQ+zjPpmfsDx+2R3v1jc6R7oyzjltL5nMmcwlMbSPyqqb
         0SZCyHYQar7tE00DUcU384NvAvDqTVDX2tfsbWSyapGgQPOBCEhzRGoX7z6nIlDnvV
         zg3sFbaH0BCBBex+k6EDOsnaqOK2uNJ3mspLZ+X1qEPw916JjyKUkzlUykywiwe/kK
         zaA2NwDlD8i6ozOO9mGzhYdmUrP9E3lFHAG8ZMI7IBk6vuHF4Bt5F5BBJ3OEoKIyuL
         3J0IIXyLSM2E70PW3BAMIgPHnCb7wEwt6vl7CN1/tq2n3bLoLka00c/NCb6VgaZaMY
         mnBVDP9IoZAxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2FD4E7BB0A;
        Sun, 20 Feb 2022 17:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: fix btfgen tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164537820972.18948.16085316034935017003.git-patchwork-notify@kernel.org>
Date:   Sun, 20 Feb 2022 17:30:09 +0000
References: <20220220042720.3336684-1-andrii@kernel.org>
In-Reply-To: <20220220042720.3336684-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, mauricio@kinvolk.io
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 19 Feb 2022 20:27:20 -0800 you wrote:
> There turned out to be a few problems with btfgen selftests.
> 
> First, core_btfgen tests are failing in BPF CI due to the use of
> full-featured bpftool, which has extra dependencies on libbfd, libcap,
> etc, which are present in BPF CI's build environment, but those shared
> libraries are missing in QEMU image in which test_progs is running.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: fix btfgen tests
    https://git.kernel.org/bpf/bpf-next/c/b03e19465b97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


