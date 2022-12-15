Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517A64E398
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 23:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLOWAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 17:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLOWAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 17:00:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D71264A1
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 14:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ABB61CE1D6A
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB0F9C43392;
        Thu, 15 Dec 2022 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671141616;
        bh=OfViFV48s/7SxftP4ljSVmO3pZ62sFpcf9G60Z+ivaY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nXJiRglymW2DOgmjCBs2+w+FyA3Zv+W7pshVa7WjE/OOvcwtBpOe6HYtvp1zzYNXm
         17iYe21ZQoBBnBPLzIE9KZLrcezvWTk92DndbpbPGpj6N/VJJ3GkxqIkMA3ngy/l2t
         6iEvu7DGiuVpigCUW+pHOH83JcvIY+6UI4Erl0zYw0HDqrAfLUDSV+v4pUn5Jo5c7H
         SRyLMXc2jG63gWURrVkhljybtoR/wzKVS/+QmJexJxnJUeltbRcfm6MLYvInA2t998
         rIyauH7defC/xiGdADl5Yd0zm9EJn2zUJAz/pmqLyP6x/HpQ2iSBwIUu3sZuvJJQmE
         5JiLEhiy5CI6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BACA4E50D70;
        Thu, 15 Dec 2022 22:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix btf_dump's packed struct determination
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167114161676.4629.6783238136964607202.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Dec 2022 22:00:16 +0000
References: <20221215183605.4149488-1-andrii@kernel.org>
In-Reply-To: <20221215183605.4149488-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, eddyz87@gmail.com
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

On Thu, 15 Dec 2022 10:36:05 -0800 you wrote:
> Fix bug in btf_dump's logic of determining if a given struct type is
> packed or not. The notion of "natural alignment" is not needed and is
> even harmful in this case, so drop it altogether. The biggest difference
> in btf_is_struct_packed() compared to its original implementation is
> that we don't really use btf__align_of() to determine overall alignment
> of a struct type (because it could be 1 for both packed and non-packed
> struct, depending on specifci field definitions), and just use field's
> actual alignment to calculate whether any field is requiring packing or
> struct's size overall necessitates packing.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix btf_dump's packed struct determination
    https://git.kernel.org/bpf/bpf-next/c/4fb877aaa179

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


