Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458646F0647
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbjD0NAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243467AbjD0NAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 09:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6E114
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E5063D32
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1D29C4339B;
        Thu, 27 Apr 2023 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682600419;
        bh=lrs4uoe5EDJt0hRT+mk6+sXEj1qclIPRvZ7E/y5CFEY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W7PgWWeaOyZe8SMQViDQtPBC2OOwAjpMIoq0EvPT0nTYiU3YLudk43pxy9cC1NNPr
         GFaRgjRiTVt7TkYpqOfYZAJZ75sUimGpJIQXNByyPgX5WjcS8xASTi7SWmol+K/1T7
         6lxB7Pn8h1XDzw2fYIZUGJwnDwYvpSBrRnAg0N01DkiS28lueYHK58TMHzmHnzo4+h
         4sMxuh0bYeymC28Pu4qumSFkDsjuzqbe0kcjL5U9SJiYRfQ0hxCFFIIWCfafm481vj
         sPn2k/RV7nYm6LLeUkMJlMoz1qD29XzhxGS1Mk3dCcTqw+TohfRbrAEDkqpQsOEf0F
         HUHyYBXkzJ3AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7BA2E270D6;
        Thu, 27 Apr 2023 13:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpftool: Show map IDs along with struct_ops
 links.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168260041973.6278.15468448375833515409.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Apr 2023 13:00:19 +0000
References: <20230421214131.352662-1-kuifeng@meta.com>
In-Reply-To: <20230421214131.352662-1-kuifeng@meta.com>
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org, kuifeng@meta.com, quentin@isovalent.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 21 Apr 2023 14:41:31 -0700 you wrote:
> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
> struct_ops to links. (226bc6ae6405) It would be helpful for users to
> know which map is associated with the link.
> 
> The assumption was that every link is associated with a BPF program, but
> this does not hold true for struct_ops. It would be better to display
> map_id instead of prog_id for struct_ops links. However, some tools may
> rely on the old assumption and need a prog_id.  The discussion on the
> mailing list suggests that tools should parse JSON format. We will maintain
> the existing JSON format by adding a map_id without removing prog_id. As
> for plain text format, we will remove prog_id from the header line and add
> a map_id for struct_ops links.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpftool: Show map IDs along with struct_ops links.
    https://git.kernel.org/bpf/bpf-next/c/74fc8801edc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


