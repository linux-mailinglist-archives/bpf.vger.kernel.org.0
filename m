Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5204B692D7A
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBKDAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 22:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBKDAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 22:00:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8D84BAA
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 19:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2BF361E2D
        for <bpf@vger.kernel.org>; Sat, 11 Feb 2023 03:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FB8FC4339C;
        Sat, 11 Feb 2023 03:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676084418;
        bh=5JaLxPK1Y8tKsoPhH0E+f7Pq4hdp0bodKlPj62FvSw8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Mhsikx7KOD4YCbpHJRwJY0EUMXwj8/WQovupRaxrpVf9mKSdJ+q225LyGhdWu42sR
         l+JO82SsixINOldMCHwb1JHVH/a2fepcbQ8UX61hEHrpUgRGzZxbEhp7AZOqQmjnjT
         aEN+2W5SpI1AWQ9jGbeozJpyoNSm0WXob3333HLOAG3GJr1Z4R7xUbc0xuSjxuF2mz
         o5iBthcokkKRcI9FxrUgCBs3NoRhT2Eix+Y9GWjm0lKKYak4HHV+oJO1SQtpdtMQjp
         PV4FAUSduc7JVQsajJjbLYbo+HRqK0AeEXPa3Lspo5aAMPZlWr2YliPvJgpJdHTt7O
         w34qBHc6RtNwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1202AE21EC7;
        Sat, 11 Feb 2023 03:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] docs,
 bpf: Ensure IETF's BPF mailing list gets copied for ISA doc changes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167608441806.4712.2611227890252688693.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Feb 2023 03:00:18 +0000
References: <57619c0dd8e354d82bf38745f99405e3babdc970.1676068387.git.daniel@iogearbox.net>
In-Reply-To: <57619c0dd8e354d82bf38745f99405e3babdc970.1676068387.git.daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     alexei.starovoitov@gmail.com, bpf@ietf.org, bpf@vger.kernel.org,
        dthaler@microsoft.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Feb 2023 23:40:31 +0100 you wrote:
> Given BPF is increasingly being used beyond just the Linux kernel, with
> implementations in NICs and other hardware, Windows, etc, there is an
> ongoing effort to document and standardize parts of the existing BPF
> infrastructure such as its ISA. As "source of truth" we decided some
> time ago to rely on the in-tree documentation, in particular, starting
> out with the Documentation/bpf/instruction-set.rst as a base for later
> RFC drafts on the ISA. Therefore, we want to ensure that changes to that
> document have bpf@ietf.org in Cc, so add a MAINTAINERS file entry with
> a section on documents related to standardization efforts. For now, this
> only relates to instruction-set.rst, and later additional files will be
> added.
> 
> [...]

Here is the summary with links:
  - [bpf-next] docs, bpf: Ensure IETF's BPF mailing list gets copied for ISA doc changes
    https://git.kernel.org/bpf/bpf-next/c/7e2a9ebe8126

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


