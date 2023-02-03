Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D3688E9F
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 05:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBCEkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 23:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBCEkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 23:40:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2C44F34E
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 20:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B9461CFD
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 04:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37666C4339B;
        Fri,  3 Feb 2023 04:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675399217;
        bh=buiwku+NfOKRWeYeLW+4fckzuTI+1uqUh8eOPzHXJ/I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vKBpTWlwK3vo8EbSXOF34id846ZCged6CYfnmHG8bbH5ZRMg6XqnmmfcAeZAcweto
         uBf9psG/22NP6jMT+mlUkZ5WflK49bCT+WpKOvVOatJrzNwf7KOS8pA3ki9glACee2
         D+dbiRYpHVnOnfYIIYCkuCeIFIMmI9q8DDjCUZbfU6QYwmGk+SX2vk0NkZhk8nOlpG
         K/bGqu5LP5f+uuUVRkro+FC//DOmf/dXyTcSYRf8g6xoA3TvzxLEtDevU/lmRO4av0
         nuDetVkORJRcU958yZVzE7QWwwv3dnWnrcxBXoSVI3qZXLdtpi44/u+yzfZ6FcBzRN
         gEhF13iCbl6/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C670E270C4;
        Fri,  3 Feb 2023 04:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Drop always true do_idr_lock parameter to
 bpf_map_free_id
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167539921711.12589.8835634003496821011.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Feb 2023 04:40:17 +0000
References: <20230202141921.4424-1-tklauser@distanz.ch>
In-Reply-To: <20230202141921.4424-1-tklauser@distanz.ch>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Feb 2023 15:19:21 +0100 you wrote:
> The do_idr_lock parameter to bpf_map_free_id was introduced by commit
> bd5f5f4ecb78 ("bpf: Add BPF_MAP_GET_FD_BY_ID"). However, all callers set
> do_idr_lock = true since commit 1e0bd5a091e5 ("bpf: Switch bpf_map ref
> counter to atomic64_t so bpf_map_inc() never fails").
> 
> While at it also inline __bpf_map_put into its only caller bpf_map_put
> now that do_idr_lock can be dropped from its signature.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Drop always true do_idr_lock parameter to bpf_map_free_id
    https://git.kernel.org/bpf/bpf-next/c/158e5e9eeaa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


