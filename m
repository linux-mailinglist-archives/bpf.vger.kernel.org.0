Return-Path: <bpf+bounces-66210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AD0B2F982
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 15:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1588A3BA02D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE72322763;
	Thu, 21 Aug 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arnTFycw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E131CA59
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781259; cv=none; b=QxR7vlc4Ia43+fRquPcA3XZCrk2sanOwJLsj19twD1QCqp6hNKCHVflGtqfXhAwXOzhCnRkeZTQyfZWvFR47t49Q/jT8a1JOV8KjCy7AubnUgLTaxItVOmb7spTUeDmcmmASmc5SFUdbOEY/GilR/gvrzXUMNRXy84WYWli6dMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781259; c=relaxed/simple;
	bh=PaiXDbMw7fXf4ztglkPwYlVhxyZrlFZDcFO6E+kOKn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2MMsKxKp4v5vqnZPS7wv8DglZ37tR0GhdwPVKC+BKmc1QxRq1L0th19Cqo7fdoR/Yvr4H1hxoFJcg0M7FKR5H4xhQgOlQoF2a8Vf652elM32ivz9rNUFt2xvmLDnhwkdr8j1fzghKnO3kvDWA7OXg0XgeJwzH/MYDIrMXoophU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arnTFycw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b4a25ccceso5486315e9.3
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755781255; x=1756386055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A0s+0adNF94jvmKSUPNlM+o2nubtVfbAlrSyfqvoUc4=;
        b=arnTFycwyvrg9gQKvnBRiHUqBhZgaudVez/Ja+L+dyopShUrN7CzU7GmH/af/VD3xy
         yXLVpgdBbszwZtvX8H1pLrqbr78zgxfzepZ8pfa38KOdPqy1sZZbwgMR7c4fb1BAiVks
         g3QeORO6GNf5VQg5N5c5RdkYRHMsbBAV5h+OMtJxor08/gcfNoF2NrbZbYqUnsGxVWAK
         4SYJ/hborsyVhZZhKAffStsBIO+NYMPCzctOPE5p7nBPy9bbVYtYbYx2Di8CNB5RvxY1
         7rf2rZCHaKQKjvWSMEWwvStlaurgjeqVOZHMokbTkQdTdlas1Nby49ECAvKDyzoh5at6
         yL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781255; x=1756386055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0s+0adNF94jvmKSUPNlM+o2nubtVfbAlrSyfqvoUc4=;
        b=qh7vwH/C5ib0S/3uUyxbPrYRlCF5oEi1gBhuKVexzrDPmRWPJ0/lGnr4FTJFlBawRZ
         Vb9OEUBfdhv4A10vEJr0R1ATkDpAg8pGP3JE5tATp8FvhR7ez8sETtECco34iWylPjKV
         rG3Ir+N/EDTQ2iMyKXvcv5mgGrhxqeRcbdIppm2HBNNAsUNZURJnUcb8OrMY3rphpWSo
         FWWRrfoZ/KhIE4ORm6AogkGEcl5G5tbmLPRqui8wWbl1RoHAm618zDm3uiPT4xob0dyf
         zaGp4VA2B4auffqMOmfM04/dfP8F0rVqW0VBl47zbjSKIRGpVQmiINaFM5eiOUKz9ix1
         Odpg==
X-Gm-Message-State: AOJu0Yy1xzTUAuFQ3c1K7QDChnEQnczdz/q5eZs2hVhwk24H2ikqAG9A
	MfxiS1XVR1QGg38IZhmAvltaoXOu28sCEOqqU5xP2EwvNdb4hccbWwaG
X-Gm-Gg: ASbGncteApQHmTKPCGCPNQPqWlNtZ3LNTU+54ffnxo5P6kkjs96PyVz3ZiNN2UcrxLd
	BTRslm5rIF+XGgmt0ps1ladFEmOQOV0CupZDYABqWodu1MaX0mPWK4SwOF0Tqi3uXy5KpMulXsd
	1Wq43Fgyk81dtnNzyCwVQScSbcgN870zMlGcOK05Gh3RUkphhiyWMl7SFimruk/wgzxB5iSP6iz
	kLtZdOPnDyyK33CRjRS5/RY3/7QhpeDC1iREATOA10isnfQBzXBCL6dEjs0Yr50ilb/Cg4VeKQD
	pJp7dPglLl9RjaJ5f47mUP/aTTZRZsSmQ+euGsQoQ5v8PLF9J9bsUFbReCebwDai+9OQltamphz
	qWEYhnh8kHSynvj1v/sGhnAZza8TGmfSkqA==
