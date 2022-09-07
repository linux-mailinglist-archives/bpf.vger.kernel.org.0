Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEA5AFA6D
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 05:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIGDKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 23:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGDKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 23:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40DEE0DE
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 20:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901506176A
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 03:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4F69C433D7;
        Wed,  7 Sep 2022 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662520217;
        bh=HIW/MzMZZ83PvJ2IpR6giGIqQwW4S5k7rlkWwjm63bM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nZ2f3ZwG40YWq2E7CGvVCF7UXb8MhNPWA+pHPClY1zYLVS4cm9D0wONqvoxilsczH
         R2p8AibjllKuQVuY+1lRcDtmkFJMbl614WcHGlJzGIner7lG/Qwhlzu3SfLtb444Ij
         RwWpLVq/i65SkSZdpfTxBGSD8ey8LkEm7VW2TCCDCcsma/NRfRGev6prTnnD+KIk1/
         VDI6xcCJsxYHiJfd1kpM1JZakcD/mXdTMza+PockHNtKarftlSTPVXRDINhxWb4bNA
         3C3oPxAZVIdcM1mqtbnQFYAzz7gvHyChi2gyJcKFz3vJrU/M+FDDHRcAVZ3wXxcGJG
         2pJNHZrv6NVWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7780E1CABE;
        Wed,  7 Sep 2022 03:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/8] bpf: Support struct argument for trampoline
 base progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166252021681.29304.3215686285897138920.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Sep 2022 03:10:16 +0000
References: <20220831152641.2077476-1-yhs@fb.com>
In-Reply-To: <20220831152641.2077476-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 31 Aug 2022 08:26:41 -0700 you wrote:
> Currently struct arguments are not supported for trampoline based progs.
> One of major reason is that struct argument may pass by value which may
> use more than one registers. This breaks trampoline progs where
> each argument is assumed to take one register. bcc community reported the
> issue ([1]) where struct argument is not supported for fentry program.
>   typedef struct {
>         uid_t val;
>   } kuid_t;
>   typedef struct {
>         gid_t val;
>   } kgid_t;
>   int security_path_chown(struct path *path, kuid_t uid, kgid_t gid);
> Inside Meta, we also have a use case to attach to tcp_setsockopt()
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   int tcp_setsockopt(struct sock *sk, int level, int optname,
>                      sockptr_t optval, unsigned int optlen);
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/8] bpf: Allow struct argument in trampoline based programs
    https://git.kernel.org/bpf/bpf-next/c/720e6a435194
  - [bpf-next,v4,2/8] bpf: x86: Support in-register struct arguments in trampoline programs
    https://git.kernel.org/bpf/bpf-next/c/a9c5ad31fbdc
  - [bpf-next,v4,3/8] bpf: Update descriptions for helpers bpf_get_func_arg[_cnt]()
    https://git.kernel.org/bpf/bpf-next/c/27ed9353aec9
  - [bpf-next,v4,4/8] bpf: arm64: No support of struct argument in trampoline programs
    https://git.kernel.org/bpf/bpf-next/c/eb707dde264a
  - [bpf-next,v4,5/8] libbpf: Add new BPF_PROG2 macro
    https://git.kernel.org/bpf/bpf-next/c/34586d29f8df
  - [bpf-next,v4,6/8] selftests/bpf: Add struct argument tests with fentry/fexit programs.
    https://git.kernel.org/bpf/bpf-next/c/1642a3945e22
  - [bpf-next,v4,7/8] selftests/bpf: Use BPF_PROG2 for some fentry programs without struct arguments
    https://git.kernel.org/bpf/bpf-next/c/a7c2ca3a2f69
  - [bpf-next,v4,8/8] selftests/bpf: Add tracing_struct test in DENYLIST.s390x
    https://git.kernel.org/bpf/bpf-next/c/ae63c10fc241

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


