Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9100F6C9239
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 05:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCZD2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 23:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCZD2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 23:28:46 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A83B74F
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 20:28:42 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id x1so5533351qtr.7
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 20:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679801322;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCx0irQ+bkLAaFDlNYC29XYLlkzrJXQFhKX+XYQuWao=;
        b=VzEWl03m3mDZTZ9hWgrBnOsREhrxJRL7wLK13Q6tWEX857eCshzxsBe8/1pGqfYi1A
         h2jROhVxPo3Ys0lTHwQmj8v+kQETLgx7/oZz0NBaLS3eJ4wLWTzspEHTD0PnAznwEFL+
         jcgjlvo7Y7Jv0u6K79qryfiefMvNC22ydayaCL6uyv9dsDJkxvw7OrgXwFJINUHJtrkD
         5ryWLwVpEzrHxNa9ijQiDXQfpA2b38+sGxNWj3ZikLfi6refifv+aSseCAOP1QbRvQKI
         DiSU1SC7TDSruh0pRltFyGY+2j18zCvtu4oQLg7/PhQPa4xsW08jZSRvd/YV5d338YQP
         wGLw==
X-Gm-Message-State: AO0yUKXiq33sxk2YY69arTIs2eDN0weB06NSPkGFPNb6trCKhucyQrZ1
        S/bM1Fz1raQUlbgQkeBz6Ro=
X-Google-Smtp-Source: AK7set8yqKyUTTSKeJHweLqKGf2RvZuMVI/uwdY/tEcINkg2vmxbkTFpE6Fz2J439+WgBLz+GoHNdQ==
X-Received: by 2002:a05:622a:1648:b0:3db:f58b:400 with SMTP id y8-20020a05622a164800b003dbf58b0400mr13673892qtj.1.1679801321820;
        Sat, 25 Mar 2023 20:28:41 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id s20-20020a374514000000b00742bc037f29sm15529861qka.120.2023.03.25.20.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 20:28:41 -0700 (PDT)
Date:   Sat, 25 Mar 2023 22:28:39 -0500
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Add docs on extended 64-bit
 immediate instructions
Message-ID: <20230326032839.GF363182@maniforge>
References: <20230325224305.2157-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325224305.2157-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 25, 2023 at 10:43:05PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add docs on extended 64-bit immediate instructions, including six instructions
> previously undocumented.  Include a brief description of map objects, and variables,
> as used by those instructions.
> 
> ---
> V1 -> V2: rebased on top of latest master
> 
> V2 -> V3: addressed comments from Alexei
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 56 +++++++++++++++++++++++----
>  Documentation/bpf/linux-notes.rst     | 13 +++++++
>  2 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index db8789e6969..2c8347d63e7 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -385,14 +385,54 @@ and loaded back to ``R0``.
>  -----------------------------
>  
>  Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
> -encoding for an extra imm64 value.
> -
> -There is currently only one such instruction.
> -
> -``BPF_LD | BPF_DW | BPF_IMM`` means::
> -
> -  dst = imm64
> -
> +encoding defined in `Instruction encoding`_, and use the 'src' field of the
> +basic instruction to hold an opcode subtype.
> +
> +The following instructions are defined, and use additional concepts defined below:

nit: Perhaps this is a bit clearer? Wdyt?

The following opcode subtypes are defined for `BPF_IMM | BPF_DQ |
BPF_LD` instructions, with new terms such as "map" defined further
below:

> +
> +=========================  ======  ===  =========================================  ===========  ==============
> +opcode construction        opcode  src  pseudocode                                 imm type     dst type
> +=========================  ======  ===  =========================================  ===========  ==============
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                                integer      integer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                       integer      code pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                      map index    map
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
> +=========================  ======  ===  =========================================  ===========  ==============
> +
> +where
> +
> +* map_by_fd(imm) means to convert a 32-bit POSIX file descriptor into an address of a map object (see `Map objects`_)
> +* map_by_idx(imm) means to convert a 32-bit index into an address of a map object
> +* map_val(map) gets the address of the first value in a given map object
> +* var_addr(imm) gets the address of a platform variable (see `Platform Variables`_) with a given id
> +* code_addr(imm) gets the address of the instruction at a specified relative offset in number of (64-bit) instructions
> +* the 'imm type' can be used by disassemblers for display
> +* the 'dst type' can be used for verification and JIT compilation purposes
> +
> +Map objects
> +~~~~~~~~~~~
> +
> +Maps are shared memory regions accessible by eBPF programs on some platforms, where we use the term "map object"
> +to refer to an object containing the data and metadata (e.g., size) about the memory region.
> +A map can have various semantics as defined in a separate document, and may or may not have a single
> +contiguous memory region, but the 'map_val(map)' is currently only defined for maps that do have a single
> +contiguous memory region.
> +
> +Each map object can have a POSIX file descriptor (fd) if supported by the platform,
> +where 'map_by_fd(imm)' means to get the map with the specified file descriptor.
> +Each BPF program can also be defined to use a set of maps associated with the program
> +at load time, and 'map_by_idx(imm)' means to get the map with the given index in the set
> +associated with the BPF program containing the instruction.
> +
> +Platform Variables
> +~~~~~~~~~~~~~~~~~~
> +
> +Platform variables are memory regions, identified by integer ids, exposed by the runtime and accessible by BPF programs on
> +some platforms.  The 'var_addr(imm)' operation means to get the address of the memory region
> +identified by the given id.
>  
>  Legacy BPF Packet access instructions
>  -------------------------------------
> diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> index 956b0c86699..2d161467105 100644
> --- a/Documentation/bpf/linux-notes.rst
> +++ b/Documentation/bpf/linux-notes.rst
> @@ -12,6 +12,19 @@ Byte swap instructions
>  
>  ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
>  
> +Map objects
> +===========
> +
> +Linux only supports the 'map_val(map)' operation on array maps with a single element.
> +
> +Linux uses an fd_array to store maps associated with a BPF program. Thus,
> +map_by_index(index) uses the fd at that index in the array.
> +
> +Variables
> +=========
> +
> +Linux uses BTF ids to identify variables.

Not quite sure exactly what this means. Linux uses BTF ids to identify
_types_, right? This doesn't seem like something that needs to be
specified as Linux specific either, even if it's not yet supported
elsewhere. Certain legacy things such as Linux-specific helpers make
sense, but not sure about BTF ids.

> +
>  Legacy BPF Packet access instructions
>  =====================================
>  
> -- 
> 2.33.4
> 
> -- 
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf
