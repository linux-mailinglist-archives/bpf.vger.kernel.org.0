Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC46626439
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 23:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKKWKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 17:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiKKWKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 17:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD7A4044F
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 14:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB6AE62100
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 22:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40B22C433C1;
        Fri, 11 Nov 2022 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668204616;
        bh=40H44fmMP10up6twkc3rWGASAsN9qIFbpK7jvaWSydo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=phGzvUomLDfAI8gsXcknDydh7vxqGZKLKjtQmAdRashkUH+iY9cG/j7cuHP9uCWIh
         ku7vmdZ0ie6n1VpaowUzOES9vyhP+O3aJcIni27ZMjp3fyTTnmJEunN+eE9wa/yYT6
         SHJaFjLDZPhtIhTF3a9lhrIdQ7ygUSKYsu/yHA/dCY/LhU99zMfBAFOy0K4XSAGu0R
         vGQCJNrf8nKOXLFrwxA4gvopQEGcI0msVJ2kmLq5JvP+EOycKW08YBB+kFsyeWjl0i
         M83FZSiBRbTKK/GzSuNBAdutWF0MhTvb41dtQcNac01rt7K+pc67fCiGHojPBWf6+H
         rCdhOFyy6vSig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EA62E270C6;
        Fri, 11 Nov 2022 22:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix veristat's singular file-or-prog
 filter
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166820461611.14492.15680603214904923952.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 22:10:16 +0000
References: <20221111181242.2101192-1-andrii@kernel.org>
In-Reply-To: <20221111181242.2101192-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 11 Nov 2022 10:12:42 -0800 you wrote:
> Fix the bug of filtering out filename too early, before we know the
> program name, if using unified file-or-prog filter (i.e., -f
> <any-glob>). Because we try to filter BPF object file early without
> opening and parsing it, if any_glob (file-or-prog) filter is used we
> have to accept any filename just to get program name, which might match
> any_glob.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix veristat's singular file-or-prog filter
    https://git.kernel.org/bpf/bpf-next/c/eb6af4ceda2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


