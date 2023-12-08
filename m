Return-Path: <bpf+bounces-17197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677380A8A7
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825CCB20B4E
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365DC374EC;
	Fri,  8 Dec 2023 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="JapmRTTW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41245123
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 08:22:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1d450d5c11so293984266b.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 08:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1702052557; x=1702657357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MJAkN2KIbr5vY+hfpEqPU9lqyUB0UwFFRe1CtUVHCs=;
        b=JapmRTTWqmDsYpNdpriS/g1ZTQ+1/50HKuQgNPPg7QPz2JVHd5Ba2wBooHte+SS6bH
         pIDR3S2Vy/5kuoP1L2jj3/xFsX/dZp7fCQthOijdFdPBc2C5D2nXHFdBGuDhPzvjW/tT
         tIfda99WoZu69xWBpJ/poXzVzALaHIrZTAaz2z342ExZin+wQG3m/W54gTv6ofu1JMYG
         TkDJwVOyG2eAgxxspweQQHyEoDJAhU78dBXktirQnAhsD+4DLe/lAaQ65K/iovF1CVIu
         O66FB7Zd97SLGRQe9+w8XyOAwZ0WK1cqrP7fJbwkqD3wmWTk3v10qZZmMcx5RVAndPrj
         Ro4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052557; x=1702657357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MJAkN2KIbr5vY+hfpEqPU9lqyUB0UwFFRe1CtUVHCs=;
        b=uQCShTiUGulf9YZ3zmOz4RxghAJ6ywx+Mmknf85Ol/OGFnOrEBX9oVyJahaZ/UAMWt
         7xD2OP0n0fYViORl8obqUOOx243pvI9yXM+MIY9P8/k1TbnERNUE5xfOk0UfifHJ1ker
         TfFolTo5AoULFdHWQE2z8nFKhGc9K9NiCHjMat6hNikBwPkEp5mnZ0+H+pF4VV2TMdaE
         iB0ZkqQKf91V9wlacV8PaNeMP6iitOcQZA23mGJGDTywyRaBgezEnYK9ZCKvKsTZGQbz
         GAkpcX2qLlTXW9QwL59tEHJpQuI/Audg1w2ZAeIGUbTSzLuhITDkREchmNkAKulSAQ2F
         sFhg==
X-Gm-Message-State: AOJu0Yz/kSkrqvbMqQym22k43VLcHFV9kyC7QqsktGcCrpSIzS39dKGM
	0iuaaBW4m54DK/oyI5wkQLPxXw==
X-Google-Smtp-Source: AGHT+IHuzTvuhi1aZ8VDjxsl8B3z7LiOsiOH+2SH9Lc/GlSJ+pjo9C65WQV66VTfEzme1U+JChaM5w==
X-Received: by 2002:a17:907:2d28:b0:a03:a857:c6e0 with SMTP id gs40-20020a1709072d2800b00a03a857c6e0mr138124ejc.77.1702052556572;
        Fri, 08 Dec 2023 08:22:36 -0800 (PST)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id hd10-20020a170907968a00b009fcb5fcfbe6sm1168898ejc.220.2023.12.08.08.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:22:36 -0800 (PST)
Date: Fri, 8 Dec 2023 16:19:19 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Message-ID: <ZXNCB5sEendzNj6+@zh-lab-node-5>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
 <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>

On Thu, Dec 07, 2023 at 07:45:32PM -0800, Alexei Starovoitov wrote:
> On Wed, Dec 6, 2023 at 6:13 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > +
> > +static __always_inline int __bpf_static_branch_jump(void *static_key)
> > +{
> > +       asm goto("1:\n\t"
> > +               "goto %l[l_yes]\n\t"
> > +               ".pushsection .jump_table, \"aw\"\n\t"
> > +               ".balign 8\n\t"
> > +               ".long 1b - .\n\t"
> > +               ".long %l[l_yes] - .\n\t"
> > +               ".quad %c0 - . + 1\n\t"
> > +               ".popsection\n\t"
> > +               :: "i" (static_key)
> > +               :: l_yes);
> > +       return 0;
> > +l_yes:
> > +       return 1;
> > +}
> 
> Could you add a test to patch 7 where the same subprog is
> used by multiple main progs and another test where a prog
> with static_keys is statically linked by libbpf into another prog?
> I suspect these cases are not handled by libbpf in the series.
> The adjustment of insn offsets is tricky and I don't see this logic
> in patch 5.
> 
> The special handling of JA insn (if it's listed in
> static_branches_info[]) is fragile. The check_cfg() and the verifier
> main loop are two places so far, but JA is an unconditional jump.
> Every tool that understands BPF ISA would have to treat JA as "maybe
> it's not a jump in this case" and that is concerning.

Will do, thanks.

