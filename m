Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A3567B958
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbjAYSaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjAYSaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:30:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C4B10423;
        Wed, 25 Jan 2023 10:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7AEA615B4;
        Wed, 25 Jan 2023 18:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B249C4339B;
        Wed, 25 Jan 2023 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674671418;
        bh=Ootqe48GLeaKP+EQ6FOt0Rpl1ixvDVXWWRwI+21XuAk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pbs6qwpraPaHgrEUNfy4I3sW7H0m9W10IQJkQwVt2Poa55z8/U99JwTeQHR0G1oU+
         BARcnTzdMFPfWN7zuEWM8AQdRNk8ttAerpofwVBtNGjh/l/pSKBh9g8H+oPvlbUO6H
         0O0DrvqQZeftH3X2DE10zVUjn4HGf61iSZ1GxDXqzbXiZYDcjxIOMJVn/URVsxZ5Lp
         MRD0SCQqWl3qa5TkeuwLBUgfroJKYmHJPwMaYI+iVyIxji26l3HK/+hhNnnHr8Mk+N
         ELcBwZOIXvrXiPhcUHbMhM9yM+qOj64nPwNe4An0Jg37XFeZEbma46n6bQvRXRqj55
         lJr3PPJq6p+tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DAEFF83ED0;
        Wed, 25 Jan 2023 18:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] Enable struct_ops programs to be sleepable
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167467141805.9880.9077905771766371858.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Jan 2023 18:30:18 +0000
References: <20230125164735.785732-1-void@manifault.com>
In-Reply-To: <20230125164735.785732-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
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

On Wed, 25 Jan 2023 10:47:31 -0600 you wrote:
> This is part 4 of https://lore.kernel.org/bpf/20230123232228.646563-1-void@manifault.com/
> 
> Part 3: https://lore.kernel.org/all/20230125050359.339273-1-void@manifault.com/
> Part 2: https://lore.kernel.org/all/20230124160802.1122124-1-void@manifault.com/
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable
    https://git.kernel.org/bpf/bpf-next/c/1e12d3ef47d2
  - [bpf-next,v4,2/4] libbpf: Support sleepable struct_ops.s section
    https://git.kernel.org/bpf/bpf-next/c/913b2255c3d8
  - [bpf-next,v4,3/4] bpf: Pass const struct bpf_prog * to .check_member
    https://git.kernel.org/bpf/bpf-next/c/51a52a29ebaa
  - [bpf-next,v4,4/4] bpf/selftests: Verify struct_ops prog sleepable behavior
    https://git.kernel.org/bpf/bpf-next/c/7dd880592a88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


