Return-Path: <bpf+bounces-60543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A87AD7EA8
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791271891739
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCC2E0B5A;
	Thu, 12 Jun 2025 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMhJfkSs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D11DED60;
	Thu, 12 Jun 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768980; cv=none; b=P/ydx9vr1RnXD/CMHqnO9svFTJs+YFhwLByOvLAKUDYdBsIKivg9N8jRfMCCbrPlfvIYL509DDxBFj99RFMV+zy4eYqkK+gRlu9QnzwfhkO6l8OL5kSD7lqQE7D5zdN79m3P1hSd7hPtQQvT6mggp8gYAAsqwq4Nap9zNmwOSas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768980; c=relaxed/simple;
	bh=SWc40E9ymE9TWl1eJOzG8Xg9vzocdsFZwromuiKxaAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG7vIMxS7ugXxR5QmxD1Sn2eGjoSyMB/+CaDWO7hYTOr2Y7rJZqHnkXkiPNOqLG4ai4RSWPRdPBWThQV2olXQMmkBS3THSzJ1VLSZ1CMiEs/JsbTiTa4vsn/YDDwiRviDC8zuffkwHrtDonYPool8T55yD//KzV0MPc8VxnWQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMhJfkSs; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2f1032e1c4so1508975a12.3;
        Thu, 12 Jun 2025 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749768978; x=1750373778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDx5y2Y5t16rGt1IVK1WTGH+oZvnW6++wb3YHagsORs=;
        b=kMhJfkSs3UwRTghpjXq0LCcvlyHjtwqegl+SIQ82FQ+mCv42Dh+pidLr6gfS03Kt/G
         tr4E3s48BXNgVDuUN041pehpy4tVc2o0K3umlsa4uSOiq48YDrop4haUX0ICMQNDLb4I
         a7Nqaq52a+rgoExS45NlqZim5mksvlHFQY3/ILxNuD+zeVHHGljpYNlNrPK3dOIX3vxU
         RHJRHhkxylf4SOy+JOJH5zYdVSh3z+h7M09RhX3PBZjlC9VDd6ifpO4e3msLsQwJ3Y4W
         IRURYTBo3zlvjrXSWx+qu8goOtvOHHjpQwwF+oR/UHBC8RYq28jLN0jRXWLqZDTOrQJU
         QELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749768978; x=1750373778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDx5y2Y5t16rGt1IVK1WTGH+oZvnW6++wb3YHagsORs=;
        b=NADORucw6ZXLUt//Ul/TX0Jq46ZVvy6AEImd4wQfY00WlZngYrCu+dqmGwu2G4TuaN
         PKmSzuZiLTc6RgVs8X9wWnM6Xw0jI7qXTgOGMYRAufvCm7R0OFlNvMdeUGSUeICPLwsw
         fBx1IIouESmOUjcuPCjkLnZFUCNVjTCGBxbu5XhQakWTopWdNdM1N/bLmg/1Tt8stkz9
         xvMOipPG7nWQlN6OmTADHTkYIq6yNdrNRiud1D3VGiOiE6ppctwQMgnI8AXnXmWkS0uY
         hFTTyjpn8LBuoxfp9zHOmhu6mgiNnERT28Oo+iq+TfOWXQXIoOs4XPsNl4IWQYNT8u0u
         y4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUjxXJcR+1OXTS8MGnELEc9BOL3E8NFGAVAwwysIE2n1tvS3m5M7K5J6Tu9tb5WV+VKOOgJpNI5Q4lsYLfr0Rbi5JbPa/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAT28BrwXAtrxIP9nsjRCXVDt9sR9WkVc+aoU5LR+uRf+1aHsz
	oVEBobnDRaF+IUD7vIH55AUmxZ+YSiJJf5Wb96bAq+v4hVif5yN+om861PMVxcHxHZgiz7Bx3hK
	4tqMpqEBOf3wD5/fJSNJt0/tWCMcmyOsansTR
