Return-Path: <bpf+bounces-73074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0AAC225D7
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 513E134E7FC
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01368274FEF;
	Thu, 30 Oct 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgZcQGv3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690F1D555
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858060; cv=none; b=r1po6ttOXO/Xz2CJtRHGyJSxSy7kNWmyleI6ZLq43/GwR0DFCPaUQX7LIL9RTvXv6LxBbmG8PZLjS0SL+CYLw6GfkvhXgYNi3XlLEV+QxgT3z5NuY42w2vPTcqYKOPZZ7H3eCRrSuEVGQMwkS4oVZvhEp7kEss5/LgxweDzVKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858060; c=relaxed/simple;
	bh=WKm3sJxlW7zF7Dur6IQddDh489Ch9a3z38SJ2k3P6h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gejR86xJl+UcOWI6S+s7XMEzahQEXwmKYOUiq0NQbgfIsDQhB2D/Bb7Pi3qJGuLHBFCwK8AyILTKbKI2Lo7jBKZfjmDVMC56fvM6ldVOvo2BKqITAL/nUO2Vi33Qp8npGAak03Osg63HA0m2qkRAsjemG2421dVGeY91GYj9pew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgZcQGv3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2952048eb88so2567145ad.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761858058; x=1762462858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ57gzRl6KcVlbdLGnZHLm6ZRNYwITrKoWTg5Bc8Qvk=;
        b=NgZcQGv3l7MZagjsaMSMmAF1+l1fqYDf2ZxwtKXXNHra0cw7I3484kZNxr94K0K/70
         VLriHwaq105/J9lowKEs+mWbeZ7aGsZI3XzIUN1UfT5i/6GV23uyh2ZkZm5Z45JERrv7
         8516mAhps+E1cj7fzeDzHo9d+tIm6tLGLAAkZdNJNaovC4KLkPudhEWkel+I+je/UoIk
         MLuq13OcYvSzZzS+WZxFWfikf0CgLikZWGTeas952VbZ0vJDnnY6N3O84YjaQZcipv9r
         rUS23JKILMI1iMhGRIJoMzUx/2iVA4lW5l40yF0lB9BWpIEjcvcOgIUYnql57q9PDJf/
         OFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761858058; x=1762462858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ57gzRl6KcVlbdLGnZHLm6ZRNYwITrKoWTg5Bc8Qvk=;
        b=WYx/6mAIDX9slRxiGGwC8bmM5UhctLlJsRMnQAqtd0kbP1xmp1yy4qugz/0YSLbdwQ
         gZGMBIUW/Xs0TNsCZNb0wb96Ovq6fkdKq71Vv7otQoAI1Eth0/yvXnq/3D3g5A3gUDU5
         2BAI9k2zO/eJQ9Y7k/a5aK9yxUvNol1BDc6BWQNp80xrmo3A1oh5tiUdX6WCMEVVoq4C
         2vVmPht6/DroVWD6oMS09ptjDtplR0IdlM25wivKQB94xuxOdnzjon0UaYS6UNaj94TN
         6p7pdDBgrD/IT91l0llQSWbbeU3lHGcVxB5830bXbAqQm1xE3e1UTAv5NaCUI5zwIWxY
         w9bw==
X-Gm-Message-State: AOJu0YxDc2obRYdDpuCLaHh2ArrAVPeYtj8Khtc+iRdho7kdeUVrva0p
	rmLjP/YhE6DgvUuvUHsLLsm4SOWjFVMnRQ2GNuWkNqSND+FjCtuHAWRobtg7m9OK3EMSxD+HhUv
	AqTKsimH0vokLyB6Lz6nsEIhKuiIj5xM=
X-Gm-Gg: ASbGncuIk+u4H+/FvHet3BaBfWW9oW7TwmtWYN0ajq0SW2I6k+ytAchIv/bDs8o+s1I
	dA7UmR6OXOur25IsTEHPB2gu62hCX1Vbu9qlZ5OqyD3X6RUjL1ePEjAcjFac4f5/PGWA2UbcHgm
	h0c88u+2K8uAoF59/ZBxDTqIdERzxjtxTXXfac1+UO9kV5M6SyFDFcYNJ1GybFQDnaAZ3qSzAFK
	vGOKDkL9jBq3GumEZ8RjIETDUYwlZ8JJcnd3L0qw2uMibQYzN5Plg8UT3+0HMZyj4Z5Zd+ecnDz
