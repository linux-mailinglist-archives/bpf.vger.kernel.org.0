Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1503A6B83FB
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 22:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCMVao (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 17:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCMVan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 17:30:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CE570401
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 14:30:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so13114871pjp.2
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678743030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pdIcDTaNYx8meba7J71wC0jcHf4ChgWgF6Qn7sYIh4=;
        b=QeoAwPu2AO/Y5i5EUhoGYtVrZT7KRIyYVlRRWyrKQAM3MZWWPgukrd8juJFkMdzclr
         GSfKl4BnVrpuoohLGaIkXn0Ld+gJebnbIJR1TXskETq3QyA9OiwAbIQci2HRXRFS0CIz
         7KJcq5q8Sr6JHxRZ1GDPkCtFsOvF0V1mew54ylcqfqxVaHZsPxA6Pq6XoNVsn4VBmfca
         OYzbWpescgDyZBkqv6+yKxCiEbquCWftwAKj3yYnczZM0BmNH1CH0DH6t2UpLe12O+7A
         BVfz1Fv/W28MhCJf5aIWaJMUvssuCsq1+OZkL4DsIImyq/vMEQpmDaErpCFE1z7hS3Wx
         90oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678743030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pdIcDTaNYx8meba7J71wC0jcHf4ChgWgF6Qn7sYIh4=;
        b=XrmTSZbdmYkuepwh9MhWYk+62qL+XY/KdxCRqO4k+clDQPNFI3vZ7XSgDztMeSlmhy
         MVY0QNU8HPi2/qtx/JfsFvbtvz5NeKwM0ttee3uniLSogeYuOt964xT+Z7I6aRAuD2r7
         020gfCZNEKiHs6MujOh6spMEi0SGAZrl5Fc4V6P3J0y/YMsL9WaKn1bwDSt9kivCuWzp
         3fl5VxlHniLwSDc+mLPw2pdrrq/kFXVzaRUdvy61CgoavclTaL8OMpJnv6hhqitjY5Vt
         rRKFSOz44xdMMhMmDuzQj0oYBCFVj/s0Ei4ekuBoiNkDm6I1DrUIOTx51lP5pwgB0SAJ
         OQng==
X-Gm-Message-State: AO0yUKVjY8yllGi9AKmny4s+nnX7v9xvqEW4ANxZTMhEXXoKuLQ0ouGs
        UUT7vWwLHOYod1xIq51r4gM=
X-Google-Smtp-Source: AK7set/yaYCeD+ebCGVC4MTuSvjYMfbN0JZlNuvw2mTNDasMBSOLY5b9DOWCuMCFmrpE+9uYGNLmvg==
X-Received: by 2002:a05:6a20:7343:b0:d0:360c:ea91 with SMTP id v3-20020a056a20734300b000d0360cea91mr23913007pzc.20.1678743030504;
        Mon, 13 Mar 2023 14:30:30 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:ad6b])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b005d503abc8fesm144937pfm.218.2023.03.13.14.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:30:29 -0700 (PDT)
Date:   Mon, 13 Mar 2023 14:30:27 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Add extended call
 instructions
Message-ID: <20230313213027.4m5taqvxgsomiu5n@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230312221958.879-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312221958.879-1-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 12, 2023 at 10:19:58PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add extended call instructions.  Since BPF can be used in userland
> or SmartNICs, this uses the more generic "Platform-specific helper functions"
> term as suggested by David Vernet, rather than the kernel specific "kfuncs".
> 
> ---
> V1 -> V2: addressed comments from David Vernet
> 
> V2 -> V3: make descriptions in table consistent with updated names
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 63 +++++++++++++++++----------
>  Documentation/bpf/linux-notes.rst     |  4 ++
>  2 files changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 5e43e14abe8..f890bcd0dba 100644
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
> +BPF_CALL  0x8    0x0  call platform-agnostic helper function imm   see `Platform-agnostic helper functions`_
> +BPF_CALL  0x8    0x1  call PC += offset                            see `BPF-local functions`_
> +BPF_CALL  0x8    0x2  call platform-specific helper function imm   see `Platform-specific helper functions`_
> +BPF_EXIT  0x9    0x0  return                                       BPF_JMP only
> +BPF_JLT   0xa    any  PC += offset if dst < src                    unsigned
> +BPF_JLE   0xb    any  PC += offset if dst <= src                   unsigned
> +BPF_JSLT  0xc    any  PC += offset if dst < src                    signed
> +BPF_JSLE  0xd    any  PC += offset if dst <= src                   signed
> +========  =====  ===  ===========================================  =========================================
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
> +apply.  Platforms are not required to implement any platform-specific
> +functions.

I don't think it's a right distinction.
helper vs kfunc are just different mechanisms. Like old approach and new.
Both can be platform specific and agnostic.
Take bpf_inode_storage_get() or bpf_find_vma(),
I doubt anything like this will be available on non-Linux OS.
While bpf_obj_new_impl() might very well be in every OS.

> +
> +BPF-local functions
> +~~~~~~~~~~~~~~
> +BPF-local functions are functions exposed by the same BPF program as the caller,
> +and are referenced by offset from the call instruction, similar to ``BPF_JA``.
> +A ``BPF_EXIT`` within the BPF-local function will return to the caller.

Instead of saying 'BPF-local' may be use 'program local' ?
