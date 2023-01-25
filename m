Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9467A9AB
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 05:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjAYEkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 23:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAYEkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 23:40:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52FB539BE;
        Tue, 24 Jan 2023 20:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 692516132D;
        Wed, 25 Jan 2023 04:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDD79C4339B;
        Wed, 25 Jan 2023 04:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674621616;
        bh=chjz9070j6mQLyORX1CNctcEH8HzirVYmMh+jA4h9fg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YFj2v0beaPwUROicHo18JAGlArBMVyHbYiAurg4H2pijvDP7+lb2PXNcX8LDgiryK
         sCzC98guItb5cFC/W1ymtq0vD5c1Y2NeQE2V9Zar3YeV6k3KwxSfDSFlGMsk+M5Vje
         aibFexYjGatE0d+8thzT4dXU87gxQyLj0ePsvob0gGZMOf1/Vi0hvc+cAILqB30/vO
         P+wE+wZGWUKpJtA51vCG0NrkoDQRCVJMHHjc+DS/oxMqjlJlM/5VGH6DCTkLxDbCfV
         HZwoC0aLQi/sF0h1OD54KfV3XIYIp47kqdvTq+EUuOx7Ilmy8QOsB2iIDGq50OH1u4
         8BUK0xrcVfJQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1947F83ECD;
        Wed, 25 Jan 2023 04:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/9] Enable cpumasks to be used as kptrs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167462161665.8470.7244847116038822799.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Jan 2023 04:40:16 +0000
References: <20230120192523.3650503-1-void@manifault.com>
In-Reply-To: <20230120192523.3650503-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
        memxor@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Jan 2023 13:25:14 -0600 you wrote:
> This is part 2 of https://lore.kernel.org/all/20230119235833.2948341-1-void@manifault.com/
> 
> Changelog:
> ----------
> v1 -> v2:
> - Put back 'static' keyword in bpf_find_btf_id()
>   (kernel test robot <lkp@intel.com>)
> - Surround cpumask kfuncs in __diag() blocks to avoid no-prototype build
>   warnings (kernel test robot <lkp@intel.com>)
> - Enable ___init suffixes to a type definition to signal that a type is
>   a nocast alias of another type. That is, that when passed to a kfunc
>   that expects one of the two types, the verifier will reject the other
>   even if they're equivalent according to the C standard (Kumar and
>   Alexei)
> - Reject NULL for all trusted args, not just PTR_TO_MEM (Kumar)
> - Reject both NULL and PTR_MAYBE_NULL for all trusted args (Kumar and
>   Alexei )
> - Improve examples given in cpumask documentation (Alexei)
> - Use __success macro for nested_trust test (Alexei)
> - Fix comment typo in struct bpf_cpumask comment header.
> - Fix another example in the bpf_cpumask doc examples.
> - Add documentation for ___init suffix change mentioned above.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/9] bpf: Enable annotating trusted nested pointers
    https://git.kernel.org/bpf/bpf-next/c/57539b1c0ac2
  - [bpf-next,v2,2/9] bpf: Allow trusted args to walk struct when checking BTF IDs
    https://git.kernel.org/bpf/bpf-next/c/b613d335a743
  - [bpf-next,v2,3/9] bpf: Disallow NULLable pointers for trusted kfuncs
    (no matching commit)
  - [bpf-next,v2,4/9] bpf: Enable cpumasks to be queried and used as kptrs
    (no matching commit)
  - [bpf-next,v2,5/9] selftests/bpf: Add nested trust selftests suite
    (no matching commit)
  - [bpf-next,v2,6/9] selftests/bpf: Add selftest suite for cpumask kfuncs
    (no matching commit)
  - [bpf-next,v2,7/9] bpf/docs: Document cpumask kfuncs in a new file
    (no matching commit)
  - [bpf-next,v2,8/9] bpf/docs: Document how nested trusted fields may be defined
    (no matching commit)
  - [bpf-next,v2,9/9] bpf/docs: Document the nocast aliasing behavior of ___init
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


