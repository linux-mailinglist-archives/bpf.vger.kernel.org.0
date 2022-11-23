Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB1636C7A
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiKWVkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiKWVkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80709737C;
        Wed, 23 Nov 2022 13:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8B161F36;
        Wed, 23 Nov 2022 21:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 912A5C433C1;
        Wed, 23 Nov 2022 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669239616;
        bh=IzWZCp88QHPXTFVoDqVqm+H47Sk2uhhaUXS72fR33pY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MYT2QuQCAkpnrtdo7RBiA8uNElcU+qsJHn1SbrKsIxDh5zSyQr5i4LsIB7bem8f8+
         xxZbpRH0w1PRzkoZrrK0hdoIYALZJYLkORyGDuUHoXiri2uKgMvhvjo6LaJXM1hlAE
         SdDAMGOK9OsVX0xoCvIMk4WohV3rJhqvpYxG4nq5iS3uPDB79r8rYcTE8w4YHGeXq9
         HxIP0LIj9hh3KcJbrIrQe/+RCvabMGrcN9pKqHCca92pvY27hYE+PvlWfIwMYAs/Iy
         8j5BvFnOExAgZG1myvEshvbvRybfYT/4DLIv9krWVCg8HLh681sL1kY4w7joPjqKcF
         764W4BvJF7+Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78F27E21EFD;
        Wed, 23 Nov 2022 21:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] docs: fix sphinx warnings for cpu+dev maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166923961649.12268.10118409428649323814.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Nov 2022 21:40:16 +0000
References: <20221123092321.88558-1-mtahhan@redhat.com>
In-Reply-To: <20221123092321.88558-1-mtahhan@redhat.com>
To:     Maryam Tahhan <mtahhan@redhat.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, akiyks@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 23 Nov 2022 09:23:19 +0000 you wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Sphinx version >=3.1 warns about duplicate function declarations in the
> CPUMAP and DEVMAP documentation. This is because the function name is the
> same for Kernel and User space BPF progs but the parameters and return types
> they take is what differs. This patch moves from using the ``c:function::``
> directive to using the ``code-block:: c`` directive. The patches also fix
> the indentation for the text associated with the "new" code block delcarations.
> The missing support of c:namespace-push:: and c:namespace-pop:: directives by
> helper scripts for kernel documentation prevents using the ``c:function::``
> directive with proper namespacing.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] docs: fix sphinx warnings for cpumap
    https://git.kernel.org/bpf/bpf-next/c/3685b0dc0d02
  - [bpf-next,v3,2/2] docs: fix sphinx warnings for devmap
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


