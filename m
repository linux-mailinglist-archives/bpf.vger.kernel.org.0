Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1A52D9DB
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 18:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbiESQKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbiESQKX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 12:10:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736859CF5C
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 09:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D26ADCE25D7
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 16:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF814C34113;
        Thu, 19 May 2022 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652976615;
        bh=lClLmCOYyKuN0cUVDCPU6roiq3rWqsJEy47eNRLPOd4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GispbnL14e2RYBuWdvR/+PpqE9Pq3JL1wWuvWnZXLuyDJQTofHUo/7mEMPAw7hd0X
         a6503UxMkKQrdcUohSD3AII6HVrtoUBB0jKXDsx+ETLyO9cNALNE3s52HKVrHoyZQM
         ZIuqaGixTbQpFKEMkFksXjg4VuEXW7plfIJm/PRkvHIlQU+SQ1+PT/dPgqY5VkVYG2
         5+fzdFPxgutmcsLfEHDYnjfuNpIP6ohRR/T4G3l1WVbZz3psx8uqKGR9ht4PPnh1Vj
         BE0IDVqg1mCyBeZxHbT0/kDB7/wYnwXUPcs9oDAHy+ITw/5Eg8oQRJOJqJZhJWI171
         QwnK/e0zsz4Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA49CF03939;
        Thu, 19 May 2022 16:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Start libbpf 1.0 dev cycle
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165297661482.2756.6771543472079536284.git-patchwork-notify@kernel.org>
Date:   Thu, 19 May 2022 16:10:14 +0000
References: <20220518185915.3529475-1-andrii@kernel.org>
In-Reply-To: <20220518185915.3529475-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 May 2022 11:59:12 -0700 you wrote:
> Start preparations for libbpf 1.0 release and as a first test remove
> bpf_create_map*() APIs.
> 
> Andrii Nakryiko (3):
>   libbpf: fix up global symbol counting logic
>   libbpf: start 1.0 development cycle
>   libbpf: remove bpf_create_map*() APIs
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] libbpf: fix up global symbol counting logic
    https://git.kernel.org/bpf/bpf-next/c/056431ae4d79
  - [bpf-next,2/3] libbpf: start 1.0 development cycle
    https://git.kernel.org/bpf/bpf-next/c/e2371b1632b1
  - [bpf-next,3/3] libbpf: remove bpf_create_map*() APIs
    https://git.kernel.org/bpf/bpf-next/c/d16495a98232

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