X-Gm-Gg: ASbGncvv2NMmRWYgPv3M+zpnrjq4IWR5+wfQD8GigFQ1SxCGli87get1rEHs5ZVuKjW
	JfgqtrPjd1xKBKndVAv9qUfnY2WPyDfX8zRt+Z7e9JYdMfFowyyXctsTR1H1VyjkETREUYlp/oN
	cqXBNwSPSUX+2yzWKp4ZBfv/X50TNL0awkBAg+gDQEVxjVL7lxNGrDrpmiH6k=
X-Google-Smtp-Source: AGHT+IHLoZazh6myhZ6WeP/7jjD4/oqrZvxbFVJ4S7FaDhFA6ie7vO5VL9s83KxSVXHgBgtq2wdffDwSwcnbek9Z8tQ=
X-Received: by 2002:a05:6a20:244c:b0:215:cf53:c35 with SMTP id
 adf61e73a8af0-21facebaeb5mr1090336637.31.1749768978122; Thu, 12 Jun 2025
 15:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-11-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-11-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 15:56:04 -0700
X-Gm-Features: AX0GCFs9aqT8Vl6SLKHZnnjJs5Tu4SPUkFZsWZFSIjIK8mPgHsZ-9PgIrG0iRQs
Message-ID: <CAEf4BzYKH2cV7NE_0MXSFnJPUqMe4E-13ZA6Y+hWV12Un9F6FQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> To fulfill the BPF signing contract, represented as Sig(I_loader ||
> H_meta), the generated trusted loader program must verify the integrity
> of the metadata. This signature cryptographically binds the loader's
> instructions (I_loader) to a hash of the metadata (H_meta).
>
> The verification process is embedded directly into the loader program.
> Upon execution, the loader loads the runtime hash from struct bpf_map
> i.e. BPF_PSEUDO_MAP_IDX and compares this runtime hash against an
> expected hash value that has been hardcoded directly by
> bpf_obj__gen_loader.
>
> The load from bpf_map can be improved by calling
> BPF_OBJ_GET_INFO_BY_FD from the kernel context after BPF_OBJ_GET_INFO_BY_=
FD
> has been updated for being called from the kernel context.
>
> The following instructions are generated:
>
>     ld_imm64 r1, const_ptr_to_map // insn[0].src_reg =3D=3D BPF_PSEUDO_MA=
P_IDX
>     r2 =3D *(u64 *)(r1 + 0);
>     ld_imm64 r3, sha256_of_map_part1 // constant precomputed by
> bpftool (part of H_meta)
>     if r2 !=3D r3 goto out;
>
>     r2 =3D *(u64 *)(r1 + 8);
>     ld_imm64 r3, sha256_of_map_part2 // (part of H_meta)
>     if r2 !=3D r3 goto out;
>
>     r2 =3D *(u64 *)(r1 + 16);
>     ld_imm64 r3, sha256_of_map_part3 // (part of H_meta)
>     if r2 !=3D r3 goto out;
>
>     r2 =3D *(u64 *)(r1 + 24);
>     ld_imm64 r3, sha256_of_map_part4 // (part of H_meta)
>     if r2 !=3D r3 goto out;
>     ...
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |  2 ++
>  tools/lib/bpf/gen_loader.c       | 52 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h           |  3 +-
>  3 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_int=
ernal.h
> index 6ff963a491d9..49af4260b8e6 100644
> --- a/tools/lib/bpf/bpf_gen_internal.h
> +++ b/tools/lib/bpf/bpf_gen_internal.h
> @@ -4,6 +4,7 @@
>  #define __BPF_GEN_INTERNAL_H
>
>  #include "bpf.h"
> +#include "libbpf_internal.h"
>
>  struct ksym_relo_desc {
>         const char *name;
> @@ -50,6 +51,7 @@ struct bpf_gen {
>         __u32 nr_ksyms;
>         int fd_array;
>         int nr_fd_array;
> +       int hash_insn_offset[SHA256_DWORD_SIZE];
>  };
>
>  void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int=
 nr_maps);
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 113ae4abd345..3d672c09e948 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -110,6 +110,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_ins=
n insn1, struct bpf_insn in
>
>  static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
>  static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
> +static void bpf_gen__signature_match(struct bpf_gen *gen);
>
>  void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int=
 nr_maps)
