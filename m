Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00B6080C5
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiJUVai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJUVah (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9107224CC32;
        Fri, 21 Oct 2022 14:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D0C661F93;
        Fri, 21 Oct 2022 21:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C136BC433B5;
        Fri, 21 Oct 2022 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666387832;
        bh=odl3zYkOMPgjkzgtfo2vZKSQF7mnCwR7KAENKw8l/Uo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QQ7aYppSFi5NZGqmO4ICuXjsT8DEkkTzXoKvjHZPdmbAJcdEOEu/HksnLyFZaIOQ8
         C0HUBbziOp0uw9nAf6OynZKy6JKEwPLHCjP5pS7lYElc0jTjmIOJWVf7eWhpa73t+r
         ATWSr+7Zf/D2tJ9swlfKtA/c18c2ZU0QPisTF/h25dufDOQp79gh9pYESMSmdWhuME
         Il6fmzo684Ii20+3gBfEfJ0qrN7SCyr84jsGDQbQWpVnVmHNOf9AmrFXdbMG0ODpwv
         UiK+cjqC9bWyJbvDFblvuQdPKX86XV4h73HP+8yO7QCKb9xm3JjHl2hnPaM7vuSUEX
         M6pyhOXXZ0hUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EF16E270E1;
        Fri, 21 Oct 2022 21:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Avoid allocating reg_name with sscanf in
 parse_usdt_arg()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166638783264.15541.17720155984505413324.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 21:30:32 +0000
References: <20221018145538.2046842-1-xukuohai@huaweicloud.com>
In-Reply-To: <20221018145538.2046842-1-xukuohai@huaweicloud.com>
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 18 Oct 2022 10:55:38 -0400 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> The reg_name in parse_usdt_arg() is used to hold register name, which
> is short enough to be held in a 16-byte array, so we could define
> reg_name as char reg_name[16] to avoid dynamically allocating reg_name
> with sscanf.
> 
> [...]

Here is the summary with links:
  - libbpf: Avoid allocating reg_name with sscanf in parse_usdt_arg()
    https://git.kernel.org/bpf/bpf-next/c/d9740535b857

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


