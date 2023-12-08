Return-Path: <bpf+bounces-17256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33780AF53
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C8E1F21437
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCDE58ADE;
	Fri,  8 Dec 2023 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y92RLsVE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E010E0
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 14:04:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1f37fd4b53so279345466b.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 14:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702073060; x=1702677860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBgehNe6k0Xp2T8L0p5feAksACxSSvosWttsTL51fRc=;
        b=Y92RLsVEJyRkiyOieLyDss54/mrKH3wQCXVyDLomO2j6yvrlS8tfnJhDyrdXheAbAI
         BV+c6IM88fC8Y504XY60NDuV59yBobNVVBENdPv/qGUAjfFLhH4l9QUmvx9lk/f2TOOQ
         +n/sMk1WAYaTH1wnTBFrtMleLipxXOM5cU2C8HgDrzBlkykrvjsxZpoqICk8Mh262GPz
         yNcE5OwCOz9odyZAan6ZlVq5BRyoxGa0mJh/LuqcPvuexXtkp/ilk/nft/3ckKnn8MzH
         X9MJwOTpfjeKZg/QTE4vF6Cv+gg/v0mcrskDs2zcLYGzfvEl121t7h4akWYBHGHT3mwt
         sU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073060; x=1702677860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBgehNe6k0Xp2T8L0p5feAksACxSSvosWttsTL51fRc=;
        b=ceC4MHQ5IQzuQcmgDm4+UmgAibVzk0DhyaOs3fsLPERNbnhal5sLhd7kLuYeiHwvm3
         GktzaKVUSgaZKFKLVEKFwsddeIim89SL2MExp+56A87BgoGg7e5jk4xmPxSgX3hnLaED
         MypOJT4knqfXDAEVrwg5sZzaJgTOy1XlyyNwd5ZFnYTbIUpxSYltRPmdM/lxcIyvFzWU
         a2+mXgOP/1BgBDNeaSFWUYXZoQ/7W8qoI2Gf3m+9jLg8Emdh8RMGzDzsDVrHFrvjLYwD
         XQ+A7YPEFH+I82mWCb3PJBYwEdqQ0vdSQ5PF97G/Wx2mYmjlhJYM1MizL8XyqBFp6h7O
         QYGg==
X-Gm-Message-State: AOJu0YxcgxpVcdKN7h/livCxBAttYlKq3KSVzcgQN6JfY3/dJqDjudjw
	kUeFOBa5ut7FRrKILlq39hroT+HF3Un6VVMmQO0=
X-Google-Smtp-Source: AGHT+IEy7m/3dZwuG3m5fiZogRVuklLwaw6agPhYEK+7VBsoIi4U1prttylSWtRZJg+IvcJpltr/0ojIGb+uomApoqI=
X-Received: by 2002:a17:906:7056:b0:a19:a1ba:da6f with SMTP id
 r22-20020a170906705600b00a19a1bada6fmr312853ejj.150.1702073059683; Fri, 08
 Dec 2023 14:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141030.1478753-1-aspsk@isovalent.com> <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com> <ZXNCB5sEendzNj6+@zh-lab-node-5>