> I certainly see the appeal of copy-pasting kernel's static_branch logic,
> but we can do better since we're not bound by x86 ISA.
> 
> How about we introduce a new insn JA_MAYBE insn, and check_cfg and
> the verifier will process it as insn_idx += insn->off/imm _or_ insn_idx += 1.
> The new instruction will indicate that it may jump or fall through.
> Another bit could be used to indicate a "default" action (jump vs
> fallthrough) which will be used by JITs to translate into nop or jmp.
> Once it's a part of the instruction stream we can have bpf prog callable
> kfunc that can flip JA_MAYBE target
> (I think this feature is missing in the patch set. It's necessary
> to add an ability for bpf prog to flip static_branch. Currently
> you're proposing to do it from user space only),
> and there will be no need to supply static_branches_info[] at prog load time.
> The libbpf static linking will work as-is without extra code.
> 
> JA_MAYBE will also remove the need for extra bpf map type.
> The bpf prog can _optionally_ do '.long 1b - .' asm trick and
> store the address of JA_MAYBE insn into an arbitrary 8 byte value
> (either in a global variable, a section or somewhere else).
> I think it's necessary to decouple patching of JA_MAYBE vs naming
> the location.
> The ".pushsection .jump_table" should be optional.
> The kernel's static_key approach hard codes them together, but
> it's due to x86 limitations.
> We can introduce JA_MAYBE and use it everywhere in the bpf prog and
> do not add names or addresses next to them. Then 'bpftool prog dump' can
> retrieve the insn stream and another command can patch a specific
> instruction (because JA_MAYBE is easy to spot vs regular JA).
> At the end it's just a text_poke_bp() to convert
> a target of JA_MAYBE.
> The bpf prog can be written with
>  asm goto("go_maybe +0, %l[l_yes]")
> without names and maps, and the jumps will follow the indicated
> 'default' branch (how about, the 1st listed is default, the 2nd is
> maybe).
> The kernel static keys cannot be flipped atomically anyway,
> so multiple branches using the same static key is equivalent to an
> array of addresses that are flipped one by one.

Thanks for the detailed review. You're right, without adding a new
instruction non-kernel observers can't distinguish between a JA and a
"static branch JA". This also makes sense to encode direct/inverse flag as
well (and more, see below). I would call the new instruction something like
JA_CFG, emphasizing the fact that this is a JA which can be configured by
an external force.

We also can easily add a kfunc API, however, I am for keeping the "map API"
in place (in addition to more fine-grained API you've proposed). See my
considerations and examples below.

> I suspect the main use case for isovalent is to compile a bpf prog
> with debug code that is not running by default and then flip
> various parts when debugging is necessary.
> With JA_MAYBE it's still going to be bpf_static_branch_[un]likely(),
> but no extra map and the prog will load fine. Then you can patch
> all of such insns or subset of them on demand.
> (The verifier will allow patching of JA_MAYBE only between two targets,
> so no safety issues).
> I think it's more flexible than the new map type and static_branches_info[].
> wdyt?

Here is how I think about API. Imagine that we have this new instruction,
JA_CFG, and that a program uses it in multiple places. If we don't mark
those instructions, then after compilation an external observer can't
distinguish between them. We don't know if this is supposed to be
instructions controlled by one key or another. We may care about this, say,
when a program uses key A for enabling/disabling debug and key B to
enable/disable another optional feature.

If we push offsets of jumps in a separate section via the "'.long 1b - .'
asm trick", then we will have all the same problems with relocations which
is fragile, as you've shown. What we can do instead is to encode "local key
id" inside the instruction. This local_id is local to the program where it
is used. (We can use 4 bits in, say, dst_reg, or 16 bits of unused
offset/imm, as one of them will be unused. As for me, 4 may be enough for
the initial implementation.) This way we can distinguish between different
keys in one program, and a new `bpf_static_key_set_prog(prog, key_id, value)`
kfunc can be used to toggle this key on/off for a particular program. This
way we don't care about relocation, and API is straightforward.

However, if this is the only API we provide, then this makes user's life
hard, as they will have to keep track of ids, and programs used, and
mapping from "global" id to local ids for each program (when multiple
programs use the same static key, which is desirable). If we keep the
higher-level "map API", then this simplifies user's life: on a program load
a user can send a list of (local_id -> map) mappings, and then toggle all
the branches controlled by "a [global] static key" by either

    bpf(MAP_UPDATE_ELEM, map, value)

or

    kfunc bpf_static_key_set(map, value)

whatever is more useful. (I think that keeping the bpf(2) userspace API is
worth doing it, as otherwise this, again, makes life harder: users would
have to recompile/update iterator programs if new programs using a static
key are added, etc.)

Libbpf can simplify life even more by automatically allocating local ids
and passing mappings to kernel for a program from the
`bpf_static_branch_{unlikely,likely}(&map)`, so that users don't ever thing
about this, if don't want to. Again, no relocations are required here.

So, to summarize:

  * A new instruction BPF_JA_CFG[ID,FLAGS,OFFSET] where ID is local to the
    program, FLAGS is 0/1 for normal/inverse branches

  * A new kfunc `bpf_static_key_set_prog(prog, key_id, value)` which
    toggles all the branches with ID=key_id in the given prog

  * Extend bpf_attr with a list of (local_id -> map) mappings. This is an
    optinal list if user doesn't want one or all branches to be controlled
    by a map

  * A new kfunc `bpf_static_key_set(map, value)` which toggles all the
    static branches in all programs which use `map` to control branches

  * bpf(2, MAP_UPDATE_ELEM, map, value) acts as the previous kfunc, but in
    a single syscall without the requirement to create iterators

