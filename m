Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF760E634
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiJZRKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiJZRKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 13:10:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47B3334C
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 10:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 460B5B823A2
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 17:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1A16C433C1;
        Wed, 26 Oct 2022 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666804215;
        bh=NDk+I6Oytm3y8Q5ycojAYJV0d2ZHJBvRtby2K6erGP4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QjLVGW5sU9DfIp4ObAY1sMrau/hoprjqZ5ZPao4KNW64bdl9NtvjlbY8SCP4mrH2v
         mWCgbc2rzIklbQRyWUVatD4pzmYgEVWtG/FNKXJPKrpBnEnDRrDM6uaK2ZlTWHg0Ox
         DB4da7WDcMN0zhJb/irpuhntT9AQ4tr/T5lapBwebc4sH4phB8JFFUnVpckKo5CgYd
         mrebNE1I30BjYvC7k39HP87+nOKDFnaLMdvpjCk2qDdJRdDj74t30zQ7+Cub6aQvHw
         K17A2zZV5bhZC5RJ4C/2moQo5BrKs4YIgSeBrYEkJhxRkTq/ppk/vaT+tnJerZU15+
         tHbxSW+62H+eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4190E270DB;
        Wed, 26 Oct 2022 17:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix bpftool synctypes checking
 failure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166680421579.6635.1102994754514154034.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Oct 2022 17:10:15 +0000
References: <20221026163014.470732-1-yhs@fb.com>
In-Reply-To: <20221026163014.470732-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 26 Oct 2022 09:30:14 -0700 you wrote:
> kernel-patches/bpf failed with error:
>   Running bpftool checks...
>   Comparing /data/users/ast/net-next/tools/include/uapi/linux/bpf.h (bpf_map_type) and
>             /data/users/ast/net-next/tools/bpf/bpftool/map.c (do_help() TYPE):
>             {'cgroup_storage_deprecated', 'cgroup_storage'}
>   Comparing /data/users/ast/net-next/tools/include/uapi/linux/bpf.h (bpf_map_type) and
>             /data/users/ast/net-next/tools/bpf/bpftool/Documentation/bpftool-map.rst (TYPE):
>             {'cgroup_storage_deprecated', 'cgroup_storage'}
> The selftests/bpf/test_bpftool_synctypes.py runs checking in the above.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix bpftool synctypes checking failure
    https://git.kernel.org/bpf/bpf-next/c/d96d4276eaeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


