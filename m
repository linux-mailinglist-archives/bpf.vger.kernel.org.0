Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCAE59EDF4
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 23:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiHWVF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 17:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiHWVAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 17:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B5E792C0
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 14:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA4C615A6
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91508C433B5;
        Tue, 23 Aug 2022 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661288415;
        bh=+wEv3CAPnRTMZ5id/A1thnseL32K3myXYo1sbvGKyec=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MINSfRFj09NxrJiUled/u6GI3WgQEtMQ6GzMlEHOJP7pcjCDqJYuDeaoCnGibZgB9
         AtCujJYJLCFLt/UQnwaWB8GuMll/LvwyVhr5rS5U2XRS8CoqgukDsCDDmzkXVszEWj
         s5aGfO9nnfiKlxqZGpA8PvRKWr2+UmDLH2v1WPcQUvkvV1k5Pxju/+1rEhiUJ14ZvV
         KWAiVCBd22ZNDyjubHDi0lZkZC/huNHuAEgEiD4Nwf0GTsV12NRDMnPgrHZdj3386o
         zSeFw2haFLkLlgTIQmbtvxE2917TDkcxhJdGJIFUGurvelM/kIG9dEPxKEsIrWEykA
         z0MRF3BKoPe3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71A7AE2A041;
        Tue, 23 Aug 2022 21:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] scripts/bpf: Set version attribute for
 bpf-helpers(7) man page
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166128841544.23044.1104644839520813777.git-patchwork-notify@kernel.org>
Date:   Tue, 23 Aug 2022 21:00:15 +0000
References: <20220823155327.98888-1-quentin@isovalent.com>
In-Reply-To: <20220823155327.98888-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        alx.manpages@gmail.com
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

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 23 Aug 2022 16:53:26 +0100 you wrote:
> The bpf-helpers(7) manual page shipped in the man-pages project is
> generated from the documentation contained in the BPF UAPI header, in
> the Linux repository, parsed by script/bpf_doc.py and then fed to
> rst2man.
> 
> After a recent update of that page [0], Alejandro reported that the
> linter used to validate the man pages complains about the generated
> document [1]. The header for the page is supposed to contain some
> attributes that we do not set correctly with the script. This commit
> updates the "project and version" field. We discussed the format of
> those fields in [1] and [2].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] scripts/bpf: Set version attribute for bpf-helpers(7) man page
    https://git.kernel.org/bpf/bpf-next/c/fd0a38f9c37d
  - [bpf-next,v2,2/2] scripts/bpf: Set date attribute for bpf-helpers(7) man page
    https://git.kernel.org/bpf/bpf-next/c/92ec1cc3784a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


