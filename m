Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B85B4B2B
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIKBUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIKBUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 21:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94403275E2;
        Sat, 10 Sep 2022 18:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D9AAB80AFB;
        Sun, 11 Sep 2022 01:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B313AC433D7;
        Sun, 11 Sep 2022 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662859214;
        bh=rWDmi4fW+8QiaUIaHPO9PJpi7XbAu+qWF7VNyCjQb1o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d/ca/W/qRzivihAnXQLNkLbaXbQat52l8m85Vq1/NeeJ6BMp7K4JZL3KVPCGB/vti
         iqsAXlZybZK9RiwEvZo9jLfNIF58/FSEWVl22VHbr61ZKk9VHG+c2aXgrxFhXimd3T
         LSqaf51Cmb+BbB3yqbQ2efRUjobTk5QzfoQwgSI4rvhirHkS2HQKNVXy2yvEmZgeXU
         r0dDQFIJft9QLKg+iM8SEt8S74I9iLEisS8pMHqDo/IA8OkyHjlKGT7CbiIS6fl8Uq
         yETrmviT2JV8xthTB20Lx1Y/U8aXEWpS6XEt3NGNg4g7c8dlpP+Na7m+UaCM1PE1Wa
         tOhDeRzMWvHdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 926D1C73FE7;
        Sun, 11 Sep 2022 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: btf: fix truncated last_member_type_id in
 btf_struct_resolve
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166285921459.4256.17072586904568979283.git-patchwork-notify@kernel.org>
Date:   Sun, 11 Sep 2022 01:20:14 +0000
References: <20220910110120.339242-1-oss@lmb.io>
In-Reply-To: <20220910110120.339242-1-oss@lmb.io>
To:     Lorenz Bauer <oss@lmb.io>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 10 Sep 2022 11:01:20 +0000 you wrote:
> When trying to finish resolving a struct member, btf_struct_resolve
> saves the member type id in a u16 temporary variable. This truncates
> the 32 bit type id value if it exceeds UINT16_MAX.
> 
> As a result, structs that have members with type ids > UINT16_MAX and
> which need resolution will fail with a message like this:
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: btf: fix truncated last_member_type_id in btf_struct_resolve
    https://git.kernel.org/bpf/bpf/c/a37a32583e28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