>  {
> @@ -152,6 +153,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level=
, int nr_progs, int nr_maps
>         /* R7 contains the error code from sys_bpf. Copy it into R0 and e=
xit. */
>         emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
>         emit(gen, BPF_EXIT_INSN());
> +       if (gen->opts->gen_hash)

use OPTS_GET instead of directly accessing a field that might not be there?

> +               bpf_gen__signature_match(gen);
>  }
>
>  static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
> @@ -368,6 +371,25 @@ static void emit_sys_close_blob(struct bpf_gen *gen,=
 int blob_off)
>         __emit_sys_close(gen);
>  }
>
> +static int compute_sha_udpate_offsets(struct bpf_gen *gen)
> +{
> +       __u64 sha[SHA256_DWORD_SIZE];
> +       int i, err;
> +
> +       err =3D libbpf_sha256(gen->data_start, gen->data_cur - gen->data_=
start, sha);
> +       if (err < 0) {
> +               pr_warn("sha256 computation of the metadata failed");
> +               return err;
> +       }
> +       for (i =3D 0; i < SHA256_DWORD_SIZE; i++) {
> +               struct bpf_insn *insn =3D
> +                       (struct bpf_insn *)(gen->insn_start + gen->hash_i=
nsn_offset[i]);
> +               insn[0].imm =3D (__u32)sha[i];
> +               insn[1].imm =3D sha[i] >> 32;
> +       }
> +       return 0;
> +}
> +
>  int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
>  {
>         int i;
> @@ -394,6 +416,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_prog=
s, int nr_maps)
>                               blob_fd_array_off(gen, i));
>         emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
>         emit(gen, BPF_EXIT_INSN());
> +       if (gen->opts->gen_hash) {

ditto, OPTS_GET

> +               gen->error =3D compute_sha_udpate_offsets(gen);
> +               if (gen->error)
> +                       return gen->error;
> +       }
> +
>         pr_debug("gen: finish %s\n", errstr(gen->error));
>         if (!gen->error) {
>                 struct gen_loader_opts *opts =3D gen->opts;
> @@ -557,6 +585,30 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>                 emit_sys_close_stack(gen, stack_off(inner_map_fd));
>  }
>
> +static void bpf_gen__signature_match(struct bpf_gen *gen)
> +{
> +       __s64 off =3D -(gen->insn_cur - gen->insn_start - gen->cleanup_la=
bel) / 8 - 1;
> +       int i;
> +
> +       for (i =3D 0; i < SHA256_DWORD_SIZE; i++) {
> +               emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MA=
P_IDX,
> +                                                0, 0, 0, 0));
> +               emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, i * s=
izeof(__u64)));
> +               gen->hash_insn_offset[i] =3D gen->insn_cur - gen->insn_st=
art;
> +               emit2(gen,
> +                     BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));

nit: doesn't fit on a single line? same below


> +
> +               if (is_simm16(off)) {
> +                       emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +                       emit(gen,
> +                            BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, o=
ff));
> +               } else {
> +                       gen->error =3D -ERANGE;
> +                       emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
> +               }
> +       }
> +}
> +
>  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *atta=
ch_name,
>                                    enum bpf_attach_type type)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b6ee9870523a..084372fa54f4 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1803,9 +1803,10 @@ struct gen_loader_opts {
>         const char *insns;
>         __u32 data_sz;
>         __u32 insns_sz;
> +       bool gen_hash;
>  };
>
> -#define gen_loader_opts__last_field insns_sz
> +#define gen_loader_opts__last_field gen_hash
>  LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
>                                       struct gen_loader_opts *opts);
>
> --
> 2.43.0
>

