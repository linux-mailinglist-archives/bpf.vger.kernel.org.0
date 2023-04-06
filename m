Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAEF6D8E54
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 06:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjDFEaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 00:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDFEaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 00:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144D7AAC
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 21:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E243362D20
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 04:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BBBFC433D2;
        Thu,  6 Apr 2023 04:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680755420;
        bh=eLLUHA7t1T3pN97KkiiFAsWGVAs60VoW39xuFuh7eeQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W7lmKs9/LSg2DcLA6iJHsvSozPgoB+ZKNeMrl64phhIZYjwPz2hT6/TCzvapB8Qnc
         BJxaigJowkZO5OjSD5fJsJSBgwafx52vClqC7CSbEN5Rdif+DjVXuYQP3mdq0sk8tM
         KLqqyrYlZgOap4C+Q+/RInFAxNfuSrUFMf/rOQnoR0fnBwI3ImFhhEbb1MfJT9dpBw
         eMrQnJ03eHrUl/QFlcmdgDOHrQnURDugK5lTfgGQ6CoAJPBLPx0UOCGnXPEBwCTwQJ
         sRbwE73zicnpg9A4BcZfDqjOiUsr4YnU0ixATjAzaiSOdi9ybpn051tB0K4JFTmM76
         dhK/pw+n8SRxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16A36C41671;
        Thu,  6 Apr 2023 04:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] bpftool: Add inline annotations when dumping
 program CFGs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168075542008.12496.8604008028921480344.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 04:30:20 +0000
References: <20230405132120.59886-1-quentin@isovalent.com>
In-Reply-To: <20230405132120.59886-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        eddyz87@gmail.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Apr 2023 14:21:13 +0100 you wrote:
> This set contains some improvements for bpftool's "visual" program dump
> option, which produces the control flow graph in a DOT format. The main
> objective is to add support for inline annotations on such graphs, so that
> we can have the C source code for the program showing up alongside the
> instructions, when available. The last commits also make it possible to
> display the line numbers or the bare opcodes in the graph, as supported by
> regular program dumps.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] bpftool: Fix documentation about line info display for prog dumps
    https://git.kernel.org/bpf/bpf-next/c/e27f0f1620b6
  - [bpf-next,v3,2/7] bpftool: Fix bug for long instructions in program CFG dumps
    https://git.kernel.org/bpf/bpf-next/c/67cf52cdb6c8
  - [bpf-next,v3,3/7] bpftool: Support inline annotations when dumping the CFG of a program
    https://git.kernel.org/bpf/bpf-next/c/9fd496848b1c
  - [bpf-next,v3,4/7] bpftool: Return an error on prog dumps if both CFG and JSON are required
    https://git.kernel.org/bpf/bpf-next/c/05a06be72289
  - [bpf-next,v3,5/7] bpftool: Support "opcodes", "linum", "visual" simultaneously
    https://git.kernel.org/bpf/bpf-next/c/9b79f02722bb
  - [bpf-next,v3,6/7] bpftool: Support printing opcodes and source file references in CFG
    https://git.kernel.org/bpf/bpf-next/c/7483a7a70a12
  - [bpf-next,v3,7/7] bpftool: Clean up _bpftool_once_attr() calls in bash completion
    https://git.kernel.org/bpf/bpf-next/c/7319296855f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


