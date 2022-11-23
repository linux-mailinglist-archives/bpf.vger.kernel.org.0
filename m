Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89613636E83
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 00:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKWXlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 18:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiKWXlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 18:41:09 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103FCDEAED;
        Wed, 23 Nov 2022 15:41:07 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1oxzMU-000LXo-Tb; Thu, 24 Nov 2022 00:41:02 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oxzMU-000BxX-Fr; Thu, 24 Nov 2022 00:41:02 +0100
Subject: Re: [PATCH bpf-next 0/3] bpf: Add LDX/STX/ST sanitize in jited BPF
 progs
To:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20221123141546.238297-1-sunhao.th@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bf22362b-0a7c-1cb3-1f22-28144bdf4380@iogearbox.net>
Date:   Thu, 24 Nov 2022 00:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221123141546.238297-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26729/Wed Nov 23 09:18:01 2022)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
        URIBL_DBL_ABUSE_REDIR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23/22 3:15 PM, Hao Sun wrote:
> The verifier sometimes makes mistakes[1][2] that may be exploited to
> achieve arbitrary read/write. Currently, syzbot is continuously testing
> bpf, and can find memory issues in bpf syscalls, but it can hardly find
> mischecking/bugs in the verifier. We need runtime checks like KASAN in
> BPF programs for this. This patch series implements address sanitize
> in jited BPF progs for testing purpose, so that tools like syzbot can
> find interesting bugs in the verifier automatically by, if possible,
> generating and executing BPF programs that bypass the verifier but have
> memory issues, then triggering this sanitizing.
> 
> The idea is to dispatch read/write addr of a BPF program to the kernel
> functions that are instrumented by KASAN, to achieve indirect checking.
> Indirect checking is adopted because this is much simple, instrument
> direct checking like compilers makes the jit much more complex. The
> main step is: back up R0&R1 and store addr in R1, and then insert the
> checking function before load/store insns, during bpf_misc_fixup(), and
> finally in the jit stage, backup R1~R5 to make sure the checking funcs
> won't corrupt regs states. An extra Kconfig option is used to enable
> this, so normal use case won't be impacted at all.

Thanks for looking into this! It's a bit unfortunate that this will need
changes in every BPF JIT. Have you thought about a generic solution which
would not require changes in JITs? Given this is for debugging and finding
mischecking/bugs in the verifier, can't we reuse interpreter for this and
only implement it there? I would be curious if we could achieve the same
result from [3] with such approach.

> Also, not all ldx/stx/st are instrumented. Insns rewrote by other fixup
> or conversion passes that use BPF_REG_AX are skipped, because that
> conflicts with us; insns whose access addr is specified by R10 are also
> skipped because they are trivial to verify.
> 
> Patch1 sanitizes st/stx insns, and Patch2 sanitizes ldx insns, Patch3 adds
> selftests for instrumentation in each possible case, and all new/existing
> selftests for the verifier can pass. Also, a BPF prog that also exploits
> CVE-2022-23222 to achieve OOB read is provided[3], this can be perfertly
> captured with this patch series.
> 
> I haven't found a better way to back up the regs before executing the
> checking functions, and have to store them on the stack. Comments and
> advice are surely welcome.
> 
> [1] http://bit.do/CVE-2021-3490
> [2] http://bit.do/CVE-2022-23222
> [3] OOB-read: https://pastebin.com/raw/Ee1Cw492
> 
> Hao Sun (3):
>    bpf: Sanitize STX/ST in jited BPF progs with KASAN
>    bpf: Sanitize LDX in jited BPF progs with KASAN
>    selftests/bpf: Add tests for LDX/STX/ST sanitize
> 
>   arch/x86/net/bpf_jit_comp.c                   |  34 ++
>   include/linux/bpf.h                           |  14 +
>   kernel/bpf/Kconfig                            |  14 +
>   kernel/bpf/verifier.c                         | 190 +++++++++++
>   .../selftests/bpf/verifier/sanitize_st_ldx.c  | 323 ++++++++++++++++++
>   5 files changed, 575 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c
> 
> 
> base-commit: 8a2162a9227dda936a21fe72014a9931a3853a7b
> 

Thanks,
Daniel
