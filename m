Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC36B629C41
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiKOOkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 09:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKOOkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30081DDD6;
        Tue, 15 Nov 2022 06:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D525617D2;
        Tue, 15 Nov 2022 14:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99CD9C433B5;
        Tue, 15 Nov 2022 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523215;
        bh=jPI1jRT23/lK6CcvQACSi0pCkrudmNLDNQtDy5gk1sc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VStS3lfiSlvSdEHo/Uw7gbGl+iObVNGENQ0p1ARp14DaNg2OQH+WSFzJ8s7yFOp1U
         pDKScE2mBas788/vqlZ+ONGF9jzoEVSSxUxPNS0z3GYwZg8sakf47JhLunMX53xzhU
         cb8yIREh8IxKviw5YAhbB6LvqoZFNAeZdTHf7U7J3oEvuty76Vt0GJ7hanolm5hJ3x
         EZfOj/PYmudpI7eGGUG5oIzQLpiS7j90WE5m6DdrvaHMJOag4DkwsTuxy3CW3datcv
         p8JYQcQlmdTx4uPGQP6IWCPfSvztBltbRQUoo8gXkyo+3ahkaVPpqik6DNtwwBmH1K
         gqRfCXAZ4zSvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D808C395FE;
        Tue, 15 Nov 2022 14:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] perf,
 bpf: Use subprog name when reporting subprog ksymbol
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166852321551.8656.10733510198219998954.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Nov 2022 14:40:15 +0000
References: <20221114095733.158588-1-houtao@huaweicloud.com>
In-Reply-To: <20221114095733.158588-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, jolsa@kernel.org, andrii@kernel.org,
        song@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        sdf@google.com, houtao1@huawei.com,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 14 Nov 2022 17:57:33 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit bfea9a8574f3 ("bpf: Add name to struct bpf_ksym"), when
> reporting subprog ksymbol to perf, prog name instead of subprog name is
> used. The backtrace of bpf program with subprogs will be incorrect as
> shown below:
> 
> [...]

Here is the summary with links:
  - [bpf] perf, bpf: Use subprog name when reporting subprog ksymbol
    https://git.kernel.org/bpf/bpf/c/47df8a2f78bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


