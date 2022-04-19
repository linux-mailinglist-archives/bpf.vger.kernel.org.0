Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6391D507B96
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 23:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357886AbiDSVC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357478AbiDSVC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 17:02:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10D1D31C
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 14:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB554B81C9E
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 21:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C90EC385A9;
        Tue, 19 Apr 2022 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650402012;
        bh=w5teHblO2uIQWUbMIamoMX+AAeqzEmwK0NB5deuDf44=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b23ikSQiwwtH2qSt6rXPnkNn009G+RfFq+ASRER0E5oYJxgD0ZpBA97bST/QLR0en
         92tm2bj4H0LbXBC+49nPPDqgjBPyOF3QtgDZbuUwyg2B0K3YRQkDbRRuRezahDaYhs
         1VaB0WMA0g8rTPmYG3p8QQNpHMByrTfiVivArcw2qa8jS45xjCY9Hop/AcB3FulP9L
         zqGUPWc5HwlverDE/A9C05RQesD3d9DXgutheGLJwttZBzxyHif0e+93R2db+k9nI3
         M1Dz44UwKVOCPUrbghFXqa2JuXT2cSoUHNaFwrSyIPOmMtioT2zhbwcavhadh1O0g+
         I4XMXVpfdtsPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 401F0E8DBDA;
        Tue, 19 Apr 2022 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: support opting out from autoloading BPF
 programs declaratively
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165040201224.664.18250423075695493920.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 21:00:12 +0000
References: <20220419002452.632125-1-andrii@kernel.org>
In-Reply-To: <20220419002452.632125-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 Apr 2022 17:24:50 -0700 you wrote:
> Establish SEC("?abc") naming convention (i.e., adding question mark in
> front of otherwise normal section name) that allows to set corresponding
> program's autoload property to false. This is effectively just
> a declarative way to do bpf_program__set_autoload(prog, false).
> 
> Having a way to do this declaratively in BPF code itself is useful and
> convenient for various scenarios. E.g., for testing, when BPF object
> consists of multiple independent BPF programs that each needs to be
> tested separately. Opting out all of them by default and then setting
> autoload to true for just one of them at a time simplifies testing code
> (see next patch for few conversions in BPF selftests taking advantage of
> this new feature).
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: support opting out from autoloading BPF programs declaratively
    https://git.kernel.org/bpf/bpf-next/c/a3820c481112
  - [bpf-next,2/2] selftests/bpf: use non-autoloaded programs in few tests
    https://git.kernel.org/bpf/bpf-next/c/0d7fefebea55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


