Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F736AAC1D
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 20:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCDTaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 14:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCDTaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 14:30:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F31ABF3
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 11:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B80060687
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 19:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D076DC4339B;
        Sat,  4 Mar 2023 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677958219;
        bh=HawH4EFIPUusKh1u5FIDsbxgFwQmZZlkJwWPmUn4vtk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ego68ZIHCZdj1BSybsyxE49O+O9en1bN46T7gqZKeduMXv3hwYbEUM3Adh+z+FoiB
         qsO3vEmMLIcnC4PbY1zy+4nEOT8puf65vX65iXPwdcRiJhxLAuGP7EAspuMKkMjhOi
         EHvoXQyzQC3lZ0F2NI1UimfijgQ5dunQ9Dmv96tlPeHRLkwaBkVpddXrC89TLKvwUD
         Hcjvd4EDgtLJkLdhDWUldIbtBrdtNTzlj4L84yvvBPSJ/GN2yg3xnteBgEQ40FAh/M
         gZO7UW/tYn3A4ox3a0k0gFnN1Pg60Am/tb/wvMyn91WDHm+h2DVqVPvvyOAGUCiWpx
         IlKVSUBGIBo+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF34FE68D22;
        Sat,  4 Mar 2023 19:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/17] BPF open-coded iterators
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167795821971.19007.3389245453385038851.git-patchwork-notify@kernel.org>
Date:   Sat, 04 Mar 2023 19:30:19 +0000
References: <20230302235015.2044271-1-andrii@kernel.org>
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, tj@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 2 Mar 2023 15:49:58 -0800 you wrote:
> Add support for open-coded (aka inline) iterators in BPF world. This is a next
> evolution of gradually allowing more powerful and less restrictive looping and
> iteration capabilities to BPF programs.
> 
> We set up a framework for implementing all kinds of iterators (e.g., cgroup,
> task, file, etc, iterators), but this patch set only implements numbers
> iterator, which is used to implement ergonomic bpf_for() for-like construct
> (see patch #15). We also add bpf_for_each(), which is a generic foreach-like
> construct that will work with any kind of open-coded iterator implementation,
> as long as we stick with bpf_iter_<type>_{new,next,destroy}() naming pattern.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/17] bpf: improve stack slot state printing
    https://git.kernel.org/bpf/bpf-next/c/d54e0f6c1adf
  - [bpf-next,02/17] bpf: improve regsafe() checks for PTR_TO_{MEM,BUF,TP_BUFFER}
    https://git.kernel.org/bpf/bpf-next/c/567da5d253cd
  - [bpf-next,03/17] selftests/bpf: enhance align selftest's expected log matching
    https://git.kernel.org/bpf/bpf-next/c/6f876e75d316
  - [bpf-next,04/17] bpf: honor env->test_state_freq flag in is_state_visited()
    https://git.kernel.org/bpf/bpf-next/c/98ddcf389d1b
  - [bpf-next,05/17] selftests/bpf: adjust log_fixup's buffer size for proper truncation
    https://git.kernel.org/bpf/bpf-next/c/fffc893b6bf2
  - [bpf-next,06/17] bpf: clean up visit_insn()'s instruction processing
    https://git.kernel.org/bpf/bpf-next/c/653ae3a874ac
  - [bpf-next,07/17] bpf: fix visit_insn()'s detection of BPF_FUNC_timer_set_callback helper
    https://git.kernel.org/bpf/bpf-next/c/c1ee85a9806a
  - [bpf-next,08/17] bpf: ensure that r0 is marked scratched after any function call
    https://git.kernel.org/bpf/bpf-next/c/553a64a85c5d
  - [bpf-next,09/17] bpf: move kfunc_call_arg_meta higher in the file
    https://git.kernel.org/bpf/bpf-next/c/d0e1ac227945
  - [bpf-next,10/17] bpf: mark PTR_TO_MEM as non-null register type
    https://git.kernel.org/bpf/bpf-next/c/d5271c5b1950
  - [bpf-next,11/17] bpf: generalize dynptr_get_spi to be usable for iters
    https://git.kernel.org/bpf/bpf-next/c/a461f5adf177
  - [bpf-next,12/17] bpf: add support for fixed-size memory pointer returns for kfuncs
    https://git.kernel.org/bpf/bpf-next/c/f4b4eee6169b
  - [bpf-next,13/17] bpf: add support for open-coded iterator loops
    (no matching commit)
  - [bpf-next,14/17] bpf: implement number iterator
    (no matching commit)
  - [bpf-next,15/17] selftests/bpf: add bpf_for_each(), bpf_for(), and bpf_repeat() macros
    (no matching commit)
  - [bpf-next,16/17] selftests/bpf: add iterators tests
    (no matching commit)
  - [bpf-next,17/17] selftests/bpf: add number iterator tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


