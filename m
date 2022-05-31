Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DCF5398E4
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 23:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiEaVkZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 17:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiEaVkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 17:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F3E7356A
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 14:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C96C6136E
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 21:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FAD4C3411D;
        Tue, 31 May 2022 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654033222;
        bh=jDV5aehaOgAPLGnIx/tI+Rzg+vG3uf7DI1qhnP0aZwo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uJtvwcYhwscCTwGmpDBRdoHst9lohJfGQtROj4bvYZ5elkTwYuZJPYcPnhQ+LC0e8
         wei3gGaeccvMAxdG1TJya1iT1dT1X99AOOraYlzFot9cIz6WdE+53CtWWCKFL9JZ6E
         YUaP0Y09oTN8K1TeirFj37ZfXPZpbcUqMA3Exx7ajb+qIQJ9iZRmxN0ZyBDguP0TgK
         HmrMXUNZU6UNQEPKiWOjp5jrW+I5SqwJw+P3d/TJYKvUVnQUmpuI76cEwRd1fStzz7
         Wt2ecBwP8gPTwtIbgIcDtRBJDO3nz/nAezJcHO/8zZ93IEzTnT81EjHqkDR+pIKgHk
         6K+/lrJ0xKc0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81CF0F03944;
        Tue, 31 May 2022 21:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/12] libbpf: Textual representation of enums
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165403322252.3055.5094237402728093213.git-patchwork-notify@kernel.org>
Date:   Tue, 31 May 2022 21:40:22 +0000
References: <20220523230428.3077108-1-deso@posteo.net>
In-Reply-To: <20220523230428.3077108-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        quentin@isovalent.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 23 May 2022 23:04:16 +0000 you wrote:
> This patch set introduces the means for querying a textual representation of
> the following BPF related enum types:
> - enum bpf_map_type
> - enum bpf_prog_type
> - enum bpf_attach_type
> - enum bpf_link_type
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/12] libbpf: Introduce libbpf_bpf_prog_type_str
    https://git.kernel.org/bpf/bpf-next/c/36f21676bad3
  - [bpf-next,v4,02/12] selftests/bpf: Add test for libbpf_bpf_prog_type_str
    https://git.kernel.org/bpf/bpf-next/c/9bb1be5c6eed
  - [bpf-next,v4,03/12] bpftool: Use libbpf_bpf_prog_type_str
    https://git.kernel.org/bpf/bpf-next/c/13259b23955f
  - [bpf-next,v4,04/12] libbpf: Introduce libbpf_bpf_map_type_str
    https://git.kernel.org/bpf/bpf-next/c/1be3ac58c1f7
  - [bpf-next,v4,05/12] selftests/bpf: Add test for libbpf_bpf_map_type_str
    https://git.kernel.org/bpf/bpf-next/c/4714649a9af8
  - [bpf-next,v4,06/12] bpftool: Use libbpf_bpf_map_type_str
    https://git.kernel.org/bpf/bpf-next/c/889f4cba4bdb
  - [bpf-next,v4,07/12] libbpf: Introduce libbpf_bpf_attach_type_str
    https://git.kernel.org/bpf/bpf-next/c/58342919a189
  - [bpf-next,v4,08/12] selftests/bpf: Add test for libbpf_bpf_attach_type_str
    https://git.kernel.org/bpf/bpf-next/c/98e0e5eb4412
  - [bpf-next,v4,09/12] bpftool: Use libbpf_bpf_attach_type_str
    https://git.kernel.org/bpf/bpf-next/c/2a5ada03fcb3
  - [bpf-next,v4,10/12] libbpf: Introduce libbpf_bpf_link_type_str
    https://git.kernel.org/bpf/bpf-next/c/19b4ce1e29ff
  - [bpf-next,v4,11/12] selftests/bpf: Add test for libbpf_bpf_link_type_str
    https://git.kernel.org/bpf/bpf-next/c/8ff2d074f953
  - [bpf-next,v4,12/12] bpftool: Use libbpf_bpf_link_type_str
    https://git.kernel.org/bpf/bpf-next/c/9522b20b46c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


