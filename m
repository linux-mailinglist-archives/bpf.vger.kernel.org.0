Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47906C5F7E
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 07:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCWGKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 02:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjCWGKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 02:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F772A6D7
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 23:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54F1D62433
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 06:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A17CCC4339B;
        Thu, 23 Mar 2023 06:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679551820;
        bh=k4WEIEJQmu3tCyuGZPRa/F7kSMNA34OY3N4FX2yko5c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iTM05iItWcZ2a8xRGa7weqx/mJ/zP7IFZt59BIy7ZbPcoy3oEDu58ekqdIX9ViM4r
         pp7Bj5hLjBvFN2bNNcwf4iz/3LH6iMFO+Da8AvZDZ1MumF4vpZFGRRQGmczrarSFpy
         C+DKYnfQsj80lystxHJIIWAUc/Rt8Czm2D0FpkbGAsr49m4sZPKpIK4FcIrrd4JsZy
         +OHrMpVrRmEXAnYSDdEW3pzcLUPWXo0MQwOH8cJInbzV8ooKDbDvPCf39T7hfrEPRO
         IQZcnr2wIqTdYRKC/7nheGZG7a1p/AVAT9FADlGJhlqMndt4ifooH2ml+xI5ouPW3F
         PDit57hKM5ixg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B66DE61B86;
        Thu, 23 Mar 2023 06:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v12 0/8] Transit between BPF TCP congestion controls.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167955182049.23814.16375855529117553677.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Mar 2023 06:10:20 +0000
References: <20230323032405.3735486-1-kuifeng@meta.com>
In-Reply-To: <20230323032405.3735486-1-kuifeng@meta.com>
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 22 Mar 2023 20:23:57 -0700 you wrote:
> Major changes:
> 
>  - Create bpf_links in the kernel for BPF struct_ops to register and
>    unregister it.
> 
>  - Enables switching between implementations of bpf-tcp-cc under a
>    name instantly by replacing the backing struct_ops map of a
>    bpf_link.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v12,1/8] bpf: Retire the struct_ops map kvalue->refcnt.
    https://git.kernel.org/bpf/bpf-next/c/b671c2067a04
  - [bpf-next,v12,2/8] net: Update an existing TCP congestion control algorithm.
    https://git.kernel.org/bpf/bpf-next/c/8fb1a76a0f35
  - [bpf-next,v12,3/8] bpf: Create links for BPF struct_ops maps.
    https://git.kernel.org/bpf/bpf-next/c/68b04864ca42
  - [bpf-next,v12,4/8] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
    https://git.kernel.org/bpf/bpf-next/c/8d1608d70927
  - [bpf-next,v12,5/8] bpf: Update the struct_ops of a bpf_link.
    https://git.kernel.org/bpf/bpf-next/c/aef56f2e918b
  - [bpf-next,v12,6/8] libbpf: Update a bpf_link with another struct_ops.
    https://git.kernel.org/bpf/bpf-next/c/912dd4b0c2a5
  - [bpf-next,v12,7/8] libbpf: Use .struct_ops.link section to indicate a struct_ops with a link.
    https://git.kernel.org/bpf/bpf-next/c/809a69d61899
  - [bpf-next,v12,8/8] selftests/bpf: Test switching TCP Congestion Control algorithms.
    https://git.kernel.org/bpf/bpf-next/c/06da9f3bd641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