X-Google-Smtp-Source: AGHT+IHZKOdZrOnyIxgNxv/CnmPek33oHPGim3m308tLpZiiyqgU8vVOr67XHSZv3aRErRob6a7bwS2YLHtyxpqYi18=
X-Received: by 2002:a17:902:f545:b0:295:62d:5004 with SMTP id
 d9443c01a7336-2951a40cad2mr14344575ad.26.1761858057662; Thu, 30 Oct 2025
 14:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com> <20251028142049.1324520-9-a.s.protopopov@gmail.com>
In-Reply-To: <20251028142049.1324520-9-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Oct 2025 14:00:43 -0700
X-Gm-Features: AWmQ_bmz0um8S1Pd3JgWB4eyIFHE2zVJfPaYssSMPI97T0WnUfnmSR8T8Kn75rM
Message-ID: <CAEf4BzZok5fsX4BjhrwNB5CNQGVFCRM+M2TFhHu3x98bC1pOkg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 08/11] libbpf: support llvm-generated indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:15=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> For v4 instruction set LLVM is allowed to generate indirect jumps for
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
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c          | 249 +++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf_internal.h |   4 +
>  tools/lib/bpf/libbpf_probes.c   |   4 +
>  tools/lib/bpf/linker.c          |   9 +-
>  4 files changed, 263 insertions(+), 3 deletions(-)
>

[...]

