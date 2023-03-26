Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC56C9277
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 07:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjCZFAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 01:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCZFAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 01:00:22 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA383FB
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 22:00:20 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id x8so4675877qvr.9
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 22:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679806820;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuGZ97UW3R3q0cU4FGB1wEXWudmLjK1WOZkIXfL6ZY4=;
        b=2n80GCiY6R3w5lmLq2CW3MtO7LjKNBeOINa6rRKa5ud5DDg6FQaaIxOi2UEgqDLK1z
         WzYl22zq1TD4nZAOdNTp8R+NJ3Q8T2+34XY8jgxPxnY0DNiAlrvS0RvbKycnPtLIR6E0
         jvoVj+lEs41EHtsyDdpHnPl4ba9R71ddVJqXIGjdqc9TytYEltAh6HN/2zndMTzLsq4F
         +/zRPsav6BeH2U44PrxX535lwGf6e73fvqyVRwkzCVGuWYEirjmlERxwK4REGsLy66cI
         q2a7xGEHG7cuzHNUHQJaqL6/AUdQ8WPhTJb1t4SSMpS/Wv28GekIjl6+XlANzIaxT5Au
         ovfA==
X-Gm-Message-State: AAQBX9fOtj2CUzzRhu5QGXxkWMF4wQxoicX+VyR2NYm4VFNIr9dlinOZ
        RxJK8TVdSffvZQoQcNrFUCQbo5IM3tCEJPH4Fvk=
X-Google-Smtp-Source: AKy350atNXKpudhZ7gAS2dCQQxSyAQkn1VqObtqBOzdFkzYeGwZvAwsUnvvDtlWrb6B7as1dnWCQfA==
X-Received: by 2002:ad4:4eaf:0:b0:56e:a6f1:8cf with SMTP id ed15-20020ad44eaf000000b0056ea6f108cfmr13787965qvb.6.1679806819565;
        Sat, 25 Mar 2023 22:00:19 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id h15-20020a0cd80f000000b005dd8b93458fsm1937824qvj.39.2023.03.25.22.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 22:00:19 -0700 (PDT)
Date:   Sun, 26 Mar 2023 00:00:17 -0500
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Add docs on extended 64-bit
 immediate instructions
Message-ID: <20230326050017.GI363182@maniforge>
References: <20230325224305.2157-1-dthaler1968@googlemail.com>
 <20230326032839.GF363182@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326032839.GF363182@maniforge>
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

On Sat, Mar 25, 2023 at 10:28:39PM -0500, David Vernet wrote:
> On Sat, Mar 25, 2023 at 10:43:05PM +0000, Dave Thaler wrote:
> > From: Dave Thaler <dthaler@microsoft.com>
> > 
> > Add docs on extended 64-bit immediate instructions, including six instructions
> > previously undocumented.  Include a brief description of map objects, and variables,
> > as used by those instructions.
> > 
> > ---
> > V1 -> V2: rebased on top of latest master
> > 
> > V2 -> V3: addressed comments from Alexei
> > 
> > Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> > ---
> >  Documentation/bpf/instruction-set.rst | 56 +++++++++++++++++++++++----
> >  Documentation/bpf/linux-notes.rst     | 13 +++++++
> >  2 files changed, 61 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> > index db8789e6969..2c8347d63e7 100644
> > --- a/Documentation/bpf/instruction-set.rst
> > +++ b/Documentation/bpf/instruction-set.rst
> > @@ -385,14 +385,54 @@ and loaded back to ``R0``.
> >  -----------------------------
> >  
> >  Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
> > -encoding for an extra imm64 value.
> > -
> > -There is currently only one such instruction.
> > -
> > -``BPF_LD | BPF_DW | BPF_IMM`` means::
> > -
> > -  dst = imm64
> > -
> > +encoding defined in `Instruction encoding`_, and use the 'src' field of the
> > +basic instruction to hold an opcode subtype.
> > +
> > +The following instructions are defined, and use additional concepts defined below:
> 
> nit: Perhaps this is a bit clearer? Wdyt?
> 
> The following opcode subtypes are defined for `BPF_IMM | BPF_DQ |
> BPF_LD` instructions, with new terms such as "map" defined further
> below:

Oops, meant to say `BPF_IMM | BPF_DW | BPF_LD`

