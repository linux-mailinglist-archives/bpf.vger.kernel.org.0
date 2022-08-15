Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03AA593209
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHOPgO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiHOPgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:36:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04413D16
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 08:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A0F8B80F98
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 15:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD3DCC43143;
        Mon, 15 Aug 2022 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660577768;
        bh=zIZmRA1i9y30Vi3QvIq1EF+XD5KITgaCga0SeI40sG4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Hb+iukUEYL/30Y45q+QlBZ/yZ6vxtPsdS8fta/wEWhjth1jKay1NFMtJTABflR5z0
         OOIBWfoxMD7lrClrm2dYSv+mkvr4gaaFazFNVX8PZ26YhE0xYNMGErl6q0Q9EUQM76
         t3/wz/O9clsmZg5lByqgwf0q7j5MPvj7cVVwa1XNCKl63KmAmet/rllQBgtPV4knvC
         1KInB6YGvTb3MJTCnc4PF74FEu3TCrDWBbtbjEG1PfXzr8k3tww/ZAxSzG7fa2YD8j
         UtxRKdxYm2IOLJrGrU3me+I0GcFiJ3SFyncPiSb8fdFJZHKbOn9lLM8AjMktlCXdxf
         TdEpwUuPhhqmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4F1DE2A051;
        Mon, 15 Aug 2022 15:36:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Fix a typo in a comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166057776867.2541.6072541887808606851.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 15:36:08 +0000
References: <20220812153727.224500-1-quentin@isovalent.com>
In-Reply-To: <20220812153727.224500-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Aug 2022 16:37:25 +0100 you wrote:
> This is the wrong library name. Libcap, not libpcap.
> 
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---
>  tools/bpf/bpftool/feature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpftool: Fix a typo in a comment
    https://git.kernel.org/bpf/bpf-next/c/54c939773b2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


