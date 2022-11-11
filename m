Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A18626336
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiKKUuh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiKKUu2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:50:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA686D78;
        Fri, 11 Nov 2022 12:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D457EB827DA;
        Fri, 11 Nov 2022 20:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6614CC433D7;
        Fri, 11 Nov 2022 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668199815;
        bh=HljZBANcsjHDi7d7qwEHG9XNeUsGPycHmfVH50XxcnU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f+lxf31/jQcrHDiz5kL7NDeOuuRP89hSFW94Q/CBRbFAsof9AS8q+jxkjw0Y4HYzH
         P1X/KqSsy7IVdKp6VBxgXN04xHLHWZjHAlRKNawtzhFN3lGdUikOErk4npZibosQSQ
         1HPbly9iBOqadCJVOThboR6rffCUNOI2HYTMHa5PgfvRgsDmPZ/RlzD4huuFs2sLyj
         3aty5MUfAV9cdcIJprMEwaXiILVEh0CNI3CsslvnO0fKS6sAMXTZ5NJWuXoMhxzZsz
         Fk/2ACY8Gj0C1Yx2IN/zlGarIL1dWpNKOGYv4KoNqNK1VdM9m/U6Ugegsrbfub3yaW
         5eR9TNSgR2TOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DA18E270EF;
        Fri, 11 Nov 2022 20:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix offset calculation error in __copy_map_value and
 zero_map_value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166819981531.7597.5559620240082606702.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 20:50:15 +0000
References: <20221111125620.754855-1-xukuohai@huaweicloud.com>
In-Reply-To: <20221111125620.754855-1-xukuohai@huaweicloud.com>
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, memxor@gmail.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 11 Nov 2022 07:56:20 -0500 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Function __copy_map_value and zero_map_value miscalculated copy offset,
> resulting in possible copy of unwanted data to user or kernel.
> 
> Fix it.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix offset calculation error in __copy_map_value and zero_map_value
    https://git.kernel.org/bpf/bpf/c/1f6e04a1c7b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


