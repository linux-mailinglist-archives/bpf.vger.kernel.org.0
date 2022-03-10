Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B74D4D07
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiCJPVZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 10:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiCJPVR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 10:21:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107A70F44
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 07:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E59A0B82520
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 15:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61D28C340EB;
        Thu, 10 Mar 2022 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646925611;
        bh=rmnV7nZiv7wUUy3EhAKIJZy6fojvrw9uoygZIKmcL6Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UnSXjlZhd3eBjCDmRUDvJTOI8QWdYDd7bIJ8HGEq5zliee1GL87IjqkQZFDbGok/v
         xMaNcLfX1JqzNGzZFAcBjOUoM9vshNOjWtA9fx7ju5nsF6pG1sYhD5/frLIYQFGVYG
         2YiImIVQRrVI94cdcmQCl/vcX+J4kQT4qp97J8PD72No0DXn4meJfcEIEZ6lYJ++up
         z+CiK4J85dOYy34L3S8RCTyw98skfyhvKm060OAoR7XN+MTV/LqjcTYVhOkfxQHDlx
         Pkp56gJSR4G3DADXuN7hZFkPIGqKzBc4pOZgxIHxC2jxHuZZ3TYd3/rJtrf9y1b1w/
         bavEmKYhVeqLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47163EAC095;
        Thu, 10 Mar 2022 15:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v3,bpf-next] bpftool: Restore support for BPF offload-enabled
 feature probing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164692561128.14970.14177265183384711733.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Mar 2022 15:20:11 +0000
References: <20220310121846.921256-1-niklas.soderlund@corigine.com>
In-Reply-To: <20220310121846.921256-1-niklas.soderlund@corigine.com>
To:     =?utf-8?q?Niklas_S=C3=B6derlund_=3Cniklas=2Esoderlund=40corigine=2Ecom=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, quentin@isovalent.com, andrii@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, simon.horman@corigine.com,
        oss-drivers@corigine.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 10 Mar 2022 13:18:46 +0100 you wrote:
> Commit 1a56c18e6c2e4e74 ("bpftool: Stop supporting BPF offload-enabled
> feature probing") removed the support to probe for BPF offload features.
> This is still something that is useful for NFP NIC that can support
> offloading of BPF programs.
> 
> The reason for the dropped support was that libbpf starting with v1.0
> would drop support for passing the ifindex to the BPF prog/map/helper
> feature probing APIs. In order to keep this useful feature for NFP
> restore the functionality by moving it directly into bpftool.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] bpftool: Restore support for BPF offload-enabled feature probing
    https://git.kernel.org/bpf/bpf-next/c/f655c088e74f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


