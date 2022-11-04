Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE1619000
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 06:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKDFaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 01:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDFaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 01:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14562408B
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 22:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689E9620B5
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 05:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8894C433B5;
        Fri,  4 Nov 2022 05:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667539814;
        bh=cqfkvxvjo/MkQvv3IHlN0iws12Sxm4bsdlXxX4xRdbg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R6U/MXYNz270WTwhfRiIrQ7EGqs5D/sKK8Gf9Lt5nIxlNRQG89MiQFvQtub45jEmh
         6EOd/CDUPYpKGuwQh53HIiqAW9HgPCQK3AoPoU4m4J705uhqc+dNa9jucVRsEzSkG3
         xVyiFzt32gC9vP9vmin/TqcCXUL53AqNOt+bI2Uy6IVyIiUXxzMG3tn9G1iKf92pwl
         xGdCT2HUu4FbKw/prbrcJq8oiejpeWemi5RObv2zMioUXT0ou0/mMTsStah9HLvEG3
         AjBtkFzm9yz0hyqoHc3/+HW0LcLIyvngz5v0xQ9gCoHRvkTug2ax4+4p74uWPgEvNa
         m/Ge0SStTiHGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D892E270EA;
        Fri,  4 Nov 2022 05:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/24] Local kptrs, BPF linked lists
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166753981464.11870.10486560059847217334.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Nov 2022 05:30:14 +0000
References: <20221103191013.1236066-1-memxor@gmail.com>
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org,
        davemarchevsky@meta.com, delyank@meta.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri,  4 Nov 2022 00:39:49 +0530 you wrote:
> This series introduces user defined BPF objects, by introducing the idea
> of local kptrs. These are kptrs (strongly typed pointers) that refer to
> objects of a user defined type, hence called "local" kptrs. This allows
> BPF programs to allocate their own objects, build their own object
> hierarchies, and use the basic building blocks provided by BPF runtime
> to build their own data structures flexibly.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/24] bpf: Document UAPI details for special BPF types
    (no matching commit)
  - [bpf-next,v4,02/24] bpf: Allow specifying volatile type modifier for kptrs
    (no matching commit)
  - [bpf-next,v4,03/24] bpf: Clobber stack slot when writing over spilled PTR_TO_BTF_ID
    (no matching commit)
  - [bpf-next,v4,04/24] bpf: Fix slot type check in check_stack_write_var_off
    (no matching commit)
  - [bpf-next,v4,05/24] bpf: Drop reg_type_may_be_refcounted_or_null
    (no matching commit)
  - [bpf-next,v4,06/24] bpf: Refactor kptr_off_tab into btf_record
    (no matching commit)
  - [bpf-next,v4,07/24] bpf: Consolidate spin_lock, timer management into btf_record
    https://git.kernel.org/bpf/bpf-next/c/db559117828d
  - [bpf-next,v4,08/24] bpf: Refactor map->off_arr handling
    (no matching commit)
  - [bpf-next,v4,09/24] bpf: Support bpf_list_head in map values
    (no matching commit)
  - [bpf-next,v4,10/24] bpf: Introduce local kptrs
    (no matching commit)
  - [bpf-next,v4,11/24] bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs
    (no matching commit)
  - [bpf-next,v4,12/24] bpf: Verify ownership relationships for user BTF types
    (no matching commit)
  - [bpf-next,v4,13/24] bpf: Support locking bpf_spin_lock in local kptr
    (no matching commit)
  - [bpf-next,v4,14/24] bpf: Allow locking bpf_spin_lock global variables
    (no matching commit)
  - [bpf-next,v4,15/24] bpf: Rewrite kfunc argument handling
    (no matching commit)
  - [bpf-next,v4,16/24] bpf: Drop kfunc bits from btf_check_func_arg_match
    (no matching commit)
  - [bpf-next,v4,17/24] bpf: Support constant scalar arguments for kfuncs
    (no matching commit)
  - [bpf-next,v4,18/24] bpf: Teach verifier about non-size constant arguments
    (no matching commit)
  - [bpf-next,v4,19/24] bpf: Introduce bpf_obj_new
    (no matching commit)
  - [bpf-next,v4,20/24] bpf: Introduce bpf_obj_drop
    (no matching commit)
  - [bpf-next,v4,21/24] bpf: Permit NULL checking pointer with non-zero fixed offset
    (no matching commit)
  - [bpf-next,v4,22/24] bpf: Introduce single ownership BPF linked list API
    (no matching commit)
  - [bpf-next,v4,23/24] selftests/bpf: Add __contains macro to bpf_experimental.h
    (no matching commit)
  - [bpf-next,v4,24/24] selftests/bpf: Add BPF linked list API tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


