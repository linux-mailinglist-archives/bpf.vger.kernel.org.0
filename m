Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5DA6722EC
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjARQXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 11:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjARQWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 11:22:37 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62EC46085
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 08:20:46 -0800 (PST)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pIBB5-000CD7-IV; Wed, 18 Jan 2023 17:20:43 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pIBB5-0009qW-Be; Wed, 18 Jan 2023 17:20:43 +0100
Subject: Re: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
To:     dthaler1968@googlemail.com, bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
References: <87o7qw18l8.fsf@oracle.com>
 <20230118152329.877-1-dthaler1968@googlemail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f92955a7-8e92-eed2-243f-a532baf739b6@iogearbox.net>
Date:   Wed, 18 Jan 2023 17:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230118152329.877-1-dthaler1968@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26785/Wed Jan 18 09:42:40 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/18/23 4:23 PM, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Fix modulo zero, division by zero, overflow, and underflow.
> Also clarify how a negative immediate value is used in unsigned division
> 
> Changes from last submission: addressed conversion comment from
> Jose.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>   Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index e672d5ec6cc..f79dae527ad 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -99,19 +99,26 @@ code      value  description
>   BPF_ADD   0x00   dst += src
>   BPF_SUB   0x10   dst -= src
>   BPF_MUL   0x20   dst \*= src
> -BPF_DIV   0x30   dst /= src
> +BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
>   BPF_OR    0x40   dst \|= src
>   BPF_AND   0x50   dst &= src
>   BPF_LSH   0x60   dst <<= src
>   BPF_RSH   0x70   dst >>= src
>   BPF_NEG   0x80   dst = ~src
> -BPF_MOD   0x90   dst %= src
> +BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
>   BPF_XOR   0xa0   dst ^= src
>   BPF_MOV   0xb0   dst = src
>   BPF_ARSH  0xc0   sign extending shift right
>   BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>   ========  =====  ==========================================================
>   
> +Underflow and overflow are allowed during arithmetic operations,
> +meaning the 64-bit or 32-bit value will wrap.  If
> +eBPF program execution would result in division by zero,
> +the destination register is instead set to zero.
> +If execution would result in modulo by zero,
> +the destination register is instead left unchanged.

Looks good to go with one small nit for the previous sentence which could be
misinterpreted. The rewrites from verifier for modulo op are:

       mod32:                            mod64:

       (16) if w0 == 0x0 goto pc+2       (15) if r0 == 0x0 goto pc+1
       (9c) w1 %= w0                     (9f) r1 %= r0
       (05) goto pc+1
       (bc) w1 = w1

So for BPF_ALU as 32-bit op, it is expected that the result is 32-bit
value, too. So for 32-bit op the destination register is truncated to
32-bit value. (Related commit 9b00f1b78809 ("bpf: Fix truncation handling
for mod32 dst reg wrt zero")).

>   ``BPF_ADD | BPF_X | BPF_ALU`` means::
>   
>     dst_reg = (u32) dst_reg + (u32) src_reg;
> @@ -128,6 +135,11 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>   
>     dst_reg = dst_reg ^ imm32
>   
> +Also note that the division and modulo operations are unsigned.
> +Thus, for `BPF_ALU`, 'imm' is first interpreted as an unsigned
> +32-bit value, whereas for `BPF_ALU64`, 'imm' is first sign extended
> +to 64 bits and the result interpreted as an unsigned 64-bit value.
> +There are no instructions for signed division or modulo.
>   
>   Byte swap instructions
>   ~~~~~~~~~~~~~~~~~~~~~~
> 

