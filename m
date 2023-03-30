Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D087C6D10B4
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 23:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjC3VUl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjC3VUk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 17:20:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1801727;
        Thu, 30 Mar 2023 14:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F652B82A41;
        Thu, 30 Mar 2023 21:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B99BC4339B;
        Thu, 30 Mar 2023 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680211237;
        bh=IkCYM13B50/wAM8vMkg9yJvVMrO3qig8JpAg9+sKiqY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Sv4JassikkVbOff48J/iFOIXFclC6ZzRgv96cAucgQXnkrOl9R1zx5xy0Qt0+5cyP
         mn2j7xI++YeYcb1/j0zbf73MhJBsc0lAZTd1PosfAEQ1TNf7iUA8JxsNtvOUpXVyOp
         tGaUMuAAhY0Ml7TqysfLbms/z6Uk2SqfFuolFHxfNhoT9MO9AluQ63fybTbwejCFXb
         gteOdPXCZBttJNkRmmgAd/ik8yvUrE7qUWUsuTSyjrQiiLJboO5eBpBZlHGiMbLWHV
         /ETfSV2CMUfcC5h9Tnqlv4lWHxdJpVq559SsMW/lvmLh6HDZRDvE1msU4IQy37wbfg
         70WAxTDPhhJdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DCDAE49FA8;
        Thu, 30 Mar 2023 21:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Handle PTR_MAYBE_NULL case in PTR_TO_BTF_ID
 helper call arg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168021123724.16527.2802678466803935794.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Mar 2023 21:20:37 +0000
References: <20230330145203.80506-1-void@manifault.com>
In-Reply-To: <20230330145203.80506-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        memxor@gmail.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 30 Mar 2023 09:52:02 -0500 you wrote:
> When validating a helper function argument, we use check_reg_type() to
> ensure that the register containing the argument is of the correct type.
> When the register's base type is PTR_TO_BTF_ID, there is some
> supplemental logic where we do extra checks for various combinations of
> PTR_TO_BTF_ID type modifiers. For example, for PTR_TO_BTF_ID,
> PTR_TO_BTF_ID | PTR_TRUSTED, and PTR_TO_BTF_ID | MEM_RCU, we call
> map_kptr_match_type() for bpf_kptr_xchg() calls, and
> btf_struct_ids_match() for other helper calls.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Handle PTR_MAYBE_NULL case in PTR_TO_BTF_ID helper call arg
    https://git.kernel.org/bpf/bpf-next/c/e4c2acab95a5
  - [bpf-next,2/2] selftests/bpf: Add testcases for ptr_*_or_null_ in bpf_kptr_xchg
    https://git.kernel.org/bpf/bpf-next/c/67efbd57bc6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


