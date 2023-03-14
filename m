Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC16B8A11
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 06:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjCNFH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 01:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCNFH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 01:07:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5B4B759
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 22:07:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p20so15338757plw.13
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 22:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678770476;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lLiRVOLt+rNPgcLG+fvtd6JzA8SXYbh9mowzDFwkqU=;
        b=FePqOMF3ai4ot0j/lXFU4FCVw2YJtRiMxx+ZeJyOjlAugLvscoXwFBrKPDpGYJlHJg
         T8TxAbRLLBdjRRuOVsx7hO0miZ5Wy1P4fz+P0hsMH45Bj4MOLoC+KBcgWU8XKpu6IVve
         lXC2rK9whZWxE35DE4or0orDXF8wsHyaqquKq+gMz4YXoVRTufjdgK/wpOYdQCgMU1l7
         3SJCsORZ6HF2mM7XxcUynWUBr5gGvSrEwI6bvelWcoqENKd7MvQsFVtEZ5DyPZYyTsgA
         d7oMyY8PIKLb6DCqicgjPvAjtMtvwMKkr4XldptNt+7XI7w9fw6k1828LKttT7GyxVdS
         HpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678770476;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+lLiRVOLt+rNPgcLG+fvtd6JzA8SXYbh9mowzDFwkqU=;
        b=EODTBrA2TzjxMJykDeJASEI9iWRkKRM90ZjPWg6qiQbk3+isOwwyyUJZhgRQZv0N24
         tOnPigGbzLAYa6oCQBwaV6XyqH7+dZ4laj5MbDuhwkz/KnaAOulqUJzVrOMm9Afm7/aC
         Jt9M3thdgzpAnXAEEe5MHNqDEq4rI95bW49XGpWpkODUsduEzAzDDjXqlduSAr8X6bt+
         2fGWpm7QgxF4Mk1UxK3KWOCkwFeybz1Q88AOJsRsGpahmW5FZGA+KLJWf5/mV35G+uT8
         UKKniC76atZTMMJZzOH7fWgkeWH8BXhSklI+kJIWwy4WooYSuRYOQxBv0I7f99GgKJdr
         JY0g==
X-Gm-Message-State: AO0yUKV/+7jFVtLVK+AYNaL6J6xH/vD2RHA+Hdoz2ox6zh6dj59BDDJC
        7O+8TS/wpLyx1g0cPqNFCPM=
X-Google-Smtp-Source: AK7set/B74Xnq3C1oKPHM/f8xzS1WFtG6YT5uFuBx2YgfBqw4caJ55X6hRdwqE3PYZ44im8mpOzlMA==
X-Received: by 2002:a17:902:f54d:b0:1a0:4fda:54a with SMTP id h13-20020a170902f54d00b001a04fda054amr5146121plf.56.1678770476510;
        Mon, 13 Mar 2023 22:07:56 -0700 (PDT)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902a5cc00b0019c91989a1csm670009plq.300.2023.03.13.22.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:07:55 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:07:53 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Message-ID: <64100129e3da5_425812087b@john.notmuch>
In-Reply-To: <20230311220912.5546-1-dthaler1968@googlemail.com>
References: <20230311220912.5546-1-dthaler1968@googlemail.com>
Subject: RE: [PATCH bpf-next v2] bpf, docs: Add extended call instructions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add extended call instructions.  Since BPF can be used in userland
> or SmartNICs, this uses the more generic "Platform-specific helper functions"
> term as suggested by David Vernet, rather than the kernel specific "kfuncs".
> 
> ---
> V1 -> V2: addressed comments from David Vernet
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 63 +++++++++++++++++----------
>  Documentation/bpf/linux-notes.rst     |  4 ++
>  2 files changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 5e43e14abe8..dc348544542 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -242,35 +242,52 @@ Jump instructions
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
> +========  =====  ===  ==========================  =========================================
> +code      value  src  description                 notes
> +========  =====  ===  ==========================  =========================================
> +BPF_JA    0x0    0x0  PC += offset                BPF_JMP only
> +BPF_JEQ   0x1    any  PC += offset if dst == src
> +BPF_JGT   0x2    any  PC += offset if dst > src   unsigned
> +BPF_JGE   0x3    any  PC += offset if dst >= src  unsigned
> +BPF_JSET  0x4    any  PC += offset if dst & src
> +BPF_JNE   0x5    any  PC += offset if dst != src
> +BPF_JSGT  0x6    any  PC += offset if dst > src   signed
> +BPF_JSGE  0x7    any  PC += offset if dst >= src  signed
> +BPF_CALL  0x8    0x0  call helper function imm    see `Platform-agnostic helper functions`_
> +BPF_CALL  0x8    0x1  call PC += offset           see `BPF-local functions`_
> +BPF_CALL  0x8    0x2  call runtime function imm   see `Platform-specific helper functions`_
> +BPF_EXIT  0x9    0x0  return                      BPF_JMP only
> +BPF_JLT   0xa    any  PC += offset if dst < src   unsigned
> +BPF_JLE   0xb    any  PC += offset if dst <= src  unsigned
> +BPF_JSLT  0xc    any  PC += offset if dst < src   signed
> +BPF_JSLE  0xd    any  PC += offset if dst <= src  signed
> +========  =====  ===  ==========================  =========================================
>  
>  The eBPF program needs to store the return value into register R0 before doing a
>  BPF_EXIT.
>  
> -Helper functions
> -~~~~~~~~~~~~~~~~
> +Platform-agnostic helper functions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -Helper functions are a concept whereby BPF programs can call into a
> -set of function calls exposed by the runtime.  Each helper
> +Platform-agnostic helper functions are a concept whereby BPF programs can call
> +into a set of function calls exposed by the runtime.  Each helper
>  function is identified by an integer used in a ``BPF_CALL`` instruction.
> -The available helper functions may differ for each program type.
> +The available platform-agnostic helper functions may differ for each program
> +type, but integer values are unique across all program types.
> +
> +Platform-specific helper functions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Platform-specific helper functions are helper functions that are unique to
> +a particular platform.  They use a separate integer numbering space from
> +platform-agnostic helper functions, but otherwise the same considerations

How does the separate integer numbering space work in Linux? Here I guess
we have platform agnostic and Linux specific helpers all mingled together
correct?

> +apply.  Platforms are not required to implement any platform-specific
> +functions.
> +
> +BPF-local functions
> +~~~~~~~~~~~~~~
> +BPF-local functions are functions exposed by the same BPF program as the caller,
> +and are referenced by offset from the call instruction, similar to ``BPF_JA``.
> +A ``BPF_EXIT`` within the BPF-local function will return to the caller.
>  
>  Load and store instructions
>  ===========================
> diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> index f43b9c797bc..bdc41293e8a 100644
> --- a/Documentation/bpf/linux-notes.rst
> +++ b/Documentation/bpf/linux-notes.rst
> @@ -20,6 +20,10 @@ integer would be read from a specified register, is not currently supported
>  by the verifier.  Any programs with this instruction will fail to load
>  until such support is added.
>  
> +For historical reasons, Linux has a number of Linux-specific helper functions
> +that are encoded as platform-agnostic helper functions rather than
> + platform-specific helper functions ("kfuncs").

Is this the comment to address above integer numbering space on Linux
being inconsistent with above docs?

> +
>  Legacy BPF Packet access instructions
>  =====================================
>  
> -- 
> 2.33.4
> 


