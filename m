Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2C65F40E
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 20:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjAETB3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 14:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjAETBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 14:01:22 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4965F927
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 11:01:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902e54100b00192cc6850ffso8142383plf.18
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPoWd2Is+1dLfGKrvPSVlTgdppavfUFo8b1uTsuAH+I=;
        b=mttXejTh5dHxmizotpgXU0GrNSqfbqRZDI1wYWzByJ2twpRZAWM3gjGyur50Wu9CG6
         bupZ6f8Us6SOHJ9KQJ6T+aQraeInfc6nVbW4XynUer9pZIZfEFf4WaFTHV6twjrQfw4q
         MpIqRWJLkQq1YnXoHzVUksKOaWQsS1h94Q/MNlE+nHlRjF5orsmn9U6Pnmsn7VqCTYq0
         2ByQ/srEiZ+2rkpJygTrysYhCt+vDQtWG9aQtG8EiZ5dQC5HAYeN5GPfWaxYfZi/0cns
         rfaDqE8YaQNOoziNlQcsA1cmmzj2OjdkLYGxi5kgQ/IGlQy1a7mo1KIu65y+dKxUlhXB
         sFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPoWd2Is+1dLfGKrvPSVlTgdppavfUFo8b1uTsuAH+I=;
        b=g/eWJi/QGS5e0iBkcGwt/++2vHPaUt3ofIlFjUocqSroacU9kLBg0EZIDW4DzCcQ/f
         W5ig7kO/GHdsttVxNlvOfzWHRSTaKYWADPc5mkjXJi+wPgYviutRFr0i14axBhNLNQlo
         Fi8B9oNZSUKtNu4AfGyali4imVjrZNmMp1SxUcTxlB4PRMRz/lDFdnSCJ7/h6N6bkw5U
         PiwpjdW3IQEHm7zaI3QcSgHzYFJLMGw0HrwKVXdDVUOdxFA1qA6QarRDBwI/J5nZbvHo
         ZCq2bbAlQyb0WWVdQOHW4ac8ESYBtkrDlk7fFCFF6c/OyeBrX702TTQC5bA90IEZu68E
         3HFQ==
X-Gm-Message-State: AFqh2kobINIOf1blE3EWG3bnVgTi2NyNdXPF8j6b2he2i5Go92w5dMCU
        zChq4NkW5AJfyzIjj1qUto4BDy8=
X-Google-Smtp-Source: AMrXdXvnbyIVveeWz5lumww58W+H7+lgbNgyzK80mlxw/D1sH9ZIvGWWdr2sZHY0ti18yeDtUoWb5gg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:9284:b0:226:9980:67f3 with SMTP id
 n4-20020a17090a928400b00226998067f3mr942pjo.1.1672945279098; Thu, 05 Jan 2023
 11:01:19 -0800 (PST)
Date:   Thu, 5 Jan 2023 11:01:17 -0800
In-Reply-To: <20230105163223.3472-1-dthaler1968@googlemail.com>
Mime-Version: 1.0
References: <20230105163223.3472-1-dthaler1968@googlemail.com>
Message-ID: <Y7cefSXEQ3M3C9pk@google.com>
Subject: Re: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
From:   sdf@google.com
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/05, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>

> Fix modulo zero, division by zero, overflow, and underflow.
> Also clarify how a negative immediate value is used in unsigned division

> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

With a small note below.

> ---
>   Documentation/bpf/instruction-set.rst | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

> diff --git a/Documentation/bpf/instruction-set.rst  
> b/Documentation/bpf/instruction-set.rst
> index e672d5ec6cc..2ba7c618f33 100644
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
>   BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_  
> below)
>   ========  =====   
> ==========================================================

> +Underflow and overflow are allowed during arithmetic operations,
> +meaning the 64-bit or 32-bit value will wrap.  If
> +eBPF program execution would result in division by zero,
> +the destination register is instead set to zero.
> +If execution would result in modulo by zero,
> +the destination register is instead left unchanged.
> +
>   ``BPF_ADD | BPF_X | BPF_ALU`` means::

>     dst_reg = (u32) dst_reg + (u32) src_reg;
> @@ -128,6 +135,10 @@ BPF_END   0xd0   byte swap operations (see `Byte  
> swap instructions`_ below)

>     dst_reg = dst_reg ^ imm32


[..]

> +Also note that the division and modulo operations are unsigned,
> +where 'imm' is first sign extended to 64 bits and then converted
> +to an unsigned 64-bit value.  There are no instructions for
> +signed division or modulo.

Less sure about this part, but it looks to be true at least by looking at
the interpreter which does:

DST = DST / IMM

where:

DST === (u64) regs[insn->dst_reg]
IMM === (s32) insn->imm

(and s32 is sign-expanded to u64 according to C rules)

>   Byte swap instructions
>   ~~~~~~~~~~~~~~~~~~~~~~
> --
> 2.33.4

