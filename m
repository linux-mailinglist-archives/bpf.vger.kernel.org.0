Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01726ACBD0
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 19:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCFSBk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjCFSBe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 13:01:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302F17174;
        Mon,  6 Mar 2023 10:00:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 70FDBCE16B8;
        Mon,  6 Mar 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6D46C4339C;
        Mon,  6 Mar 2023 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678125622;
        bh=fqBnESJ+U0wdQYyNdNTmXbaJrU3rlF+cSmCnh+G12fE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OCDizL1hp5ZYLxE6DCu2yjKSR6nrMO9SpXF49RsCQTAeG/Uu6OIcJk7/y1VFcTFDF
         Xcnw1VbBzEDzGlsYmBGmIklNOpukbGf1dQb53K1hut8WJ4Rtk4eeoGTM+tJOeovhY3
         /ZyNwfrNaZyT23A0y51ni51R/xcCJbRYusDLI/wwqqfE1xc82RzkuvrQLSwPjL90Xd
         9yFivT6S6yukK9n9Auefea/9DwxQa54LRYv+ka6NYkHv6paiKOdhexxZJjwhgnMYXd
         XPgNx4TnZlcnf+ihvax+SYHWbj8Qrr7qLUMb6n0fTErbbxrqjoq17D1OpX/R6LPzTB
         hM+TEv1jxIGTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95414E55B24;
        Mon,  6 Mar 2023 18:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] libbpf: allow users to set kprobe/uprobe
 attach mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167812562260.4797.2027035240861869547.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Mar 2023 18:00:22 +0000
References: <20230306064833.7932-1-imagedong@tencent.com>
In-Reply-To: <20230306064833.7932-1-imagedong@tencent.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, benbjiang@tencent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, imagedong@tencent.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  6 Mar 2023 14:48:30 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> By default, libbpf will attach the kprobe/uprobe BPF program in the
> latest mode that supported by kernel. In this series, we add the support
> to let users manually attach kprobe/uprobe in legacy/perf/link mode in
> the 1th patch.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] libbpf: add support to set kprobe/uprobe attach mode
    (no matching commit)
  - [bpf-next,v4,2/3] selftests/bpf: split test_attach_probe into multi subtests
    https://git.kernel.org/bpf/bpf-next/c/7391ec6391e2
  - [bpf-next,v4,3/3] selftests/bpf: add test for legacy/perf kprobe/uprobe attach mode
    https://git.kernel.org/bpf/bpf-next/c/c7aec81b31e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


