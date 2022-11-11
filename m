Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820262622B
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiKKTkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbiKKTkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A937BE66;
        Fri, 11 Nov 2022 11:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129FE620C0;
        Fri, 11 Nov 2022 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54D64C433B5;
        Fri, 11 Nov 2022 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195616;
        bh=qfzKV0NRh5/n1z42DuFeqG6JTp2P/PMPuiei07DqQpk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dMVRWNuDmN/G7fO9zm1N0S1lpyECdON6OqrvpAE9leZE5UemuypM8tLJXEKpfnvg1
         1Sz1duxob3x01qTAyFekCkeAn78nxfd/CR14iOBUm4leBn0nn4+1RAV0Pq6Hw2pJTc
         PaEnBaw2v6M+ecV3mywmmg9C6VTwnsxe2iBE8PcBvp19+Za1ed5XrTxPlKnnaNYegA
         S1FFTf/P7JLE6vCwvmN/PtU6ywG81jF4G+K6e9yNSFxsGDrT32F8W1ISTIj/u+IRQm
         T4kwocWg4OgLFH9OTJa/tIEJGFAAqwXlwgUErRZP3S+1F19GPV+0hmfTueCeWUzpS1
         2cUsgnJlDMsKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BD90C395FE;
        Fri, 11 Nov 2022 19:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] docs/bpf: document BPF ARRAY_OF_MAPS and
 HASH_OF_MAPS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166819561624.2662.1812375435883285411.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 19:40:16 +0000
References: <20221108102215.47297-1-donald.hunter@gmail.com>
In-Reply-To: <20221108102215.47297-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
        yhs@meta.com, lkp@intel.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  8 Nov 2022 10:22:15 +0000 you wrote:
> Add documentation for the ARRAY_OF_MAPS and HASH_OF_MAPS map types,
> including usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> v3 -> v4:
> - Fix typo in filename, as reported by Yonghong Song
> - Add lookup to list of ops, as reported by Yonghong Song
> - Clean up declaration in example, as reported by Yonghong Song
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] docs/bpf: document BPF ARRAY_OF_MAPS and HASH_OF_MAPS
    https://git.kernel.org/bpf/bpf-next/c/f720b84811b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


