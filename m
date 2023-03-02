Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63C96A7851
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 01:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCBAU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 19:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBAUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 19:20:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02114FA9F
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 16:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6764BB8119A
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 00:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26D8CC433D2;
        Thu,  2 Mar 2023 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677716418;
        bh=aa6+JOa4YShxd042FRLO+8Db8RNRH/iAHB24+Epo2uA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jK1WE/xPEJW2ixlqO/dbKmLERZVD0f2Obmh6C9MA2J1nYZSuUELxG59Wg+9DhlCYX
         zTRM2VmqQlb72tsAfVzPWW6szErfmQtUG9lm80BiRi92vBcBLqIQ4URF5Lq7j9g4BV
         dp0BzNE1HPK5wGG7vvVhdSZEA7igi/Ogze1mgRPaWGsA/EHmzyVqdGmRZcEpmpVK7N
         HQzRdl3kvh2pNSNiYxnWOQ7A4IuysexDVhWZikzOsffGqUOiUlKwORosNIZCBJv5Bm
         AK80vNB8nyVetcJFF0OStb4mUj/0s0KeixK/Fw3iF11NHPi74uB3FT46NMqPDcIKu8
         amwY77DWXQaZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B6F9E450A5;
        Thu,  2 Mar 2023 00:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Make uprobe attachment APK aware
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167771641803.9647.15749662552167449193.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Mar 2023 00:20:18 +0000
References: <20230301212308.1839139-1-deso@posteo.net>
In-Reply-To: <20230301212308.1839139-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed,  1 Mar 2023 21:23:05 +0000 you wrote:
> On Android, APKs (android packages; zip packages with somewhat
> prescriptive contents) are first class citizens in the system: the
> shared objects contained in them don't exist in unpacked form on the
> file system. Rather, they are mmaped directly from within the archive
> and the archive is also what the kernel is aware of.
> 
> For users that complicates the process of attaching a uprobe to a
> function contained in a shared object in one such APK: they'd have to
> find the byte offset of said function from the beginning of the archive.
> That is cumbersome to do manually and can be fragile, because various
> changes could invalidate said offset.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] libbpf: Implement basic zip archive parsing support
    https://git.kernel.org/bpf/bpf-next/c/1eebcb60633f
  - [bpf-next,v4,2/3] libbpf: Introduce elf_find_func_offset_from_file() function
    https://git.kernel.org/bpf/bpf-next/c/434fdcead735
  - [bpf-next,v4,3/3] libbpf: Add support for attaching uprobes to shared objects in APKs
    https://git.kernel.org/bpf/bpf-next/c/c44fd8450763

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


