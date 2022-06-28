Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B936755EF36
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiF1UX2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 16:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiF1UWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 16:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2ED22BDB
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 13:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D60D6616F8
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 20:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36890C341CA;
        Tue, 28 Jun 2022 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656447621;
        bh=14FQ+/UjFhzAO8lyoSEwG6BTyVUp5jXMViEtpCbAJMk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VhGMQrH2l+PjElpufafdYhY0Aj6bN3r9TVw6wlNUdXTTak+5yaf36VIFWB1VXpWvM
         exVSRCi7rCisfeNp0seNjiMxp9O4rpv4WnK8qBC+NNfGINEa32v+v1dU/nny8dfgHm
         U06H8d5GWPqmUmLtdcGcxNLOykrePJLLq1IAlt7yV4wcMmSsFNPk7b88o7ldI9GGJl
         MYFrM64+XcR0/kiPgVzZx/TR6uKzDjM3wwjm8S3MnPh/qGrAwbGgKMhQGZpf9f+MmD
         D3/sLQUsrM0EAG+2ztIDeKqUKUuE083eSg7mBcrAxXmKyu4objzkghCawUPsptFdKP
         zoeGo2rkp77ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17322E49BBC;
        Tue, 28 Jun 2022 20:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 00/15] libbpf: remove deprecated APIs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165644762109.4858.7045845443300753368.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Jun 2022 20:20:21 +0000
References: <20220627211527.2245459-1-andrii@kernel.org>
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 27 Jun 2022 14:15:12 -0700 you wrote:
> This patch set removes all the deprecated APIs in preparation for 1.0 release.
> It also makes libbpf_set_strict_mode() a no-op (but keeps it to let per-1.0
> applications buildable and dynamically linkable against libbpf 1.0 if they
> were already libbpf-1.0 ready) and starts enforcing all the
> behaviors that were previously opt-in through libbpf_set_strict_mode().
> 
> xsk.{c,h} parts that are now properly provided by libxdp ([0]) are still used
> by xdpxceiver.c in selftest/bpf, so I've moved xsk.{c,h} with barely any
> changes to under selftests/bpf.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,01/15] libbpf: move xsk.{c,h} into selftests/bpf
    https://git.kernel.org/bpf/bpf-next/c/f36600634282
  - [v2,bpf-next,02/15] libbpf: remove deprecated low-level APIs
    https://git.kernel.org/bpf/bpf-next/c/765a34130ea5
  - [v2,bpf-next,03/15] libbpf: remove deprecated XDP APIs
    https://git.kernel.org/bpf/bpf-next/c/53e6af3a761c
  - [v2,bpf-next,04/15] libbpf: remove deprecated probing APIs
    https://git.kernel.org/bpf/bpf-next/c/d320fad217b7
  - [v2,bpf-next,05/15] libbpf: remove deprecated BTF APIs
    https://git.kernel.org/bpf/bpf-next/c/aaf6886d9b53
  - [v2,bpf-next,06/15] libbpf: clean up perfbuf APIs
    https://git.kernel.org/bpf/bpf-next/c/22dd7a58b2e9
  - [v2,bpf-next,07/15] libbpf: remove prog_info_linear APIs
    https://git.kernel.org/bpf/bpf-next/c/9a590538ba4f
  - [v2,bpf-next,08/15] libbpf: remove most other deprecated high-level APIs
    https://git.kernel.org/bpf/bpf-next/c/146bf811f5ac
  - [v2,bpf-next,09/15] libbpf: remove multi-instance and custom private data APIs
    https://git.kernel.org/bpf/bpf-next/c/b4bda502dfa2
  - [v2,bpf-next,10/15] libbpf: cleanup LIBBPF_DEPRECATED_SINCE supporting macros for v0.x
    https://git.kernel.org/bpf/bpf-next/c/a11113a2dcbe
  - [v2,bpf-next,11/15] libbpf: remove internal multi-instance prog support
    https://git.kernel.org/bpf/bpf-next/c/cf90a20db878
  - [v2,bpf-next,12/15] libbpf: clean up SEC() handling
    https://git.kernel.org/bpf/bpf-next/c/450b167fb9be
  - [v2,bpf-next,13/15] selftests/bpf: remove last tests with legacy BPF map definitions
    https://git.kernel.org/bpf/bpf-next/c/31e42721976b
  - [v2,bpf-next,14/15] libbpf: enforce strict libbpf 1.0 behaviors
    https://git.kernel.org/bpf/bpf-next/c/bd054102a8c7
  - [v2,bpf-next,15/15] libbpf: fix up few libbpf.map problems
    https://git.kernel.org/bpf/bpf-next/c/ab9a5a05dc48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


