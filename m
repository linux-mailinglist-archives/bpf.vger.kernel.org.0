Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6583B679DF1
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 16:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjAXPuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 10:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjAXPuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 10:50:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352993644A
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4728B812A3
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 15:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89B74C433EF;
        Tue, 24 Jan 2023 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674575416;
        bh=LxanxgVPjsmMFVwZfLM97HQ7hl17SCVZO/E7FbFt3BA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fFlEesZJumu5nC0FN2B619i40/DCtKfNEOsXoQtB9bP76OafDT+t06TaqPtOnFM6N
         HwF52Upt5IvuNnBUtfDJwepC28TTJ8nl7Gndvtnc6sDXD71hv4Ysvk5lz7vjsj1jGs
         PiekOPexY7BFhA1NmoeD5qnr7mQb6zettokhoQZz0CETRpWmySviMmTnCaeD5Os/Rr
         pgUSyKwj/VFBBZWaih3F0znv6Z37W/GIbUpnv5nSKzPNN8dm/wYTFjDCk5JB2R5qE/
         soKERRe7UtRcQR4khmRr9IXh4SzWKw6W27RCuP0bMGp/+FEpfXKwgqDWd1JusQ2gld
         PliZP/J3VrANQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7719AE21EE1;
        Tue, 24 Jan 2023 15:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167457541648.32518.13253373517166801828.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Jan 2023 15:50:16 +0000
References: <20230124001218.827-1-dthaler1968@googlemail.com>
In-Reply-To: <20230124001218.827-1-dthaler1968@googlemail.com>
To:     None <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, dthaler@microsoft.com
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

On Tue, 24 Jan 2023 00:12:18 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Fix modulo zero, division by zero, overflow, and underflow.
> Also clarify how a negative immediate value is used in unsigned division
> 
> Changes from last submission: addressed comments from Daniel.
> 
> [...]

Here is the summary with links:
  - bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
    https://git.kernel.org/bpf/bpf-next/c/0eb9d19e2201

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


