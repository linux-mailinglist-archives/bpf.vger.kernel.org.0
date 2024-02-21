Return-Path: <bpf+bounces-22355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE36885CD3D
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A121F23839
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C82D1FD7;
	Wed, 21 Feb 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyDeUjnD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC417D5
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477791; cv=none; b=UZmmvfCCQgb+b/PhCxg8Y4Jae/ZDlJYJWxUspOCwQh640G0Ubemw3UHguOW4NSLXLrt06ZuHYSTQcOnolb61IVglmLkTH+DM/s8a06syaX65H0xFk5iaNKWVh/DPdi4qNlVQRv0yM+7lnqUxX+kHS6X5PeTIgE+BQ+ZYPpsDYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477791; c=relaxed/simple;
	bh=jpz0Zlo6xAqcuN3tZICjxIkw7UIKOWx10DM58uk5GL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBfj+T1JTrXolZ8sWtPVUqf2/eHjWzTxISuGIM+pc9hdEjBGEB4IQNWmCFEim17EcQ1Ir5unSLfCG0TaAL0f3ZKOk2HWjvoGD4gs0Id/XVyn05kSzB8cJcAmlwDlTZOkDuBfglPab2jn8lyNu1OKI9N+3cripNuCC7htg3vI6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyDeUjnD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d4c0b198aso42684f8f.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708477788; x=1709082588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8xPOc+FrsqWQWJMdY+fQQMqoKy7J53Ggwzsjb8lNOY=;
        b=eyDeUjnDqhN/2g2CrSwVQQyV+RSCfTNTOwagDb/AhmkBLfRVmpLiLMqKo+v0PcdE0d
         HXb8c2pKKn/1/UQyTwiNzbCMHH5zEiXzoFPcDNnFluA0mnnUoAdDqwJCcE8nfNPg0ii0
         IySr0EiMJZ6efWGqO0+iAJer3a+P/gpSHCkdGVLUIdxYbwOkMXf3KBy2zemYXiziakdJ
         TgrtbbIzPbTHNgo+gVHqYCvgJCMCbyaGPpb0b0Kwm7IRgslAN+49PAmcVBu1HGC0GhXT
         aFLWD6iwDsHKmZSNcA0gVoHVAKi+/abh34Gn1rGEcPQHk4QJKOaNeXeYE4JsJtV2lXDz
         NKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708477788; x=1709082588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8xPOc+FrsqWQWJMdY+fQQMqoKy7J53Ggwzsjb8lNOY=;
        b=mrn3/W+Jv3CTbLrnJNpfeGUHqz4JphkOvfTqJiqAQZh5YQZTg6ePGAQ13IwAPrmj4t
         Nr4kHZAwAuzv1D3xg2t4QC3OGkXDr3RAP2Ls+tCQpeiZS0zx2tcygYPFcmMa6I3nJ50a
         EO4G//tFMqenvlOuWFnheGGJpBxJHLhr/mB6BCkWIeabtHAW4jVMGElXm+OKgJVcZiSr
         DiTsmX3glREs88iY5yij3ccuZBFe3DLpdceG8JCVzQdiNBvhiSh6FXFAT5kFsQ2nTgZG
         GYJ+XJo3dfbTJ4fqwKW0/USE8TezpDmkV88+1RmfMqjICxvzuWgCB97u5f95rcq/aEto
         z+vA==
X-Forwarded-Encrypted: i=1; AJvYcCV6cJKnmIWvAcI96xaGQojUNhfoeZBtqDYhHNj0VwECuh1Hk5pu0tNpzi2lXWb/2J0s43x1Rhyllyc8ZGybTl+9sm6p
X-Gm-Message-State: AOJu0YzbFxXcos8kDdOtXikpwo/olstPGiibTBzc4cYoXM5qqiDC8pd3
	+UDjQxP+r7WtxAWHt3j1f4aIte0LDBzfAM5bYl2lX4bEkqeSb+U06sNwdAf+Vh/76IrLIwjkCSN
	bihzvjgWXqQ0F688GVkCPIecg5Fo=
X-Google-Smtp-Source: AGHT+IH4Qza55XcHT3I3t8raFkkr5PrUVKPNzaqBWn4ZFgjAqLCBkACE9g+NxPvQHlkDhkkQaPxuBxwtcANznSnOVFQ=
X-Received: by 2002:adf:e583:0:b0:33d:71e5:f556 with SMTP id
 l3-20020adfe583000000b0033d71e5f556mr1371031wrm.27.1708477787622; Tue, 20 Feb
 2024 17:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-1-aspsk@isovalent.com> <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5> <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5> <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
 <Zc9p4e1EccPkMnmY@zh-lab-node-5>
