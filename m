Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810854AE983
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiBIFqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbiBIFkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:40:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557ABC02C45D
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 684EDB81F01
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 05:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16391C340EB;
        Wed,  9 Feb 2022 05:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644385212;
        bh=zfi8cJ8t0LVPU+gv8zq8w4CAfHlLUVENeP3xx4ZPh8A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=B6OMKj1fkisGLrgIzevh8EMEPL0mVh44iZGPHzpIx21yo9fCUtpmK0Gwk5Ez1rhhN
         PiJQiHkbep9P9a01yemsZJvB1l280Cw0xaZQlIMKSiqV1Ew6u50xYA6Mg+ESEoO6RP
         f3iPn5Sc+xrppsaZZXLx5cnLbVJ6w+5ROALBuHnTmb0mn4tTx1+vZ8EHijzuWJlsOs
         6xoeImlJs+tlOGVFNCpDrTxortNI+O2/OTGaq8zYZrFuz+q6L6F5e7rhToHgwg2Y33
         GgVg7szqEmK3e+P5HOV5mfHJa0By8/wk2i+dCSBOCCb1JJVtA6J/dX2WMkCRaplpYu
         LnGBDe+80ZpDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2679E5D07D;
        Wed,  9 Feb 2022 05:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/10] Fix accessing syscall arguments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164438521198.19906.9141954700062717431.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Feb 2022 05:40:11 +0000
References: <20220209021745.2215452-1-iii@linux.ibm.com>
In-Reply-To: <20220209021745.2215452-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, bpf@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  9 Feb 2022 03:17:35 +0100 you wrote:
> libbpf now has macros to access syscall arguments in an
> architecture-agnostic manner, but unfortunately they have a number of
> issues on non-Intel arches, which this series aims to fix.
> 
> v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
> v1 -> v2:
> * Put orig_gpr2 in place of args[1] on s390 (Vasily).
> * Fix arm64, powerpc and riscv (Heiko).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/10] selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
    https://git.kernel.org/bpf/bpf-next/c/4fc49b51ab9d
  - [bpf-next,v5,02/10] libbpf: Add PT_REGS_SYSCALL_REGS macro
    https://git.kernel.org/bpf/bpf-next/c/c5a1ffa0da76
  - [bpf-next,v5,03/10] selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
    https://git.kernel.org/bpf/bpf-next/c/3f928cab927c
  - [bpf-next,v5,04/10] libbpf: Fix accessing syscall arguments on powerpc
    https://git.kernel.org/bpf/bpf-next/c/f07f1503469b
  - [bpf-next,v5,05/10] libbpf: Fix riscv register names
    https://git.kernel.org/bpf/bpf-next/c/5c101153bfd6
  - [bpf-next,v5,06/10] libbpf: Fix accessing syscall arguments on riscv
    https://git.kernel.org/bpf/bpf-next/c/cf0b5b276923
  - [bpf-next,v5,07/10] selftests/bpf: Skip test_bpf_syscall_macro:syscall_arg1 on arm64 and s390
    https://git.kernel.org/bpf/bpf-next/c/9e45a377f29b
  - [bpf-next,v5,08/10] libbpf: Allow overriding PT_REGS_PARM1{_CORE}_SYSCALL
    https://git.kernel.org/bpf/bpf-next/c/60d16c5ccb81
  - [bpf-next,v5,09/10] libbpf: Fix accessing the first syscall argument on arm64
    https://git.kernel.org/bpf/bpf-next/c/fbca4a2f6497
  - [bpf-next,v5,10/10] libbpf: Fix accessing the first syscall argument on s390
    https://git.kernel.org/bpf/bpf-next/c/1f22a6f9f9a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