X-Google-Smtp-Source: AGHT+IFXtJruGbdrjsidBYz8irfWxEieE77VnR2ow1V7C17CsFLWWlBHNIsKU725RLPDje+AFTNACA==
X-Received: by 2002:a05:600c:1f1a:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-45b4d7dbb07mr18329915e9.13.1755781254514;
        Thu, 21 Aug 2025 06:00:54 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3a8980ed5sm6020662f8f.16.2025.08.21.06.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:00:53 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:05:24 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aKcZlBD+Mojmf+6P@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-11-a.s.protopopov@gmail.com>
 <CAEf4BzaZxoz+=_uycH=6rO3U548TF7K8v5zKukDSJjWUgEXSSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaZxoz+=_uycH=6rO3U548TF7K8v5zKukDSJjWUgEXSSw@mail.gmail.com>

On 25/08/20 05:20PM, Andrii Nakryiko wrote:
> On Sat, Aug 16, 2025 at 11:02 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > For v5 instruction set, LLVM now is allowed to generate indirect
> > jumps for switch statements and for 'goto *rX' assembly. Every such a
> > jump will be accompanied by necessary metadata, e.g. (`llvm-objdump
> > -Sr ...`):
> >
> >        0:       r2 = 0x0 ll
> >                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
> >
> > Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
> >
> >     Symbol table:
> >        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
> >
> > The -bpf-min-jump-table-entries llvm option may be used to control
> > the minimal size of a switch which will be converted to an indirect
> > jumps.
> >
> > The code generated by LLVM for a switch will look, approximately,
> > like this:
> >
> >     0: rX <- jump_table_x[i]
> >     2: rX <<= 3
> >     3: gotox *rX
> >
> > Right now there is no robust way to associate the jump with the
> > corresponding map, so libbpf doesn't insert map file descriptor
> > inside the gotox instruction.
> 
> Just from the commit description it's not clear whether that's
> something that needs fixing or is OK? If it's OK, why call it out?..

Right, will rephrase.

The idea here is that if you have, say, a switch, then, most
probably, it is compiled into 1 jump table and 1 gotox. And, if
compiler can provide enough metadata, then this makes sense for
libbpf to also associate JT with gotox by inserting the same map
descriptor inside both instructions.  However now this doesn't
work, and also there are cases when one gotox can be associated with
multiple JTs.

> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
> >  tools/bpf/bpftool/map.c                       |   2 +-
> >  tools/lib/bpf/libbpf.c                        | 159 +++++++++++++++---
> >  tools/lib/bpf/libbpf_probes.c                 |   4 +
> >  tools/lib/bpf/linker.c                        |  12 +-
> >  5 files changed, 153 insertions(+), 26 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > index 252e4c538edb..3377d4a01c62 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > @@ -55,7 +55,7 @@ MAP COMMANDS
> >  |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
> >  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
> >  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
> > -|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
> > +|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** | **insn_array** }
> >
> >  DESCRIPTION
> >  ===========
> > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > index c9de44a45778..79b90f274bef 100644
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -1477,7 +1477,7 @@ static int do_help(int argc, char **argv)
> >                 "                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
> >                 "                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
> >                 "                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
> > -               "                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
> > +               "                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena | insn_array }\n"
> >                 "       " HELP_SPEC_OPTIONS " |\n"
> >                 "                    {-f|--bpffs} | {-n|--nomount} }\n"
> >                 "",
> 
> bpftool changes sifted through into libbpf patch?

Yes thanks. I think I've sqhashed the fix here, becase it broke
the `test_progs -a libbpf_str` test.

> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fe4fc5438678..a5f04544c09c 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -191,6 +191,7 @@ static const char * const map_type_name[] = {
> >         [BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
> >         [BPF_MAP_TYPE_CGRP_STORAGE]             = "cgrp_storage",
> >         [BPF_MAP_TYPE_ARENA]                    = "arena",
> > +       [BPF_MAP_TYPE_INSN_ARRAY]               = "insn_array",
> >  };
> >
> >  static const char * const prog_type_name[] = {
> > @@ -372,6 +373,7 @@ enum reloc_type {
> >         RELO_EXTERN_CALL,
> >         RELO_SUBPROG_ADDR,
> >         RELO_CORE,
> > +       RELO_INSN_ARRAY,
> >  };
> >
> >  struct reloc_desc {
> > @@ -383,6 +385,7 @@ struct reloc_desc {
> >                         int map_idx;
> >                         int sym_off;
> >                         int ext_idx;
> > +                       int sym_size;
> 
> make it a union with ext_idx? ext_idx isn't used for jump table
> relocation, right?

Done.

> 
> >                 };
> >         };
> >  };
> > @@ -496,6 +499,10 @@ struct bpf_program {
> >         __u32 line_info_rec_size;
> >         __u32 line_info_cnt;
> >         __u32 prog_flags;
> > +
> > +       __u32 subprog_offset[256];
> > +       __u32 subprog_sec_offst[256];
> > +       __u32 subprog_cnt;
> 
> um... allocate dynamically, if necessary? (but also see above, might
> not be necessary at all)
> 
> >  };
> >
> >  struct bpf_struct_ops {
> > @@ -525,6 +532,7 @@ struct bpf_struct_ops {
> >  #define STRUCT_OPS_SEC ".struct_ops"
> >  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
> >  #define ARENA_SEC ".addr_space.1"
> > +#define JUMPTABLES_SEC ".jumptables"
> >
> >  enum libbpf_map_type {
> >         LIBBPF_MAP_UNSPEC,
> > @@ -658,6 +666,7 @@ struct elf_state {
> >         Elf64_Ehdr *ehdr;
> >         Elf_Data *symbols;
> >         Elf_Data *arena_data;
> > +       Elf_Data jumptables_data;
> >         size_t shstrndx; /* section index for section name strings */
> >         size_t strtabidx;
> >         struct elf_sec_desc *secs;
> > @@ -668,6 +677,7 @@ struct elf_state {
> >         int symbols_shndx;
> >         bool has_st_ops;
> >         int arena_data_shndx;
> > +       int jumptables_data_shndx;
> >  };
> >
> >  struct usdt_manager;
> > @@ -3945,6 +3955,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
> >                         } else if (strcmp(name, ARENA_SEC) == 0) {
> >                                 obj->efile.arena_data = data;
> >                                 obj->efile.arena_data_shndx = idx;
> > +                       } else if (strcmp(name, JUMPTABLES_SEC) == 0) {
> > +                               memcpy(&obj->efile.jumptables_data, data, sizeof(*data));
> 
> you need to preserve the contents of jump tables to preparation stage,
> right? Just memcpy'ing Elf_Data doesn't preserve d_buf's contents, no?
> So you need to allocate memory for the contents and keep it until
> preparation phase.

Ah, yes, right.

> pw-bot: cr
> 
> 
> > +                               obj->efile.jumptables_data_shndx = idx;
> >                         } else {
> >                                 pr_info("elf: skipping unrecognized data section(%d) %s\n",
> >                                         idx, name);
> > @@ -4599,6 +4612,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
> >                 return 0;
> >         }
> >
> > +       /* jump table data relocation */
> > +       if (shdr_idx == obj->efile.jumptables_data_shndx) {
> > +               reloc_desc->type = RELO_INSN_ARRAY;
> > +               reloc_desc->insn_idx = insn_idx;
> > +               reloc_desc->map_idx = -1;
> > +               reloc_desc->sym_off = sym->st_value;
> > +               reloc_desc->sym_size = sym->st_size;
> > +               return 0;
> > +       }
> > +
> >         /* generic map reference relocation */
> >         if (type == LIBBPF_MAP_UNSPEC) {
> >                 if (!bpf_object__shndx_is_maps(obj, shdr_idx)) {
> > @@ -6101,6 +6124,60 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
> >         insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
> >  }
> >
> > +static int create_jt_map(struct bpf_object *obj, int off, int size, int adjust_off)
> > +{
> > +       static union bpf_attr attr = {
> > +               .map_type = BPF_MAP_TYPE_INSN_ARRAY,
> > +               .key_size = 4,
> > +               .value_size = sizeof(struct bpf_insn_array_value),
> > +               .max_entries = 0,
> > +       };
> > +       struct bpf_insn_array_value val = {};
> > +       int map_fd;
> > +       int err;
> > +       __u32 i;
> > +       __u32 *jt;
> 
> nit: combine same-typed variable declarations?

ok

> > +
> > +       attr.max_entries = size / 8;
> 
> 8 is sizeof(struct bpf_insns_array_value)? make it obvious?

ok

> > +
> > +       map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> > +       if (map_fd < 0)
> > +               return map_fd;
> 
> is the bpf_map_create() API not usable here? what's the reason to
> open-code (incorrectly, not doing memset(0)) bpf_attr?

Yeah, I am always forgetting that bpf_map_create() exists...
Need to put "no syscall(__NR_bpf)" in the checklist.

> > +
> > +       jt = (__u32 *)(obj->efile.jumptables_data.d_buf + off);
> > +       if (!jt)
> 
> if off is not zero, this will never be true... this check looks wrong.
> Check this once at the point where you record jumptables_data?

Thanks, missed this.

> > +               return -EINVAL;
> > +
> > +       for (i = 0; i < attr.max_entries; i++) {
> > +               val.xlated_off = jt[2*i]/8 + adjust_off;
> 
> nit: code style: `jt[2 * i] / 8`
> 
> and this 8 is basically sizeof(struct bpf_insn), right? Can you use
> that to have a bit more semantic meaning here?

Sure, thanks.

> > +               err = bpf_map_update_elem(map_fd, &i, &val, 0);
> > +               if (err) {
> > +                       close(map_fd);
> > +                       return err;
> > +               }
> > +       }
> > +
> > +       err = bpf_map_freeze(map_fd);
> > +       if (err) {
> > +               close(map_fd);
> > +               return err;
> > +       }
> > +
> > +       return map_fd;
> > +}
> > +
> > +static int subprog_insn_off(struct bpf_program *prog, int insn_idx)
> > +{
> > +       int i;
> > +
> > +       for (i = prog->subprog_cnt - 1; i >= 0; i--)
> > +               if (insn_idx >= prog->subprog_offset[i])
> > +                       return prog->subprog_offset[i] - prog->subprog_sec_offst[i];
> 
> I feel like this whole subprog_offset and subprog_sec_offst shouldn't
> be even necessary.
> 
> Check bpf_object__relocate(). I'm not sure why this was done this way
> that we go across all programs in phases, doing code relocation first,
> then data relocation later (across all programs again). I might be
> forgetting some details, but if we change this to do all the
> relocation for each program one at a time, then all this information
> that you explicitly record is already recorded in
> subprog->sub_insn_off and you can use it until we start relocating
> another entry-point program. Can you give it a try?
> 
> So basically the structure will be:
> 
> for (i = 0; i < obj->nr_programs; i++) {
>    prog = ...
>    if (prog_is_subprog(...))
>        continue;
>    if (!prog->autoload)
>        continue;
>    bpf_object__relocate_calls()
>    /* that exception callback handling */
>    bpf_object__relocate_data()
>    bpf_program_fixup_func_info()
> }
> 
> It feels like this should work because there cannot be
> interdependencies between entry programs.

Ok, I will take a look at this before v2.

> 
> > +
> > +       return -prog->sec_insn_off;
> 
> why this return value?... can you elaborate?

Jump tables generated by LLVM contain offsets relative to the
beginning of a section. The offsets inside a BPF_INSN_ARRAY
are absolute (for a "load unit", i.e., insns in bpf_prog_load).
So if, say, a section A contains two progs, f1 and f2, then,
f1 starts at 0 and f2 at F2_START. So when the f2 is loaded
jump tables needs to be adjusted by -F2_START such that offsets
are correct.

> > +}
> > +
> > +
> >  /* Relocate data references within program code:
> >   *  - map references;
> >   *  - global variable references;
> > @@ -6192,6 +6269,21 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
> >                 case RELO_CORE:
> >                         /* will be handled by bpf_program_record_relos() */
> >                         break;
> > +               case RELO_INSN_ARRAY: {
> > +                       int map_fd;
> > +
> > +                       map_fd = create_jt_map(obj, relo->sym_off, relo->sym_size,
> > +                                              subprog_insn_off(prog, relo->insn_idx));
> > +                       if (map_fd < 0) {
> > +                               pr_warn("prog '%s': relo #%d: failed to create a jt map for sym_off=%u\n",
> 
> jt -> jump table, this is supposed to be at least somewhat
> human-readable ;) also we seem to be not using blah=%d approach, so
> just "sym_off %d" (and note that sym_off is int, not unsigned)

thanks, will fix

> > +                                               prog->name, i, relo->sym_off);
> > +                               return map_fd;
> > +                       }
> > +                       insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
> > +                       insn->imm = map_fd;
> > +                       insn->off = 0;
> > +               }
> > +                       break;
> >                 default:
> >                         pr_warn("prog '%s': relo #%d: bad relo type %d\n",
> >                                 prog->name, i, relo->type);
> > @@ -6389,36 +6481,58 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
> >         return 0;
> >  }
> >
> > +static int
> > +bpf_prog__append_subprog_offsets(struct bpf_program *prog, __u32 sec_insn_off, __u32 sub_insn_off)
> 
> please don't use double underscore for non-API functions, just
> prog_append_subprog_offs()
> 
> but actually I'd just inline it into bpf_object__append_subprog_code,
> it doesn't seem complicated enough to warrant its own function

ok, makes sense, will inline

> > +{
> > +       if (prog->subprog_cnt == ARRAY_SIZE(prog->subprog_sec_offst)) {
> 
> please use libbpf_reallocarray()

ok

> 
> > +               pr_warn("prog '%s': number of subprogs exceeds %zu\n",
> > +                       prog->name, ARRAY_SIZE(prog->subprog_sec_offst));
> > +               return -E2BIG;
> > +       }
> > +
> > +       prog->subprog_sec_offst[prog->subprog_cnt] = sec_insn_off;
> 
> typo: offst, but also here and below prefer sticking to "off", it's
> used pretty universally in libbpf code

ok

> > +       prog->subprog_offset[prog->subprog_cnt] = sub_insn_off;
> > +
> > +       prog->subprog_cnt += 1;
> > +       return 0;
> > +}
> > +
> >  static int
> >  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
> > -                               struct bpf_program *subprog)
> > +               struct bpf_program *subprog)
> >  {
> > -       struct bpf_insn *insns;
> > -       size_t new_cnt;
> > -       int err;
> > +       struct bpf_insn *insns;
> > +       size_t new_cnt;
> > +       int err;
> >
> > -       subprog->sub_insn_off = main_prog->insns_cnt;
> > +       subprog->sub_insn_off = main_prog->insns_cnt;
> >
> > -       new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
> > -       insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
> > -       if (!insns) {
> > -               pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
> > -               return -ENOMEM;
> > -       }
> > -       main_prog->insns = insns;
> > -       main_prog->insns_cnt = new_cnt;
> > +       new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
> > +       insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
> > +       if (!insns) {
> > +               pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
> > +               return -ENOMEM;
> > +       }
> > +       main_prog->insns = insns;
> > +       main_prog->insns_cnt = new_cnt;
> >
> > -       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
> > -              subprog->insns_cnt * sizeof(*insns));
> > +       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
> > +                       subprog->insns_cnt * sizeof(*insns));
> >
> > -       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
> > -                main_prog->name, subprog->insns_cnt, subprog->name);
> > +       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
> > +                       main_prog->name, subprog->insns_cnt, subprog->name);
> >
> > -       /* The subprog insns are now appended. Append its relos too. */
> > -       err = append_subprog_relos(main_prog, subprog);
> > -       if (err)
> > -               return err;
> > -       return 0;
> > +       /* The subprog insns are now appended. Append its relos too. */
> > +       err = append_subprog_relos(main_prog, subprog);
> > +       if (err)
> > +               return err;
> > +
> > +       err = bpf_prog__append_subprog_offsets(main_prog, subprog->sec_insn_off,
> > +                                              subprog->sub_insn_off);
> > +       if (err)
> > +               return err;
> > +
> > +       return 0;
> >  }
> >
> >  static int
> > @@ -7954,6 +8068,7 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
> >                 if (err)
> >                         return err;
> >         }
> > +
> 
> ?