In-Reply-To: <Zc9p4e1EccPkMnmY@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Feb 2024 17:09:36 -0800
Message-ID: <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 6:04=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On Wed, Feb 14, 2024 at 10:48:26PM -0800, Alexei Starovoitov wrote:
> > On Thu, Feb 8, 2024 at 3:11=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoitov wrote:
> > > > On Tue, Feb 6, 2024 at 2:08=E2=80=AFAM Anton Protopopov <aspsk@isov=
alent.com> wrote:
> > > > >
> > > > > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov wrot=
e:
> > > > > > On Fri, Feb 2, 2024 at 8:34=E2=80=AFAM Anton Protopopov <aspsk@=
isovalent.com> wrote:
> > > > > > >
> > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > > > > --- a/include/linux/bpf.h
> > > > > > > +++ b/include/linux/bpf.h
> > > > > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > > > > >         };
> > > > > > >         /* an array of original indexes for all xlated instru=
ctions */
> > > > > > >         u32 *orig_idx;
> > > > > > > +       /* for every xlated instruction point to all generate=
d jited
> > > > > > > +        * instructions, if allocated
> > > > > > > +        */
> > > > > > > +       struct {
> > > > > > > +               u32 off;        /* local offset in the jitted=
 code */
> > > > > > > +               u32 len;        /* the total len of generated=
 jit code */
> > > > > > > +       } *xlated_to_jit;
> > > > > >
> > > > > > Simply put Nack to this approach.
> > > > > >
> > > > > > Patches 2 and 3 add an extreme amount of memory overhead.
> > > > > >
> > > > > > As we discussed during office hours we need a "pointer to insn"=
 concept
> > > > > > aka "index on insn".
> > > > > > The verifier would need to track that such things exist and adj=
ust
> > > > > > indices of insns when patching affects those indices.
> > > > > >
> > > > > > For every static branch there will be one such "pointer to insn=
".
> > > > > > Different algorithms can be used to keep them correct.
> > > > > > The simplest 'lets iterate over all such pointers and update th=
em'
> > > > > > during patch_insn() may even be ok to start.
> > > > > >
> > > > > > Such "pointer to insn" won't add any memory overhead.
> > > > > > When patch+jit is done all such "pointer to insn" are fixed val=
ue.
> > > > >
> > > > > Ok, thanks for looking, this makes sense.
> > > >
> > > > Before jumping into coding I think it would be good to discuss
> > > > the design first.
> > > > I'm thinking such "address of insn" will be similar to
> > > > existing "address of subprog",
> > > > which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> > > > "address of insn" would be a bit more involved to track
> > > > during JIT and likely trivial during insn patching,
> > > > since we're already doing imm adjustment for pseudo_func.
> > > > So that part of design is straightforward.
> > > > Implementation in the kernel and libbpf can copy paste from pseudo_=
func too.
> > >
> > > To implement the "primitive version" of static branches, where the
> > > only API is `static_branch_update(xlated off, on/off)` the only
> > > requirement is to build `xlated -> jitted` mapping (which is done
> > > in JIT, after the verification). This can be done in a simplified
> > > version of this patch, without xlated->orig mapping and with
> > > xlated->jit mapping only done to gotol_or_nop instructions.
> >
> > yes. The array of insn->jit_addr sized with as many goto_or_nop-s
> > the prog will work for user space to flip them, but...
> >
> > > The "address of insn" appears when we want to provide a more
> > > higher-level API when some object (in user-space or in kernel) keeps
> > > track of one or more gotol_or_nop instructions so that after the
> > > program load this controlling object has a list of xlated offsets.
> > > But this would be a follow-up to the initial static branches patch.
> >
> > this won't work as a follow up,
> > since such an array won't work for bpf prog that wants to flip branches=
.
> > There is nothing that associates static_branch name/id with
> > particular goto_or_nop.
> > There could be a kfunc that bpf prog calls, but it can only
> > flip all of such insns in the prog.
> > Unless we start encoding a special id inside goto_or_nop or other hacks=
.
> >
> > > > The question is whether such "address of insn" should be allowed
> > > > in the data section. If so, we need to brainstorm how to
> > > > do it cleanly.
> > > > We had various hacks for similar things in the past. Like prog_arra=
y.
> > > > Let's not repeat such mistakes.
> > >
> > > So, data section is required for implementing jump tables? Like,
> > > to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
> > > corresponding "ptr to insn" object for every occurence of &&label,
> > > which will be adjusted during verification.
> > > Looks to me like this one doesn't require any more API than specifyin=
g
> > > a list of &&label occurencies on program load.
> > >
> > > For "static keys" though (a feature on top of this patch series) we
> > > need to have access to the corresponding set of adjusted pointers.
> > >
> > > Isn't this enough to add something like an array of
> > >
> > >   struct insn_ptr {
> > >       u32 type; /* LABEL, STATIC_BRANCH,... */
> > >       u32 insn_off; /* original offset on load */
> > >       union {
> > >           struct label {...};
> > >           struct st_branch { u32 key_id, ..};
> > >       };
> > >   };
> >
> > which I don't like because it hard codes static_branch needs into
> > insn->jit_addr association.
> > "address of insn" should be an individual building block without
> > bolted on parts.
> >
> > A data section with a set of such "address of insn"
> > can be a description of one static_branch.
> > There will be different ways to combine such building blocks.
> > For example:
> > static_branch(foo) can emit goto_or_nop into bpf code
> > and add "address of insn" into a section '.insn_addrs.foo".
> > This section is what libbpf and bpf prog will recognize as a set
> > of "address of insn" that can be passed into static_branch_update kfunc
> > or static_branch_update sys_bpf command.
> > The question is whether we need a new map type (array derivative)
> > to hold a set of "address of insn" or it can be a part of an existing
> > global data array.
> > A new map type is easier to reason about.
> > Notice how such a new map type is not a map type of static branches.
> > It's not a map type of goto_or_nop instructions either.
> >
> > At load time libbpf can populate this array with indices of insns
> > that the verifier and JIT need to track. Once JITed the array is readon=
ly
> > for bpf prog and for user space.
>
> So this will be a map per .insn_addrs.X section (where X is key or
> a pre-defined suffix for jump tables or indirect calls). And to tell
> the verifier about these maps we will need to pass an array of
>
>     struct {
>             u32 map_fd;
>             u32 type; /* static key, jump table, etc. */
>     }
>
> on program load. Is this correct?

