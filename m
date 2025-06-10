Return-Path: <bpf+bounces-60123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4ECAD2ACD
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 02:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0381891C79
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 00:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42B15C0;
	Tue, 10 Jun 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhQVEpQ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55119A;
	Tue, 10 Jun 2025 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749514111; cv=none; b=AUl1FTqfe2CoRuNN41PKvaFIJiniLNOUOTz57HL5Nxp6oTsuajXy2yoBelwqHkc0hzpbhPzASkxtKm+yeCpt1bQ/fQW4dqMN1Ach7btaM20/DTOINFzxmGmTPxdp7aE1GFJy7d1k21roA5BUl+B2rIqdst+ADpedkyQKecwXucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749514111; c=relaxed/simple;
	bh=+ACPguMVRg7j/e9siu1EuaaDB7GbjiOhExZ/m/CAbM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mu5p/uGcqvsXEKl5jtUyir8tauEZxjMtKdbZXIBGh1hoBz9g61AOKo2Lmi2gi2jTo9/beQm+/1qxhsqjGsRVifhcV6GWzB2/K0uxivPouAXPp/szlWAPydXTNgLsVksmSLR8QMbOjEyGLbIpcSoEXo0lB3H5xpaXi3Zp7FYtHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhQVEpQ7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45300c82c1cso7649035e9.3;
        Mon, 09 Jun 2025 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749514108; x=1750118908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrPZnQdd6HAj2vaCFNWsSqZlnmIrnZv9Ej6UTjhdApk=;
        b=OhQVEpQ7dh+D4uNYCoIwWWuXhpipYFjEWW8c0AzN54xu/eyAafPmhcsDcX4UFqdP0P
         JcI1sU2Z77HWeFbjt7EIMiV9GJmaMsSY78S6C8gzQeTeKLopVN1JsdgG13ogLNL6XACi
         iX0riS0fOIlLNr2uOgLJQ0XiIlqKSuGP1jUuuw6fK9NU6OGPzAjJn9tGvmiCmuG8iDO2
         n7knJNB39nfWZA/UXDbJvseipvoVM9L6HUdzXboLRtdJYBu7k5vvsvvJVES6SgJH7Pev
         qT3W/qE/fu7Q6nHD25ucptOvzcF1op1ZVnYxYp+xBz/19oXnaQYMyitWQPdmn2ZB3Whh
         wRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749514108; x=1750118908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrPZnQdd6HAj2vaCFNWsSqZlnmIrnZv9Ej6UTjhdApk=;
        b=Hzdyc0dWLU6pT/zCmTZB7U6lAVKrAAiUUc8ZcSCD5lBoWyWuWv8dYMf8Mc7IQfgIBC
         KEEP5bnSUJ4ZA8xm4QkZQ3zwgh4caYYxoKh3CQJZ3VK0Fpd8yZ3B1QiQp+Bho7axe5Mv
         vxymC5cI7+A/uSsWnrmDpW8Tkucwa10wVPsQUiou53n2wiJPROXpfkzzp81r5kkitk4F
         YnOmEiJuCaJp52CBelMjCIb6wdBZyLrF53DSTLbMbKfnHE7MZzUapkIouo1NE8mK9O5P
         5FAGZZxnSFeXY4LE3E95Ix+5g9ugT5EOzoJv1AIMv7OBglkw9W4mxl+9hBL9p97j2GDY
         xQfw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2MR5cZiwhEctcfANKlj4UQa8N0UeWj/gZSgW4LIZSaTpfHuNtW6g0lkYNkDlEE9DxKDiu8otnQZYbmXRZ49F26M3bEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKG/Krwt66pWjlK7YxPdD3b6aQUBArx8KECQkGT4cabjLCJO5
	OR6AxZ52JpiUQjce57GLz9ivbTno5q73BI6eZa1FAoqLM0OiJgW+kyX799dMGZIHbUvgTXM/37w
	e/zN72MkA8L4mog810XJ7FvKTjz365RqbIbhH
X-Gm-Gg: ASbGncv+rQHr73zYvv2cfij8Y1ujEtk5vejFL3ZcbOZJovc2JvaEwsNyYgU+jvaQ1yq
	kTzVQg+TQYI1G8Uh6xdcmtUVdj7l4003poAgM/yy3i2X+3frxeGFTyfeOUuutevB/CkSs6heY0B
	CcsFOkc24ZbPuqaGqCbqLg0051GtHAjOoIi8x2f9X5RniAtGcR54X6w6F3ddUbGB/50vyiSekjY
	6YsEXJTlkU=
X-Google-Smtp-Source: AGHT+IEzKRIQzdq+9NHVQSYYe+q/4X2sBUI7aVZDFJ202XHQCYuJn2PGlePGw1424jX33/MylGT6ewDLkJjWMslMPV4=
X-Received: by 2002:a05:600c:859b:b0:453:6ca:16a6 with SMTP id
 5b1f17b1804b1-45306ca17f5mr69112985e9.10.1749514107402; Mon, 09 Jun 2025
 17:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-11-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-11-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 17:08:16 -0700
X-Gm-Features: AX0GCFub4qqHJfyHDYAIr8zgP_eavbyWzJXRqtowySyGGBDS9nkceBai9tOR1aU
Message-ID: <CAADnVQL6jeigFqQqip4JmvCFrdsWGbOFrxREFuD+OOjjaz6JXg@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
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

Is there a reason to use offset instead of pointers?
Instead of
int hash_insn_offset[SHA256_DWORD_SIZE];
it could be
struct bpf_insn *hash_insn[SHA256_DWORD_SIZE];

> +               insn[0].imm =3D (__u32)sha[i];
> +               insn[1].imm =3D sha[i] >> 32;

Then above will be gen->hash_insn[i][0].imm ?

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

and this will be
gen->hash_insn[i] =3D gen->insn_cur;

