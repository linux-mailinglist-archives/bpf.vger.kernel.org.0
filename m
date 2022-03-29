Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC35C4EA51C
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 04:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiC2CWC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiC2CV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 22:21:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E842E0A1;
        Mon, 28 Mar 2022 19:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0061FB81632;
        Tue, 29 Mar 2022 02:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86111C34111;
        Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648520412;
        bh=yoKJ3ytMoLZaCrwlPcZpLP3Cq6GliNIYczQ3duyjyPY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Le5msC87pwvMmjHYSnBlBY3tk1T/AcuHIBOITjelsdDyCAvM+ckAnalC/7Iuo07Mq
         U5DOrDkaFk5Ng+4pga04xNZA3u4WcKIt8ffhEPgdRF7zdI6/se6FbNsuEa2pMlxyYP
         NOqAk3ZFwzpgCUjJoqpFZQMPP5r9GEIHEdBCs7Ybba0hR2pe1hn9ceVaApkbjDVBzg
         MrQU/1u+BeUISrUxpSMMIMAOYOp/oEybc2zos2ivW1vcbNxG30YorwDS+gLVQ2d1zy
         6TohNoNI9z5iQGpvL/nsgHibsfdvac3ZmLFnKwYL+zYqKA70ZfVJmFV85/3IpYAQdU
         OVuld0g3l9W/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68BDEF0384A;
        Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] fprobe: Fixes for Sparse and Smatch warnings
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164852041242.3757.15751806635224155365.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Mar 2022 02:20:12 +0000
References: <164802091567.1732982.1242854551611267542.stgit@devnote2>
In-Reply-To: <164802091567.1732982.1242854551611267542.stgit@devnote2>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     ast@kernel.org, andrii.nakryiko@gmail.com,
        dan.carpenter@oracle.com, kernel-janitors@vger.kernel.org,
        rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Mar 2022 16:35:15 +0900 you wrote:
> Hi,
> 
> These fprobe patches are for fixing the warnings by Smatch and sparse.
> This is arch independent part of the fixes.
> 
> 
> Thank you,
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] fprobe: Fix smatch type mismatch warning
    https://git.kernel.org/bpf/bpf/c/9052e4e83762
  - [bpf-next,2/2] fprobe: Fix sparse warning for acccessing __rcu ftrace_hash
    https://git.kernel.org/bpf/bpf/c/261608f3105c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


