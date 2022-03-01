Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B291D4C8BFC
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 13:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiCAMvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 07:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiCAMvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 07:51:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FC9398B
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 04:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8992961363
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 12:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3762C340F2;
        Tue,  1 Mar 2022 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646139041;
        bh=hkQEfhi4f78wAucbqB4V71WYgqD3nf7LDVYrveiNTzQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SuWNqdziw1aOqUEYBuqgOtSTx86ppbr4G9ylRvGHeZumF+gHyd34nrCLthnTgYLpf
         K1dfo8SjcLVI7ASnjejDRGNZ7oLvhB5s15K+yXS8wVxAkw1UcnaZ+RcS6tQ35yhVBl
         4rUsq/XSREpCRwkBjW/1EwGeQAVXaLrFGHLrBJ6IBMDFgyJOk+SM+SnCIiba67qq8b
         XVpu8SPj4waQbzW+aYZz1+O/vOTGJSeWcLlKFW0CvPI2AChj4lrPeRe4DdL4T5hPhT
         9K1hfMXOOnHxTYbq42G/FcQIy2SwopR383fiQzErh6zhZ7FAXrcVh/vZCBv5neF3GK
         lQ6lZtY5/73PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBBC3E6D4BB;
        Tue,  1 Mar 2022 12:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] Fix btf dump error caused by declaration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164613904076.30833.3926178624751769768.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Mar 2022 12:50:40 +0000
References: <20220301053250.1464204-1-xukuohai@huawei.com>
In-Reply-To: <20220301053250.1464204-1-xukuohai@huawei.com>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 1 Mar 2022 00:32:48 -0500 you wrote:
> This series fixes a btf dump error caused by forward declaration.
> 
> Currently if a declaration appears in the BTF before the definition,
> the definition is dumped as a conflicting name, eg:
> 
>     $ bpftool btf dump file vmlinux format raw | grep "'unix_sock'"
>     [81287] FWD 'unix_sock' fwd_kind=struct
>     [89336] STRUCT 'unix_sock' size=1024 vlen=14
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] libbpf: Skip forward declaration when counting duplicated type names
    https://git.kernel.org/bpf/bpf-next/c/4226961b0019
  - [bpf-next,v4,2/2] selftests/bpf: Update btf_dump case for conflicting names
    https://git.kernel.org/bpf/bpf-next/c/bd004cad78c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


