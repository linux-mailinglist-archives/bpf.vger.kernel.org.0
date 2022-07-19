Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA4057A5C2
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiGSRuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbiGSRuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BC7E001;
        Tue, 19 Jul 2022 10:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA3F2B81CB7;
        Tue, 19 Jul 2022 17:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DAF7C385A2;
        Tue, 19 Jul 2022 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658253015;
        bh=cFgZYt7UBZcUA5O2Qq1WrRkEliizedJkmjjm7OkwEmQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BisVN9fEFQ8wfrBXEtOHsxfgnYZ577C3YlGEoGGBNyEu9Xe6/Z1HtgQcnHfalBNvt
         I6rgn0iwsnPF5I6DplNGlFIc9WFqP9DDFV4JbpwybTOIudU6xdOtBRQ2bOiA/+gX2E
         DQ0GhRkHkjkmD9ibD8ebnw+4EartvgiaHcjiegjoUSq87WGN4VILYfEMZF348cesJD
         dtC5ys94xB/jEdaoucwOqCqCYt7sbRvx/uGO5Ng7aJ/5rFWfPe1jMOKWwFpZMNgNhI
         5DdB+BTW8w6b+i6HqvxP/MdAi5qItJ6Fj+/KEa6r0r+u5qtZiNUpNU4s1ozJ29GsnU
         Qh9oFbqiN0g0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26671E451B0;
        Tue, 19 Jul 2022 17:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpf, docs: document BPF_MAP_TYPE_HASH and variants
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165825301515.17492.10231267118523245732.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 17:50:15 +0000
References: <20220718125847.1390-1-donald.hunter@gmail.com>
In-Reply-To: <20220718125847.1390-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        sdf@google.com, yhs@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 18 Jul 2022 13:58:47 +0100 you wrote:
> Add documentation for BPF_MAP_TYPE_HASH including kernel version
> introduced, usage and examples. Document BPF_MAP_TYPE_PERCPU_HASH,
> BPF_MAP_TYPE_LRU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH variations.
> 
> Note that this file is included in the BPF documentation by the glob in
> Documentation/bpf/maps.rst
> 
> [...]

Here is the summary with links:
  - [v3] bpf, docs: document BPF_MAP_TYPE_HASH and variants
    https://git.kernel.org/bpf/bpf-next/c/979855d30264

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