In-Reply-To: <ZXNCB5sEendzNj6+@zh-lab-node-5>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 14:04:07 -0800
Message-ID: <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:22=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> On Thu, Dec 07, 2023 at 07:45:32PM -0800, Alexei Starovoitov wrote:
> > On Wed, Dec 6, 2023 at 6:13=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > +
> > > +static __always_inline int __bpf_static_branch_jump(void *static_key=
)
> > > +{
> > > +       asm goto("1:\n\t"
> > > +               "goto %l[l_yes]\n\t"
> > > +               ".pushsection .jump_table, \"aw\"\n\t"
> > > +               ".balign 8\n\t"
> > > +               ".long 1b - .\n\t"
> > > +               ".long %l[l_yes] - .\n\t"
> > > +               ".quad %c0 - . + 1\n\t"
> > > +               ".popsection\n\t"
> > > +               :: "i" (static_key)
> > > +               :: l_yes);
> > > +       return 0;
> > > +l_yes:
> > > +       return 1;
> > > +}
> >
> > Could you add a test to patch 7 where the same subprog is
> > used by multiple main progs and another test where a prog
> > with static_keys is statically linked by libbpf into another prog?
> > I suspect these cases are not handled by libbpf in the series.
> > The adjustment of insn offsets is tricky and I don't see this logic
> > in patch 5.
> >
> > The special handling of JA insn (if it's listed in
> > static_branches_info[]) is fragile. The check_cfg() and the verifier
> > main loop are two places so far, but JA is an unconditional jump.
> > Every tool that understands BPF ISA would have to treat JA as "maybe
> > it's not a jump in this case" and that is concerning.
>
> Will do, thanks.
>
> > I certainly see the appeal of copy-pasting kernel's static_branch logic=
,
> > but we can do better since we're not bound by x86 ISA.
> >
> > How about we introduce a new insn JA_MAYBE insn, and check_cfg and
> > the verifier will process it as insn_idx +=3D insn->off/imm _or_ insn_i=
dx +=3D 1.
> > The new instruction will indicate that it may jump or fall through.
> > Another bit could be used to indicate a "default" action (jump vs
> > fallthrough) which will be used by JITs to translate into nop or jmp.
> > Once it's a part of the instruction stream we can have bpf prog callabl=
e
> > kfunc that can flip JA_MAYBE target
> > (I think this feature is missing in the patch set. It's necessary
> > to add an ability for bpf prog to flip static_branch. Currently
> > you're proposing to do it from user space only),
> > and there will be no need to supply static_branches_info[] at prog load=
 time.
> > The libbpf static linking will work as-is without extra code.
> >
> > JA_MAYBE will also remove the need for extra bpf map type.
> > The bpf prog can _optionally_ do '.long 1b - .' asm trick and
> > store the address of JA_MAYBE insn into an arbitrary 8 byte value
> > (either in a global variable, a section or somewhere else).
> > I think it's necessary to decouple patching of JA_MAYBE vs naming
> > the location.
> > The ".pushsection .jump_table" should be optional.
> > The kernel's static_key approach hard codes them together, but
> > it's due to x86 limitations.
> > We can introduce JA_MAYBE and use it everywhere in the bpf prog and
> > do not add names or addresses next to them. Then 'bpftool prog dump' ca=
n
> > retrieve the insn stream and another command can patch a specific
> > instruction (because JA_MAYBE is easy to spot vs regular JA).
> > At the end it's just a text_poke_bp() to convert
> > a target of JA_MAYBE.
> > The bpf prog can be written with
> >  asm goto("go_maybe +0, %l[l_yes]")
> > without names and maps, and the jumps will follow the indicated
> > 'default' branch (how about, the 1st listed is default, the 2nd is
> > maybe).
> > The kernel static keys cannot be flipped atomically anyway,
> > so multiple branches using the same static key is equivalent to an
> > array of addresses that are flipped one by one.
>
> Thanks for the detailed review. You're right, without adding a new
> instruction non-kernel observers can't distinguish between a JA and a
> "static branch JA". This also makes sense to encode direct/inverse flag a=
s
> well (and more, see below). I would call the new instruction something li=
ke
> JA_CFG, emphasizing the fact that this is a JA which can be configured by
> an external force.
>
> We also can easily add a kfunc API, however, I am for keeping the "map AP=
I"
> in place (in addition to more fine-grained API you've proposed). See my
> considerations and examples below.
>
> > I suspect the main use case for isovalent is to compile a bpf prog
> > with debug code that is not running by default and then flip
> > various parts when debugging is necessary.
> > With JA_MAYBE it's still going to be bpf_static_branch_[un]likely(),
> > but no extra map and the prog will load fine. Then you can patch
> > all of such insns or subset of them on demand.
> > (The verifier will allow patching of JA_MAYBE only between two targets,
> > so no safety issues).
> > I think it's more flexible than the new map type and static_branches_in=
fo[].
> > wdyt?
>
> Here is how I think about API. Imagine that we have this new instruction,
> JA_CFG, and that a program uses it in multiple places. If we don't mark
> those instructions, then after compilation an external observer can't
> distinguish between them. We don't know if this is supposed to be
> instructions controlled by one key or another. We may care about this, sa=
y,
> when a program uses key A for enabling/disabling debug and key B to
> enable/disable another optional feature.
>
> If we push offsets of jumps in a separate section via the "'.long 1b - .'
> asm trick", then we will have all the same problems with relocations whic=
h
> is fragile, as you've shown. What we can do instead is to encode "local k=
ey
> id" inside the instruction. This local_id is local to the program where i=
t
> is used. (We can use 4 bits in, say, dst_reg, or 16 bits of unused
> offset/imm, as one of them will be unused. As for me, 4 may be enough for
> the initial implementation.) This way we can distinguish between differen=
t
> keys in one program, and a new `bpf_static_key_set_prog(prog, key_id, val=
ue)`
> kfunc can be used to toggle this key on/off for a particular program. Thi=
s
> way we don't care about relocation, and API is straightforward.

I feel like embedding some sort of ID inside the instruction is very..
unusual, shall we say?

When I was reading commit messages and discussion, I couldn't shake
the impression that this got to be solved with the help of
relocations. How about something like below (not very well thought
out, sorry) for how this can be put together both from user-space and
kernel sides.

1. We can add a special SEC(".static_keys") section, in which we
define special global variables representing a static key. These
variables will be forced to be global to ensure unique names and stuff
like that.

2. bpf_static_branch_{likely,unlikely}() macro accepts a reference to
one such special global variable and and instructs compiler to emit
relocation between static key variable and JMP_CFG instruction.

Libbpf will properly update these relocations during static linking
and subprog rearrangement, just like we do it for map references
today.

3. libbpf takes care of creating a special map (could be ARRAY with a
special flag, but a dedicated map with multiple entries might be
cleaner), in which each static key variable is represented as a
separate key.

3.5 When libbpf loads BPF program, I guess it will have to upload a
multi-mapping from static_key_id to insn_off (probably we should allow
multiple inst_offs per one static_key_id), so that kernel can identify
which instructions are to be updated.

4. Similar to SEC(".kconfig") libbpf will actually also have a
read-only global variables map, where each variable's value is static
key integer ID that corresponds to a static key in that special map
from #3. This allows user-space to easily get this ID without
hard-coding or guessing anything, it's just

int static_key_id =3D skel->static_keys->my_static_key;

Then you can do bpf_map_update_elem(&skel->maps.static_key_map,
&static_key_id, 0/1) to flip the switch from user-space.

5. From the BPF side we use global variable semantics similarly to
obtain integer key, then we can use a dedicated special kfunc that
will accept prog, static_key_id, and desired state to flip that jump
whichever way.


So on BPF side it will look roughly like this:

int static_key1 SEC(".static_keys");

...

if (bpf_static_key_likely(&static_key1)) {
   ...
}

...

/* to switch it on or off */
bpf_static_key_switch(&static_key1, 1);


From user-space side I basically already showed:


bpf_map_update_elem(bpf_map__fd(skel->static_keys->static_key1),
                    &skel->static_keys->static_key1, 1);


Something along these lines.


>
> However, if this is the only API we provide, then this makes user's life
> hard, as they will have to keep track of ids, and programs used, and
> mapping from "global" id to local ids for each program (when multiple
> programs use the same static key, which is desirable). If we keep the
> higher-level "map API", then this simplifies user's life: on a program lo=
ad
> a user can send a list of (local_id -> map) mappings, and then toggle all
> the branches controlled by "a [global] static key" by either
>
>     bpf(MAP_UPDATE_ELEM, map, value)
>
> or
>
>     kfunc bpf_static_key_set(map, value)
>
> whatever is more useful. (I think that keeping the bpf(2) userspace API i=
s
> worth doing it, as otherwise this, again, makes life harder: users would
> have to recompile/update iterator programs if new programs using a static
> key are added, etc.)
>
> Libbpf can simplify life even more by automatically allocating local ids
> and passing mappings to kernel for a program from the
> `bpf_static_branch_{unlikely,likely}(&map)`, so that users don't ever thi=
ng
> about this, if don't want to. Again, no relocations are required here.
>
> So, to summarize:
>
>   * A new instruction BPF_JA_CFG[ID,FLAGS,OFFSET] where ID is local to th=
e
>     program, FLAGS is 0/1 for normal/inverse branches
>

+1 for a dedicated instruction


>   * A new kfunc `bpf_static_key_set_prog(prog, key_id, value)` which
>     toggles all the branches with ID=3Dkey_id in the given prog
>
>   * Extend bpf_attr with a list of (local_id -> map) mappings. This is an
>     optinal list if user doesn't want one or all branches to be controlle=
d
>     by a map
>
>   * A new kfunc `bpf_static_key_set(map, value)` which toggles all the
>     static branches in all programs which use `map` to control branches
>
>   * bpf(2, MAP_UPDATE_ELEM, map, value) acts as the previous kfunc, but i=
n
>     a single syscall without the requirement to create iterators

Let's see if my above proposal fits this as a way to simplify
allocating static key IDs and keeping them in sync between BPF and
user-space sides.

