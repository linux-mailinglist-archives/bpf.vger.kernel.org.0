Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18367FAD6
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 21:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjA1UaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 15:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjA1UaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 15:30:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB11024E;
        Sat, 28 Jan 2023 12:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615DE60C42;
        Sat, 28 Jan 2023 20:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0C21C4339E;
        Sat, 28 Jan 2023 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674937816;
        bh=Cg7bPhksIoJ3zG4Vb+5DbBBGRJVsQ0QEuRU5X9gAexg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BeCxaoN9Wxbn7SNISz3wAwQnXg0TLVW60iwN+QZsBslK34a1F1+Bmh5+AzcTWRHcX
         1ZWDJACRCVqsfkSXcA4X4k/xsvKz2gnS+XVS9fos4ZkOCsEN3zUlL21FjSQ/HrXNdM
         zF1lm4sW/f+Hz1V0eRDhBk2sPee7TvAn4lBtM/OKAYSg9w4Kt8/25BVRJl8qCREroe
         uHVknXtkgLPFhBnge8rbuPYaK1hW9icmEowuirXwDQzRN31PRpp9t41ExrH67bkRSB
         hxlA9ZhNoKXZLRNSganNy8qP0V2iSfoBO31W/LSdkE07kcYGjwb3eW/0iDWJqdb86a
         2kYJYISNAf2RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88A25E54D2D;
        Sat, 28 Jan 2023 20:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] Documentation: bpf: correct spelling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167493781655.31903.4637775648236528823.git-patchwork-notify@kernel.org>
Date:   Sat, 28 Jan 2023 20:30:16 +0000
References: <20230128195046.13327-1-rdunlap@infradead.org>
In-Reply-To: <20230128195046.13327-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
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

On Sat, 28 Jan 2023 11:50:46 -0800 you wrote:
> Correct spelling problems for Documentation/bpf/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: bpf@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] Documentation: bpf: correct spelling
    https://git.kernel.org/bpf/bpf-next/c/1d3cab43f4c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


