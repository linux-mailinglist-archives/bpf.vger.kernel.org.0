Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8856E0357
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 02:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDMAuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 20:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMAuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 20:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCB5FCF
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 17:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3CD63A6F
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 00:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB533C433EF;
        Thu, 13 Apr 2023 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681347017;
        bh=LA7vVzW0P1NpAY1uuOJDBMCmsQ+z/lFd34FKsAN/aWM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tq8n9V/A+8B4dPoG/46x7jj5/nXFnMgECFZ+hTz5ghDtbYKw1bzmmD2M7d3LIIlzQ
         FzUt+RfKm6PdWRBCZc8PoPyelsB/Cz0NApr4xeJHnYRY5YKET8yK+Ls+1cG75YWhMH
         o4DOld4Bz4NBF5tFbIESQvVyTt5b2MUO2cPKghGwpMlvWpKhQwppIQjh2QRRxRAPga
         vBWuqXJfNqT+EMhzYs2rQYbIx7SW+PC0ZcnaikaQI1IeYFyy+2ciCAZoi9qDbx3GK3
         SOjz3+VAnYeb9C3B89Waup/47GCIjMgvg5MyIeNV+yTCaszTnApWgjyIfhdLh11mge
         1qnarZmS2aE/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADCDBC395C5;
        Thu, 13 Apr 2023 00:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v2 bpf-next 0/2] Fix copy_from_user_nofault()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168134701770.15140.10334019334132391578.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 00:50:17 +0000
References: <20230410174345.4376-1-dev@der-flo.net>
In-Reply-To: <20230410174345.4376-1-dev@der-flo.net>
To:     Florian Lehner <dev@der-flo.net>
Cc:     bpf@vger.kernel.org, x86@kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        peterz@infradead.org, keescook@chromium.org, tglx@linutronix.de,
        hsinweih@uci.edu, rostedt@goodmis.org, vegard.nossum@oracle.com,
        gregkh@linuxfoundation.org, alan.maguire@oracle.com,
        dylany@meta.com, riel@surriel.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 10 Apr 2023 19:43:43 +0200 you wrote:
> The original patch got submitted by Alexei Starovoitov with [0] and
> fixes issues that got also reported in [1].
> 
> This resubmission adds !pagefault_disabled() to the check in
> check_heap_object().
> 
> Changelog:
> v1->v2: Addressed comments from Alexei Starovoitov
> - move pagefault_disabled() check into first patch
> - keep __copy_from_user_inatomic() in copy_from_user_nofault()
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] mm: Fix copy_from_user_nofault().
    https://git.kernel.org/bpf/bpf-next/c/d319f344561d
  - [v2,bpf-next,2/2] perf: Fix arch_perf_out_copy_user().
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


