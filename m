Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A64DD4AD
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 07:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiCRGVb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiCRGVa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 02:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06AC17A2D6
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 23:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 198B6618F9
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 06:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 737A9C340EF;
        Fri, 18 Mar 2022 06:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647584411;
        bh=F1zCsghJueQMsFW5GEBOBU6YU5BLEIPD8aMfsq6ECwY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qJGenAUQ3rlAh3svAjviDUaIaGedEnB2UwO54Ca6gViy4z6uI6d4uj7xgKceH3sfF
         fIbospnsPIRdnF6bjQEIpTvHLGg6o3Y0RLm3w/fGya8S6KK1pPuzLPXtNhZf6ovGQD
         h/sLGj6J/nbbA0/HdlNwrA0pDh4AXbATLyHB5QF5trEBRIUcLz/ilLAEfTeaHoL4pF
         EXaEYRdEVKtj0fFbphjBJTxnU4oBBuu+ejA2+Aq7gVtHKqmYqengMijs80aaJ/W4H/
         J1CS/TG3TiZuX7mRag9smJEx7HtB4TfvRVIjFQP0vgWThmC/4jDcRhdaYZ6NqfjcQA
         PAv8kWcOFdE+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58800E6D44B;
        Fri, 18 Mar 2022 06:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/5] Subskeleton support for BPF libraries
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164758441135.25738.7426516446576821597.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Mar 2022 06:20:11 +0000
References: <cover.1647473511.git.delyank@fb.com>
In-Reply-To: <cover.1647473511.git.delyank@fb.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 16 Mar 2022 23:37:26 +0000 you wrote:
> In the quest for ever more modularity, a new need has arisen - the ability to
> access data associated with a BPF library from a corresponding userspace library.
> The catch is that we don't want the userspace library to know about the structure of the
> final BPF object that the BPF library is linked into.
> 
> In pursuit of this modularity, this patch series introduces *subskeletons.*
> Subskeletons are similar in use and design to skeletons with a couple of differences:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/5] libbpf: .text routines are subprograms in strict mode
    https://git.kernel.org/bpf/bpf-next/c/bc380eb9d048
  - [bpf-next,v4,4/5] bpftool: add support for subskeletons
    https://git.kernel.org/bpf/bpf-next/c/00389c58ffe9
  - [bpf-next,v4,2/5] libbpf: init btf_{key,value}_type_id on internal map open
    https://git.kernel.org/bpf/bpf-next/c/262cfb74ffda
  - [bpf-next,v4,5/5] selftests/bpf: test subskeleton functionality
    https://git.kernel.org/bpf/bpf-next/c/3cccbaa03321
  - [bpf-next,v4,3/5] libbpf: add subskeleton scaffolding
    https://git.kernel.org/bpf/bpf-next/c/430025e5dca5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


