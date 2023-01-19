Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB58672F3B
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjASCuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjASCuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC56843F
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA8BDB81FB9
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 02:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DC56C43392;
        Thu, 19 Jan 2023 02:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674096617;
        bh=dIfInEvsIcErG3Q5nii6nM1aW9WWVrK4CQ7O+fiv6vE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c4ZYdnCBZjRukBzRFViY0l0xgniNV5nX72gzKpHaDU/+IFAdpKQMff3ClIYzZdZJs
         VIHojP2CeFcBAR4jKeYqqY6MxYtRsDJt8n7tK7NgPnX+bfm9J3vJ1fauWg9kHBUabi
         UuYcF6jGTUs2od0Vgjqi7DJEaQP7zYDe6v5hTncCYCBQXjWt7/DwJ3GX2GncW0YAVs
         uGFeKIvbtFtWrkzy+xFywu/yEagHeRlZoUN6cpBCzMc4Z0yZDbTDbScaQvSRuqo+TP
         9lXSv4gyvIyZvuIbLv1C3iBTa71pc/FG3Nh0ucdZiJZWubWQuuRVHj+Af8TOJB2gSv
         190axuSa5cNMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E4C7E54D2B;
        Thu, 19 Jan 2023 02:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix off-by-one error in bpf_mem_cache_idx()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167409661738.25196.11510955578505781676.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Jan 2023 02:50:17 +0000
References: <20230118084630.3750680-1-houtao@huaweicloud.com>
In-Reply-To: <20230118084630.3750680-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
        song@kernel.org, haoluo@google.com, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, houtao1@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Jan 2023 16:46:30 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> According to the definition of sizes[NUM_CACHES], when the size passed
> to bpf_mem_cache_size() is 256, it should return 6 instead 7.
> 
> Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allocator.")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix off-by-one error in bpf_mem_cache_idx()
    https://git.kernel.org/bpf/bpf/c/36024d023d13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


