Return-Path: <bpf+bounces-69016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98DB8BA13
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEED71C20A7F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1482857F0;
	Fri, 19 Sep 2025 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euo3DH8d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C03A8F7
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323941; cv=none; b=kcXCW8AhukF9Fl5WLFYZ//5+Ngvwv8seGoEiyKETt/4Z05ZCpB5WKtoswphsY7s05lysc8K2UzHWpdFc8lxGUXhvL1cVfdSnrKX2mxSG8vU6gLTJztIuJJpXP0pBUKSyoTlrfsRPdXXqKmsoqx5CszlAn0p6Z3ie9rE+c7vcqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323941; c=relaxed/simple;
	bh=49ef4QIFuZDUXY3k0g06D4TMxvpVSoTnEmbZYsUqPj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PG9dFdFX9TfQozqe8Z8ZWsCquV8NTzzitLI2bTUpFceJG5NTUBrUzq+0Vdwik5xECy9mcuSj7t/dJZAT7XUSCwMOxuwlpmAXqvfZTUwrleX4znjXfTWa6zRSazudT31o0hW183WG/oEAzsKJCUQtdwmMmjoAZF9oEvtkU6ie4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euo3DH8d; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-327f87275d4so2833595a91.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323938; x=1758928738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzOey1e+sKGgTbftiPQOwLJC43wFBls5HECik1uGrVM=;
        b=euo3DH8dFEuP6SLsg4wPcpzhAFmVzpzw57KSo5ODCDmlDVbDrSfRUPsTLKN4+L780o
         MoEmr4g7MQDuWmVZpndGyXOd/mnCDclavVEvoVZm7Sk5AdbNVc1WlecNc5UNL3AOntQ6
         y6yRNg0FCPJHXZLlqME0hJAPpUbx8clrI3j3AxN9hnjqJIuk5/NFm8F2on9n1/6ZLgvg
         CzUk7CDKUNioHs78xJuy61fbDWQn0n3PD1OD+IekkU1qny51ekmfVVJKKAu9/GdvFkRB
         kXhJp+LnGeY6PcgmrpRIDUYorQqbOjgLvu+LS4I+R4a3eYPAII5mLEbO61PGM/Blmnlh
         1KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323938; x=1758928738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzOey1e+sKGgTbftiPQOwLJC43wFBls5HECik1uGrVM=;
        b=mHhYvEkBAUKazzyqaXFX+Aky+0MvfEOgtUMFJZcSTCZIrwwYmsYk+7zCdNtleIrAk2
         cKB/UQ4eY9ZPE1/TVWQrwCotojx1PL0XyDRFAa93mIiXgmoPfMcg1AtSVzioe45msFNd
         LUdpug3ATnQz+x57r+r5xPk42l4D1Uk30RSggqCduTJr/6iHLvt+W1gFmvzlEuy26017
         42BWFvpVfhcG3GyqT7iucQ8wzgT3kNbeOtvVNPCCpMZsCJcba/24cEW9rSMzGY5kSPAK
         JhqXNgY+mqqNFDxvR/82XrZeBEmeq7rBOMhsKb33WEeNSDidgU17hYyTSCb5fyegIhJL
         sSZw==
X-Gm-Message-State: AOJu0YwL4HqyvE/I527AWQ3JmT9mYQTaNFc/2fg4b2b5ca1/tmOccrZu
	nwJeuS577zjKxKl1o5dRxJWrQgOvk3CoggZ8zcYkJX2G3A8uvpgzyp/3my2nXkkfYjIGRq9sdSv
	cMLhqkCq/57Shpe80dTDIf0UyuS9OVev+dA==
X-Gm-Gg: ASbGncumsCjXMGo4Mz96mFPyaZ3gX3Srie/5hu/cgJuL9bpABT4J+CpHmOuQOm9atDu
	X9BkmISW28jsGu/wFXKC3ypN0L2iO3/kj5jTCV7XwRTxO/usGectepOV6sDfyL1Y8MNv4541u+m
	00iE5MJciuL4lUYYJSk2ezjua8vlVkpRLg5Z3pcERrbZHDRQ0YEVIzWQuk2eTMgDkqhP3vO+b48
	yvKkTXB03LDsf4ZkP+TgXA=
