Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F95A8647
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiHaTAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiHaTAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 15:00:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120124F32;
        Wed, 31 Aug 2022 12:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99BE5B8229B;
        Wed, 31 Aug 2022 19:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38610C43147;
        Wed, 31 Aug 2022 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661972417;
        bh=mK6JO5EdjbYWRUneA+pYJvL/0luDHh7ixAZ5Xhgmcho=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tYhDkZcwC9IOt5R5VqDc9YIZ4QDz7fB8UXTf6KD/AmhbpPv5F2E9B3dh/yo3E7LSH
         DYW25ILkDmSNXTUIi3fsGus2EkSTMNwLKIGiuUyYjfrS66d5o1LBUZtKq+SWLzmyYp
         3nvZxL+aP13nVSU+XxL5m0q2KVYXuOOmyIJtGqq8SzerGvet3kxXongbRDsIx9G2op
         78qp32w+GPCOMVQNInU4GNiapa5HeeDCdggX0b7MdF82RK2g7DDxO+Gl/Mz1MN9cW4
         Zr3pYEBEmKmKmS4w2mF1lPkrZJklSOlEaxmu40TbJd+x3PGXY5GlqqNkS/XKqg1K56
         bAXlrdhw7lK7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E3EDE924DB;
        Wed, 31 Aug 2022 19:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: add GCC support for bpf_tail_call_static
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166197241711.25924.12874489815667312350.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 19:00:17 +0000
References: <20220829210546.755377-1-james.hilliard1@gmail.com>
In-Reply-To: <20220829210546.755377-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 29 Aug 2022 15:05:46 -0600 you wrote:
> The bpf_tail_call_static function is currently not defined unless
> using clang >= 8.
> 
> To support bpf_tail_call_static on GCC we can check if __clang__ is
> not defined to enable bpf_tail_call_static.
> 
> We need to use GCC assembly syntax when the compiler does not define
> __clang__ as LLVM inline assembly is not fully compatible with GCC.
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: add GCC support for bpf_tail_call_static
    https://git.kernel.org/bpf/bpf-next/c/14e5ce79943a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


