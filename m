Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CCA6291B0
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 07:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiKOGAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 01:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiKOGAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 01:00:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8481612AF9
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 22:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46A14B8167E
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 06:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4D99C433C1;
        Tue, 15 Nov 2022 06:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668492016;
        bh=h2jiNFZ3PAytuIdDNIae5L+mGWwpcjowoVPIj1UAmsE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Maeix/OZCdy6ATEwrhriNpI8Pc29xDdvUS+Ng98sHuNpDbkEi+5vVcuh5Gu4u6NZk
         j2osf8OMi6ZdjnA62vdnxlXhgUaXTqYK74It2YAFUVwjWpb1EbhtjikN+FGYtIZQbW
         yWEucAwzkg37KY4prH1Zh+I55TnOCBGXVj5TNYgq+XHY0WMpP5MDTHRAVLzBq9pnZI
         V9HHdIyD8eB1PxZj6P6EQ9xQIZmban7VxFJz7Ea2+/Vifbqn/D7QgvWpHJdusfDhy2
         tUwnGKVY7KLHUHmzT3CCpIl4OPrhpQYtfl5mkdl0ce0R8saeNRSUAplo58FIkeYxP3
         y6Q2CM+K9zESQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E07CE4D021;
        Tue, 15 Nov 2022 06:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 00/26] Allocated objects, BPF linked lists
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166849201657.20675.11515665661615198603.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Nov 2022 06:00:16 +0000
References: <20221114191547.1694267-1-memxor@gmail.com>
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org,
        davemarchevsky@meta.com
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

On Tue, 15 Nov 2022 00:45:21 +0530 you wrote:
> This series introduces user defined BPF objects of a type in program
> BTF. This allows BPF programs to allocate their own objects, build their
> own object hierarchies, and use the basic building blocks provided by
> BPF runtime to build their own data structures flexibly.
> 
> Then, we introduce the support for single ownership BPF linked lists,
> which can be put inside BPF maps, or allocated objects, and hold such
> allocated objects as elements. It works as an instrusive collection,
> which is done to allow making allocated objects part of multiple data
> structures at the same time in the future.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,01/26] bpf: Remove local kptr references in documentation
    https://git.kernel.org/bpf/bpf-next/c/1f6d52f1a894
  - [bpf-next,v7,02/26] bpf: Remove BPF_MAP_OFF_ARR_MAX
    https://git.kernel.org/bpf/bpf-next/c/2d577252579b
  - [bpf-next,v7,03/26] bpf: Fix copy_map_value, zero_map_value
    https://git.kernel.org/bpf/bpf-next/c/e5feed0f64f7
  - [bpf-next,v7,04/26] bpf: Support bpf_list_head in map values
    https://git.kernel.org/bpf/bpf-next/c/f0c5941ff5b2
  - [bpf-next,v7,05/26] bpf: Rename RET_PTR_TO_ALLOC_MEM
    https://git.kernel.org/bpf/bpf-next/c/2de2669b4e52
  - [bpf-next,v7,06/26] bpf: Rename MEM_ALLOC to MEM_RINGBUF
    https://git.kernel.org/bpf/bpf-next/c/894f2a8b1673
  - [bpf-next,v7,07/26] bpf: Refactor btf_struct_access
    https://git.kernel.org/bpf/bpf-next/c/6728aea7216c
  - [bpf-next,v7,08/26] bpf: Introduce allocated objects support
    (no matching commit)
  - [bpf-next,v7,09/26] bpf: Recognize lock and list fields in allocated objects
    (no matching commit)
  - [bpf-next,v7,10/26] bpf: Verify ownership relationships for user BTF types
    (no matching commit)
  - [bpf-next,v7,11/26] bpf: Allow locking bpf_spin_lock in allocated objects
    (no matching commit)
  - [bpf-next,v7,12/26] bpf: Allow locking bpf_spin_lock global variables
    (no matching commit)
  - [bpf-next,v7,13/26] bpf: Allow locking bpf_spin_lock in inner map values
    (no matching commit)
  - [bpf-next,v7,14/26] bpf: Rewrite kfunc argument handling
    (no matching commit)
  - [bpf-next,v7,15/26] bpf: Drop kfunc bits from btf_check_func_arg_match
    (no matching commit)
  - [bpf-next,v7,16/26] bpf: Support constant scalar arguments for kfuncs
    (no matching commit)
  - [bpf-next,v7,17/26] bpf: Introduce bpf_obj_new
    (no matching commit)
  - [bpf-next,v7,18/26] bpf: Introduce bpf_obj_drop
    (no matching commit)
  - [bpf-next,v7,19/26] bpf: Permit NULL checking pointer with non-zero fixed offset
    (no matching commit)
  - [bpf-next,v7,20/26] bpf: Introduce single ownership BPF linked list API
    (no matching commit)
  - [bpf-next,v7,21/26] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
    (no matching commit)
  - [bpf-next,v7,22/26] selftests/bpf: Add __contains macro to bpf_experimental.h
    (no matching commit)
  - [bpf-next,v7,23/26] selftests/bpf: Update spinlock selftest
    (no matching commit)
  - [bpf-next,v7,24/26] selftests/bpf: Add failure test cases for spin lock pairing
    (no matching commit)
  - [bpf-next,v7,25/26] selftests/bpf: Add BPF linked list API tests
    (no matching commit)
  - [bpf-next,v7,26/26] selftests/bpf: Add BTF sanity tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