X-Google-Smtp-Source: AGHT+IHjGO16rNCZFdrStNshza7h2GS0PUDewGiYipE3Z/Vz0IyW84V+Z2bmblr7uIt0xL1sFPrbYPiJAke7Uv/epvA=
X-Received: by 2002:a17:90b:5543:b0:32e:7512:b680 with SMTP id
 98e67ed59e1d1-33097fdb08cmr5159202a91.1.1758323938420; Fri, 19 Sep 2025
 16:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918093850.455051-1-a.s.protopopov@gmail.com> <20250918093850.455051-12-a.s.protopopov@gmail.com>
In-Reply-To: <20250918093850.455051-12-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 16:18:43 -0700
X-Gm-Features: AS18NWCz08zX6EpPtBzm_PlpMRLI0pyIBRIfoFjFas75PQu1yNaqsHeAjWZnPVA
Message-ID: <CAEf4BzaXzCMYQhS+9FwQHbNpaWS_kJJ48-nZL280nQWRS0ckMw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 11/13] libbpf: support llvm-generated indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:32=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> For v5 instruction set LLVM is allowed to generate indirect jumps for
> switch statements and for 'goto *rX' assembly. Every such a jump will
> be accompanied by necessary metadata, e.g. (`llvm-objdump -Sr ...`):
>
>        0:       r2 =3D 0x0 ll
>                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
>
> Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
>
>     Symbol table:
>        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
>
> The -bpf-min-jump-table-entries llvm option may be used to control the
> minimal size of a switch which will be converted to an indirect jumps.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c        | 150 +++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf_probes.c |   4 +
>  tools/lib/bpf/linker.c        |  10 ++-
>  3 files changed, 161 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2c1f48f77680..57cac0810d2e 100644
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
> @@ -382,7 +384,10 @@ struct reloc_desc {
>                 struct {
>                         int map_idx;
>                         int sym_off;
> -                       int ext_idx;
> +                       union {
> +                               int ext_idx;
> +                               int sym_size;
> +                       };
>                 };
>         };
>  };
> @@ -424,6 +429,11 @@ struct bpf_sec_def {
>         libbpf_prog_attach_fn_t prog_attach_fn;
>  };
>
> +struct bpf_light_subprog {
> +       __u32 sec_insn_off;
> +       __u32 sub_insn_off;
> +};
> +
>  /*
>   * bpf_prog should be a better name but it has been used in
>   * linux/filter.h.
> @@ -496,6 +506,9 @@ struct bpf_program {
>         __u32 line_info_rec_size;
>         __u32 line_info_cnt;
>         __u32 prog_flags;
> +
> +       struct bpf_light_subprog *subprog;

nit: subprogs (but still subprog_cnt, yep)

> +       __u32 subprog_cnt;
>  };
>
>  struct bpf_struct_ops {
> @@ -525,6 +538,7 @@ struct bpf_struct_ops {
>  #define STRUCT_OPS_SEC ".struct_ops"
>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>  #define ARENA_SEC ".addr_space.1"
> +#define JUMPTABLES_SEC ".jumptables"
>
>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> @@ -668,6 +682,7 @@ struct elf_state {
>         int symbols_shndx;
>         bool has_st_ops;
>         int arena_data_shndx;
> +       int jumptables_data_shndx;
>  };
>
>  struct usdt_manager;
> @@ -739,6 +754,9 @@ struct bpf_object {
>         void *arena_data;
>         size_t arena_data_sz;
>
> +       void *jumptables_data;
> +       size_t jumptables_data_sz;
> +
>         struct kern_feature_cache *feat_cache;
>         char *token_path;
>         int token_fd;
> @@ -765,6 +783,7 @@ void bpf_program__unload(struct bpf_program *prog)
>
>         zfree(&prog->func_info);
>         zfree(&prog->line_info);
> +       zfree(&prog->subprog);
>  }
>
>  static void bpf_program__exit(struct bpf_program *prog)
> @@ -3945,6 +3964,13 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
>                         } else if (strcmp(name, ARENA_SEC) =3D=3D 0) {
>                                 obj->efile.arena_data =3D data;
>                                 obj->efile.arena_data_shndx =3D idx;
> +                       } else if (strcmp(name, JUMPTABLES_SEC) =3D=3D 0)=
 {
> +                               obj->jumptables_data =3D malloc(data->d_s=
ize);
> +                               if (!obj->jumptables_data)
> +                                       return -ENOMEM;
> +                               memcpy(obj->jumptables_data, data->d_buf,=
 data->d_size);
> +                               obj->jumptables_data_sz =3D data->d_size;
> +                               obj->efile.jumptables_data_shndx =3D idx;
>                         } else {
>                                 pr_info("elf: skipping unrecognized data =
section(%d) %s\n",
>                                         idx, name);
> @@ -4599,6 +4625,16 @@ static int bpf_program__record_reloc(struct bpf_pr=
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
> @@ -6101,6 +6137,74 @@ static void poison_kfunc_call(struct bpf_program *=
prog, int relo_idx,
>         insn->imm =3D POISON_CALL_KFUNC_BASE + ext_idx;
>  }
>
> +static int create_jt_map(struct bpf_object *obj, int off, int size, int =
adjust_off)
> +{
> +       const __u32 value_size =3D sizeof(struct bpf_insn_array_value);
> +       const __u32 max_entries =3D size / value_size;
> +       struct bpf_insn_array_value val =3D {};
> +       int map_fd, err;
> +       __u64 xlated_off;
> +       __u64 *jt;
> +       __u32 i;
> +
> +       map_fd =3D bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, "jt",

let's call it ".jumptables" just like special global data maps?

> +                               4, value_size, max_entries, NULL);
> +       if (map_fd < 0)
> +               return map_fd;
> +
> +       if (!obj->jumptables_data) {
> +               pr_warn("object contains no jumptables_data\n");

for map-related errors we follow (pretty consistently) error format:

map '%s': whatever bad happened

let's stick to that here? "map '.jumptables': ELF file is missing jump
table data" or something along those lines?

> +               return -EINVAL;
> +       }
> +       if ((off + size) > obj->jumptables_data_sz) {

nit: unnecessary ()

> +               pr_warn("jumptables_data size is %zd, trying to access %d=
\n",
> +                       obj->jumptables_data_sz, off + size);
> +               return -EINVAL;
> +       }
> +
> +       jt =3D (__u64 *)(obj->jumptables_data + off);
> +       for (i =3D 0; i < max_entries; i++) {
> +               /*
> +                * LLVM-generated jump tables contain u64 records, howeve=
r
> +                * should contain values that fit in u32.
> +                * The adjust_off provided by the caller adjusts the offs=
et to
> +                * be relative to the beginning of the main function
> +                */
> +               xlated_off =3D jt[i]/sizeof(struct bpf_insn) + adjust_off=
;
> +               if (xlated_off > UINT32_MAX) {
> +                       pr_warn("invalid jump table value %llx at offset =
%d (adjust_off %d)\n",
> +                               jt[i], off + i, adjust_off);

no close(map_fd)? same in a bunch of places above? I'd actually move
map create to right before this loop and simplify error handling

pw-bot: cr

> +                       return -EINVAL;
> +               }
> +
> +               val.xlated_off =3D xlated_off;
> +               err =3D bpf_map_update_elem(map_fd, &i, &val, 0);
> +               if (err) {
> +                       close(map_fd);
> +                       return err;
> +               }
> +       }
> +       return map_fd;
> +}
> +
> +/*
> + * In LLVM the .jumptables section contains jump tables entries relative=
 to the
> + * section start. The BPF kernel-side code expects jump table offsets re=
lative
> + * to the beginning of the program (passed in bpf(BPF_PROG_LOAD)). This =
helper
> + * computes a delta to be added when creating a map.
> + */
> +static int jt_adjust_off(struct bpf_program *prog, int insn_idx)
> +{
> +       int i;
> +
> +       for (i =3D prog->subprog_cnt - 1; i >=3D 0; i--)
> +               if (insn_idx >=3D prog->subprog[i].sub_insn_off)
> +                       return prog->subprog[i].sub_insn_off - prog->subp=
rog[i].sec_insn_off;

nit: please add {} around multi-line for loop body (even if it's a
single statement)

> +
> +       return -prog->sec_insn_off;
> +}
> +
> +
>  /* Relocate data references within program code:
>   *  - map references;
>   *  - global variable references;
> @@ -6192,6 +6296,21 @@ bpf_object__relocate_data(struct bpf_object *obj, =
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
> +                                              jt_adjust_off(prog, relo->=
insn_idx));

Who's closing all these fds? (I feel like we'd want to have all those
maps in a list of bpf_object's maps, just like .rodata and others)

Also, how many of those will we have? Each individual relocation gets
its own map, right?..


> +                       if (map_fd < 0) {
> +                               pr_warn("prog '%s': relo #%d: can't creat=
e jump table: sym_off %u\n",
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
> @@ -6389,6 +6508,24 @@ static int append_subprog_relos(struct bpf_program=
 *main_prog, struct bpf_progra
>         return 0;
>  }
>
> +static int save_subprog_offsets(struct bpf_program *main_prog, struct bp=
f_program *subprog)
> +{
> +       size_t size =3D sizeof(main_prog->subprog[0]);
> +       int new_cnt =3D main_prog->subprog_cnt + 1;
> +       void *tmp;
> +
> +       tmp =3D libbpf_reallocarray(main_prog->subprog, new_cnt, size);
> +       if (!tmp)
> +               return -ENOMEM;
> +
> +       main_prog->subprog =3D tmp;
> +       main_prog->subprog[new_cnt - 1].sec_insn_off =3D subprog->sec_ins=
n_off;
> +       main_prog->subprog[new_cnt - 1].sub_insn_off =3D subprog->sub_ins=
n_off;
> +       main_prog->subprog_cnt =3D new_cnt;
> +
> +       return 0;
> +}
> +
>  static int
>  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_progr=
am *main_prog,
>                                 struct bpf_program *subprog)
> @@ -6418,6 +6555,14 @@ bpf_object__append_subprog_code(struct bpf_object =
*obj, struct bpf_program *main
>         err =3D append_subprog_relos(main_prog, subprog);
>         if (err)
>                 return err;
> +
> +       /* Save subprogram offsets */
> +       err =3D save_subprog_offsets(main_prog, subprog);
> +       if (err) {
> +               pr_warn("prog '%s': failed to add subprog offsets\n", mai=
n_prog->name);

emit error itself as well, use errstr()

> +               return err;
> +       }
> +
>         return 0;
>  }
>
> @@ -9185,6 +9330,9 @@ void bpf_object__close(struct bpf_object *obj)
>
>         zfree(&obj->arena_data);
>
> +       zfree(&obj->jumptables_data);
> +       obj->jumptables_data_sz =3D 0;
> +
>         free(obj);
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
> index a469e5d4fee7..d1585baa9f14 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -28,6 +28,8 @@
>  #include "str_error.h"
>
>  #define BTF_EXTERN_SEC ".extern"
> +#define JUMPTABLES_SEC ".jumptables"
> +#define JUMPTABLES_REL_SEC ".rel.jumptables"
>
>  struct src_sec {
>         const char *sec_name;
> @@ -2026,6 +2028,9 @@ static int linker_append_elf_sym(struct bpf_linker =
*linker, struct src_obj *obj,
>                         obj->sym_map[src_sym_idx] =3D dst_sec->sec_sym_id=
x;
>                         return 0;
>                 }
> +
> +               if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) =3D=3D 0)
> +                       goto add_sym;
>         }
>
>         if (sym_bind =3D=3D STB_LOCAL)
> @@ -2272,8 +2277,9 @@ static int linker_append_elf_relos(struct bpf_linke=
r *linker, struct src_obj *ob
>                                                 insn->imm +=3D sec->dst_o=
ff / sizeof(struct bpf_insn);
>                                         else
>                                                 insn->imm +=3D sec->dst_o=
ff;
> -                               } else {
> -                                       pr_warn("relocation against STT_S=
ECTION in non-exec section is not supported!\n");
> +                               } else if (strcmp(src_sec->sec_name, JUMP=
TABLES_REL_SEC)) {

please add explicit `!=3D 0`, but also didn't we agree to have

if (strcmp(..., JUMPTABLES_REL_SEC) =3D=3D 0) {
    /* no need to adjust .jumptables */
} else {
    ... original default handling of errors ...


Also, how did you test that this actually works? Can you add a
selftest demonstrating this?

}

> +                                       pr_warn("relocation against STT_S=
ECTION in section %s is not supported!\n",
> +                                               src_sec->sec_name);
>                                         return -EINVAL;
>                                 }
>                         }
> --
> 2.34.1
>

