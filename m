Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4C46D54A9
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjDCWUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDCWUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 18:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EAB273E
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 15:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FE5862CE9
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 22:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC212C4339B;
        Mon,  3 Apr 2023 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680560417;
        bh=K/erbVkacj2N3yBu+RQxaei7LRemsTxEccFmFnONwWU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XIDnohTKY2n4J6HCBWAwyCFMcwEDCWDGliGpXitQw53F0e+Vj5Azw46G+iDJ+/cZW
         BZ351RXndYiisSrzdjba+T0kNYRB7Fqm45VoqzmlqiaG+32JJP6XqqB2xTq2MDj3L5
         EYswNqTCJHl4ZWQl/YujGTG6A1i/Hb22zaegSa9ph6QONRZhKc/TbP84OO0Vvszm2q
         DYCMoYYLHHo9Ia1QNdSQheGbxotziH7a2zenRXbe89KIuDUH+Hd+MkYUgcHWq/bzuj
         VS8Ut1mYU4eMNyPZuHUQ7fjQEavW8KtD4Df6Eh/tauTNlTaJ1mLeYv6/iekYbu8oWs
         xjGjzdWfaYi1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A50CC73FF5;
        Mon,  3 Apr 2023 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix struct_meta lookup for bpf_obj_free_fields
 kfunc call
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168056041762.500.5353160583881542927.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Apr 2023 22:20:17 +0000
References: <20230403200027.2271029-1-davemarchevsky@fb.com>
In-Reply-To: <20230403200027.2271029-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 3 Apr 2023 13:00:27 -0700 you wrote:
> bpf_obj_drop_impl has a void return type. In check_kfunc_call, the "else
> if" which sets insn_aux->kptr_struct_meta for bpf_obj_drop_impl is
> surrounded by a larger if statement which checks btf_type_is_ptr. As a
> result:
> 
>   * The bpf_obj_drop_impl-specific code will never execute
>   * The btf_struct_meta input to bpf_obj_drop is always NULL
>   * __bpf_obj_drop_impl will always see a NULL btf_record when called
>     from BPF program, and won't call bpf_obj_free_fields
>   * program-allocated kptrs which have fields that should be cleaned up
>     by bpf_obj_free_fields may instead leak resources
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call
    https://git.kernel.org/bpf/bpf-next/c/f6a6a5a97628

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