> @@ -738,6 +758,16 @@ struct bpf_object {
>         void *arena_data;
>         size_t arena_data_sz;
>
> +       void *jumptables_data;
> +       size_t jumptables_data_sz;
> +
> +       struct {
> +               struct bpf_program *prog;

It bit us many times already when we stored direct bpf_program/bpf_map
pointers inside bpf_object (because depending on when those pointers
are taken they might be invalidated when we add another prog/map). I'm
too lazy to figure out if this can be a problem for this particular
case, but I think it would be more consistent and safer to store
program index and just look up struct bpf_program * (it's just an
array, quick and easy).

Consider that for a follow up, if this patch set lands as is.

> +               int sym_off;
> +               int fd;
> +       } *jumptable_maps;
> +       size_t jumptable_map_cnt;
> +
>         struct kern_feature_cache *feat_cache;
>         char *token_path;
>         int token_fd;

[...]

> +static int add_jt_map(struct bpf_object *obj, struct bpf_program *prog, =
int sym_off, int map_fd)
> +{
> +       size_t new_cnt =3D obj->jumptable_map_cnt + 1;
> +       size_t size =3D sizeof(obj->jumptable_maps[0]);
> +       void *tmp;
> +
> +       tmp =3D libbpf_reallocarray(obj->jumptable_maps, new_cnt, size);
> +       if (!tmp)
> +               return -ENOMEM;
> +
> +       obj->jumptable_maps =3D tmp;
> +       obj->jumptable_maps[new_cnt - 1].prog =3D prog;
> +       obj->jumptable_maps[new_cnt - 1].sym_off =3D sym_off;
> +       obj->jumptable_maps[new_cnt - 1].fd =3D map_fd;
> +       obj->jumptable_map_cnt =3D new_cnt;

nit: I'd go with `size_t cnt =3D obj->jumptable_map_cnt`, use `cnt + 1`
for reallocarray, and just `cnt` everywhere else. Then just canonical
`obj->jumptable_map_cnt++;` at the end.

minor, but if you get a chance, consider this

> +
> +       return 0;
> +}
> +
> +static int find_subprog_idx(struct bpf_program *prog, int insn_idx)
> +{
> +       int i;
> +
> +       for (i =3D prog->subprog_cnt - 1; i >=3D 0; i--) {
> +               if (insn_idx >=3D prog->subprogs[i].sub_insn_off)
> +                       return i;
> +       }
> +
> +       return -1;
> +}
> +
> +static int create_jt_map(struct bpf_object *obj, struct bpf_program *pro=
g, struct reloc_desc *relo)
> +{
> +       const __u32 jt_entry_size =3D 8;
> +       int sym_off =3D relo->sym_off;
> +       int jt_size =3D relo->sym_size;
> +       __u32 max_entries =3D jt_size / jt_entry_size;
> +       __u32 value_size =3D sizeof(struct bpf_insn_array_value);
> +       struct bpf_insn_array_value val =3D {};
> +       int subprog_idx;
> +       int map_fd, err;
> +       __u64 insn_off;
> +       __u64 *jt;
> +       __u32 i;
> +
> +       map_fd =3D find_jt_map(obj, prog, sym_off);
> +       if (map_fd >=3D 0)
> +               return map_fd;
> +
> +       if (sym_off % jt_entry_size) {
> +               pr_warn("jumptable start %d should be multiple of %u\n",
> +                       sym_off, jt_entry_size);
> +               return -EINVAL;
> +       }
> +
> +       if (jt_size % jt_entry_size) {
> +               pr_warn("jumptable size %d should be multiple of %u\n",
> +                       jt_size, jt_entry_size);
> +               return -EINVAL;
> +       }
> +
> +       map_fd =3D bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> +                               4, value_size, max_entries, NULL);
> +       if (map_fd < 0)
> +               return map_fd;
> +
> +       if (!obj->jumptables_data) {
> +               pr_warn("map '.jumptables': ELF file is missing jump tabl=
e data\n");

I commend you for using `map '.jumptables':` logging prefix  to follow
libbpf-wide consistent map-related logging style. I'd just like to
commend you on all other pr_warn in this function, if you know what I
mean ;)

> +               err =3D -EINVAL;
> +               goto err_close;
> +       }
> +       if (sym_off + jt_size > obj->jumptables_data_sz) {
> +               pr_warn("jumptables_data size is %zd, trying to access %d=
\n",
> +                       obj->jumptables_data_sz, sym_off + jt_size);
> +               err =3D -EINVAL;
> +               goto err_close;
> +       }
> +
> +       subprog_idx =3D -1; /* main program */
> +       if (relo->insn_idx < 0 || relo->insn_idx >=3D prog->insns_cnt) {
> +               pr_warn("invalid instruction index %d\n", relo->insn_idx)=
;
> +               err =3D -EINVAL;
> +               goto err_close;
> +       }
> +       if (prog->subprogs)
> +               subprog_idx =3D find_subprog_idx(prog, relo->insn_idx);
> +
> +       jt =3D (__u64 *)(obj->jumptables_data + sym_off);
> +       for (i =3D 0; i < max_entries; i++) {
> +               /*
> +                * The offset should be made to be relative to the beginn=
ing of
> +                * the main function, not the subfunction.
> +                */
> +               insn_off =3D jt[i]/sizeof(struct bpf_insn);
> +               if (subprog_idx >=3D 0) {
> +                       insn_off -=3D prog->subprogs[subprog_idx].sec_ins=
n_off;
> +                       insn_off +=3D prog->subprogs[subprog_idx].sub_ins=
n_off;
> +               } else {
> +                       insn_off -=3D prog->sec_insn_off;
> +               }
> +
> +               /*
> +                * LLVM-generated jump tables contain u64 records, howeve=
r
> +                * should contain values that fit in u32.
> +                */
> +               if (insn_off > UINT32_MAX) {
> +                       pr_warn("invalid jump table value 0x%llx at offse=
t %d\n",

we will most probably get compiler warnings about %llx (same for
%lld/%llu, of course) and using __u64 (because %l or %ll for __u64 is
platform dependent, if I'm not mistaken). In most (all?) other places
we explicitly cast to (long long) as a mitigation.

> +                               jt[i], sym_off + i);
> +                       err =3D -EINVAL;
> +                       goto err_close;
> +               }
> +
> +               val.orig_off =3D insn_off;
> +               err =3D bpf_map_update_elem(map_fd, &i, &val, 0);
> +               if (err)
> +                       goto err_close;
> +       }
> +
> +       err =3D bpf_map_freeze(map_fd);
> +       if (err)
> +               goto err_close;
> +
> +       err =3D add_jt_map(obj, prog, sym_off, map_fd);
> +       if (err)
> +               goto err_close;
> +
> +       return map_fd;
> +
> +err_close:
> +       close(map_fd);
> +       return err;
> +}
> +
>  /* Relocate data references within program code:
>   *  - map references;
>   *  - global variable references;
> @@ -6235,6 +6434,20 @@ bpf_object__relocate_data(struct bpf_object *obj, =
struct bpf_program *prog)
>                 case RELO_CORE:
>                         /* will be handled by bpf_program_record_relos() =
*/
>                         break;
> +               case RELO_INSN_ARRAY: {
> +                       int map_fd;
> +
> +                       map_fd =3D create_jt_map(obj, prog, relo);
> +                       if (map_fd < 0) {
> +                               pr_warn("prog '%s': relo #%d: can't creat=
e jump table: sym_off %u\n",
> +                                               prog->name, i, relo->sym_=
off);

nit: make sure to align second row with first arg in the first row

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
> @@ -6432,6 +6645,24 @@ static int append_subprog_relos(struct bpf_program=
 *main_prog, struct bpf_progra
>         return 0;
>  }
>
> +static int save_subprog_offsets(struct bpf_program *main_prog, struct bp=
f_program *subprog)
> +{
> +       size_t size =3D sizeof(main_prog->subprogs[0]);
> +       int new_cnt =3D main_prog->subprog_cnt + 1;
> +       void *tmp;
> +
> +       tmp =3D libbpf_reallocarray(main_prog->subprogs, new_cnt, size);
> +       if (!tmp)
> +               return -ENOMEM;
> +
> +       main_prog->subprogs =3D tmp;
> +       main_prog->subprogs[new_cnt - 1].sec_insn_off =3D subprog->sec_in=
sn_off;
> +       main_prog->subprogs[new_cnt - 1].sub_insn_off =3D subprog->sub_in=
sn_off;
> +       main_prog->subprog_cnt =3D new_cnt;
> +

ditto about new_cnt, cnt would be nicer and shorter, imo

> +       return 0;
> +}
> +
>  static int
>  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_progr=
am *main_prog,
>                                 struct bpf_program *subprog)
> @@ -6461,6 +6692,15 @@ bpf_object__append_subprog_code(struct bpf_object =
*obj, struct bpf_program *main
>         err =3D append_subprog_relos(main_prog, subprog);
>         if (err)
>                 return err;
> +
> +       /* Save subprogram offsets */

yeah, that's what "save_subprog_offset" literally implies, what value
does this comment provide?

> +       err =3D save_subprog_offsets(main_prog, subprog);
> +       if (err) {
> +               pr_warn("prog '%s': failed to add subprog offsets: %s\n",
> +                       main_prog->name, errstr(err));
> +               return err;
> +       }
> +
>         return 0;
>  }
>
> @@ -9228,6 +9468,13 @@ void bpf_object__close(struct bpf_object *obj)
>
>         zfree(&obj->arena_data);
>
> +       zfree(&obj->jumptables_data);
> +       obj->jumptables_data_sz =3D 0;
> +
> +       for (i =3D 0; i < obj->jumptable_map_cnt; i++)
> +               close(obj->jumptable_maps[i].fd);
> +       zfree(&obj->jumptable_maps);
> +
>         free(obj);
>  }
>
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 35b2527bedec..93bc39bd1307 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -74,6 +74,10 @@
>  #define ELF64_ST_VISIBILITY(o) ((o) & 0x03)
>  #endif
>
> +#ifndef JUMPTABLES_SEC

do we expect this definition to come from somewhere else as well?

> +#define JUMPTABLES_SEC ".jumptables"
> +#endif
> +
>  #define BTF_INFO_ENC(kind, kind_flag, vlen) \
>         ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN)=
)
>  #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_=
type)

[...]

