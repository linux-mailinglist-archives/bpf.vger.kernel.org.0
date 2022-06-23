Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8C557102
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 04:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376797AbiFWCUQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 22:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiFWCUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 22:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D274B3DA6B
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E00A61D63
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 02:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9338C3411B;
        Thu, 23 Jun 2022 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655950813;
        bh=sD+ex+By0t7FTXWcixcL1JHk4XS7CDDCkQeTDCU9czE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dl1A4QCx9RduvIVUANSvSOgmAGi2B5+oUWUIUWCJ9Rl4fHjRxZ1L3Of0VqnadSaOR
         uTW2ZSCTr08KKFGuJ5tfKALG3J2R2iS6KqiEaMJL/phAT0qOIvFx0bJd+bo21ahcu+
         xKW1kdiKqcmK2kH8Q7EKBwrneZI/4Y6jC7qHomkQ0qFDbQm5MTo/Iye4keEKQOKU5O
         g28gioJZODZY4vq37OVAqpdFSWFZCcuLTxhYECsDR54smvBpD6CUKQjmUaBay+263v
         HSWF5aIyCle3wyl0nyY8SKKBi+KEkuiaN9Np2tBy65+daA9v8REYZa4u5gs58os00r
         6xILWZG5qu0vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CB83E574DA;
        Thu, 23 Jun 2022 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for local_storage
 get
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165595081363.12810.7536174863919321406.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Jun 2022 02:20:13 +0000
References: <20220620222554.270578-1-davemarchevsky@fb.com>
In-Reply-To: <20220620222554.270578-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 Jun 2022 15:25:54 -0700 you wrote:
> Add a benchmarks to demonstrate the performance cliff for local_storage
> get as the number of local_storage maps increases beyond current
> local_storage implementation's cache size.
> 
> "sequential get" and "interleaved get" benchmarks are added, both of
> which do many bpf_task_storage_get calls on sets of task local_storage
> maps of various counts, while considering a single specific map to be
> 'important' and counting task_storage_gets to the important map
> separately in addition to normal 'hits' count of all gets. Goal here is
> to mimic scenario where a particular program using one map - the
> important one - is running on a system where many other local_storage
> maps exist and are accessed often.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next] selftests/bpf: Add benchmark for local_storage get
    https://git.kernel.org/bpf/bpf-next/c/73087489250d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


