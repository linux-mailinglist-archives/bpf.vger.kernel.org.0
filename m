Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA59954B43E
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiFNPKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiFNPKO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 11:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3FD2E68C
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 08:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E3D60DB9
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 15:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC6D6C3411E;
        Tue, 14 Jun 2022 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655219412;
        bh=ncjAqe8cc6cEvsS8WzOg2TnJ0KjuFG7RSy6CPBTqtkk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E/R66eeV7PcmCkaOt5pwV8h/i8wjnureIm/0PwFApKA4T+PGv0MwpWnNUttrtA1IJ
         R8aNPCQvQlQWNnhkUhkQ4lEePX+QIxk62wtxQba1DzA2T25f/ECNQEndpjbXunJRVH
         so96uHpSXaXch+3excrOZ45eVUu+D0HBo2/UkLUIchSXofvob7MmnpRgIm/yzhRL7N
         cuK5CEeWIiHO9YOLllp5EgHgbYR66YHJb2kDtzlL3X2GtTd/Kqb3goLX28v8snzOWD
         za3YvgBrQznAry1zz2DRd+VtzDLhzSPVZF0GmmOhcJXPy2dFeeEKIxLe7F7cGAxm2r
         5zpHx3nbn7EYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F4AEE73854;
        Tue, 14 Jun 2022 15:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix an unsigned < 0 bug
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165521941258.21816.9774675288125317014.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 15:10:12 +0000
References: <20220613054314.1251905-1-yhs@fb.com>
In-Reply-To: <20220613054314.1251905-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 12 Jun 2022 22:43:14 -0700 you wrote:
> Andrii reported a bug with the following information:
>   2859 	if (enum64_placeholder_id == 0) {
>   2860 		enum64_placeholder_id = btf__add_int(btf, "enum64_placeholder", 1, 0);
>   >>>     CID 394804:  Control flow issues  (NO_EFFECT)
>   >>>     This less-than-zero comparison of an unsigned value is never true. "enum64_placeholder_id < 0U".
>   2861 		if (enum64_placeholder_id < 0)
>   2862 			return enum64_placeholder_id;
>   2863    	...
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix an unsigned < 0 bug
    https://git.kernel.org/bpf/bpf-next/c/c49a44b39b31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


