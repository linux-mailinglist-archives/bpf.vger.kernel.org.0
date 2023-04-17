Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422F6E51E2
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDQUa0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 16:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDQUaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 16:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2091FD4;
        Mon, 17 Apr 2023 13:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A998629B6;
        Mon, 17 Apr 2023 20:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD7D1C433A0;
        Mon, 17 Apr 2023 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681763420;
        bh=kiEIljlt09XsCaA9Y2GUxOe42naE7VPA9YmITyBKdv8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TqN2SBk9OUacIibhSHw60mtLfs+SeQrsWlbyRGt0YB4um8+mQ7bGai+2qusVfkJx5
         Hf0mp6RMN5ebGRY33yAP/3kJNpOu/6wh19px84grLMktgqcfALieuEtjX5P71aqjkY
         VhW3/7b5BirpuODAw3uj2Lyvyp9qsll9o1tS//cy4jutzQBsaeg36ZeTzV9Gndim8i
         CgVLI/r+IpUaWCnUa61k+4wgcGk8CCtWQ0PAZHFpUGkiHl/Ry5LG4BvzZQjRFoIYvd
         aRr0PW+8XApo6nuP7Kg344CSNMggJxH+xUIt6qLNVpfqeNPpqoPv5nqmEroOS6zJly
         dKlP1Y/g/cK9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 955E3C40C5E;
        Mon, 17 Apr 2023 20:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: lirc program type should not require SYS_CAP_ADMIN
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168176342060.32012.3458485345693041514.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Apr 2023 20:30:20 +0000
References: <ZD0ArKpwnDBJZsrE@gofer.mess.org>
In-Reply-To: <ZD0ArKpwnDBJZsrE@gofer.mess.org>
To:     Sean Young <sean@mess.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Apr 2023 09:17:48 +0100 you wrote:
> Make it possible to load lirc program type with just CAP_BPF. There is
> nothing exceptional about lirc programs that means they require
> SYS_CAP_ADMIN.
> 
> In order to attach or detach a lirc program type you need permission to
> open /dev/lirc0; if you have permission to do that, you can alter all
> sorts of lirc receiving options. Changing the IR protocol decoder is no
> different.
> 
> [...]

Here is the summary with links:
  - [v2] bpf: lirc program type should not require SYS_CAP_ADMIN
    https://git.kernel.org/bpf/bpf-next/c/69a8c792cd95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


