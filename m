Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3CD6B6022
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 20:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCKTVV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 14:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCKTVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 14:21:21 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EEC580CD
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 11:21:19 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id h19so9376148qtk.7
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 11:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678562479;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSoCQl6PtFGacxoKuXAgjRAWX3+xpAtWdXnwfWxMD30=;
        b=gMKvOiu26DHRmZ+DDRK9XeNQNzLZtGJfbjINkpreoHJcBqT3GY0b6Ty4MT/qxLxUOW
         YPpx2TThzeCX4pepMAmMrA+2x0IAe6QWCJC1mEbjVd7WENsLt3BbMSsHLqRj3LCDDfK4
         PXckdXibey5hvAeN8CusMJE9xyuPTsMk8QgnaiB6BBjV5PTFjJNZ/SQXEVGWtj2wYDFd
         ZYb6LRuPeaCZcD9Evm/qhSOo23C5HvOAxYKDc9xFdRLV/MrZ7ZwsaSVGijAickQBnkvZ
         b9H2y8t5fsZgoPTkGQP/tAkXAfm3dA1RDeCwecC6zESZCsSBJokEVcoYmHQoXJHe2onk
         6e5A==
X-Gm-Message-State: AO0yUKWN8ruMd8ToqpRRIloAgsA+5JkGoAtBQTzYtBc/KmwYzUL1cfpT
        qf4NK2WOgSaOvxdaQjXDHKDt2/MdH23rqA==
X-Google-Smtp-Source: AK7set8pys4kw8uzSSar6NWnfcEzMj4KoCla64bT5/JMP8SjvEYkpofQelgikq/0mvcjfibjBOaakg==
X-Received: by 2002:ac8:4e8f:0:b0:3bf:cea5:9866 with SMTP id 15-20020ac84e8f000000b003bfcea59866mr52105552qtp.24.1678562478603;
        Sat, 11 Mar 2023 11:21:18 -0800 (PST)
Received: from maniforge ([2620:10d:c091:400::5:8f9c])
        by smtp.gmail.com with ESMTPSA id 18-20020a370a12000000b007456b51ee13sm876285qkk.16.2023.03.11.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 11:21:18 -0800 (PST)
Date:   Sat, 11 Mar 2023 13:21:15 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Add extended call instructions
Message-ID: <20230311192115.GA332677@maniforge>
References: <20230310232144.4077-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310232144.4077-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 11:21:44PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add extended call instructions.  Since BPF can be used in userland
> or SmartNICs, this uses the more generic "runtime functions"
> rather than the kernel specific "kfuncs" as a term.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Hi Dave,

Thanks for sending out the patch. It's a nice improvement to the doc to
disambiguate these instruction call types. Left a few comments below.

> ---
>  Documentation/bpf/instruction-set.rst | 50 +++++++++++++++++----------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 5e43e14abe8..bc2319a7707 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -242,24 +242,26 @@ Jump instructions
>  otherwise identical operations.
>  The 'code' field encodes the operation as below:
>  
> -========  =====  =========================  ============
> -code      value  description                notes
> -========  =====  =========================  ============
> -BPF_JA    0x00   PC += off                  BPF_JMP only
> -BPF_JEQ   0x10   PC += off if dst == src
> -BPF_JGT   0x20   PC += off if dst > src     unsigned
> -BPF_JGE   0x30   PC += off if dst >= src    unsigned
> -BPF_JSET  0x40   PC += off if dst & src
> -BPF_JNE   0x50   PC += off if dst != src
> -BPF_JSGT  0x60   PC += off if dst > src     signed
> -BPF_JSGE  0x70   PC += off if dst >= src    signed
> -BPF_CALL  0x80   function call              see `Helper functions`_
> -BPF_EXIT  0x90   function / program return  BPF_JMP only
> -BPF_JLT   0xa0   PC += off if dst < src     unsigned
> -BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> -BPF_JSLT  0xc0   PC += off if dst < src     signed
> -BPF_JSLE  0xd0   PC += off if dst <= src    signed
> -========  =====  =========================  ============
> +========  =====  ===  ==========================  ========================
> +code      value  src  description                 notes
> +========  =====  ===  ==========================  ========================
> +BPF_JA    0x0    0x0  PC += offset                BPF_JMP only
> +BPF_JEQ   0x1    any  PC += offset if dst == src
> +BPF_JGT   0x2    any  PC += offset if dst > src   unsigned
> +BPF_JGE   0x3    any  PC += offset if dst >= src  unsigned
> +BPF_JSET  0x4    any  PC += offset if dst & src
> +BPF_JNE   0x5    any  PC += offset if dst != src
> +BPF_JSGT  0x6    any  PC += offset if dst > src   signed
> +BPF_JSGE  0x7    any  PC += offset if dst >= src  signed
> +BPF_CALL  0x8    0x0  call helper function imm    see `Helper functions`_
> +BPF_CALL  0x8    0x1  call PC += offset           see `eBPF functions`_
> +BPF_CALL  0x8    0x2  call runtime function imm   see `Runtime functions`_

