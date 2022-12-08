Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D7B6479EE
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 00:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLHXa0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 18:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLHXaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 18:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF2A6ACDB
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 15:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3786208B
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 23:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96D29C433D2;
        Thu,  8 Dec 2022 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670542216;
        bh=TDc3Y24FlI67ZOZxINZQdpzZtwLKNAQDieZgdoXXgiY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KGlGea7znkYLiTwAM8fFHrVdnmAf+bePfXtWJ0KKeAfNzp3qmIvSULy4vs7EiRvjb
         hQAledyTsAkzSORxzBaBjsT/Tc/080mM4EZr+wt+q8Yp/PiJl+rQTgEYU5TppWRPbc
         wHe4OOlQraBebr1DMXtzKYGjqsa5wW+JjnwXwaQ85hJYeTymCJ0cNy74+efsSejgUp
         5QZecSe2dZ+FAJNKFZy7SCbobeICLz05XptVRw8UGYRj0c6STBo1bM/eqzTloZKlgV
         6CMLJGOuKHefLOamt2xTFmhjTXj4UAtduWwnaxLlrt3NXzzGOVrHNGEzhcevwd9z5R
         cXtaKhcncEmFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63010C433D7;
        Thu,  8 Dec 2022 23:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Bring test_offload.py back to life
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167054221640.5818.6092024783601204555.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Dec 2022 23:30:16 +0000
References: <20221206232739.2504890-1-sdf@google.com>
In-Reply-To: <20221206232739.2504890-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
        toke@kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  6 Dec 2022 15:27:39 -0800 you wrote:
> Bpftool has new extra libbpf_det_bind probing map we need to exclude.
> Also skip trying to load netdevsim modules if it's already loaded (builtin).
> 
> v2:
> - drop iproute2->bpftool changes (Toke)
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Toke Høiland-Jørgensen <toke@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Bring test_offload.py back to life
    https://git.kernel.org/bpf/bpf-next/c/e60db051a4a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


