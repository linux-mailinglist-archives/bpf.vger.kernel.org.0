Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E86B51FC
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 21:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjCJUby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 15:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCJUbi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 15:31:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5013B2A2
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 12:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D29DB82410
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 20:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36F8BC4339B;
        Fri, 10 Mar 2023 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678480218;
        bh=8/eTu5imn2JQt1ra3enfswE3qWY3uU6Cdf1YraaY+1w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lpU/GjkdcxVWG8y8kJ6J7f3FYlzPaTZx5MfaEiUprx7NmPOsnJ29iytChCozqz2kz
         o9oS1lAlrag0X/aa+iIpNMC1jl96uBzEU3h/pkqzKVkzWbBKaEs6hkpXhcOJXLIxUA
         w7IOekHW6xfXmL79nRJnNxC8B8tvjqKZ2RG8APPRxiLzKzksQIf+Hnp9ecTsKaWDvH
         x2bfWY5wXAGa2gSitnC8hlB19ylD1dADbacqabJee67zmsvHVxeEjEn5iK1rquqDnP
         bzX5175piuud9IU3Lnj+MBueQ0MbWA0FCNQJD189/o63rMVpV1czUEHHLTKF44rh65
         qrA9kVv6TWxXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B6F6C59A4C;
        Fri, 10 Mar 2023 20:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next 0/6] Support stashing local kptrs with
 bpf_kptr_xchg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167848021810.31195.5242744618303272983.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 20:30:18 +0000
References: <20230309180111.1618459-1-davemarchevsky@fb.com>
In-Reply-To: <20230309180111.1618459-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, tj@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 9 Mar 2023 10:01:05 -0800 you wrote:
> Local kptrs are kptrs allocated via bpf_obj_new with a type specified in program
> BTF. A BPF program which creates a local kptr has exclusive control of the
> lifetime of the kptr, and, prior to terminating, must:
> 
>   * free the kptr via bpf_obj_drop
>   * If the kptr is a {list,rbtree} node, add the node to a {list, rbtree},
>     thereby passing control of the lifetime to the collection
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next,1/6] bpf: verifier: Rename kernel_type_name helper to btf_type_name
    https://git.kernel.org/bpf/bpf-next/c/b32a5dae44cc
  - [v1,bpf-next,2/6] bpf: btf: Remove unused btf_field_info_type enum
    https://git.kernel.org/bpf/bpf-next/c/a4aa38897b6a
  - [v1,bpf-next,3/6] bpf: Change btf_record_find enum parameter to field_mask
    https://git.kernel.org/bpf/bpf-next/c/74843b57ec70
  - [v1,bpf-next,4/6] bpf: Support __kptr to local kptrs
    (no matching commit)
  - [v1,bpf-next,5/6] bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg
    (no matching commit)
  - [v1,bpf-next,6/6] selftests/bpf: Add local kptr stashing test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


