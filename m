Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF06BA511
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 03:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCOCSN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 22:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjCOCSM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 22:18:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F2E1A97F
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 19:18:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso2405094pjc.1
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678846689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ8UbxHn4VfxLIb8+7cNiD/Quv5XkESBNHAD0gXgqFc=;
        b=Be+5Qd7rYCSlphmG7/ovnx4yGxpdI1ewvoAOmFXk1bMbyGDM8jk+/XZ0j++/KheDsw
         dRwwvGv4h9TQNcyHmTAN3s8dRlWrSL6dF3WGC6v/OX1TIvJGaS8+FvL8cl3aBFCEYq0q
         yKi1RbMFlyqHh8Gwb8BkDMdO73OM0xhqs7pVb0uGxnP2DOlWsnqpNtR61rtSkBQnEcQl
         der1Ub93Un3ZCpJBW9ZraQSZQEO6yNp1cbRyWE2RuZItD3rzSH/4OGy32m8UmGQq2A3m
         srOX00GH87EWdlMqzfYsmY2p6FUsng7Qi/J8Nc93u4xxiBlnpaExj65dlnqURjDkglOh
         z1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678846689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ8UbxHn4VfxLIb8+7cNiD/Quv5XkESBNHAD0gXgqFc=;
        b=bCDmMRzYJjC+jW0UIQravQZGLiw90tH+O8z810B8zTMdEu4k2Yb0C/RRPmpxn9hEX1
         RVczppnBhYA8m1gFV1mKWcFEGBq6G32aXmj81m5mSq2Oq8MKkg7hVPA4SKQ1gSxHyu12
         tY66cUW8LwCRjGMkaKV8ZESvI5U+FO+72MWww0pDYrJkX0l6GA3uKRi17nN5d0Tp3TPD
         sUHsG6HLZCxiZ9tkW1L4JaJnPntSBPqzm0p1iNbvTVtTHoxxo8Uue4kNnZatZjz7pLyw
         I2M+ziHC6TNnlqYqSANLeB0YzjpgEqMYmXd0nsQJXpN706OQKQQ+p5O7ghRVrKcD8H9L
         RKiA==
X-Gm-Message-State: AO0yUKUyC3uUCOMrdqx7+ApB+EYOc+7Gs4aQNlH3cJWL7sSM6WpXulS2
        9y8wk03MKigW0d7gupFBpV9iOc/Kn0I=
X-Google-Smtp-Source: AK7set9v4kZW9JrlvuR10hRwWxzGQ4HHeV9oNpadaeh0ignh8ktCRJzl2RdCmNx7qHcW2rfe0CwZTw==
X-Received: by 2002:a17:903:32c2:b0:19d:1d32:fbe with SMTP id i2-20020a17090332c200b0019d1d320fbemr1419610plr.20.1678846689584;
        Tue, 14 Mar 2023 19:18:09 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:2bcf])
        by smtp.gmail.com with ESMTPSA id lc16-20020a170902fa9000b0019f398ed834sm2372220plb.212.2023.03.14.19.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 19:18:09 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:18:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next v2 RESEND] bpf, docs: Add docs on extended
 64-bit immediate instructions
Message-ID: <20230315021806.zql4gok2abfkzdqw@macbook-pro-6.dhcp.thefacebook.com>
References: <20230308204623.959-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308204623.959-1-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 08, 2023 at 08:46:23PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add docs on extended 64-bit immediate instructions, including six instructions
> previously undocumented.  Include a brief description of map objects, and variables,
> as used by those instructions.
> 
> ---
> V1 - V2: rebased on top of latest master
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 56 +++++++++++++++++++++++----
>  Documentation/bpf/linux-notes.rst     | 10 +++++
>  2 files changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index db8789e6969..89087913fbf 100644
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
> +
> +=========================  ======  ===  =====================================  ===========  ==============
> +opcode construction        opcode  src  pseudocode                             imm type     dst type
> +=========================  ======  ===  =====================================  ===========  ==============
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                            integer      integer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                   map fd       map
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = mva(map_by_fd(imm)) + next_imm   map fd       data pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = variable_addr(imm)               variable id  data pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                   integer      code pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                  map index    map
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = mva(map_by_idx(imm)) + next_imm  map index    data pointer
> +=========================  ======  ===  =====================================  ===========  ==============
> +
> +where
> +
> +* map_by_fd(fd) means to convert a 32-bit POSIX file descriptor into an address of a map object (see `Map objects`_)

should it be map_by_fd(imm) here or map_by_fd(fd) in the table?
let's make it consistent.

> +* map_by_index(index) means to convert a 32-bit index into an address of a map object

Should it be map_by_idx to match the table?

> +* mva(map) gets the address of the first value in a given map object

'mva' looks to cryptic especially, since it's first introduced in the table and explained later.

Maybe use map_val(map) ?

> +* variable_addr(id) gets the address of a variable (see `Variables`_) with a given id

var_addr(imm) to make it shorter?

> +* code_addr(offset) gets the address of the instruction at a specified relative offset in units of 64-bit blocks

code_addr(imm) for consistency?

instead of "units of 64-bit blocks" it's better to use "in number of instructions".

> +* the 'imm type' can be used by disassemblers for display
> +* the 'dst type' can be used for verification and JIT compilation purposes
> +
> +Map objects
> +~~~~~~~~~~~
> +
> +Maps are shared memory regions accessible by eBPF programs on some platforms, where we use the term "map object"
> +to refer to an object containing the data and metadata (e.g., size) about the memory region.
> +A map can have various semantics as defined in a separate document, and may or may not have a single
> +contiguous memory region, but the 'mva(map)' is currently only defined for maps that do have a single
> +contiguous memory region.  Support for maps is optional.

I'm not sure why mention "Support for maps is optional." at all.
BPF can be used without programs too. The user space can use bpf maps as a storage for user space data.
Should we say "Support for programs is optional." ?
I suggest to drop that sentence.

> +
> +Each map object can have a POSIX file descriptor (fd) if supported by the platform,
> +where 'map_by_fd(fd)' means to get the map with the specified file descriptor.
> +Each eBPF program can also be defined to use a set of maps associated with the program
> +at load time, and 'map_by_index(index)' means to get the map with the given index in the set
> +associated with the eBPF program containing the instruction.

"in the set associated"
I think it needs to be clarified. No one will understand that this part refers to 'fd_array'.

> +
> +Variables
> +~~~~~~~~~
> +
> +Variables are memory regions, identified by integer ids, accessible by eBPF programs on
> +some platforms.  The 'variable_addr(id)' operation means to get the address of the memory region
> +identified by the given id.  Support for such variables is optional.

"Support for such variables is optional."
Unnecessary statement. Equally confusing.

It's probably worth clarifying that var_addr() is the address of kernel variable
and not a bpf program variable.
