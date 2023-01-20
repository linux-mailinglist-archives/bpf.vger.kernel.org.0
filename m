Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCBE675A03
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjATQbk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 11:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjATQbc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 11:31:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E255FF0
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 08:30:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3773ECE2964
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D396C4339B;
        Fri, 20 Jan 2023 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674232217;
        bh=e7kKeH7I/o0eZtOR19ecT85hZWYOjMEOom231zMpVmQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D4RUjVKpvxPfsBOdsgY5cd/Dd6tkwE+ehVR7mHII31ZpAFyFyofKTSJ49HU1sYzGQ
         D+jj+4ol+szI9R1Fx9tEzssg1RSjOEPJXF83USTT/WrUP28BRgNlpAX57J7xbplPBc
         G81Mfktybnfqt5YhadFipeu3Ivqzga5dzhGTB6RJEuTlZZ+y3tlmx7VTjI3fQy3J3f
         LcuuopgBP3ALuxATCnieYPKUzQ5sHv7q1gNHr7KqlwDvx3LE/KmY7Mm3cNqAdimyTh
         0b6mgNTCeLZnD70VkmiwcR8BRvgTdmo3DDnj6wLWEoQSDGq787yn2qQpXXdeKE5Ojo
         wr/RlR+Ii4Hbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F3DAC04E34;
        Fri, 20 Jan 2023 16:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf] bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167423221732.12974.16844479315045266341.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Jan 2023 16:30:17 +0000
References: <20230120122148.1522359-1-jolsa@kernel.org>
In-Reply-To: <20230120122148.1522359-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        memxor@gmail.com, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Jan 2023 13:21:48 +0100 you wrote:
> We take the BTF reference before we register dtors and we need
> to put it back when it's done.
> 
> We probably won't se a problem with kernel BTF, but module BTF
> would stay loaded (because of the extra ref) even when its module
> is removed.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf] bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
    https://git.kernel.org/bpf/bpf/c/74bc3a5acc82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


