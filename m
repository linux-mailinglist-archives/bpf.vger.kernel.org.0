Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30054DEA32
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbiCSSvf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbiCSSvf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:51:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D182241FF
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D1D7B80DB0
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 18:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48C3CC340EC;
        Sat, 19 Mar 2022 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647715811;
        bh=+QAJnhFybsWb5ckKVbssoWMIMqbnXo1v+JQPgaAgQqo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sTdjZtQgZl4oyzywzsKSfCN5kIpARdk4TQXRYr6OAdzsX73aLxl0Z0wqZIGjVfnOO
         ic8xTnNF2m3oE+boDuBEY5867o6Txwrcy2oPgIVJazOvop4sKZdgu2idWRi+wLpmpW
         UIYpX23+rBJrMli2Uu+Tar9OYfujgSif7/DJkux5HTmJw2WzuIMt9qx3RuJz/hVsRX
         e7FEFFhNPDCazC+e+UMsz0G7C4oUbJtBKQkJ09iUKPu4QWdoWcGjwgUm03Aj3LAkGM
         /jYmLUePoV1+QxR1pVorrRczGkFKa/Tqt5JogOTYvyT4U4vlWQQiXln1annZ6KsAEU
         8SVWr8n9MnAqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30326F03841;
        Sat, 19 Mar 2022 18:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/15] Introduce typed pointer support in BPF maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164771581019.7815.13540456142547732378.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Mar 2022 18:50:10 +0000
References: <20220317115957.3193097-1-memxor@gmail.com>
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, toke@redhat.com, brouer@redhat.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 17 Mar 2022 17:29:42 +0530 you wrote:
> This set enables storing pointers of a certain type in BPF map, and extends the
> verifier to enforce type safety and lifetime correctness properties.
> 
> The infrastructure being added is generic enough for allowing storing any kind
> of pointers whose type is available using BTF (user or kernel) in the future
> (e.g. strongly typed memory allocation in BPF program), which are internally
> tracked in the verifier as PTR_TO_BTF_ID, but for now the series limits them to
> four kinds of pointers obtained from the kernel.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/15] bpf: Factor out fd returning from bpf_btf_find_by_name_kind
    https://git.kernel.org/bpf/bpf-next/c/edc3ec09ab70
  - [bpf-next,v2,02/15] bpf: Make btf_find_field more generic
    (no matching commit)
  - [bpf-next,v2,03/15] bpf: Allow storing unreferenced kptr in map
    (no matching commit)
  - [bpf-next,v2,04/15] bpf: Allow storing referenced kptr in map
    (no matching commit)
  - [bpf-next,v2,05/15] bpf: Allow storing percpu kptr in map
    (no matching commit)
  - [bpf-next,v2,06/15] bpf: Allow storing user kptr in map
    (no matching commit)
  - [bpf-next,v2,07/15] bpf: Prevent escaping of kptr loaded from maps
    (no matching commit)
  - [bpf-next,v2,08/15] bpf: Adapt copy_map_value for multiple offset case
    (no matching commit)
  - [bpf-next,v2,09/15] bpf: Always raise reference in btf_get_module_btf
    https://git.kernel.org/bpf/bpf-next/c/9492450fd287
  - [bpf-next,v2,10/15] bpf: Populate pairs of btf_id and destructor kfunc in btf
    (no matching commit)
  - [bpf-next,v2,11/15] bpf: Wire up freeing of referenced kptr
    (no matching commit)
  - [bpf-next,v2,12/15] bpf: Teach verifier about kptr_get kfunc helpers
    (no matching commit)
  - [bpf-next,v2,13/15] libbpf: Add kptr type tag macros to bpf_helpers.h
    (no matching commit)
  - [bpf-next,v2,14/15] selftests/bpf: Add C tests for kptr
    (no matching commit)
  - [bpf-next,v2,15/15] selftests/bpf: Add verifier tests for kptr
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