Probably not.
Since we're going with a new map type (at least for the sake of this
discussion) it shouldn't need a new way to tell the verifier about it.
If .insn_addrs.jmp_table_A was a section generated for switch() statement
by llvm it will be created as a map by libbpf,
and there will be an ld_imm64 insn generated by llvm that points
to that map.
libbpf will populate ld_imm64 insn with map_fd, just like it does
for global data.

> > With that mechanism compilers can generate a proper switch() jmp table.
> > llvm work can be a follow up, of course, but the whole design needs
> > to be thought through to cover all use cases.
> >
> > To summarize, here's what I'm proposing:
> > - PTR_TO_INSN verifier regtype that can be passed to static_branch_upda=
te kfunc
>
> If we have a set of pointers to jump instructions, generated from
> static_branch(foo) for same foo, then this makes more sense to
> provide a
>
>     static_branch_update(foo)

For bpf_static_branch_update(&foo) kfunc there will be another
ld_imm64 insn that points to that map.
No need for new interface here either.

> (where foo is substituted by libbpf with a map fd of .insn_addrs.foo
> on load). The same for userspace:
>
>     bpf(STATIC_BRANCH_UPDATE, .attrs=3D{.map_fd=3Dfoo})

but for libbpf it would be nice to have a helper that knows
this .insn_addrs section details.

> > - new map type (array) that holds objects that are PTR_TO_INSN for the =
verifier
> > libbpf populates this array with indices of insn it wants to track.
> > bpf prog needs to "use" this array, so prog/map association is built.
> > - verifier/JIT update each PTR_TO_INSN during transformations.
> > - static_branch(foo) macro emits goto_or_nop insn and adds 8 bytes
> > into ".insn_addrs.foo" section with an ELF relocation that
> > libbpf will convert into index.
> >
> > When compilers implement jmptables for switch(key) they will generate
> > ".insn_addrs.uniq_suffix" sections and emit
> > rX =3D ld_imm64 that_section
> > rX +=3D switch_key
> > rY =3D *(u64 *)rX
> > jmpx rY
>
> What are the types for rX and rY? I thought that we will need to do
> smth like
>
>   rX =3D .insn_addrs.uniq_suffix[switch_key] /* rX has type PTR_TO_INSN *=
/
>   ...
>   jmpx rX

right. That ".insn_addrs.uniq_suffix[switch_key]" C syntax is exactly:
  rX =3D ld_imm64 that_section
  rX +=3D switch_key
in assembly.

>
> this can be done if for switch cases (or any other goto *label alike) we =
generate
>
>   rX =3D map_lookup_elem(.insn_addrs.uniq_suffix, index)
>   jmpx rX

No need for function calls.
  rX =3D ld_imm64 that_section
  rX +=3D switch_key

should work.

It works for global variables already, like:
  rX =3D ld_imm64 global_data_array_map
  rX +=3D 8 // address of 2nd u64 in global data