Thanks, fixing + squashing artefacts.

> 
> >         return 0;
> >  }
> >
> > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> > index 9dfbe7750f56..bccf4bb747e1 100644
> > --- a/tools/lib/bpf/libbpf_probes.c
> > +++ b/tools/lib/bpf/libbpf_probes.c
> > @@ -364,6 +364,10 @@ static int probe_map_create(enum bpf_map_type map_type)
> >         case BPF_MAP_TYPE_SOCKHASH:
> >         case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
> >                 break;
> > +       case BPF_MAP_TYPE_INSN_ARRAY:
> > +               key_size        = sizeof(__u32);
> > +               value_size      = sizeof(struct bpf_insn_array_value);
> > +               break;
> >         case BPF_MAP_TYPE_UNSPEC:
> >         default:
> >                 return -EOPNOTSUPP;
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index a469e5d4fee7..827867f8bba3 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -28,6 +28,9 @@
> >  #include "str_error.h"
> >
> >  #define BTF_EXTERN_SEC ".extern"
> > +#define RODATA_REL_SEC ".rel.rodata"
> > +#define JUMPTABLES_SEC ".jumptables"
> > +#define JUMPTABLES_REL_SEC ".rel.jumptables"
> >
> >  struct src_sec {
> >         const char *sec_name;
> > @@ -2026,6 +2029,9 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
> >                         obj->sym_map[src_sym_idx] = dst_sec->sec_sym_idx;
> >                         return 0;
> >                 }
> > +
> > +               if (!strcmp(src_sec->sec_name, JUMPTABLES_SEC))
> 
> If you look around in this file (and most of libbpf source code), you
> won't see !strcmp() in it. Let's be consistent and explicit with == 0
> and != 0 here and below.

