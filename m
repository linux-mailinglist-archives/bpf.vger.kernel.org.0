Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A657256C40C
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiGHVZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbiGHVZ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 17:25:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F93823BF9
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 14:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5648B82999
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 21:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D56DC341C6;
        Fri,  8 Jul 2022 21:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657315552;
        bh=lnf68t5P7zq2JJz352AymXVD6Aji55smg6s41kFgyRc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KHhiodPh9GtcwH9v8h2ktcC0kn3pUMIr01Vhn/tsXmBXep3FokGt8VerLq+aSZbQ0
         3T2ESfguyv4SmeFQcSVs8fMpQg19afFcf4byHITZ4UDwSSHIhQB8CDgIw4zKFOsZwf
         1dJsPN07BJ4vfki2fyrdfSlv98xu8R8KAiHGoAFYXOLUpKatYrtYHwpLyGjMUXvTsT
         5VlgZ3Zaff6IzWC9UlWcx3ICsuDNZpRx1jOipwe6Eicfp9zAVMepIOqZyOcz5jJPxa
         iOigVy3mcf1AegiATUFgOW7eHYF5V3IwDK8yvBB1dQF5iBvWH1BagZLijbUUPg37Tu
         BnfyAvy6p313Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5169FE45BDA;
        Fri,  8 Jul 2022 21:25:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: check attach_func_proto more carefully in
 check_return_code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165731555232.21745.17915659016940178166.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Jul 2022 21:25:52 +0000
References: <20220708175000.2603078-1-sdf@google.com>
In-Reply-To: <20220708175000.2603078-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  8 Jul 2022 10:50:00 -0700 you wrote:
> Syzkaller reports the following crash:
> RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
> RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
> RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610
> 
> With the following reproducer:
> bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3, &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"], &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: check attach_func_proto more carefully in check_return_code
    https://git.kernel.org/bpf/bpf-next/c/d1a6edecc1fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


