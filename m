Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4425E4B7706
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbiBORK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 12:10:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242259AbiBORK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 12:10:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009511ADFA
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 09:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB7C8614DF
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 17:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C445C340F2;
        Tue, 15 Feb 2022 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644945012;
        bh=8wLUP3tBUzbNHHDPXqBKEiqqbg7Ea/VquCadpAa8kcc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mCv0XA3LW1WKxcJJEOMEQgim8hqjlQcNQzU2/++VkqgRo31lVjGOWC+IvLfEio5Dq
         cEUocn0crsMyfdJQw5rjL6cTvCY5tUUekx7pP4m1CW5axQozeEULdxN3ReL4nWvRus
         xRGt6Ee069oTRA2cOWu9mv82eTah5Ody21M5wPe6vl4l/wIkuLH9QuQEgVrzT1N6jj
         PsMeMcc2nOmq5R2bfXIDlKBJjhyJguOvWeDKcRcr//223lB9odSlkDNZzSzA7wpSbs
         UniUWZZJdRhHqnwwkD2EsKZ2XTo7Av+4j284Oh7CJJyKNnCx19R/4Yj3cOgVzy9hS/
         Mq6D/ugoPUwGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03124E6D458;
        Tue, 15 Feb 2022 17:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpftool: fix the error when lookup in no-btf maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164494501200.23700.5378828821722678685.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Feb 2022 17:10:12 +0000
References: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
In-Reply-To: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
To:     Yinjun Zhang <yinjun.zhang@corigine.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        niklas.soderlund@corigine.com, simon.horman@corigine.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  8 Feb 2022 00:00:25 +0800 you wrote:
> When reworking btf__get_from_id() in commit a19f93cfafdf the error
> handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
> if bpf_btf_get_fd_by_id() failed the error would not be propagated to
> callers of btf__get_from_id(), after the rework it is. This lead to a
> change in behavior in print_key_value() that now prints an error when
> trying to lookup keys in maps with no btf available.
> 
> [...]

Here is the summary with links:
  - [bpf] bpftool: fix the error when lookup in no-btf maps
    https://git.kernel.org/bpf/bpf-next/c/edc21dc909c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


