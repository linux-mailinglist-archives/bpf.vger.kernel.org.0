Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B1100F5A
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 00:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKRXOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 18:14:18 -0500
Received: from www62.your-server.de ([213.133.104.62]:38060 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfKRXOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 18:14:18 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iWqDo-000772-7A; Tue, 19 Nov 2019 00:14:16 +0100
Received: from [178.197.248.45] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iWqDn-0004vY-Up; Tue, 19 Nov 2019 00:14:16 +0100
Subject: Re: [PATCH bpf-next] [tools/bpf] workaround an alu32 sub-register
 spilling issue
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@fb.com>, kernel-team@fb.com
References: <20191117214036.1309510-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <729f2eb8-3019-b8e6-a135-53c6d565c88f@iogearbox.net>
Date:   Tue, 19 Nov 2019 00:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191117214036.1309510-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25637/Mon Nov 18 10:53:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/19 10:40 PM, Yonghong Song wrote:
> Currently, with latest llvm trunk, selftest test_progs failed
> obj file test_seg6_loop.o with the following error
> in verifier:
>    infinite loop detected at insn 76
> The byte code sequence looks like below, and noted
> that alu32 has been turned off by default for better
> generated codes in general:
>        48:       w3 = 100
>        49:       *(u32 *)(r10 - 68) = r3
>        ...
>    ;             if (tlv.type == SR6_TLV_PADDING) {
>        76:       if w3 == 5 goto -18 <LBB0_19>
>        ...
>        85:       r1 = *(u32 *)(r10 - 68)
>    ;     for (int i = 0; i < 100; i++) {
>        86:       w1 += -1
>        87:       if w1 == 0 goto +5 <LBB0_20>
>        88:       *(u32 *)(r10 - 68) = r1
> 
> The main reason for verification failure is due to
> partial spills at r10 - 68 for induction variable "i".
> 
> Current verifier only handles spills with 8-byte values.
> The above 4-byte value spill to stack is treated to
> STACK_MISC and its content is not saved. For the above example,
>      w3 = 100
>        R3_w=inv100 fp-64_w=inv1086626730498
>      *(u32 *)(r10 - 68) = r3
>        R3_w=inv100 fp-64_w=inv1086626730498
>      ...
>      r1 = *(u32 *)(r10 - 68)
>        R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>        fp-64=inv1086626730498
> 
> To resolve this issue, verifier needs to be extended to
> track sub-registers in spilling, or llvm needs to enhanced
> to prevent sub-register spilling in register allocation
> phase. The former will increase verifier complexity and
> the latter will need some llvm "hacking".
> 
> Let us workaround this issue by declaring the induction
> variable as "long" type so spilling will happen at non
> sub-register level. We can revisit this later if sub-register
> spilling causes similar or other verification issues.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied, thanks!