The names "Helper functions", "eBPF functions", and "Runtime functions"
feel, for lack of a better term, insufficiently distinct. I realize that
it's very tricky to get the naming right here given that some of these
terms (helpers + runtime functions) are conceptually the same thing, but
as a reader with no background I expect I'd be confused by what the
distinctions are as they all kind of sound like the same thing. What do
you think of this as an alternative:

1. Standard helper functions
2. BPF-local functions
3. Platform-specific helper functions

The idea with the latter is of course that the platform can choose to
implement whatever helper functions (kfuncs for Linux) apply exclusively
to that platform. I think we'd need some formal encoding for this in the
standard, so it seems appropriate to apply it here. What do you think?

> +BPF_EXIT  0x9    0x0  return                      BPF_JMP only
> +BPF_JLT   0xa    any  PC += offset if dst < src   unsigned
> +BPF_JLE   0xb    any  PC += offset if dst <= src  unsigned
> +BPF_JSLT  0xc    any  PC += offset if dst < src   signed
> +BPF_JSLE  0xd    any  PC += offset if dst <= src  signed
> +========  =====  ===  ==========================  ========================
>  
>  The eBPF program needs to store the return value into register R0 before doing a
>  BPF_EXIT.
> @@ -272,6 +274,18 @@ set of function calls exposed by the runtime.  Each helper
>  function is identified by an integer used in a ``BPF_CALL`` instruction.
>  The available helper functions may differ for each program type.
>  
> +Runtime functions
> +~~~~~~~~~~~~~~~~~
> +Runtime functions are like helper functions except that they are not specific
> +to eBPF programs.  They use a different numbering space from helper functions,

Per my suggestion above, should we rephrase this as "platform-specific"
helper functions? E.g. something like:

Platform-specific helper functions are helper functions that may be
unique to a particular platform. An encoding for a platform-specific
function on one platform may or may not correspond to the same function
on another platform. Platforms are not required to implement any
platform-specific function.

As alluded to above, the fact that they're not specific to BPF seems
like an implementation detail from the perspective of the encoding /
standard. Thoughts?

> +but otherwise the same considerations apply.
> +
> +eBPF functions
> +~~~~~~~~~~~~~~
> +eBPF functions are functions exposed by the same eBPF program as the caller,
> +and are referenced by offset from the call instruction, similar to ``BPF_JA``.
> +A ``BPF_EXIT`` within the eBPF function will return to the caller.

Suggestion: Can we simply say BPF instead of eBPF? At this point I'm not
sure what the 'e' distinction really buys us, though I'm sure I'm
missing context from (many) prior discussions. I also don't want to
bikeshed too much on this point for your patch, so if it becomes a
"thing" then feel free to ignore.

Thanks,
David