ok

> 
> > +                       goto add_sym;
> >         }
> >
> >         if (sym_bind == STB_LOCAL)
> > @@ -2272,8 +2278,10 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
> >                                                 insn->imm += sec->dst_off / sizeof(struct bpf_insn);
> >                                         else
> >                                                 insn->imm += sec->dst_off;
> > -                               } else {
> > -                                       pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
> > +                               } else if (strcmp(src_sec->sec_name, JUMPTABLES_REL_SEC) &&
> > +                                          strcmp(src_sec->sec_name, RODATA_REL_SEC)) {
> 
> where does .rel.rodata come from?
> 
> and we don't need to adjust the contents of any of those sections, right?...
> 
> can you please add some tests validating that two object files with
> jumptables can be linked together and end up with proper combined
> .jumptables section?
> 
> 
> and in terms of code, can we do
> 
> } else if (strcmp(..., JUMPTABLES_REL_SEC) == 0) {
>     /* nothing to do for .rel.jumptables */
> } else {
>     pr_warn(...);
> }
> 
> It makes it more apparent what is supported and what's not.

Yes, sure. The rodata might be obsolete, I will check, and
.rel.jumptables is actually not used. This should be cleaned up
once LLVM patch stabilizes. Thanks for noticing this,
this way it is for sure added to my checklist :-)

> 
> > +                                       pr_warn("relocation against STT_SECTION in section %s is not supported!\n",
> > +                                               src_sec->sec_name);
> >                                         return -EINVAL;
> >                                 }
> >                         }
> > --
> > 2.34.1
> >

