Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E195BF246
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 02:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIUAkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 20:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIUAkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 20:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEB1A061;
        Tue, 20 Sep 2022 17:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30BA9B82DC4;
        Wed, 21 Sep 2022 00:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D274DC433C1;
        Wed, 21 Sep 2022 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663720814;
        bh=QuGlF4oR80+iV2zM2o3vgC0PY/352i8eVnDT5Cp2rfo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a/HvLO/znD9YbyO11olBSY/R3aXRi3dfqa9Cd2YSebXwkfWIDktMOcBa68EIOAjlf
         jHah1wXyvPDa8GznNI8zMNUfDhyEiDZD7UrABkYffufwr5XbDrM+YTQLVDsWQvYZW7
         l3CgtlhjcUg+vkscUHQi9m32VnPTXkN+sh08upqNiMfiZmtCOmXK94JTgsYCBZSuIJ
         7Ko+ZIhPboLV698c5x/T4O0UQ4JM/GlsylE798IllW8biDgfAiySPjFZPSjLiVK8o1
         QipR8FomO4QhoCggkWpoFpL1MPE2JBCEttPfGCFPJAocjrn09olEDLw4G63KAIZc0/
         eQZc9+x1GV+2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B40B0E21EE0;
        Wed, 21 Sep 2022 00:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: Fix NULL pointer exception in API
 btf_dump__dump_type_data
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166372081471.5331.6260558640505751145.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Sep 2022 00:40:14 +0000
References: <20220917084809.30770-1-liuxin350@huawei.com>
In-Reply-To: <20220917084809.30770-1-liuxin350@huawei.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, zhudi2@huawei.com,
        kongweibin2@huawei.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 17 Sep 2022 16:48:09 +0800 you wrote:
> We found that function btf_dump__dump_type_data can be called by the
> user as an API, but in this function, the `opts` parameter may be used
> as a null pointer.This causes `opts->indent_str` to trigger a NULL
> pointer exception.
> 
> Fixes: 2ce8450ef5a3 ("libbpf: add bpf_object__open_{file, mem} w/ extensible opts")
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> Signed-off-by: Weibin Kong <kongweibin2@huawei.com>
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: Fix NULL pointer exception in API btf_dump__dump_type_data
    https://git.kernel.org/bpf/bpf-next/c/7620bffbf72c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


