Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E286420D4
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 01:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiLEAuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 19:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLEAuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 19:50:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C501147D;
        Sun,  4 Dec 2022 16:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0340B8095A;
        Mon,  5 Dec 2022 00:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71239C433D7;
        Mon,  5 Dec 2022 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670201414;
        bh=zFjUbytBBkcyk5kiTMsOxobi+R623bJ3aBKnzT38gJA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bJIPxvqBkiCK0QIf3q9BskaAi/liRz/Yk+ZrVd1shwsWC/J3Ug3qH49CCGK9UxsJ2
         UGtkIgUjnr1vOcFPQoR+g3JD3MmKEDT2WD6VIMkm5Z/8IcYdpxfXtelLdD7MRy/avp
         mZzD4aK+bWn4UMFOOuDsmo8a4dhbndn8A17nqFbi/8RFYTLKvai8JIpFiHhBeW+N/i
         JX6/csL1pmEaMZHTV6xRoV8MRbxJMknISvXpZxb1l4CkQtkFClPDUeQF9HxYnf+LMT
         1V01Yi+Dpmz7oijC0hF4oTzbYy9C7fSO/Nx5rBv7dReRp8yPgEt8t1sku6GIA94WNE
         Gnm5FMhl1YB+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50101E270CF;
        Mon,  5 Dec 2022 00:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/1] BPF Iterator Document
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167020141432.8683.2334419071365840277.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Dec 2022 00:50:14 +0000
References: <20221202221710.320810-1-ssreevani@meta.com>
In-Reply-To: <20221202221710.320810-1-ssreevani@meta.com>
To:     Sreevani Sreejith <ssreevani@meta.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, psreep@gmail.com,
        void@manifault.com, yhs@meta.com, mykolal@meta.com
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

On Fri, 2 Dec 2022 14:17:09 -0800 you wrote:
> From: Sreevani <ssreevani@meta.com>
> 
> Removed SVG image file.
> 
> Sreevani Sreejith (1):
>   bpf, docs: BPF Iterator Document
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/1] bpf, docs: BPF Iterator Document
    https://git.kernel.org/bpf/bpf-next/c/8972e18a439d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


