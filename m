Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230976C9218
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 04:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjCZCM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 22:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZCM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 22:12:57 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8452D101
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 19:12:55 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id o44so4620565qvo.4
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 19:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679796774;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTkt+iNV4oWtx/XMDhvID2lCMHg8oJY1AonvSsYqELQ=;
        b=fD1D60Gl6NJ8r4q3R10BeTsSW88H120x0WfhwdB6VAIyHQzSN1lviI3UWlWX64MmIZ
         E8ruVcpc7hFTz3ol4RDp9w53nsT69C1D9e9t3ynWSZEey69Q1UL2cc2K9pL5tJ2c3Xq9
         nSF69qwSmilwwMkECN6p+y9/KdC6D2XRdbCPgGedQKEHwKVcO+cQ+jsEq7KzfDs4HtFp
         UwR4ykWk7HSoOTrjqw0wWD52+8iTCiEaQcJoMymbUeDpeDhTcP2jQoq91Uq1oDETuWJ7
         IgJq7XarTjNLcfDM9Wt0zacQJWWXq7EAszC9yWwmRaCwIwai38OSGPxS4FjF6BCzTa28
         FX7A==
X-Gm-Message-State: AAQBX9eNqjgiQjKt4FLqUSCb08mlR5xYGrpJbpx4uKWwkA3DdinB4vPI
        bJvWvtbE6A1N69HAYHLMsks=
X-Google-Smtp-Source: AKy350ZjD7ucHEZ1g/UnFuPHr5+/NB2j7sJpGJ/UehJ9KTHUTgpYPJnYz/CrTxBbMD7jUxgTZsKjDQ==
X-Received: by 2002:a05:6214:21ad:b0:572:636d:625f with SMTP id t13-20020a05621421ad00b00572636d625fmr12897996qvc.33.1679796774370;
        Sat, 25 Mar 2023 19:12:54 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id b14-20020a0cbf4e000000b005dd8b9345d1sm1845957qvj.105.2023.03.25.19.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 19:12:53 -0700 (PDT)
Date:   Sat, 25 Mar 2023 21:12:51 -0500
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next v4] bpf, docs: Add extended call
 instructions
Message-ID: <20230326021251.GD363182@maniforge>
References: <20230325102314.1504-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325102314.1504-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 25, 2023 at 10:23:14AM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add extended call instructions.  Uses the term "program-local" for
> call by offset.  And there are instructions for calling helper functions
> by "address" (the old way of using integer values), and for calling
> helper functions by BTF ID (for kfuncs).
> 
> ---
> V1 -> V2: addressed comments from David Vernet
> 
> V2 -> V3: make descriptions in table consistent with updated names
> 
> V3 -> V4: addressed comments from Alexei
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Looks great, thanks for driving this to consensus. Just left one nit
below, but here's my stamp regardless:

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/instruction-set.rst | 59 +++++++++++++++++----------
>  1 file changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 5e43e14abe8..ed8f35becb2 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -242,35 +242,50 @@ Jump instructions
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
> +========  =====  ===  ===========================================  =========================================
> +code      value  src  description                                  notes
> +========  =====  ===  ===========================================  =========================================
> +BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP only
> +BPF_JEQ   0x1    any  PC += offset if dst == src
> +BPF_JGT   0x2    any  PC += offset if dst > src                    unsigned
> +BPF_JGE   0x3    any  PC += offset if dst >= src                   unsigned
> +BPF_JSET  0x4    any  PC += offset if dst & src
> +BPF_JNE   0x5    any  PC += offset if dst != src
> +BPF_JSGT  0x6    any  PC += offset if dst > src                    signed
> +BPF_JSGE  0x7    any  PC += offset if dst >= src                   signed
> +BPF_CALL  0x8    0x0  call helper function by address		   see `Helper functions`_

nit: Seems like the alignment got messed up here?

> +BPF_CALL  0x8    0x1  call PC += offset                            see `Program-local functions`_
> +BPF_CALL  0x8    0x2  call helper function by BTF ID               see `Helper functions`_
> +BPF_EXIT  0x9    0x0  return                                       BPF_JMP only
> +BPF_JLT   0xa    any  PC += offset if dst < src                    unsigned
> +BPF_JLE   0xb    any  PC += offset if dst <= src                   unsigned
> +BPF_JSLT  0xc    any  PC += offset if dst < src                    signed
> +BPF_JSLE  0xd    any  PC += offset if dst <= src                   signed
> +========  =====  ===  ===========================================  =========================================
>  
>  The eBPF program needs to store the return value into register R0 before doing a
> -BPF_EXIT.
> +``BPF_EXIT``.
>  
>  Helper functions
>  ~~~~~~~~~~~~~~~~
>  
>  Helper functions are a concept whereby BPF programs can call into a
> -set of function calls exposed by the runtime.  Each helper
> -function is identified by an integer used in a ``BPF_CALL`` instruction.
> -The available helper functions may differ for each program type.
> +set of function calls exposed by the underlying platform.
> +
> +Historically, each helper function was identified by an address
> +encoded in the imm field.  The available helper functions may differ
> +for each program type, but address values are unique across all program types.
> +
> +Platforms that support the BPF Type Format (BTF) support identifying
> +a helper function by a BTF ID encoded in the imm field, where the BTF ID
> +identifies the helper name and type.
> +
> +Program-local functions
> +~~~~~~~~~~~~~~~~~~~~~~~
> +Program-local functions are functions exposed by the same BPF program as the
> +caller, and are referenced by offset from the call instruction, similar to
> +``BPF_JA``.  A ``BPF_EXIT`` within the program-local function will return to
> +the caller.
>  
>  Load and store instructions
>  ===========================
> -- 
> 2.33.4
> 
> -- 
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf
