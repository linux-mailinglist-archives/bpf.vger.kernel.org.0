Return-Path: <bpf+bounces-66135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A4B2E95F
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E567B2BA5
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA281A9FAD;
	Thu, 21 Aug 2025 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqdEJVx+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8F335C7
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755735626; cv=none; b=k7bOn0uYRLy3KPulS77X8z2oGCUqwHgs4kxlRG63m6qlQ7ToMBOXFWynPailPncs+8Rg7yJP2ekxAkoGWYugFt7Ua0w/mvn9ZjWobN1nFo86IhC9lB/J1PWBySQnln8I/vq/KyHrfAP1zJSN2aAuT6umrxD7NmwssLu0ZuWeszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755735626; c=relaxed/simple;
	bh=t5q4anOkWqgqxQPAq02nQD9ZientKzM0hrpmn29BluE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyDNXnTBP8WgNyCTTaU512NIgcjfAlH3A+vShIw2ESqr4PbDQSq6Tb/AEPyTC3jk9rXJp+f1Cnn/oykUe3MSTMbXT4d8acKDk79bTy5xkQhBWOZfe+9cQ5nwd5pNx6iPUXt2xd1iFpi8JETWh3luZ6uYBDLWAjqiDVyBka4A/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqdEJVx+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326df0e75so364871a91.2
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755735623; x=1756340423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=856OR1US8V19QQud4NGV0mmX6LhS99jX2gN2B/nYupQ=;
        b=jqdEJVx+LjrH9G13Vtpu/vsIBmajQ59tgrZJ0lRQJNQFhRILZk+/CaDcF8Fnmr4MYG
         iNF5+DWJtatSAliUJ4FFe+rM1iP90ihGfdsVXDzuQmY0hyAQc3DPI1ehvd0y7JBtA2/9
         oYzIZci6/OmdhtdFvceQeXEQSpHy6qYE2Xx5KtCVYBB2aGRmNXbV8I0A6CDqWOgQ/Fuw
         +RoX/gvmqtNyk/YbnnUcG09/iYlRRPpEG8wuG8Oqcsqs5ZOZSYhMX6znzpS9aBCW09AI
         ebUqxgxhmmXEaZMe5YaWJwV/45tPDL2rnvd4V3J/HtXKo7ktfNf+KnqNMD6f3Ef1kYMK
         gBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755735623; x=1756340423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=856OR1US8V19QQud4NGV0mmX6LhS99jX2gN2B/nYupQ=;
        b=Pq44+MY5QFODF4DbBlRx586YpfCRCQyc/Ee4tA0fN3YD1AONaazCXGoXgbUbLTa/Zo
         JMYSYU7Ipv++UsLJIhj0OySBVw+GFP/nJHcwcZOJphnVuxt/hyWqSjRwZuFcj+4tpaUa
         ylftqocybVfIHgUFPb64znRakNMXKB+2D8x/jViqtR0wiawFrtqk+xq3nm+5BDuFwG2M
         zciV+MniEcr52ZDh9Fyk4XRS3KDdezLrk76EJR1JmKNNjKDlmFFen4NmRqQypQMZm3os
         qs9fFcy9HafB5CJ1mA95DVFwCqel2e9NpIknUb97F+k2vAabL/i2SiF+tZcE6M8ClOnR
         HGMQ==
X-Gm-Message-State: AOJu0YzaqTiCO6Y4YFVdMM+Kt//BWI/BrNRTCSUoNytpheH/v7pbpazu
	Ix3Fb+4Yh8HBLGoac6Ttfp4PNeT+HbPG6XHhWqT+X0hHCDzV3kTiLPYDSLxPE5M7v+LaUIAHxZm
	cn6TmckHa+SRGefvSHYQp0jW6sEzprGTf0hRk
X-Gm-Gg: ASbGncsSJXnBpYpI41DN/Dpw4/2EghoQsV2U9TLqJKtIwraE1TsXbHhyk0/Q/MGZgEu
	gIIO/n9TOAfv2vfkCECPnRPuksJ08/9KIH+FBhPq0zMrhQs5TeEisDdr+w2DGEoAIACzehqSdk5
	bqm3gM/IvasZ9SiFS1XlISNnDwSs6l2LzpD2yy+/A2pIk8pFNgbPq3W58ohcc71qJVdyx0qT3un
	LM9kCup4Q9/y48YjDf5FHA=
X-Google-Smtp-Source: AGHT+IGDsdPl+5Whpp/RzpP97fI0lv1RMK8aH55VOzVb2LQehgvcguJrbRBHYHapfJfnzCXV0W3MxGTAkJQh8cdSyQk=
X-Received: by 2002:a17:90b:3bc8:b0:324:e03a:662e with SMTP id
 98e67ed59e1d1-324ed139a8cmr865031a91.23.1755735623035; Wed, 20 Aug 2025
 17:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816180631.952085-1-a.s.protopopov@gmail.com> <20250816180631.952085-11-a.s.protopopov@gmail.com>
In-Reply-To: <20250816180631.952085-11-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 17:20:08 -0700
X-Gm-Features: Ac12FXzfpGqY8zU4ZYn-PLoGzcAygdHF7raWRfPAtRE6jahDXkGxNpa8oUHgYO0
Message-ID: <CAEf4BzaZxoz+=_uycH=6rO3U548TF7K8v5zKukDSJjWUgEXSSw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 11:02=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> For v5 instruction set, LLVM now is allowed to generate indirect
> jumps for switch statements and for 'goto *rX' assembly. Every such a
> jump will be accompanied by necessary metadata, e.g. (`llvm-objdump
> -Sr ...`):
>
>        0:       r2 =3D 0x0 ll
>                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
>
> Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
>
>     Symbol table:
>        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
>
> The -bpf-min-jump-table-entries llvm option may be used to control
> the minimal size of a switch which will be converted to an indirect
> jumps.
>
> The code generated by LLVM for a switch will look, approximately,
> like this:
>
>     0: rX <- jump_table_x[i]
>     2: rX <<=3D 3
>     3: gotox *rX
>
> Right now there is no robust way to associate the jump with the
> corresponding map, so libbpf doesn't insert map file descriptor
> inside the gotox instruction.

Just from the commit description it's not clear whether that's
something that needs fixing or is OK? If it's OK, why call it out?..

>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
>  tools/bpf/bpftool/map.c                       |   2 +-
>  tools/lib/bpf/libbpf.c                        | 159 +++++++++++++++---
>  tools/lib/bpf/libbpf_probes.c                 |   4 +
>  tools/lib/bpf/linker.c                        |  12 +-
>  5 files changed, 153 insertions(+), 26 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/=
bpftool/Documentation/bpftool-map.rst
> index 252e4c538edb..3377d4a01c62 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -55,7 +55,7 @@ MAP COMMANDS
>  |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskm=
ap** | **sockhash**
>  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_s=
torage**
>  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ring=
buf** | **inode_storage**
> -|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_=
storage** | **arena** }
> +|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_=
storage** | **arena** | **insn_array** }
>
>  DESCRIPTION
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c9de44a45778..79b90f274bef 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1477,7 +1477,7 @@ static int do_help(int argc, char **argv)
>                 "                 devmap | devmap_hash | sockmap | cpumap=
 | xskmap | sockhash |\n"
>                 "                 cgroup_storage | reuseport_sockarray | =
percpu_cgroup_storage |\n"
>                 "                 queue | stack | sk_storage | struct_ops=
 | ringbuf | inode_storage |\n"
> -               "                 task_storage | bloom_filter | user_ring=
buf | cgrp_storage | arena }\n"
> +               "                 task_storage | bloom_filter | user_ring=
buf | cgrp_storage | arena | insn_array }\n"
>                 "       " HELP_SPEC_OPTIONS " |\n"
>                 "                    {-f|--bpffs} | {-n|--nomount} }\n"
>                 "",

bpftool changes sifted through into libbpf patch?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fe4fc5438678..a5f04544c09c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -191,6 +191,7 @@ static const char * const map_type_name[] =3D {
>         [BPF_MAP_TYPE_USER_RINGBUF]             =3D "user_ringbuf",
>         [BPF_MAP_TYPE_CGRP_STORAGE]             =3D "cgrp_storage",
>         [BPF_MAP_TYPE_ARENA]                    =3D "arena",
> +       [BPF_MAP_TYPE_INSN_ARRAY]               =3D "insn_array",
>  };
>
>  static const char * const prog_type_name[] =3D {
> @@ -372,6 +373,7 @@ enum reloc_type {
>         RELO_EXTERN_CALL,
>         RELO_SUBPROG_ADDR,
>         RELO_CORE,
> +       RELO_INSN_ARRAY,
>  };
>
>  struct reloc_desc {
> @@ -383,6 +385,7 @@ struct reloc_desc {
>                         int map_idx;
>                         int sym_off;
>                         int ext_idx;
> +                       int sym_size;

make it a union with ext_idx? ext_idx isn't used for jump table
relocation, right?

>                 };
>         };
>  };
> @@ -496,6 +499,10 @@ struct bpf_program {
>         __u32 line_info_rec_size;
>         __u32 line_info_cnt;
>         __u32 prog_flags;
> +
> +       __u32 subprog_offset[256];
> +       __u32 subprog_sec_offst[256];
> +       __u32 subprog_cnt;

um... allocate dynamically, if necessary? (but also see above, might
not be necessary at all)

>  };
>
>  struct bpf_struct_ops {
> @@ -525,6 +532,7 @@ struct bpf_struct_ops {
>  #define STRUCT_OPS_SEC ".struct_ops"
>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>  #define ARENA_SEC ".addr_space.1"
> +#define JUMPTABLES_SEC ".jumptables"
>
>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> @@ -658,6 +666,7 @@ struct elf_state {
>         Elf64_Ehdr *ehdr;
>         Elf_Data *symbols;
>         Elf_Data *arena_data;
> +       Elf_Data jumptables_data;
>         size_t shstrndx; /* section index for section name strings */
>         size_t strtabidx;
>         struct elf_sec_desc *secs;
> @@ -668,6 +677,7 @@ struct elf_state {
>         int symbols_shndx;
>         bool has_st_ops;
>         int arena_data_shndx;
> +       int jumptables_data_shndx;
>  };
>
>  struct usdt_manager;
> @@ -3945,6 +3955,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
>                         } else if (strcmp(name, ARENA_SEC) =3D=3D 0) {
>                                 obj->efile.arena_data =3D data;
>                                 obj->efile.arena_data_shndx =3D idx;
> +                       } else if (strcmp(name, JUMPTABLES_SEC) =3D=3D 0)=
 {
> +                               memcpy(&obj->efile.jumptables_data, data,=
 sizeof(*data));

you need to preserve the contents of jump tables to preparation stage,
right? Just memcpy'ing Elf_Data doesn't preserve d_buf's contents, no?
So you need to allocate memory for the contents and keep it until
preparation phase.

pw-bot: cr


> +                               obj->efile.jumptables_data_shndx =3D idx;
>                         } else {
>                                 pr_info("elf: skipping unrecognized data =
section(%d) %s\n",
>                                         idx, name);
> @@ -4599,6 +4612,16 @@ static int bpf_program__record_reloc(struct bpf_pr=
ogram *prog,
>                 return 0;
>         }
>
> +       /* jump table data relocation */
> +       if (shdr_idx =3D=3D obj->efile.jumptables_data_shndx) {
> +               reloc_desc->type =3D RELO_INSN_ARRAY;
> +               reloc_desc->insn_idx =3D insn_idx;
> +               reloc_desc->map_idx =3D -1;
> +               reloc_desc->sym_off =3D sym->st_value;
> +               reloc_desc->sym_size =3D sym->st_size;
> +               return 0;
> +       }
> +
>         /* generic map reference relocation */
>         if (type =3D=3D LIBBPF_MAP_UNSPEC) {
>                 if (!bpf_object__shndx_is_maps(obj, shdr_idx)) {
> @@ -6101,6 +6124,60 @@ static void poison_kfunc_call(struct bpf_program *=
prog, int relo_idx,
>         insn->imm =3D POISON_CALL_KFUNC_BASE + ext_idx;
>  }
>
> +static int create_jt_map(struct bpf_object *obj, int off, int size, int =
adjust_off)
> +{
> +       static union bpf_attr attr =3D {
> +               .map_type =3D BPF_MAP_TYPE_INSN_ARRAY,
> +               .key_size =3D 4,
> +               .value_size =3D sizeof(struct bpf_insn_array_value),
> +               .max_entries =3D 0,
> +       };
> +       struct bpf_insn_array_value val =3D {};
> +       int map_fd;
> +       int err;
> +       __u32 i;
> +       __u32 *jt;

nit: combine same-typed variable declarations?

> +
> +       attr.max_entries =3D size / 8;

8 is sizeof(struct bpf_insns_array_value)? make it obvious?

> +
> +       map_fd =3D syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr))=
;
> +       if (map_fd < 0)
> +               return map_fd;

is the bpf_map_create() API not usable here? what's the reason to
open-code (incorrectly, not doing memset(0)) bpf_attr?

> +
> +       jt =3D (__u32 *)(obj->efile.jumptables_data.d_buf + off);
> +       if (!jt)

if off is not zero, this will never be true... this check looks wrong.
Check this once at the point where you record jumptables_data?

> +               return -EINVAL;
> +
> +       for (i =3D 0; i < attr.max_entries; i++) {
> +               val.xlated_off =3D jt[2*i]/8 + adjust_off;

nit: code style: `jt[2 * i] / 8`

and this 8 is basically sizeof(struct bpf_insn), right? Can you use
that to have a bit more semantic meaning here?

> +               err =3D bpf_map_update_elem(map_fd, &i, &val, 0);
> +               if (err) {
> +                       close(map_fd);
> +                       return err;
> +               }
> +       }
> +
> +       err =3D bpf_map_freeze(map_fd);
> +       if (err) {
> +               close(map_fd);
> +               return err;
> +       }
> +
> +       return map_fd;
> +}
> +
> +static int subprog_insn_off(struct bpf_program *prog, int insn_idx)
> +{
> +       int i;
> +
> +       for (i =3D prog->subprog_cnt - 1; i >=3D 0; i--)
> +               if (insn_idx >=3D prog->subprog_offset[i])
> +                       return prog->subprog_offset[i] - prog->subprog_se=
c_offst[i];

I feel like this whole subprog_offset and subprog_sec_offst shouldn't
be even necessary.

Check bpf_object__relocate(). I'm not sure why this was done this way
that we go across all programs in phases, doing code relocation first,
then data relocation later (across all programs again). I might be
forgetting some details, but if we change this to do all the
relocation for each program one at a time, then all this information
that you explicitly record is already recorded in
subprog->sub_insn_off and you can use it until we start relocating
another entry-point program. Can you give it a try?

So basically the structure will be:

for (i =3D 0; i < obj->nr_programs; i++) {
   prog =3D ...
   if (prog_is_subprog(...))
       continue;
   if (!prog->autoload)
       continue;
   bpf_object__relocate_calls()
   /* that exception callback handling */
   bpf_object__relocate_data()
   bpf_program_fixup_func_info()
}

It feels like this should work because there cannot be
interdependencies between entry programs.


> +
> +       return -prog->sec_insn_off;

why this return value?... can you elaborate?

> +}
> +
> +
>  /* Relocate data references within program code:
>   *  - map references;
>   *  - global variable references;
> @@ -6192,6 +6269,21 @@ bpf_object__relocate_data(struct bpf_object *obj, =
struct bpf_program *prog)
>                 case RELO_CORE:
>                         /* will be handled by bpf_program_record_relos() =
*/
>                         break;
> +               case RELO_INSN_ARRAY: {
> +                       int map_fd;
> +
> +                       map_fd =3D create_jt_map(obj, relo->sym_off, relo=
->sym_size,
> +                                              subprog_insn_off(prog, rel=
o->insn_idx));
> +                       if (map_fd < 0) {
> +                               pr_warn("prog '%s': relo #%d: failed to c=
reate a jt map for sym_off=3D%u\n",

jt -> jump table, this is supposed to be at least somewhat
human-readable ;) also we seem to be not using blah=3D%d approach, so
just "sym_off %d" (and note that sym_off is int, not unsigned)

> +                                               prog->name, i, relo->sym_=
off);
> +                               return map_fd;
> +                       }
> +                       insn[0].src_reg =3D BPF_PSEUDO_MAP_VALUE;
> +                       insn->imm =3D map_fd;
> +                       insn->off =3D 0;
> +               }
> +                       break;
>                 default:
>                         pr_warn("prog '%s': relo #%d: bad relo type %d\n"=
,
>                                 prog->name, i, relo->type);
> @@ -6389,36 +6481,58 @@ static int append_subprog_relos(struct bpf_progra=
m *main_prog, struct bpf_progra
>         return 0;
>  }
>
> +static int
> +bpf_prog__append_subprog_offsets(struct bpf_program *prog, __u32 sec_ins=
n_off, __u32 sub_insn_off)

please don't use double underscore for non-API functions, just
prog_append_subprog_offs()

but actually I'd just inline it into bpf_object__append_subprog_code,
it doesn't seem complicated enough to warrant its own function


> +{
> +       if (prog->subprog_cnt =3D=3D ARRAY_SIZE(prog->subprog_sec_offst))=
 {

please use libbpf_reallocarray()

> +               pr_warn("prog '%s': number of subprogs exceeds %zu\n",
> +                       prog->name, ARRAY_SIZE(prog->subprog_sec_offst));
> +               return -E2BIG;
> +       }
> +
> +       prog->subprog_sec_offst[prog->subprog_cnt] =3D sec_insn_off;

typo: offst, but also here and below prefer sticking to "off", it's
used pretty universally in libbpf code

> +       prog->subprog_offset[prog->subprog_cnt] =3D sub_insn_off;
> +
> +       prog->subprog_cnt +=3D 1;
> +       return 0;
> +}
> +
>  static int
>  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_progr=
am *main_prog,
> -                               struct bpf_program *subprog)
> +               struct bpf_program *subprog)
>  {
> -       struct bpf_insn *insns;
> -       size_t new_cnt;
> -       int err;
> +       struct bpf_insn *insns;
> +       size_t new_cnt;
> +       int err;
>
> -       subprog->sub_insn_off =3D main_prog->insns_cnt;
> +       subprog->sub_insn_off =3D main_prog->insns_cnt;
>
> -       new_cnt =3D main_prog->insns_cnt + subprog->insns_cnt;
> -       insns =3D libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*=
insns));
> -       if (!insns) {
> -               pr_warn("prog '%s': failed to realloc prog code\n", main_=
prog->name);
> -               return -ENOMEM;
> -       }
> -       main_prog->insns =3D insns;
> -       main_prog->insns_cnt =3D new_cnt;
> +       new_cnt =3D main_prog->insns_cnt + subprog->insns_cnt;
> +       insns =3D libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*=
insns));
> +       if (!insns) {
> +               pr_warn("prog '%s': failed to realloc prog code\n", main_=
prog->name);
> +               return -ENOMEM;
> +       }
> +       main_prog->insns =3D insns;
> +       main_prog->insns_cnt =3D new_cnt;
>
> -       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
> -              subprog->insns_cnt * sizeof(*insns));
> +       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
> +                       subprog->insns_cnt * sizeof(*insns));
>
> -       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
> -                main_prog->name, subprog->insns_cnt, subprog->name);
> +       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
> +                       main_prog->name, subprog->insns_cnt, subprog->nam=
e);
>
> -       /* The subprog insns are now appended. Append its relos too. */
> -       err =3D append_subprog_relos(main_prog, subprog);
> -       if (err)
> -               return err;
> -       return 0;
> +       /* The subprog insns are now appended. Append its relos too. */
> +       err =3D append_subprog_relos(main_prog, subprog);
> +       if (err)
> +               return err;
> +
> +       err =3D bpf_prog__append_subprog_offsets(main_prog, subprog->sec_=
insn_off,
> +                                              subprog->sub_insn_off);
> +       if (err)
> +               return err;
> +
> +       return 0;
>  }
>
>  static int
> @@ -7954,6 +8068,7 @@ static int bpf_object_prepare_progs(struct bpf_obje=
ct *obj)
>                 if (err)
>                         return err;
>         }
> +

?

>         return 0;
>  }
>
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index 9dfbe7750f56..bccf4bb747e1 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -364,6 +364,10 @@ static int probe_map_create(enum bpf_map_type map_ty=
pe)
>         case BPF_MAP_TYPE_SOCKHASH:
>         case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
>                 break;
> +       case BPF_MAP_TYPE_INSN_ARRAY:
> +               key_size        =3D sizeof(__u32);
> +               value_size      =3D sizeof(struct bpf_insn_array_value);
> +               break;
>         case BPF_MAP_TYPE_UNSPEC:
>         default:
>                 return -EOPNOTSUPP;
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index a469e5d4fee7..827867f8bba3 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -28,6 +28,9 @@
>  #include "str_error.h"
>
>  #define BTF_EXTERN_SEC ".extern"
> +#define RODATA_REL_SEC ".rel.rodata"
> +#define JUMPTABLES_SEC ".jumptables"
> +#define JUMPTABLES_REL_SEC ".rel.jumptables"
>
>  struct src_sec {
>         const char *sec_name;
> @@ -2026,6 +2029,9 @@ static int linker_append_elf_sym(struct bpf_linker =
*linker, struct src_obj *obj,
>                         obj->sym_map[src_sym_idx] =3D dst_sec->sec_sym_id=
x;
>                         return 0;
>                 }
> +
> +               if (!strcmp(src_sec->sec_name, JUMPTABLES_SEC))

If you look around in this file (and most of libbpf source code), you
won't see !strcmp() in it. Let's be consistent and explicit with =3D=3D 0
and !=3D 0 here and below.

> +                       goto add_sym;
>         }
>
>         if (sym_bind =3D=3D STB_LOCAL)
> @@ -2272,8 +2278,10 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
>                                                 insn->imm +=3D sec->dst_o=
ff / sizeof(struct bpf_insn);
>                                         else
>                                                 insn->imm +=3D sec->dst_o=
ff;
> -                               } else {
> -                                       pr_warn("relocation against STT_S=
ECTION in non-exec section is not supported!\n");
> +                               } else if (strcmp(src_sec->sec_name, JUMP=
TABLES_REL_SEC) &&
> +                                          strcmp(src_sec->sec_name, RODA=
TA_REL_SEC)) {

where does .rel.rodata come from?

and we don't need to adjust the contents of any of those sections, right?..=
.

can you please add some tests validating that two object files with
jumptables can be linked together and end up with proper combined
.jumptables section?


and in terms of code, can we do

} else if (strcmp(..., JUMPTABLES_REL_SEC) =3D=3D 0) {
    /* nothing to do for .rel.jumptables */
} else {
    pr_warn(...);
}

It makes it more apparent what is supported and what's not.

> +                                       pr_warn("relocation against STT_S=
ECTION in section %s is not supported!\n",
> +                                               src_sec->sec_name);
>                                         return -EINVAL;
>                                 }
>                         }
> --
> 2.34.1
>

