Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4570645245
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 03:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLGCuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 21:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLGCuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 21:50:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA6054B32
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 18:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA64B61633
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 02:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51007C433C1;
        Wed,  7 Dec 2022 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670381421;
        bh=Q7JH62bVzsJdu2dW2nS9CW83Ob9g6ddk0JxX8Kr/seU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UibBJw+fepGPLLFDEeN3N8uC77nQ4ZT/vxkL1ZZ0IVtlmOr6fCj92ksoLMlG8uRDI
         TZ/qqhBUYKFeT0DymcxytQzWstdfyZe7v3zOgiZQpu6iWdiuuMzIPcjqx2SRFgDjPE
         y57IduktYZyfrCxeSBbXRFAqxoqItZusscgp18npBRsgfBwv4O62CYKpqhTu5xY/LK
         vjq5uscCzMPCXyvg5+zyn4tx5VrQpMojlgA8CbH6nP1txEU98ohs7V2nXz3+5nLHou
         yoIqLKBNrgEoXXvSqeQSTP0IRiI1jHCxVzlN9zwU/9ocvbE2Gz8rIPcR8SOuQI9uyS
         mYWRK58rfeA4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F840E270CF;
        Wed,  7 Dec 2022 02:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167038142103.19603.6830051103769600116.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 02:50:21 +0000
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, memxor@gmail.com,
        tj@kernel.org
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

On Tue, 6 Dec 2022 15:09:47 -0800 you wrote:
> This series adds a rbtree datastructure following the "next-gen
> datastructure" precedent set by recently-added linked-list [0]. This is
> a reimplementation of previous rbtree RFC [1] to use kfunc + kptr
> instead of adding a new map type. This series adds a smaller set of API
> functions than that RFC - just the minimum needed to support current
> cgfifo example scheduler in ongoing sched_ext effort [2], namely:
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/13] bpf: Loosen alloc obj test in verifier's reg_btf_record
    https://git.kernel.org/bpf/bpf-next/c/d8939cb0a03c
  - [bpf-next,02/13] bpf: map_check_btf should fail if btf_parse_fields fails
    (no matching commit)
  - [bpf-next,03/13] bpf: Minor refactor of ref_set_release_on_unlock
    (no matching commit)
  - [bpf-next,04/13] bpf: rename list_head -> datastructure_head in field info types
    (no matching commit)
  - [bpf-next,05/13] bpf: Add basic bpf_rb_{root,node} support
    (no matching commit)
  - [bpf-next,06/13] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
    (no matching commit)
  - [bpf-next,07/13] bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args
    (no matching commit)
  - [bpf-next,08/13] bpf: Add callback validation to kfunc verifier logic
    (no matching commit)
  - [bpf-next,09/13] bpf: Special verifier handling for bpf_rbtree_{remove, first}
    (no matching commit)
  - [bpf-next,10/13] bpf, x86: BPF_PROBE_MEM handling for insn->off < 0
    (no matching commit)
  - [bpf-next,11/13] bpf: Add bpf_rbtree_{add,remove,first} decls to bpf_experimental.h
    (no matching commit)
  - [bpf-next,12/13] libbpf: Make BTF mandatory if program BTF has spin_lock or alloc_obj type
    (no matching commit)
  - [bpf-next,13/13] selftests/bpf: Add rbtree selftests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


