Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A3694D8B
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBMRAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 12:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBMRAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 12:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81C193E9
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 09:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF0BF611F6
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 17:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08FFBC4339B;
        Mon, 13 Feb 2023 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307617;
        bh=bWg/9vr8LORhjSIQyHS9BKq6yvERnPC3+1d4QHf0/0g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oy+BN2LwGpEkxcxBTvJ4vsCyQOWHzDKtwIY4zYAgqjknDVucQa282Cxut4QJ+y1Eb
         BcRUEG08YVTUgObc8kmya/mWtepCukuVYM3ui58WUDQBj1JCxe71E2gy9vMvC4y3SX
         Wc6WQnBtwj7o2kLyPxfIWTmNtasbfE+KeY5uvMAYgJ3lVXLtDQv8xuyxpfoLdE/1am
         hlOByqKa6d5Encd5WUpVKtEs+NbCVsPuYQBUTI0m/48WjmEuZN16SRBSufMmjOs/Cc
         +nu4WcKEp6JQtpRlHK8p2o4tMwg9+7UMXiOjb3aO/yOdIiSG1srfbh8Gh1bgVAskGo
         EKRkYx5Uc2qmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFC12E68D34;
        Mon, 13 Feb 2023 17:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167630761691.25127.4875659022895763877.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Feb 2023 17:00:16 +0000
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, acme@kernel.org,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  9 Feb 2023 13:28:51 +0000 you wrote:
> v1.25 of pahole supports filtering out functions with multiple
> inconsistent function prototypes or optimized-out parameters
> from the BTF representation.  These present problems because
> there is no additional info in BTF saying which inconsistent
> prototype matches which function instance to help guide
> attachment, and functions with optimized-out parameters can
> lead to incorrect assumptions about register contents.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
    https://git.kernel.org/bpf/bpf-next/c/0243d3dfe274

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


