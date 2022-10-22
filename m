Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE760839B
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 04:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJVCaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 22:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJVCa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 22:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDD8DB774
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 19:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8620861FC4
        for <bpf@vger.kernel.org>; Sat, 22 Oct 2022 02:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7648C4347C;
        Sat, 22 Oct 2022 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666405819;
        bh=38gKEpS1yDfcefF7yFZoWEv4hqBkT6HqI8uTJFeeMOo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pBQR1zw7VNmQqbDMT0BJR6nhWJigvLV5zhUygUZsHWyRDo5FymZ9RwcibQRWrcp3a
         irEW2v8npYyyc9gF8/+ddGld6Yniem1sidI3aglnnT08D1UI2fj7HwCjXVgwt+xD7D
         hpzpv/j7NltPdfQjjDTRwKqEO1FjnK2AXHRamkCBuRISaDROudko2ZxGYaX2126du/
         2XkIAu4fS1/Pe4DKgVnAXBbfXEbaQr52FPiMOfBfTp30mZ+bFfCNcfrV2stK2+XV/+
         tMFttoLSuSWZSzzTGsbrAVKCsTAKd4pXBoA8rzoAXNTTgavWgZxbwvk/+H3dfapdpw
         0RSjbbicYgtNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4078E270E2;
        Sat, 22 Oct 2022 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 1/4] bpf: Allow ringbuf memory to be used as map
 key
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166640581979.9082.14191234166274787215.git-patchwork-notify@kernel.org>
Date:   Sat, 22 Oct 2022 02:30:19 +0000
References: <20221020160721.4030492-1-davemarchevsky@fb.com>
In-Reply-To: <20221020160721.4030492-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com, memxor@gmail.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 20 Oct 2022 09:07:18 -0700 you wrote:
> This patch adds support for the following pattern:
> 
>   struct some_data *data = bpf_ringbuf_reserve(&ringbuf, sizeof(struct some_data, 0));
>   if (!data)
>     return;
>   bpf_map_lookup_elem(&another_map, &data->some_field);
>   bpf_ringbuf_submit(data);
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/4] bpf: Allow ringbuf memory to be used as map key
    https://git.kernel.org/bpf/bpf-next/c/9ef40974a82a
  - [v5,bpf-next,2/4] bpf: Consider all mem_types compatible for map_{key,value} args
    https://git.kernel.org/bpf/bpf-next/c/d1673304097c
  - [v5,bpf-next,3/4] selftests/bpf: Add test verifying bpf_ringbuf_reserve retval use in map ops
    https://git.kernel.org/bpf/bpf-next/c/51ee71d38d8c
  - [v5,bpf-next,4/4] selftests/bpf: Add write to hashmap to array_map iter test
    https://git.kernel.org/bpf/bpf-next/c/8f4bc15b9ad7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


