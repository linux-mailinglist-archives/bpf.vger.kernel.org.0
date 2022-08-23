Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5A59EF9D
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 01:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiHWXUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiHWXUY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 19:20:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1557578BA
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 363F2CE2084
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 23:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71C21C433D6;
        Tue, 23 Aug 2022 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661296817;
        bh=XMOwaBVZBi12KdHH8dvd78tpaTQmY74wklUaJpEP4/4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ueIu7crQhXmJXJuTIGOPsOVI5Sn/Et9M8l5i8EhsQjdkZ9BC9QXNCtkb1zpSitltW
         Ci8L5KFMHt2bfCsLbm3Y+lBRXNhaM7+Ynp+884OP0tzh7FoGjs5KxfQEW7qp8k6oMC
         aAn0VFef9L+4PcNyuDZsEpHKF6Aawe8J1ueE2VGB3bbGVb3R7VgN6lZQ9RDZMlvEqc
         eDW0exgHvA1UNNbAdBJ2DOv81Z9lW11JHz6RZ/XlHyABOMQOsTRKK1L383ACAymT6P
         EPGWXFpfOUNQz3oHyViS0l+aLr//89obDvLXoqRUPu2u3ktvAfv1OYjTojw4kfbmeR
         W8G2NA++QGheQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F566C0C3EC;
        Tue, 23 Aug 2022 23:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/5] bpf: expose bpf_{g,s}et_retval to more cgroup
 hooks
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166129681731.10727.1913185417224376513.git-patchwork-notify@kernel.org>
Date:   Tue, 23 Aug 2022 23:20:17 +0000
References: <20220823222555.523590-1-sdf@google.com>
In-Reply-To: <20220823222555.523590-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Aug 2022 15:25:50 -0700 you wrote:
> Apparently, only a small subset of cgroup hooks actually falls
> back to cgroup_base_func_proto. This leads to unexpected result
> where not all cgroup helpers have bpf_{g,s}et_retval.
> 
> It's getting harder and harder to manage which helpers are exported
> to which hooks. We now have the following call chains:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/5] bpf: Introduce cgroup_{common,current}_func_proto
    https://git.kernel.org/bpf/bpf-next/c/dea6a4e17013
  - [bpf-next,v5,2/5] bpf: Use cgroup_{common,current}_func_proto in more hooks
    https://git.kernel.org/bpf/bpf-next/c/bed89185af0d
  - [bpf-next,v5,3/5] bpf: expose bpf_strtol and bpf_strtoul to all program types
    https://git.kernel.org/bpf/bpf-next/c/8a67f2de9b1d
  - [bpf-next,v5,4/5] bpf: update bpf_{g,s}et_retval documentation
    https://git.kernel.org/bpf/bpf-next/c/2172fb8007ea
  - [bpf-next,v5,5/5] selftests/bpf: Make sure bpf_{g,s}et_retval is exposed everywhere
    https://git.kernel.org/bpf/bpf-next/c/e7215f574079

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


