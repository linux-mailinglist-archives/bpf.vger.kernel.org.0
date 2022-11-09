Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9211622874
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 11:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKIK1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 05:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKIK0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 05:26:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799D27925;
        Wed,  9 Nov 2022 02:26:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFC9619AB;
        Wed,  9 Nov 2022 10:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FBAC433D6;
        Wed,  9 Nov 2022 10:26:31 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-kernel@vger.kernel.org, Akihiro HARAI <jharai0815@gmail.com>,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] arm64/syscall: Include asm/ptrace.h in syscall_wrapper header.
Date:   Wed,  9 Nov 2022 10:26:29 +0000
Message-Id: <166798958453.3807941.18336415954221459051.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031215728.50389-1-kuniyu@amazon.com>
References: <20221031215728.50389-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 31 Oct 2022 14:57:28 -0700, Kuniyuki Iwashima wrote:
> Add the same change for ARM64 as done in the commit 9440c4294160
> ("x86/syscall: Include asm/ptrace.h in syscall_wrapper header") to
> make sure all syscalls see 'struct pt_regs' definition and resulted
> BTF for '__arm64_sys_*(struct pt_regs *regs)' functions point to
> actual struct.
> 
> Without this patch, the BPF verifier refuses to load a tracing prog
> which accesses pt_regs.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/syscall: Include asm/ptrace.h in syscall_wrapper header.
      https://git.kernel.org/arm64/c/acfc35cfcee5

-- 
Catalin