> 
> > +
> > +=========================  ======  ===  =========================================  ===========  ==============
> > +opcode construction        opcode  src  pseudocode                                 imm type     dst type
> > +=========================  ======  ===  =========================================  ===========  ==============
> > +BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                                integer      integer
> > +BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
> > +BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
> > +BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
> > +BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                       integer      code pointer
> > +BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                      map index    map
> > +BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
> > +=========================  ======  ===  =========================================  ===========  ==============
> > +
> > +where
> > +
> > +* map_by_fd(imm) means to convert a 32-bit POSIX file descriptor into an address of a map object (see `Map objects`_)
> > +* map_by_idx(imm) means to convert a 32-bit index into an address of a map object
> > +* map_val(map) gets the address of the first value in a given map object
> > +* var_addr(imm) gets the address of a platform variable (see `Platform Variables`_) with a given id
> > +* code_addr(imm) gets the address of the instruction at a specified relative offset in number of (64-bit) instructions
> > +* the 'imm type' can be used by disassemblers for display
> > +* the 'dst type' can be used for verification and JIT compilation purposes
> > +
> > +Map objects
> > +~~~~~~~~~~~
> > +
> > +Maps are shared memory regions accessible by eBPF programs on some platforms, where we use the term "map object"
> > +to refer to an object containing the data and metadata (e.g., size) about the memory region.
> > +A map can have various semantics as defined in a separate document, and may or may not have a single
> > +contiguous memory region, but the 'map_val(map)' is currently only defined for maps that do have a single
> > +contiguous memory region.
> > +
> > +Each map object can have a POSIX file descriptor (fd) if supported by the platform,
> > +where 'map_by_fd(imm)' means to get the map with the specified file descriptor.
> > +Each BPF program can also be defined to use a set of maps associated with the program
> > +at load time, and 'map_by_idx(imm)' means to get the map with the given index in the set
> > +associated with the BPF program containing the instruction.
> > +
> > +Platform Variables
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +Platform variables are memory regions, identified by integer ids, exposed by the runtime and accessible by BPF programs on
> > +some platforms.  The 'var_addr(imm)' operation means to get the address of the memory region
> > +identified by the given id.
> >  
> >  Legacy BPF Packet access instructions
> >  -------------------------------------
> > diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> > index 956b0c86699..2d161467105 100644
> > --- a/Documentation/bpf/linux-notes.rst
> > +++ b/Documentation/bpf/linux-notes.rst
> > @@ -12,6 +12,19 @@ Byte swap instructions
> >  
> >  ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
> >  
> > +Map objects
> > +===========
> > +
> > +Linux only supports the 'map_val(map)' operation on array maps with a single element.
> > +
> > +Linux uses an fd_array to store maps associated with a BPF program. Thus,
> > +map_by_index(index) uses the fd at that index in the array.
> > +
> > +Variables
> > +=========
> > +
> > +Linux uses BTF ids to identify variables.
> 
> Not quite sure exactly what this means. Linux uses BTF ids to identify
> _types_, right? This doesn't seem like something that needs to be
> specified as Linux specific either, even if it's not yet supported
> elsewhere. Certain legacy things such as Linux-specific helpers make
> sense, but not sure about BTF ids.

Ok, I read over this some more and I think I understand what the
intention was here. You were specifying that for the following
instruction encoding:

=========================  ======  ===  ===================  ===========  ============
opcode construction        opcode  src  pseudocode           imm type     dst type
=========================  ======  ===  ===================  ===========  ============
BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)  variable id  data pointer

imm is a BTF ID, and it is Linux-specific that var_addr(imm) happens to
be mapping a BTF ID to an actual variable address that is stored in dst.
Is that right? If so, I think this section needs to include a bit more
context so that it makes sense on its own. What about something like
this:

The following 64-bit immediate instruction specifies that a variable
address, which corresponds to some integer stored in the immediate
field, should be loaded:

=========================  ======  ===  =========================================  ===========  ==============
opcode construction        opcode  src  pseudocode                                 imm type     dst type
=========================  ======  ===  =========================================  ===========  ==============
BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer

On Linux, this integer is a BTF ID.

> > +
> >  Legacy BPF Packet access instructions
> >  =====================================
> >  
> > -- 
> > 2.33.4
> > 
> > -- 
> > Bpf mailing list
> > Bpf@ietf.org
> > https://www.ietf.org/mailman/listinfo/bpf
