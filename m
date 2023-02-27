Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331106A4ADD
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjB0TaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjB0TaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F8E234FA;
        Mon, 27 Feb 2023 11:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4612E60F1A;
        Mon, 27 Feb 2023 19:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B5D3C433EF;
        Mon, 27 Feb 2023 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677526217;
        bh=ipfO5vHE18p62waIl1A3u+cDdbTiiBXAcT53zd5+9O8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lDHBnnu5rpEp5LUmXzlWjvZUQ4e+BJceass8iwpPZxvkHqWa0DxJYWOBO3xe0dQ6Y
         nqZl9YP8KdzCwIBz1EEoIFlXJrnL1OBcqeXAck6V9FsUBji51fDUvHbo24BCuvOkWy
         N6Q99U71cK0AiipHMLBelokEQZHKSOByD5uYuAQPHbwjMLdNCzRuBnSYtsqs2pGQbD
         vR1x8xG8BQpwS7a4uvdmv1hVB1/B+/4/uJNgH7JuWX6eB7OLsPlKKftqV1upQvr8eP
         WG7Q3H81KhT9Ct2MSeCy79lzhujeeVRVc/kovez4rgUM+TxuLI2X+jvlEbzxuBL9Ct
         Gaj5eIEnsanHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8275FE4D00F;
        Mon, 27 Feb 2023 19:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools: bpftool: remove invalid \' json escape
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167752621753.5062.4191667021667722418.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 19:30:17 +0000
References: <20230227150853.16863-1-gerhorst@cs.fau.de>
In-Reply-To: <20230227150853.16863-1-gerhorst@cs.fau.de>
To:     Luis Gerhorst <gerhorst@cs.fau.de>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 27 Feb 2023 16:08:54 +0100 you wrote:
> RFC8259 ("The JavaScript Object Notation (JSON) Data Interchange
> Format") only specifies \", \\, \/, \b, \f, \n, \r, and \r as valid
> two-character escape sequences. This does not include \', which is not
> required in JSON because it exclusively uses double quotes as string
> separators.
> 
> Solidus (/) may be escaped, but does not have to. Only reverse
> solidus (\), double quotes ("), and the control characters have to be
> escaped. Therefore, with this fix, bpftool correctly supports all valid
> two-character escape sequences (but still does not support characters
> that require multi-character escape sequences).
> 
> [...]

Here is the summary with links:
  - tools: bpftool: remove invalid \' json escape
    https://git.kernel.org/bpf/bpf-next/c/c679bbd611c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


