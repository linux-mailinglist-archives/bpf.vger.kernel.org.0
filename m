Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E9159EDCD
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 22:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiHWUwv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 16:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiHWUwg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 16:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB1E2F9
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 13:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6AEF6159A
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 20:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3165BC433C1;
        Tue, 23 Aug 2022 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661287817;
        bh=xehIwjuJi+6KERq1JWVe/fe/2+Ypj1on/7xDwJFisJM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iJ4aTFA1dvPmSxi2Q68JkQwSDP+AuEzFz8cg74XxZ+W9ybjctk2DKeszbSCfM7T/i
         nCQQrHCAjW145hNCVn5hsLUCWiRIHNNFmLjKhmb42Xw04CiLWqPqNPMPHv2pZ2NpiG
         U4nfHECuTJ9V2TgybhQnsTKfAHCrJyfpXsYsAqT2NFNhDv0GOJh7y5QlgNQQWWMJ11
         iTgK3ro8AZUy1ALKFO/PPRgfnLea8prdNaZ0RK9bhSY1eSrF+5oXRfl0/sZgLOCe7U
         kCgwdyj4v9aHF3TmoFO7nCcMcoiqrPLlbB41CjVTCfOrAODO3heewxQ3ab8ynQRFng
         3VLzaL6s5JojA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 069CFE2A041;
        Tue, 23 Aug 2022 20:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] flow_dissector: Allow bpf flow-dissector
 progs to request fallback to normal dissection
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166128781701.18610.15502744232104475545.git-patchwork-notify@kernel.org>
Date:   Tue, 23 Aug 2022 20:50:17 +0000
References: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
In-Reply-To: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, sdf@google.com,
        jakub@cloudflare.com, ppenkov@google.com, willemb@google.com,
        shmulik.ladkani@gmail.com
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

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 21 Aug 2022 14:35:15 +0300 you wrote:
> Currently, attaching BPF_PROG_TYPE_FLOW_DISSECTOR programs completely
> replaces the flow-dissector logic with custom dissection logic.
> This forces implementors to write programs that handle dissection for
> any flows expected in the namespace.
> 
> It makes sense for flow-dissector bpf programs to just augment the
> dissector with custom logic (e.g. dissecting certain flows or custom
> protocols), while enjoying the broad capabilities of the standard
> dissector for any other traffic.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] flow_dissector: Make 'bpf_flow_dissect' return the bpf program retcode
    https://git.kernel.org/bpf/bpf-next/c/0ba985024ae7
  - [v2,bpf-next,2/4] bpf/flow_dissector: Introduce BPF_FLOW_DISSECTOR_CONTINUE retcode for flow-dissector bpf progs
    https://git.kernel.org/bpf/bpf-next/c/91350fe15293
  - [v2,bpf-next,3/4] bpf: test_run: Propagate bpf_flow_dissect's retval to user's bpf_attr.test.retval
    https://git.kernel.org/bpf/bpf-next/c/5deedfbee842
  - [v2,bpf-next,4/4] selftests/bpf: test BPF_FLOW_DISSECTOR_CONTINUE
    https://git.kernel.org/bpf/bpf-next/c/d6513727c2af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


