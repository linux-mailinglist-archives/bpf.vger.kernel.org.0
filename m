Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4A762EC67
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 04:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiKRDk1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 22:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiKRDk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 22:40:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37975EF89
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 19:40:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74F85B82276
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 03:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B1E3C433C1;
        Fri, 18 Nov 2022 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668742823;
        bh=94ICJ0kvQzN8YnF9fXln8QPlfk6LqmpTyhT3Mw65MpQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IfxfPp6V7xreD0Tv+XV9jXR6YTF1rY3sozU79BGeG/eM2zNLUIIPZmCAV+x+nZy+N
         WdgmX4mRLoyVn9zpGBGFsXsRq+6Fzewq/t2YO/nCpkNpFkUmmt5OP9K8Hf3w/lqbit
         cjg60n1hKlQjNKwF6A3fl9g+Li1V7BdfaISdMIcL7SAuMF608fmXTdSb8hBtD3iwUv
         ELVle8m20Fs6nbBQj5JgO04OnYtvoVUixWLe25jLe32nA5NCoFlUS9VHGEs3QnKLgF
         jxHTm6QxpwB2bZahxwd9eNM1ZggxXTDw8kElVVs2qAnnG+WQH8xhfs9Ac31z3y3DMu
         PCjF/4ktXS1BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E790FC395F3;
        Fri, 18 Nov 2022 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v10 00/24] Allocated objects, BPF linked lists
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166874282293.21431.3904898619780304391.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Nov 2022 03:40:22 +0000
References: <20221118015614.2013203-1-memxor@gmail.com>
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
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

On Fri, 18 Nov 2022 07:25:50 +0530 you wrote:
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
  - [bpf-next,v10,01/24] bpf: Fix early return in map_check_btf
    https://git.kernel.org/bpf/bpf-next/c/c237bfa5283a
  - [bpf-next,v10,02/24] bpf: Do btf_record_free outside map_free callback
    https://git.kernel.org/bpf/bpf-next/c/d7f5ef653c3d
  - [bpf-next,v10,03/24] bpf: Free inner_map_meta when btf_record_dup fails
    https://git.kernel.org/bpf/bpf-next/c/d48995723c9a
  - [bpf-next,v10,04/24] bpf: Populate field_offs for inner_map_meta
    https://git.kernel.org/bpf/bpf-next/c/f73e601aafb2
  - [bpf-next,v10,05/24] bpf: Introduce allocated objects support
    https://git.kernel.org/bpf/bpf-next/c/282de143ead9
  - [bpf-next,v10,06/24] bpf: Recognize lock and list fields in allocated objects
    https://git.kernel.org/bpf/bpf-next/c/8ffa5cc14213
  - [bpf-next,v10,07/24] bpf: Verify ownership relationships for user BTF types
    https://git.kernel.org/bpf/bpf-next/c/865ce09a49d7
  - [bpf-next,v10,08/24] bpf: Allow locking bpf_spin_lock in allocated objects
    https://git.kernel.org/bpf/bpf-next/c/4e814da0d599
  - [bpf-next,v10,09/24] bpf: Allow locking bpf_spin_lock global variables
    https://git.kernel.org/bpf/bpf-next/c/d0d78c1df9b1
  - [bpf-next,v10,10/24] bpf: Allow locking bpf_spin_lock in inner map values
    https://git.kernel.org/bpf/bpf-next/c/b7ff97925b55
  - [bpf-next,v10,11/24] bpf: Rewrite kfunc argument handling
    https://git.kernel.org/bpf/bpf-next/c/00b85860feb8
  - [bpf-next,v10,12/24] bpf: Support constant scalar arguments for kfuncs
    https://git.kernel.org/bpf/bpf-next/c/a50388dbb328
  - [bpf-next,v10,13/24] bpf: Introduce bpf_obj_new
    https://git.kernel.org/bpf/bpf-next/c/958cf2e273f0
  - [bpf-next,v10,14/24] bpf: Introduce bpf_obj_drop
    https://git.kernel.org/bpf/bpf-next/c/ac9f06050a35
  - [bpf-next,v10,15/24] bpf: Permit NULL checking pointer with non-zero fixed offset
    https://git.kernel.org/bpf/bpf-next/c/df57f38a0d08
  - [bpf-next,v10,16/24] bpf: Introduce single ownership BPF linked list API
    https://git.kernel.org/bpf/bpf-next/c/8cab76ec6349
  - [bpf-next,v10,17/24] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
    https://git.kernel.org/bpf/bpf-next/c/534e86bc6c66
  - [bpf-next,v10,18/24] bpf: Add comments for map BTF matching requirement for bpf_list_head
    https://git.kernel.org/bpf/bpf-next/c/c22dfdd21592
  - [bpf-next,v10,19/24] selftests/bpf: Add __contains macro to bpf_experimental.h
    https://git.kernel.org/bpf/bpf-next/c/64069c72b4b8
  - [bpf-next,v10,20/24] selftests/bpf: Update spinlock selftest
    https://git.kernel.org/bpf/bpf-next/c/d85aedac4dc4
  - [bpf-next,v10,21/24] selftests/bpf: Add failure test cases for spin lock pairing
    https://git.kernel.org/bpf/bpf-next/c/c48748aea4f8
  - [bpf-next,v10,22/24] selftests/bpf: Add BPF linked list API tests
    https://git.kernel.org/bpf/bpf-next/c/300f19dcdb99
  - [bpf-next,v10,23/24] selftests/bpf: Add BTF sanity tests
    https://git.kernel.org/bpf/bpf-next/c/dc2df7bf4c8a
  - [bpf-next,v10,24/24] selftests/bpf: Temporarily disable linked list tests
    https://git.kernel.org/bpf/bpf-next/c/0a2f85a1be43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


