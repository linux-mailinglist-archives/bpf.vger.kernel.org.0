Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D700509605
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 06:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381402AbiDUEnD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 00:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDUEnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 00:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAEB267A
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6EA61CC5
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 04:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40BC9C385A8;
        Thu, 21 Apr 2022 04:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650516012;
        bh=9Dv1GhyA4T7NN9NY6yHXbKGgT/1H6kQ/vr+S0imoay0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NQISh3TJ9dlQPVuWFoF66C2xLIMXteazlNo4qMxhlkq2RYZN573z2xLYUseI38h9K
         L9Bn2AcqVrm4LSgNyUeznEI5AwP8lfKDJq83UvzpIrfTmeAQMYC83tA9PEbiddA+2i
         MbqDPus3hdCqkSEiELpyJL4HUHtMaG15N08MZ63/ooQaiqN3+5xM0Fj8CiFezYVE3x
         gjBcveJU5rjp+Exj78iqaYfLDP8I1QknhdRAdMGSctFm6UTXYm9+D0KybpwwWpgmVW
         wr5AaOypK2G6l60fE2+pQFS4eObWKSD0zfldCp4YWKD7xYPAUWu/3RqBWpfKMki7qo
         PQegTwORGuS3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B185E8DD85;
        Thu, 21 Apr 2022 04:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/13] Introduce typed pointer support in BPF maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165051601210.2500.17907694823304593612.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Apr 2022 04:40:12 +0000
References: <20220415160354.1050687-1-memxor@gmail.com>
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, joannelkoong@gmail.com, toke@redhat.com,
        brouer@redhat.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 15 Apr 2022 21:33:41 +0530 you wrote:
> This set enables storing pointers of a certain type in BPF map, and extends the
> verifier to enforce type safety and lifetime correctness properties.
> 
> The infrastructure being added is generic enough for allowing storing any kind
> of pointers whose type is available using BTF (user or kernel) in the future
> (e.g. strongly typed memory allocation in BPF program), which are internally
> tracked in the verifier as PTR_TO_BTF_ID, but for now the series limits them to
> two kinds of pointers obtained from the kernel.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/13] bpf: Make btf_find_field more generic
    https://git.kernel.org/bpf/bpf-next/c/91af2fc8739e
  - [bpf-next,v5,02/13] bpf: Move check_ptr_off_reg before check_map_access
    https://git.kernel.org/bpf/bpf-next/c/0ed6ff597f2d
  - [bpf-next,v5,03/13] bpf: Allow storing unreferenced kptr in map
    (no matching commit)
  - [bpf-next,v5,04/13] bpf: Tag argument to be released in bpf_func_proto
    (no matching commit)
  - [bpf-next,v5,05/13] bpf: Allow storing referenced kptr in map
    (no matching commit)
  - [bpf-next,v5,06/13] bpf: Prevent escaping of kptr loaded from maps
    (no matching commit)
  - [bpf-next,v5,07/13] bpf: Adapt copy_map_value for multiple offset case
    (no matching commit)
  - [bpf-next,v5,08/13] bpf: Populate pairs of btf_id and destructor kfunc in btf
    (no matching commit)
  - [bpf-next,v5,09/13] bpf: Wire up freeing of referenced kptr
    (no matching commit)
  - [bpf-next,v5,10/13] bpf: Teach verifier about kptr_get kfunc helpers
    (no matching commit)
  - [bpf-next,v5,11/13] libbpf: Add kptr type tag macros to bpf_helpers.h
    (no matching commit)
  - [bpf-next,v5,12/13] selftests/bpf: Add C tests for kptr
    (no matching commit)
  - [bpf-next,v5,13/13] selftests/bpf: Add verifier tests for kptr
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


