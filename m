Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF765E58DF
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 04:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiIVCua (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 22:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiIVCuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 22:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37734AB415
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 19:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93CE463323
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 02:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E42A3C433C1;
        Thu, 22 Sep 2022 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663815016;
        bh=zpvwOEvQLS027NP3axFeABAFkn0/2DGEbDP67pUJHeY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SnQN4XfRLiVczmG8j+6y38dYjyiosCI8tP9RrvFkq80GZ9U3QecxLHQbxwGW6G7WV
         v8pggP4CNsjpi9FQ0QEkscXl9LZjUB1Mo4n20gPP0iI3UswN7x8aAVrywFQC2EzFNH
         ZX0KRh6CllautPuMZI5TmXOIUX6SM+tj1lhnXDqgW/yonr24h3zqGUGWTxbqXKykNE
         Os+1blL6fHp39Cb+oRs2yhk2MCFlbGbd1h3taUlZtbEi7Qjub/msl5MT1WCQoIHv/0
         WWFpCuruDrGqMsAQH979CXYhFyll2vWvrCYYVhMtNxftOgohlcsnTfq3bwb8TSjmb6
         5T7TB2ILsPcWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC1A7E4D03D;
        Thu, 22 Sep 2022 02:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] veristat: CSV output, comparison mode,
 filtering
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166381501575.9036.15674223102031993052.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 02:50:15 +0000
References: <20220921164254.3630690-1-andrii@kernel.org>
In-Reply-To: <20220921164254.3630690-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

On Wed, 21 Sep 2022 09:42:50 -0700 you wrote:
> Add three more critical features to veristat tool, which make it sufficient
> for a practical work on BPF verifier:
> 
>   - CSV output, which allows easier programmatic post-processing of stats;
> 
>   - building upon CSV output, veristat now supports comparison mode, in which
>     two previously captured CSV outputs from veristat are compared with each
>     other in a convenient form;
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] selftests/bpf: fix double bpf_object__close() in veristate
    https://git.kernel.org/bpf/bpf-next/c/f338ac910567
  - [v2,bpf-next,2/4] selftests/bpf: add CSV output mode for veristat
    https://git.kernel.org/bpf/bpf-next/c/e5eb08d8fe46
  - [v2,bpf-next,3/4] selftests/bpf: add comparison mode to veristat
    https://git.kernel.org/bpf/bpf-next/c/394169b079b5
  - [v2,bpf-next,4/4] selftests/bpf: add ability to filter programs in veristat
    https://git.kernel.org/bpf/bpf-next/c/bde4a96cdcad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


