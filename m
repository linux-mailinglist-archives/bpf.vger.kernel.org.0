Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993394B269D
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 14:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiBKNAg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 08:00:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiBKNAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 08:00:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BD3F05
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 05:00:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E084661E3D
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 404ADC340F0;
        Fri, 11 Feb 2022 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644584434;
        bh=eCJZszj5g1ohKaYCAu7VNjIHBMNPF8zX5uhhguRxhWw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VJU4a4QwMXPf349BiEpEpfrVWwP371rcaavimgCIkFMJeORPe3w6bqHRguQuykddv
         Zvv8AxDKIqh1xC/6qvakbZJQ1sa1kVzekBpWRGMPsv7gxsbcsiYGZK+XVanFb5v4hs
         kJVa6vFokfDnxxv0iSeX0olE8tPuRXMMZ6FzadxezPAwvF+YYK1GjxZFHq7Sh0bkNv
         yQro+gX9yKPUG3gAeStbR9weZn1xZhIDrOUm6zco4PAnYfTK5EG3s3/EsOAXzmqrS0
         ebaCEnzQaWSWh9vgYhxpF/G9/8sDxF8s47fXOs90t+CBO12LcXAXSj09jrIJe0glJQ
         1OhUwPsm853jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E80DE6BBCA;
        Fri, 11 Feb 2022 13:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164458443411.16961.10103501274518019457.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Feb 2022 13:00:34 +0000
References: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
In-Reply-To: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
To:     Felix Maurer <fmaurer@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  9 Feb 2022 16:55:26 +0100 you wrote:
> If bpf_msg_push_data is called with len 0 (as it happens during
> selftests/bpf/test_sockmap), we do not need to do anything and can
> return early.
> 
> Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
> error: we later called get_order(copy + len); if len was 0, copy + len
> was also often 0 and get_order returned some undefined value (at the
> moment 52). alloc_pages caught that and failed, but then
> bpf_msg_push_data returned ENOMEM. This was wrong because we are most
> probably not out of memory and actually do not need any additional
> memory.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Do not try bpf_msg_push_data with len 0
    https://git.kernel.org/bpf/bpf/c/4a11678f6838

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


