Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC076381CE
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 00:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKXXkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 18:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXXkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 18:40:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346C114;
        Thu, 24 Nov 2022 15:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D760CB828FD;
        Thu, 24 Nov 2022 23:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90B4BC433D7;
        Thu, 24 Nov 2022 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669333215;
        bh=fK6idouijYo9HkPNrm4PwNjTBLo/DRfdAeopcwIx0O8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b6T/PE5VHcvjl/lRcT5ipJjhY7mQQau7mDcqYOlhCLRkH95E4mxSRUi2NOT5ipwx/
         7wxL5O6qz2GQ5V1gyoR0ct2vDNsJBslntxRuBtYYzxTK5Yv0aDhvQoBbtU5W16Iw/H
         wi6NeGFHId5SgwCRlkRkEmIQjjMCfcgnWBYE1QrYSqhMqf8ggN6DC3N98Z3gILxnCe
         M6TBatvkQ42+bLbYsWHBrBnTNuJekThtPFAvqktqJmcgP/a4nKFQSzhVTDSlvojdEe
         d6P2rfgQNfkcjdqTt+b4etiol2zu60r1DWpNFp5xnyDWPsXsSfIbrxJiGNdp6NBZ+w
         bcbtMZS0KZC+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7653DE270C7;
        Thu, 24 Nov 2022 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/1] docs: BPF_MAP_TYPE_XSKMAP
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166933321548.13496.9802101349602354854.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Nov 2022 23:40:15 +0000
References: <20221123090043.83945-1-mtahhan@redhat.com>
In-Reply-To: <20221123090043.83945-1-mtahhan@redhat.com>
To:     Maryam Tahhan <mtahhan@redhat.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com,
        magnus.karlsson@gmail.com, akiyks@gmail.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 23 Nov 2022 09:00:43 +0000 you wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_XSKMAP
> including kernel version introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/1] docs: BPF_MAP_TYPE_XSKMAP
    https://git.kernel.org/bpf/bpf-next/c/2b3e8f6f5b93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


